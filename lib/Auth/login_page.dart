// // import 'package:flutter/material.dart';
// // import 'package:intl_phone_field/intl_phone_field.dart'; // For country flag picker
// // import 'package:travel_dating/Auth/otp_verification_page.dart';
// //
// // class LoginPage extends StatefulWidget {
// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }
// //
// // class _LoginPageState extends State<LoginPage> {
// //   final _formKey = GlobalKey<FormState>(); // Key for the form
// //   String? phoneNumber; // To store the validated phone number
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.pink[50], // Light pink background
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               const SizedBox(height: 50),
// //               Text(
// //                 "Let’s Start With Your Number",
// //                 style: TextStyle(
// //                   fontSize: 20,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 40),
// //
// //               // Form for Phone Number Validation
// //               Form(
// //                 key: _formKey,
// //                 child: IntlPhoneField(
// //                   decoration: InputDecoration(
// //                     hintText: "Enter phone number",
// //                     filled: true,
// //                     fillColor: Colors.white,
// //                     border: OutlineInputBorder(
// //                       borderRadius: BorderRadius.circular(10),
// //                       borderSide: BorderSide.none,
// //                     ),
// //                   ),
// //                   initialCountryCode: 'IN', // Default to India
// //                   validator: (value) {
// //                     if (value == null || value.completeNumber.isEmpty) {
// //                       return "Phone number is required";
// //                     }
// //                     if (!value.isValidNumber()) {
// //                       return "Please enter a valid phone number";
// //                     }
// //                     return null;
// //                   },
// //                   onSaved: (value) {
// //                     phoneNumber = value?.completeNumber; // Save the complete number
// //                   },
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 32),
// //
// //               // Continue Button
// //               GestureDetector(
// //                 onTap: () {
// //                   if (_formKey.currentState!.validate()) {
// //                     _formKey.currentState!.save(); // Save the phone number
// //                     print("Phone Number: $phoneNumber");
// //
// //                     // Navigate to OTPVerificationPage with the phone number
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => OTPVerificationPage(phoneNumber: phoneNumber!),
// //                       ),
// //                     );
// //                   }
// //                 },
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(
// //                     vertical: 16.0,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.pink,
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: const Center(
// //                     child: Text(
// //                       "Continue",
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //               const SizedBox(height: 20),
// //
// //               // Divider with Text
// //               Row(
// //                 children: const [
// //                   Expanded(
// //                     child: Divider(thickness: 1, color: Colors.grey),
// //                   ),
// //                   Padding(
// //                     padding: EdgeInsets.symmetric(horizontal: 8.0),
// //                     child: Text(
// //                       "Or Login With",
// //                       style: TextStyle(color: Colors.grey),
// //                     ),
// //                   ),
// //                   Expanded(
// //                     child: Divider(thickness: 1, color: Colors.grey),
// //                   ),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// //               // Social Buttons
// //               Row(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   _buildSocialButton(
// //                     icon: Icons.facebook,
// //                     color: Colors.blue,
// //                     onTap: () {
// //                       print("Facebook Button Pressed");
// //                     },
// //                   ),
// //                   const SizedBox(width: 20),
// //                   _buildSocialButton(
// //                     icon: Icons.g_mobiledata,
// //                     color: Colors.red,
// //                     onTap: () {
// //                       print("Google Button Pressed");
// //                     },
// //                   ),
// //                 ],
// //               ),
// //
// //               const SizedBox(height: 20),
// //
// //               // Sign Up Text
// //               GestureDetector(
// //                 onTap: () {
// //                   Navigator.pushNamed(context, '/signup'); // Navigate to Sign Up
// //                 },
// //                 child: const Center(
// //                   child: Text.rich(
// //                     TextSpan(
// //                       text: "Don’t have an account? ",
// //                       style: TextStyle(color: Colors.black),
// //                       children: [
// //                         TextSpan(
// //                           text: "Sign Up",
// //                           style: TextStyle(
// //                             color: Colors.pink,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildSocialButton({
// //     required IconData icon,
// //     required Color color,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         padding: const EdgeInsets.all(10),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(10),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.grey.withOpacity(0.3),
// //               blurRadius: 5,
// //               offset: Offset(0, 5),
// //             ),
// //           ],
// //         ),
// //         child: Icon(icon, size: 40, color: color),
// //       ),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';
// // import 'otp_verification_page.dart';
// //
// // class LoginPage extends StatefulWidget {
// //   @override
// //   _LoginPageState createState() => _LoginPageState();
// // }
// //
// // class _LoginPageState extends State<LoginPage> {
// //   final _formKey = GlobalKey<FormState>();
// //   final TextEditingController _emailController = TextEditingController();
// //   final TextEditingController _passwordController = TextEditingController();
// //
// //   Future<void> _login() async {
// //     if (_formKey.currentState!.validate()) {
// //       final email = _emailController.text.trim();
// //       final password = _passwordController.text.trim();
// //
// //       try {
// //         final response = await http.post(
// //           Uri.parse('https://demo.samsidh.com/api/v1/login'),
// //           headers: {'Content-Type': 'application/json'},
// //           body: json.encode({'email': email, 'password': password}),
// //         );
// //
// //         if (response.statusCode == 200) {
// //           final data = json.decode(response.body);
// //           if (data['code'] == 'success') {
// //             // Navigate to OTP Verification Page
// //             Navigator.push(
// //               context,
// //               MaterialPageRoute(
// //                 builder: (context) => OTPVerificationPage(
// //                   email: email, // The email entered by the user
// //                   password: password, // The password entered by the user
// //                   otp: data['otp'], // The OTP received from the login API response
// //                 ),
// //               ),
// //             );
// //           } else {
// //             _showErrorSnackbar(data['message']);
// //           }
// //         } else {
// //           _showErrorSnackbar('Login failed. Please try again.');
// //         }
// //       } catch (e) {
// //         _showErrorSnackbar('Failed to connect to the server.');
// //       }
// //     }
// //   }
// //
// //   void _showErrorSnackbar(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.pink[50],
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               Text(
// //                 "Login",
// //                 style: TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.black,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               const SizedBox(height: 20),
// //               TextFormField(
// //                 controller: _emailController,
// //                 decoration: InputDecoration(
// //                   hintText: "Email",
// //                   filled: true,
// //                   fillColor: Colors.white,
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                 ),
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please enter your email";
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 16),
// //               TextFormField(
// //                 controller: _passwordController,
// //                 decoration: InputDecoration(
// //                   hintText: "Password",
// //                   filled: true,
// //                   fillColor: Colors.white,
// //                   border: OutlineInputBorder(
// //                     borderRadius: BorderRadius.circular(10),
// //                     borderSide: BorderSide.none,
// //                   ),
// //                 ),
// //                 obscureText: true,
// //                 validator: (value) {
// //                   if (value == null || value.isEmpty) {
// //                     return "Please enter your password";
// //                   }
// //                   return null;
// //                 },
// //               ),
// //               const SizedBox(height: 20),
// //               GestureDetector(
// //                 onTap: _login,
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(vertical: 16.0),
// //                   decoration: BoxDecoration(
// //                     color: Colors.pink,
// //                     borderRadius: BorderRadius.circular(10),
// //                   ),
// //                   child: Center(
// //                     child: Text(
// //                       "Login",
// //                       style: TextStyle(fontSize: 18, color: Colors.white),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'otp_verification_page.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   Future<void> _login() async {
//     if (_formKey.currentState!.validate()) {
//       final email = _emailController.text.trim();
//       final password = _passwordController.text.trim();
//
//       setState(() {
//         _isLoading = true;
//       });
//
//       try {
//         // Log request details for debugging
//         debugPrint('Attempting login with email: $email');
//
//         final response = await http.post(
//           Uri.parse('https://demo.samsidh.com/api/v1/login'),
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode({'email': email, 'password': password}),
//         );
//
//         // Log response status and body
//         debugPrint('Response Status: ${response.statusCode}');
//         debugPrint('Response Body: ${response.body}');
//
//         if (response.statusCode == 200) {
//           final data = json.decode(response.body);
//           if (data['code'] == 'success') {
//             // Navigate to OTP Verification Page
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => OTPVerificationPage(
//                   email: email,
//                   password: password,
//                   otp: data['otp'], // The OTP received from the login API response
//                 ),
//               ),
//             );
//           } else {
//             debugPrint("API Error: ${data['message']}");
//             _showErrorSnackbar(data['message']);
//           }
//         } else {
//           debugPrint("HTTP Error: ${response.statusCode} - ${response.body}");
//           _showErrorSnackbar('Login failed. Please try again.');
//         }
//       } catch (e) {
//         debugPrint("Exception: $e");
//         _showErrorSnackbar('Failed to connect to the server.');
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   void _showErrorSnackbar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "Login",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   hintText: "Email",
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your email";
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return "Please enter a valid email";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(
//                   hintText: "Password",
//                   filled: true,
//                   fillColor: Colors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "Please enter your password";
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               _isLoading
//                   ? Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
//                 ),
//               )
//                   : GestureDetector(
//                 onTap: _login,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.pink,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Login",
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'otp_verification_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true; // State to manage password visibility
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      setState(() {
        _isLoading = true;
      });

      try {
        debugPrint('Attempting login with email: $email');

        final response = await http.post(
          Uri.parse('https://demo.samsidh.com/api/v1/login'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'email': email, 'password': password}),
        );

        debugPrint('Response Status: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');

        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          if (data['code'] == 'success') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerificationPage(
                  email: email,
                  password: password,
                  otp: data['otp'], // The OTP received from the login API response
                ),
              ),
            );
          } else {
            // Print API error in console and show in Snackbar
            debugPrint("API Error: ${data['message']}");
            _showErrorSnackbar(data['message']);
          }
        } else if (response.statusCode == 500) {
          final errorData = json.decode(response.body);
          final errorMessage = errorData['message'] ?? 'An error occurred';
          debugPrint("HTTP Error: ${response.statusCode} - $errorMessage");
          _showErrorSnackbar(errorMessage); // Show error in Snackbar
        } else {
          debugPrint("HTTP Error: ${response.statusCode} - ${response.body}");
          _showErrorSnackbar('Login failed. Please try again.');
        }
      } catch (e) {
        debugPrint("Exception: $e");
        _showErrorSnackbar('Failed to connect to the server.');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red, // Red background for error messages
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                ),
              )
                  : GestureDetector(
                onTap: _login,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
