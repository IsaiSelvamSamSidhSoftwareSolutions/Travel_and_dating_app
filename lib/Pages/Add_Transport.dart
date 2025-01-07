import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddTransportScreen extends StatefulWidget {
  @override
  _AddTransportScreenState createState() => _AddTransportScreenState();
}

class _AddTransportScreenState extends State<AddTransportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // Fields
  String name = '';
  String seats = '';
  String doors = '';
  bool isManual = false;
  bool hasAC = false;
  String model = '';
  String capacity = '';
  String color = '';
  String fuelType = '';
  String speed = '';
  String power = '';
  String frontTireUsage = '';
  String backTireUsage = '';
  String driverName = '';
  String driverLicense = '';
  File? transportImage;
  File? rcBookImage;
  List<File> frontTireImages = [];
  List<File> backTireImages = [];
  final ImagePicker _picker = ImagePicker();

  // Pick Image
  Future<void> _pickImage(ImageSource source, Function(File) onSelected) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      onSelected(File(pickedFile.path));
    }
  }
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    // Get data from GetStorage
    final storage = GetStorage();
    final token = storage.read('JwtToken') ?? '';
    final email = storage.read('email') ?? '';
    final username = storage.read('username') ?? '';
    final userId = storage.read('userId') ?? '';

    final uri = Uri.parse("https://demo.samsidh.com/api/v1/trips/transport");
    final request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers['Authorization'] = 'Bearer $token';
    request.headers['email'] = email;
    request.headers['username'] = username;

    // Add form data
    request.fields['user'] = userId;
    request.fields['name'] = name;
    request.fields['seats'] = seats;
    request.fields['doors'] = doors;
    request.fields['manual'] = isManual.toString();
    request.fields['ac'] = hasAC.toString();
    request.fields['model'] = model;
    request.fields['capacity'] = capacity;
    request.fields['color'] = color;
    request.fields['fuelType'] = fuelType;
    request.fields['speed'] = speed;
    request.fields['power'] = power;
    request.fields['frontTireUsagePercent'] = frontTireUsage;
    request.fields['backTireUsagePercent'] = backTireUsage;
    request.fields['driverName'] = driverName;
    request.fields['driverLicense'] = driverLicense;

    // Add files
    if (transportImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'images',
        transportImage!.path,
      ));
    }
    if (rcBookImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'rcBookImages',
        rcBookImage!.path,
      ));
    }
    for (var file in frontTireImages) {
      request.files.add(await http.MultipartFile.fromPath(
        'frontTireImages',
        file.path,
      ));
    }
    for (var file in backTireImages) {
      request.files.add(await http.MultipartFile.fromPath(
        'backTireImages',
        file.path,
      ));
    }

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decodedResponse = jsonDecode(responseBody);

      // Print response in console
      print('Response: $decodedResponse');

      if (response.statusCode == 200) {
        // Show success toast
        Fluttertoast.showToast(msg: "Transport added successfully!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Transport added successfully!")),
        );
      } else {
        // Show generic error
        Fluttertoast.showToast(msg: "Something went wrong!");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add transport. Try again.")),
        );
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(msg: "An error occurred. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Add Transport"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Name
                TextFormField(
                  decoration: InputDecoration(labelText: 'Transport Name'),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                  onSaved: (value) => name = value!,
                ),
                // Seats
                TextFormField(
                  decoration: InputDecoration(labelText: 'Seats'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                  onSaved: (value) => seats = value!,
                ),
                // Doors
                TextFormField(
                  decoration: InputDecoration(labelText: 'Doors'),
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                  onSaved: (value) => doors = value!,
                ),
                // Manual
                SwitchListTile(
                  title: Text("Manual Transmission"),
                  value: isManual,
                  onChanged: (value) {
                    setState(() {
                      isManual = value;
                    });
                  },
                ),
                // Air Conditioning
                SwitchListTile(
                  title: Text("Air Conditioning"),
                  value: hasAC,
                  onChanged: (value) {
                    setState(() {
                      hasAC = value;
                    });
                  },
                ),
                // Driver Name
                TextFormField(
                  decoration: InputDecoration(labelText: 'Driver Name'),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                  onSaved: (value) => driverName = value!,
                ),
                // Driver License
                TextFormField(
                  decoration: InputDecoration(labelText: 'Driver License'),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                  onSaved: (value) => driverLicense = value!,
                ),
                SizedBox(height: 16),
                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text("Add Transport"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
