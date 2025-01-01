import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationPage extends StatefulWidget {
  final String email;
  final String password;
  final String otp;

  const OTPVerificationPage({
    Key? key,
    required this.email,
    required this.password,
    required this.otp,
  }) : super(key: key);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController();
  final GetStorage _storage = GetStorage();
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    // Automatically fill the OTP field
    _otpController.text = widget.otp;
  }
  Future<void> _verifyOTP() async {
    setState(() {
      _isVerifying = true;
    });

    try {
      final uri = Uri.parse('https://demo.samsidh.com/api/v1/login-with-otp');
      final headers = {'Content-Type': 'application/json'};
      final body = json.encode({
        'email': widget.email,
        'password': widget.password,
        'otp': widget.otp,
      });

      print("Request URL: $uri");
      print("Request Headers: $headers");
      print("Request Body: $body");

      final response = await http.post(uri, headers: headers, body: body);

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['code'] == 'success') {
          final userResponse = data['userResponse'] ?? {};

          // Store user details
          _storage.write('jwttoken', data['jwttoken']);
          _storage.write('refresh_token', data['refresh_token']);
          _storage.write('username', userResponse['username'] ?? '');
          _storage.write('email', userResponse['email'] ?? '');
          _storage.write('userId', userResponse['_id'] ?? '');
          _storage.write('dob', userResponse['dob'] ?? '');
          _storage.write('gender', userResponse['gender'] ?? '');
          _storage.write('looking_for', userResponse['looking_for'] ?? '');
          _storage.write('mobile', userResponse['mobile'] ?? '');
          _storage.write('password', widget.password); // Save entered password
          _storage.write('name', userResponse['name'] ?? '');
          _storage.write('interest', userResponse['interest'] ?? []);
          _storage.write('isPrivate', userResponse['isPrivate'] ?? false);

          print('Stored user details successfully.');

          // Navigate to HomePage
          Navigator.pushReplacementNamed(context, '/HomePage');
        } else {
          _showErrorSnackbar(data['message'] ?? 'Unknown error occurred.');
        }

      } else {
        _showErrorSnackbar('OTP verification failed.');
      }
    } catch (e) {
      print("Error during OTP verification: $e");
      _showErrorSnackbar('Failed to connect to the server.');
    } finally {
      setState(() {
        _isVerifying = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify OTP",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              "Please enter the OTP sent to your email:",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // OTP Input Fields
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: _otpController,
              keyboardType: TextInputType.number,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 60,
                fieldWidth: 50,
                activeColor: Colors.pink,
                selectedColor: Colors.pink.shade200,
                inactiveColor: Colors.grey.shade300,
              ),
              onChanged: (value) {},
            ),

            const SizedBox(height: 20),

            // Verify Button or Loading Spinner
            if (_isVerifying)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              )
            else
              GestureDetector(
                onTap: _verifyOTP,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Verify OTP",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
