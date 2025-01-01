import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  final ImagePicker _picker = ImagePicker();
  List<File?> images = [null, null, null, null, null, null];

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from the previous page
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back Button
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                "Upload Your Photo",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "We’d love to see you. Upload a photo for your dating journey",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Dot Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: index == 4 ? 12 : 8,
                    height: index == 4 ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 4 ? Colors.pink : Colors.pink[100],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Photo Upload Section
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.pink[100],
                    ),
                  ),
                  Column(
                    children: [
                      // Center Image
                      _buildImageCircle(2, isCenter: true),
                      const SizedBox(height: 20),
                      // Outer Images
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          for (int i = 0; i < images.length; i++)
                            if (i != 2) _buildImageCircle(i),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Complete Button
              GestureDetector(
                onTap: () {
                  if (images.every((image) => image != null)) {
                    // Collect all image paths
                    List<String?> imagePaths = images.map((image) => image?.path).toList();

                    print("All images selected: $imagePaths");

                    // Navigate to locationPermission page with arguments
                    Navigator.pushReplacementNamed(
                      context,
                      '/locationPermission',
                      arguments: {
                        'name': arguments?['name'],
                        'email': arguments?['email'],
                        'dateOfBirth': arguments?['dateOfBirth'],
                        'gender': arguments?['gender'],
                        'phoneNumber': arguments?['phoneNumber'],
                        'password': arguments?['password'],
                        'selectedCategory': arguments?['selectedCategory'],
                        'uploadedImages': imagePaths, // Include all image paths
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please upload all 6 images."),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Complete",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
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

  Widget _buildImageCircle(int index, {bool isCenter = false}) {
    return GestureDetector(
      onTap: () async {
        XFile? pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
        );
        if (pickedImage != null) {
          int fileSize = await File(pickedImage.path).length(); // File size in bytes
          if (fileSize < 100) { // Low-quality image check
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "The image quality is low. Please select a higher-quality image!",
                ),
              ),
            );
          } else {
            setState(() {
              images[index] = File(pickedImage.path);
            });
          }
        }
      },
      child: Container(
        width: isCenter ? 120 : 60,
        height: isCenter ? 120 : 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.pink, width: isCenter ? 3 : 2),
          image: images[index] != null
              ? DecorationImage(
            image: FileImage(images[index]!),
            fit: BoxFit.cover,
          )
              : null,
        ),
        child: images[index] == null
            ? const Center(
          child: Icon(
            Icons.add,
            color: Colors.pink,
            size: 30,
          ),
        )
            : null,
      ),
    );
  }
}
