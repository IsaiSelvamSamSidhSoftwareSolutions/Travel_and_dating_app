
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(EditProfileApp());
}

class EditProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _profileImage;
  List<File?> _additionalImages = [null, null, null, null];
  String? _profileImageUrl;
  List<String> _additionalImageUrls = []; // Define _additionalImageUrls here
  final picker = ImagePicker();
  final storage = GetStorage();

  // Controllers for input fields
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _mobileController = TextEditingController();
  final _lookingForController = TextEditingController();
  final _interestController = TextEditingController();
  final _jobController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  bool _isPrivate = false;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final String? userId = storage.read('userId');
    final String? token = storage.read('jwttoken');
    final String? email = storage.read('email');
    final String? username = storage.read('username');

    if (userId == null || token == null || email == null || username == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in. Please log in again.")),
      );
      return;
    }

    final String apiUrl = 'https://demo.samsidh.com/api/v1/view/$userId';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'email': email,
          'username': username,
        },
      );

      debugPrint("Fetch API Response Status: ${response.statusCode}");
      debugPrint("Fetch API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['user'];
        debugPrint("Fetched User Data: $data"); // Log fetched data
        setState(() {
          _nameController.text = data['name'] ?? '';
          _usernameController.text = data['username'] ?? '';
          _emailController.text = data['email'] ?? '';
          _dobController.text = data['dob'] ?? '';
          _genderController.text = data['gender'] ?? '';
          _mobileController.text = data['mobile'] ?? '';
          _lookingForController.text = data['looking_for'] ?? '';
          _interestController.text = (data['interest'] as List<dynamic>)
              .map((e) => e.toString())
              .join(', ');
          _jobController.text = data['job'] ?? '';
          _heightController.text = data['height']?.toString() ?? '';
          _weightController.text = data['weight']?.toString() ?? '';
          _profileImageUrl = data['uploads_profile']?.isNotEmpty == true
              ? "https://demo.samsidh.com/${data['uploads_profile'][0]}"
              : null;
          // Handle profile image
          final profileImages = data['uploads_profile'] as List<dynamic>? ?? [];
          _profileImageUrl = profileImages.isNotEmpty
              ? "https://demo.samsidh.com/${profileImages[0]}"
              : null;

          // Handle additional images
          _additionalImages = List<File?>.filled(4, null, growable: false);
          for (int i = 1; i < profileImages.length && i <= 4; i++) {
            final imageUrl = "https://demo.samsidh.com/${profileImages[i]}";
            _additionalImages[i - 1] = null; // Placeholder for possible local changes
            _additionalImageUrls.add(imageUrl); // Store remote URLs for display
          }

          _isPrivate = data['isPrivate'] ?? false;
          _isLoading = false;
        });
      } else {
        debugPrint("Fetch Error: ${response.body}"); // Log error response
        _showError("Failed to fetch user data.");
      }
    } catch (e) {
      debugPrint("Exception during fetch: $e");
      _showError("Error: Could not fetch user data.");
    }
  }
  Future<void> _updateUserData() async {
    final String? userId = storage.read('userId');
    final String? token = storage.read('jwttoken');
    final String? email = storage.read('email');
    final String? username = storage.read('username');

    if (userId == null || token == null || email == null || username == null) {
      _showError("User not logged in. Please log in again.");
      return;
    }

    final String apiUrl = 'https://demo.samsidh.com/api/v1/update-user/$userId';

    try {
      // Initialize MultipartRequest for PUT
      final request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['email'] = email;
      request.headers['username'] = username;

      // Add text fields as form data
      request.fields['name'] = _nameController.text;
      request.fields['username'] = _usernameController.text;
      request.fields['email'] = _emailController.text;
      request.fields['dob'] = _dobController.text;
      request.fields['gender'] = _genderController.text;
      request.fields['mobile'] = _mobileController.text;
      request.fields['looking_for'] = _lookingForController.text;
      request.fields['interest'] = _interestController.text.split(', ').join(',');
      request.fields['job'] = _jobController.text;
      request.fields['height'] = _heightController.text;
      request.fields['weight'] = _weightController.text;
      request.fields['isPrivate'] = _isPrivate.toString();

      // Add profile image if edited
      if (_profileImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'profile_image', // Key name expected by the backend
          _profileImage!.path,
        ));
      }

      // Add additional images directly if they exist
      for (int i = 0; i < _additionalImages.length; i++) {
        if (_additionalImages[i] != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'additional_image_$i', // Key name expected by the backend
            _additionalImages[i]!.path,
          ));
        }
      }

      // Send the request
      final response = await request.send();

      // Read and handle the response
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profile updated successfully!")),
        );
        await _fetchUserData(); // Refresh data after update
      } else {
        debugPrint("Update Error: $responseBody");
        _showError("Failed to update profile. Response: $responseBody");
      }
    } catch (e) {
      debugPrint("Exception during update: $e");
      _showError("Error: Could not update profile. Exception: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }


  Future<void> _pickImage(bool isMainImage, int? index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (isMainImage) {
          _profileImage = File(pickedFile.path);
        } else if (index != null) {
          _additionalImages[index] = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010), // Earliest selectable date
      lastDate: DateTime.now(), // Latest selectable date
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = "${pickedDate.toLocal()}".split(' ')[0]; // Format the date as needed
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image
            _buildProfileImage(),
            SizedBox(height: 20),

            // Additional Images
            _buildAdditionalImages(),
            SizedBox(height: 20),

            // Input Fields
            _buildInputField("Name", _nameController),
            _buildInputField("Username", _usernameController),
            _buildInputField("Email", _emailController),
            GestureDetector(
              onTap: () => _selectDate(context), // Trigger the date picker
              child: AbsorbPointer(
                child: _buildInputField("Date of Birth", _dobController),
              ),
            ),
            _buildInputField("Gender", _genderController),
            _buildInputField("Mobile", _mobileController),
            _buildInputField("Looking For", _lookingForController),
            _buildInputField("Interests", _interestController),
            _buildInputField("Job", _jobController),
            _buildInputField("Height", _heightController),
            _buildInputField("Weight", _weightController),
            SizedBox(height: 16),

            // Toggle Privacy
            _buildPrivacyToggle(),
            SizedBox(height: 16),

            // Submit Button
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!)
                : _profileImageUrl != null
                ? NetworkImage(_profileImageUrl!) as ImageProvider
                : null,
            child: _profileImage == null && _profileImageUrl == null
                ? Icon(Icons.person, size: 60, color: Colors.grey)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _pickImage(true, null),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.pinkAccent,
                child: Icon(Icons.camera_alt, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildAdditionalImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Additional Photos",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            final imageUrl = index < _additionalImageUrls.length
                ? _additionalImageUrls[index]
                : null;

            return GestureDetector(
              onTap: () => _editImage(index),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.pinkAccent),
                ),
                child: _additionalImages[index] != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _additionalImages[index]!,
                    fit: BoxFit.cover,
                  ),
                )
                    : imageUrl != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
                    : Icon(Icons.add, color: Colors.pinkAccent),
              ),
            );
          }),
        ),
      ],
    );
  }
  Future<void> _editImage(int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (index < _additionalImages.length) {
          _additionalImages[index] = File(pickedFile.path);
        }
      });
    }
  }


  Widget _buildInputField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter your $label",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.pinkAccent),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPrivacyToggle() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isPrivate = !_isPrivate;
          });

          // Call the API after toggling
          _updateUserData();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _isPrivate ? Colors.red : Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          _isPrivate ? "PRIVATE" : "PUBLIC",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: _updateUserData,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          "Submit",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
