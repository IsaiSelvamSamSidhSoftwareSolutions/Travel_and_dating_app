// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'dart:math';
// // // import 'package:flutter/material.dart';
// // // import 'package:geolocator/geolocator.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:get_storage/get_storage.dart';
// // // import 'package:mime/mime.dart';
// // // import 'package:http_parser/http_parser.dart';
// // //
// // // class LocationPermissionPage extends StatefulWidget {
// // //   @override
// // //   _LocationPermissionPageState createState() => _LocationPermissionPageState();
// // // }
// // //
// // // class _LocationPermissionPageState extends State<LocationPermissionPage> {
// // //   final GetStorage _storage = GetStorage();
// // //   String? latitude;
// // //   String? longitude;
// // //   Map<String, dynamic>? arguments;
// // //   List<String> uploadedImages = [];
// // //
// // //   final String dummyLatitude = "37.7749";
// // //   final String dummyLongitude = "-122.4194";
// // //
// // //   @override
// // //   void didChangeDependencies() {
// // //     super.didChangeDependencies();
// // //
// // //     final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
// // //     if (args != null) {
// // //       setState(() {
// // //         arguments = args;
// // //         uploadedImages = (args['uploadedImages'] as List<dynamic>?)
// // //             ?.map((e) => e.toString())
// // //             .toList() ??
// // //             [];
// // //       });
// // //     }
// // //   }
// // //
// // //   void _getCurrentLocation() async {
// // //     try {
// // //       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// // //       if (!serviceEnabled) {
// // //         _registerWithDummyLocation();
// // //         return;
// // //       }
// // //
// // //       LocationPermission permission = await Geolocator.checkPermission();
// // //       if (permission == LocationPermission.denied) {
// // //         permission = await Geolocator.requestPermission();
// // //         if (permission == LocationPermission.denied) {
// // //           _registerWithDummyLocation();
// // //           return;
// // //         }
// // //       }
// // //
// // //       if (permission == LocationPermission.deniedForever) {
// // //         _registerWithDummyLocation();
// // //         return;
// // //       }
// // //
// // //       Position position = await Geolocator.getCurrentPosition(
// // //         desiredAccuracy: LocationAccuracy.high,
// // //       );
// // //
// // //       setState(() {
// // //         latitude = position.latitude.toString();
// // //         longitude = position.longitude.toString();
// // //       });
// // //
// // //       _registerUser(latitude: latitude, longitude: longitude);
// // //     } catch (e) {
// // //       _registerWithDummyLocation();
// // //     }
// // //   }
// // //
// // //   void _registerWithDummyLocation() {
// // //     _registerUser(latitude: dummyLatitude, longitude: dummyLongitude);
// // //   }
// // //   String _formatDob(String? dob) {
// // //     if (dob == null || dob.isEmpty) {
// // //       throw Exception("Date of Birth is required and cannot be empty.");
// // //     }
// // //     try {
// // //       // Convert `27-12-2000` to `2000-12-27`
// // //       final parts = dob.split('-');
// // //       if (parts.length == 3) {
// // //         return '${parts[2]}-${parts[1]}-${parts[0]}'; // Rearrange to `YYYY-MM-DD`
// // //       }
// // //     } catch (e) {
// // //       print("Date conversion error: $e");
// // //     }
// // //     throw Exception("Invalid Date of Birth format. Expected format is DD-MM-YYYY.");
// // //   }
// // //
// // //   Future<void> _registerUser({required String? latitude, required String? longitude}) async {
// // //     final String apiUrl = "https://demo.samsidh.com/api/v1/register";
// // //
// // //     try {
// // //       if (arguments == null) {
// // //         throw Exception("Arguments are missing.");
// // //       }
// // //
// // //       // Validate required fields
// // //       final requiredFields = [
// // //         "gender",
// // //         "name",
// // //         "email",
// // //         "dateOfBirth",
// // //         "selectedCategory",
// // //         "password",
// // //         "phoneNumber"
// // //       ];
// // //
// // //       for (String field in requiredFields) {
// // //         if (arguments![field] == null || arguments![field].toString().trim().isEmpty) {
// // //           throw Exception("$field is required.");
// // //         }
// // //       }
// // //
// // //       String? username = arguments?["username"];
// // //       if (username == null || username.trim().isEmpty) {
// // //         final String name = arguments!["name"].toString().trim();
// // //         username = "$name${Random().nextInt(9000) + 1000}";
// // //       }
// // //
// // //       Map<String, String> registrationData = {
// // //         "gender": arguments!["gender"],
// // //         "name": arguments!["name"],
// // //         "username": username,
// // //         "email": arguments!["email"],
// // //         // "dob": arguments!["dateOfBirth"],
// // //         "dob": _formatDob(arguments!["dateOfBirth"]),
// // //
// // //         "looking_for": arguments!["selectedCategory"],
// // //         "latitude": latitude ?? dummyLatitude,
// // //         "longitude": longitude ?? dummyLongitude,
// // //         "password": arguments!["password"],
// // //         "mobile": arguments!["phoneNumber"],
// // //         "interest": arguments?["interest"] ?? "Reading",
// // //         "isPrivate": (arguments?["isPrivate"] ?? true).toString(),
// // //       };
// // //
// // //       print("### POSTING DATA ###");
// // //       print(registrationData);
// // //
// // //       var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
// // //
// // //       // Add text data
// // //       registrationData.forEach((key, value) {
// // //         request.fields[key] = value;
// // //       });
// // //
// // //       // Add image files with MIME type validation
// // //       for (var imagePath in uploadedImages) {
// // //         final mimeType = lookupMimeType(imagePath);
// // //         if (mimeType == null || !(mimeType == 'image/jpeg' || mimeType == 'image/png')) {
// // //           print("Invalid file type: $imagePath, MIME Type: $mimeType");
// // //           _showSnackBar("Invalid image format for $imagePath. Only JPEG and PNG are allowed.");
// // //           continue;
// // //         }
// // //
// // //         if (await File(imagePath).exists()) {
// // //           print("Adding Image Path to Request: $imagePath");
// // //           request.files.add(
// // //             await http.MultipartFile.fromPath(
// // //               'uploads_profile',
// // //               imagePath,
// // //               contentType: MediaType('image', mimeType.split('/')[1]),
// // //             ),
// // //           );
// // //         } else {
// // //           print("Invalid image path: $imagePath");
// // //         }
// // //       }
// // //
// // //       _showLoadingDialog("Please wait...");
// // //
// // //       var response = await request.send();
// // //       Navigator.pop(context); // Dismiss loading dialog
// // //
// // //       if (response.statusCode == 200) {
// // //         final responseBody = jsonDecode(await response.stream.bytesToString());
// // //         print("### API RESPONSE ###");
// // //         print(responseBody);
// // //
// // //         if (responseBody["code"] == "success") {
// // //           print("Registration Successful: ${responseBody["message"]}");
// // //           _storage.write("jwttoken", responseBody["jwttoken"]);
// // //           _storage.write("refresh_token", responseBody["refresh_token"]);
// // //           _showSuccessAlert("Account created successfully!");
// // //         } else {
// // //           throw Exception(responseBody["message"] ?? "Registration failed.");
// // //         }
// // //       } else {
// // //         final responseBody = await response.stream.bytesToString();
// // //         print("### API ERROR RESPONSE ###");
// // //         print("Status Code: ${response.statusCode}");
// // //         print("Error: $responseBody");
// // //         throw Exception("Error: $responseBody");
// // //       }
// // //     } catch (e) {
// // //       print("### EXCEPTION ###");
// // //       print("Exception: $e");
// // //       _showSnackBar("Error: ${e.toString()}");
// // //     }
// // //   }
// // //
// // //   void _showSnackBar(String message) {
// // //     ScaffoldMessenger.of(context).showSnackBar(
// // //       SnackBar(
// // //         content: Text(message),
// // //       ),
// // //     );
// // //   }
// // //
// // //   void _showLoadingDialog(String message) {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           content: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               CircularProgressIndicator(),
// // //               const SizedBox(height: 20),
// // //               Text(
// // //                 message,
// // //                 textAlign: TextAlign.center,
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   void _showSuccessAlert(String message) {
// // //     showDialog(
// // //       context: context,
// // //       barrierDismissible: false,
// // //       builder: (BuildContext context) {
// // //         return AlertDialog(
// // //           title: const Text("Success"),
// // //           content: Text(message),
// // //           actions: [
// // //             TextButton(
// // //               onPressed: () {
// // //                 Navigator.pop(context);
// // //                 Navigator.pushReplacementNamed(context, '/login');
// // //               },
// // //               child: const Text("OK"),
// // //             ),
// // //           ],
// // //         );
// // //       },
// // //     );
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.pink[50],
// // //       body: Center(
// // //         child: Column(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Icon(
// // //               Icons.location_on,
// // //               size: 100,
// // //               color: Colors.red,
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Text(
// // //               "Enable Your Location",
// // //               style: TextStyle(
// // //                 fontSize: 22,
// // //                 fontWeight: FontWeight.bold,
// // //                 color: Colors.black,
// // //               ),
// // //               textAlign: TextAlign.center,
// // //             ),
// // //             const SizedBox(height: 8),
// // //             Text(
// // //               "Choose your location to start finding people around you",
// // //               style: TextStyle(fontSize: 16, color: Colors.black54),
// // //               textAlign: TextAlign.center,
// // //             ),
// // //             const SizedBox(height: 30),
// // //             ElevatedButton(
// // //               style: ElevatedButton.styleFrom(
// // //                 backgroundColor: Colors.pink,
// // //                 shape: RoundedRectangleBorder(
// // //                   borderRadius: BorderRadius.circular(10),
// // //                 ),
// // //                 padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
// // //               ),
// // //               onPressed: _getCurrentLocation,
// // //               child: const Text(
// // //                 "Allow Location Access",
// // //                 style: TextStyle(fontSize: 16, color: Colors.white),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             TextButton(
// // //               onPressed: _registerWithDummyLocation,
// // //               child: Text(
// // //                 "Enter Location Manually",
// // //                 style: TextStyle(fontSize: 16, color: Colors.pink),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'dart:convert';
// // import 'dart:io';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:get_storage/get_storage.dart';
// // import 'package:mime/mime.dart';
// // import 'package:http_parser/http_parser.dart';
// //
// // class LocationPermissionPage extends StatefulWidget {
// //   @override
// //   _LocationPermissionPageState createState() => _LocationPermissionPageState();
// // }
// //
// // class _LocationPermissionPageState extends State<LocationPermissionPage> {
// //   final GetStorage _storage = GetStorage();
// //   String? latitude;
// //   String? longitude;
// //   Map<String, dynamic>? arguments;
// //   List<String> uploadedImages = [];
// //   final String dummyLatitude = "37.7749";
// //   final String dummyLongitude = "-122.4194";
// //
// //   List<String> travelDatingQuotes = [
// //     "Adventure awaits, let’s explore together!",
// //     "Love knows no distance, let's find it nearby.",
// //     "Travel far, love near.",
// //     "The journey is sweeter with someone special.",
// //     "Wanderlust and love, a perfect combination.",
// //   ];
// //
// //   @override
// //   void didChangeDependencies() {
// //     super.didChangeDependencies();
// //     final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
// //     if (args != null) {
// //       setState(() {
// //         arguments = args;
// //         uploadedImages = (args['uploadedImages'] as List<dynamic>?)
// //             ?.map((e) => e.toString())
// //             .toList() ??
// //             [];
// //       });
// //     }
// //   }
// //
// //   void _getCurrentLocation() async {
// //     try {
// //       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
// //       if (!serviceEnabled) {
// //         _registerWithDummyLocation();
// //         return;
// //       }
// //
// //       LocationPermission permission = await Geolocator.checkPermission();
// //       if (permission == LocationPermission.denied) {
// //         permission = await Geolocator.requestPermission();
// //         if (permission == LocationPermission.denied) {
// //           _registerWithDummyLocation();
// //           return;
// //         }
// //       }
// //
// //       if (permission == LocationPermission.deniedForever) {
// //         _registerWithDummyLocation();
// //         return;
// //       }
// //
// //       Position position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );
// //
// //       setState(() {
// //         latitude = position.latitude.toString();
// //         longitude = position.longitude.toString();
// //       });
// //
// //       _registerUser(latitude: latitude, longitude: longitude);
// //     } catch (e) {
// //       print("Error fetching location: $e");
// //       _registerWithDummyLocation();
// //     }
// //   }
// //
// //   void _registerWithDummyLocation() {
// //     _registerUser(latitude: dummyLatitude, longitude: dummyLongitude);
// //   }
// //
// //   String getRandomQuote() {
// //     return travelDatingQuotes[Random().nextInt(travelDatingQuotes.length)];
// //   }
// //
// //   String _formatDob(String? dob) {
// //     if (dob == null || dob.isEmpty) {
// //       throw Exception("Date of Birth is required and cannot be empty.");
// //     }
// //     try {
// //       final parts = dob.split('-');
// //       if (parts.length == 3) {
// //         return '${parts[2]}-${parts[1]}-${parts[0]}';
// //       }
// //     } catch (e) {
// //       print("Date conversion error: $e");
// //     }
// //     throw Exception("Invalid Date of Birth format. Expected format is DD-MM-YYYY.");
// //   }
// //
// //   Future<void> _registerUser({required String? latitude, required String? longitude}) async {
// //     final String apiUrl = "https://demo.samsidh.com/api/v1/register";
// //
// //     try {
// //       if (arguments == null) {
// //         throw Exception("Arguments are missing.");
// //       }
// //
// //       final requiredFields = [
// //         "gender",
// //         "name",
// //         "email",
// //         "dateOfBirth",
// //         "selectedCategory",
// //         "password",
// //         "phoneNumber"
// //       ];
// //
// //       for (String field in requiredFields) {
// //         if (arguments![field] == null || arguments![field].toString().trim().isEmpty) {
// //           throw Exception("$field is required.");
// //         }
// //       }
// //
// //       String? username = arguments?["username"];
// //       if (username == null || username.trim().isEmpty) {
// //         final String name = arguments!["name"].toString().trim();
// //         username = "$name${Random().nextInt(9000) + 1000}";
// //       }
// //
// //       Map<String, String> registrationData = {
// //         "gender": arguments!["gender"],
// //         "name": arguments!["name"],
// //         "username": username,
// //         "email": arguments!["email"],
// //         "dob": _formatDob(arguments!["dateOfBirth"]),
// //         "looking_for": arguments!["selectedCategory"],
// //         "latitude": latitude ?? dummyLatitude,
// //         "longitude": longitude ?? dummyLongitude,
// //         "password": arguments!["password"],
// //         "mobile": arguments!["phoneNumber"],
// //         "interest": arguments?["interest"] ?? "Reading",
// //         "isPrivate": (arguments?["isPrivate"] ?? true).toString(),
// //       };
// //
// //       var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
// //
// //       registrationData.forEach((key, value) {
// //         request.fields[key] = value;
// //       });
// //
// //       for (var imagePath in uploadedImages) {
// //         final mimeType = lookupMimeType(imagePath);
// //         if (mimeType == null || !(mimeType == 'image/jpeg' || mimeType == 'image/png')) {
// //           print("Invalid image format: $imagePath, MIME Type: $mimeType");
// //           continue;
// //         }
// //
// //         if (await File(imagePath).exists()) {
// //           request.files.add(
// //             await http.MultipartFile.fromPath(
// //               'uploads_profile',
// //               imagePath,
// //               contentType: MediaType('image', mimeType.split('/')[1]),
// //             ),
// //           );
// //         }
// //       }
// //
// //       print(getRandomQuote());
// //       var response = await request.send();
// //
// //       if (response.statusCode == 200) {
// //         final responseBody = jsonDecode(await response.stream.bytesToString());
// //         print("### API RESPONSE ###\n$responseBody");
// //
// //         if (responseBody["code"] == "success") {
// //           _storage.write("jwttoken", responseBody["jwttoken"]);
// //           _storage.write("refresh_token", responseBody["refresh_token"]);
// //           _showSuccessAlert("Account created successfully!");
// //         } else {
// //           throw Exception(responseBody["message"] ?? "Registration failed.");
// //         }
// //       } else {
// //         final responseBody = await response.stream.bytesToString();
// //         print("### API ERROR RESPONSE ###\nStatus Code: ${response.statusCode}\n$responseBody");
// //
// //         if (response.statusCode == 500 && responseBody.contains("Username, email, or mobile already exists")) {
// //           _showErrorBottomSheet({
// //             "email": registrationData["email"],
// //             "mobile": registrationData["mobile"],
// //           });
// //         } else {
// //           throw Exception("Error: $responseBody");
// //         }
// //       }
// //     } catch (e) {
// //       print("Exception: $e");
// //     }
// //   }
// //
// //   void _showErrorBottomSheet(Map<String, dynamic> responseData) {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
// //       ),
// //       builder: (BuildContext context) {
// //         final emailController = TextEditingController(text: responseData["email"]);
// //         final phoneController = TextEditingController(text: responseData["mobile"]);
// //
// //         return Padding(
// //           padding: EdgeInsets.only(
// //             bottom: MediaQuery.of(context).viewInsets.bottom,
// //             left: 20,
// //             right: 20,
// //             top: 20,
// //           ),
// //           child: Column(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Text(
// //                 "We found the provided email or phone number already exists. Kindly change it.",
// //                 style: TextStyle(fontSize: 16, color: Colors.black),
// //                 textAlign: TextAlign.center,
// //               ),
// //               SizedBox(height: 20),
// //               TextField(
// //                 controller: emailController,
// //                 decoration: InputDecoration(
// //                   labelText: "Email",
// //                   border: OutlineInputBorder(),
// //                 ),
// //               ),
// //               SizedBox(height: 10),
// //               TextField(
// //                 controller: phoneController,
// //                 decoration: InputDecoration(
// //                   labelText: "Phone Number",
// //                   border: OutlineInputBorder(),
// //                 ),
// //                 keyboardType: TextInputType.phone,
// //               ),
// //               SizedBox(height: 20),
// //               ElevatedButton.icon(
// //                 onPressed: () {
// //                   Navigator.pop(context);
// //                   _retryRegistration(
// //                     email: emailController.text.trim(),
// //                     phoneNumber: phoneController.text.trim(),
// //                   );
// //                 },
// //                 icon: Icon(Icons.check),
// //                 label: Text("Submit"),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// //
// //   void _retryRegistration({required String email, required String phoneNumber}) {
// //     setState(() {
// //       arguments?["email"] = email;
// //       arguments?["phoneNumber"] = phoneNumber;
// //     });
// //
// //     _registerUser(latitude: latitude, longitude: longitude);
// //   }
// //
// //   void _showSuccessAlert(String message) {
// //     showDialog(
// //       context: context,
// //       barrierDismissible: false,
// //       builder: (BuildContext context) {
// //         return AlertDialog(
// //           title: const Text("Success"),
// //           content: Text(message),
// //           actions: [
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //                 Navigator.pushReplacementNamed(context, '/login');
// //               },
// //               child: const Text("OK"),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.pink[50],
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(
// //               Icons.location_on,
// //               size: 100,
// //               color: Colors.red,
// //             ),
// //             const SizedBox(height: 20),
// //             Text(
// //               "Enable Your Location",
// //               style: TextStyle(
// //                 fontSize: 22,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.black,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 8),
// //             Text(
// //               "Choose your location to start finding people around you",
// //               style: TextStyle(fontSize: 16, color: Colors.black54),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(height: 30),
// //             ElevatedButton(
// //               onPressed: _getCurrentLocation,
// //               child: const Text("Allow Location Access"),
// //             ),
// //             const SizedBox(height: 20),
// //             TextButton(
// //               onPressed: _registerWithDummyLocation,
// //               child: Text("Enter Location Manually"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
// import 'package:mime/mime.dart';
// import 'package:http_parser/http_parser.dart';
//
// class LocationPermissionPage extends StatefulWidget {
//   @override
//   _LocationPermissionPageState createState() => _LocationPermissionPageState();
// }
//
// class _LocationPermissionPageState extends State<LocationPermissionPage> {
//   final GetStorage _storage = GetStorage();
//   String? latitude;
//   String? longitude;
//   Map<String, dynamic>? arguments;
//   List<String> uploadedImages = [];
//   final String dummyLatitude = "37.7749";
//   final String dummyLongitude = "-122.4194";
//
//   // Quotes for travel/dating
//   List<String> travelDatingQuotes = [
//     "Adventure awaits, let’s explore together!",
//     "Love knows no distance, let's find it nearby.",
//     "Travel far, love near.",
//     "The journey is sweeter with someone special.",
//     "Wanderlust and love, a perfect combination.",
//   ];
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
//     if (args != null) {
//       setState(() {
//         arguments = args;
//         uploadedImages = (args['uploadedImages'] as List<dynamic>?)
//             ?.map((e) => e.toString())
//             .toList() ??
//             [];
//       });
//     }
//   }
//
//   void _getCurrentLocation() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         _registerWithDummyLocation();
//         return;
//       }
//
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           _registerWithDummyLocation();
//           return;
//         }
//       }
//
//       if (permission == LocationPermission.deniedForever) {
//         _registerWithDummyLocation();
//         return;
//       }
//
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//
//       setState(() {
//         latitude = position.latitude.toString();
//         longitude = position.longitude.toString();
//       });
//
//       _registerUser(latitude: latitude, longitude: longitude);
//     } catch (e) {
//       print("Error fetching location: $e");
//       _registerWithDummyLocation();
//     }
//   }
//
//   void _registerWithDummyLocation() {
//     _registerUser(latitude: dummyLatitude, longitude: dummyLongitude);
//   }
//
//   String getRandomQuote() {
//     return travelDatingQuotes[Random().nextInt(travelDatingQuotes.length)];
//   }
//
//   Future<void> _registerUser({required String? latitude, required String? longitude}) async {
//     final String apiUrl = "https://demo.samsidh.com/api/v1/register";
//
//     try {
//       if (arguments == null) {
//         throw Exception("Arguments are missing.");
//       }
//
//       final requiredFields = [
//         "gender",
//         "name",
//         "email",
//         "dateOfBirth",
//         "selectedCategory",
//         "password",
//         "phoneNumber"
//       ];
//
//       for (String field in requiredFields) {
//         if (arguments![field] == null || arguments![field].toString().trim().isEmpty) {
//           throw Exception("$field is required.");
//         }
//       }
//
//       String? username = arguments?["username"];
//       if (username == null || username.trim().isEmpty) {
//         final String name = arguments!["name"].toString().trim();
//         username = "$name${Random().nextInt(9000) + 1000}";
//       }
//
//       Map<String, String> registrationData = {
//         "gender": arguments!["gender"],
//         "name": arguments!["name"],
//         "username": username,
//         "email": arguments!["email"],
//         "dob": arguments!["dateOfBirth"],
//         "looking_for": arguments!["selectedCategory"],
//         "latitude": latitude ?? dummyLatitude,
//         "longitude": longitude ?? dummyLongitude,
//         "password": arguments!["password"],
//         "mobile": arguments!["phoneNumber"],
//         "interest": arguments?["interest"] ?? "Reading",
//         "isPrivate": (arguments?["isPrivate"] ?? true).toString(),
//       };
//
//       var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
//
//       registrationData.forEach((key, value) {
//         request.fields[key] = value;
//       });
//
//       _showLoadingDialog(getRandomQuote());
//
//       var response = await request.send();
//       Navigator.pop(context);
//
//       if (response.statusCode == 200) {
//         final responseBody = jsonDecode(await response.stream.bytesToString());
//         print("### API RESPONSE ###\n$responseBody");
//
//         if (responseBody["code"] == "success") {
//           _storage.write("jwttoken", responseBody["jwttoken"]);
//           _storage.write("refresh_token", responseBody["refresh_token"]);
//           _showSuccessAlert("Account created successfully!\n${getRandomQuote()}\n\nPlease login with your credentials.");
//         } else {
//           throw Exception(responseBody["message"] ?? "Registration failed.");
//         }
//       } else {
//         final responseBody = await response.stream.bytesToString();
//         print("### API ERROR RESPONSE ###\nStatus Code: ${response.statusCode}\n$responseBody");
//
//         if (response.statusCode == 500 && responseBody.contains("Username, email, or mobile already exists")) {
//           _showErrorBottomSheet({
//             "email": registrationData["email"],
//             "mobile": registrationData["mobile"],
//           });
//         } else {
//           throw Exception("Error: $responseBody");
//         }
//       }
//     } catch (e) {
//       print("Exception: $e");
//     }
//   }
//
//   void _showLoadingDialog(String quote) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(),
//               SizedBox(height: 20),
//               Text(
//                 "Please wait...",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 quote,
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showErrorBottomSheet(Map<String, dynamic> responseData) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (BuildContext context) {
//         final emailController = TextEditingController(text: responseData["email"]);
//         final phoneController = TextEditingController(text: responseData["mobile"]);
//
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//             left: 20,
//             right: 20,
//             top: 20,
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "We found the provided email or phone number already exists. Kindly change it.",
//                 style: TextStyle(fontSize: 16, color: Colors.black),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               SizedBox(height: 10),
//               TextField(
//                 controller: phoneController,
//                 decoration: InputDecoration(
//                   labelText: "Phone Number",
//                   border: OutlineInputBorder(),
//                 ),
//                 keyboardType: TextInputType.phone,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   _retryRegistration(
//                     email: emailController.text.trim(),
//                     phoneNumber: phoneController.text.trim(),
//                   );
//                 },
//                 icon: Icon(Icons.check),
//                 label: Text("Submit"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _retryRegistration({required String email, required String phoneNumber}) {
//     setState(() {
//       arguments?["email"] = email;
//       arguments?["phoneNumber"] = phoneNumber;
//     });
//
//     _registerUser(latitude: latitude, longitude: longitude);
//   }
//
//   void _showSuccessAlert(String message) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.pink[50],
//           title: Text(
//             "Success",
//             style: TextStyle(color: Colors.pink),
//           ),
//           content: Text(
//             message,
//             style: TextStyle(fontSize: 16, color: Colors.black),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacementNamed(context, '/login');
//               },
//               child: Text(
//                 "Login",
//                 style: TextStyle(color: Colors.pink),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.location_on,
//               size: 100,
//               color: Colors.pink,
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Enable Your Location",
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 8),
//             Text(
//               "Choose your location to start finding people around you",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.pink,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
//               ),
//               onPressed: _getCurrentLocation,
//               child: Text(
//                 "Allow Location Access",
//                 style: TextStyle(fontSize: 16, color: Colors.white),
//               ),
//             ),
//             SizedBox(height: 20),
//             TextButton(
//               onPressed: _registerWithDummyLocation,
//               child: Text(
//                 "Enter Location Manually",
//                 style: TextStyle(fontSize: 16, color: Colors.pink),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class LocationPermissionPage extends StatefulWidget {
  @override
  _LocationPermissionPageState createState() => _LocationPermissionPageState();
}

class _LocationPermissionPageState extends State<LocationPermissionPage> {
  final GetStorage _storage = GetStorage();
  String? latitude;
  String? longitude;
  Map<String, dynamic>? arguments;
  List<String> uploadedImages = [];
  final String dummyLatitude = "37.7749";
  final String dummyLongitude = "-122.4194";

  // Quotes for travel/dating
  List<String> travelDatingQuotes = [
    "Adventure awaits, let’s explore together!",
    "Love knows no distance, let's find it nearby.",
    "Travel far, love near.",
    "The journey is sweeter with someone special.",
    "Wanderlust and love, a perfect combination.",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      setState(() {
        arguments = args;
        uploadedImages = (args['uploadedImages'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
            [];
      });
    }
  }

  // Convert DOB from DD-MM-YYYY to YYYY-MM-DD
  String _formatDob(String? dob) {
    if (dob == null || dob.isEmpty) {
      throw Exception("Date of Birth is required and cannot be empty.");
    }
    try {
      final parts = dob.split('-');
      if (parts.length == 3) {
        return '${parts[2]}-${parts[1]}-${parts[0]}'; // Rearrange to YYYY-MM-DD
      }
    } catch (e) {
      print("Date conversion error: $e");
    }
    throw Exception("Invalid Date of Birth format. Expected format is DD-MM-YYYY.");
  }

  void _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _registerWithDummyLocation();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _registerWithDummyLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _registerWithDummyLocation();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });

      _registerUser(latitude: latitude, longitude: longitude);
    } catch (e) {
      print("Error fetching location: $e");
      _registerWithDummyLocation();
    }
  }

  void _registerWithDummyLocation() {
    _registerUser(latitude: dummyLatitude, longitude: dummyLongitude);
  }

  String getRandomQuote() {
    return travelDatingQuotes[Random().nextInt(travelDatingQuotes.length)];
  }

  Future<void> _registerUser({required String? latitude, required String? longitude}) async {
    final String apiUrl = "https://demo.samsidh.com/api/v1/register";

    try {
      if (arguments == null) {
        throw Exception("Arguments are missing.");
      }

      final requiredFields = [
        "gender",
        "name",
        "email",
        "dateOfBirth",
        "selectedCategory",
        "password",
        "phoneNumber"
      ];

      for (String field in requiredFields) {
        if (arguments![field] == null || arguments![field].toString().trim().isEmpty) {
          throw Exception("$field is required.");
        }
      }

      String? username = arguments?["username"];
      if (username == null || username.trim().isEmpty) {
        final String name = arguments!["name"].toString().trim();
        username = "$name${Random().nextInt(9000) + 1000}";
      }

      Map<String, String> registrationData = {
        "gender": arguments!["gender"],
        "name": arguments!["name"],
        "username": username,
        "email": arguments!["email"],
        "dob": _formatDob(arguments!["dateOfBirth"]),
        "looking_for": arguments!["selectedCategory"],
        "latitude": latitude ?? dummyLatitude,
        "longitude": longitude ?? dummyLongitude,
        "password": arguments!["password"],
        "mobile": arguments!["phoneNumber"],
        "interest": arguments?["interest"] ?? "Reading",
        "isPrivate": (arguments?["isPrivate"] ?? true).toString(),
      };

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      registrationData.forEach((key, value) {
        request.fields[key] = value;
      });

      for (var imagePath in uploadedImages) {
        final mimeType = lookupMimeType(imagePath);
        if (mimeType == null || !(mimeType == 'image/jpeg' || mimeType == 'image/png')) {
          print("Invalid file type: $imagePath, MIME Type: $mimeType");
          continue;
        }

        if (await File(imagePath).exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'uploads_profile',
              imagePath,
              contentType: MediaType('image', mimeType.split('/')[1]),
            ),
          );
        }
      }

      _showLoadingDialog(getRandomQuote());

      var response = await request.send();
      Navigator.pop(context);

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(await response.stream.bytesToString());
        print("### API RESPONSE ###\n$responseBody");

        if (responseBody["code"] == "success") {
          _storage.write("jwttoken", responseBody["jwttoken"]);
          _storage.write("refresh_token", responseBody["refresh_token"]);
          _showSuccessAlert("Account created successfully!\n${getRandomQuote()}\n\nPlease login with your credentials.");
        } else {
          throw Exception(responseBody["message"] ?? "Registration failed.");
        }
      } else {
        final responseBody = await response.stream.bytesToString();
        print("### API ERROR RESPONSE ###\nStatus Code: ${response.statusCode}\n$responseBody");

        if (response.statusCode == 500 && responseBody.contains("Username, email, or mobile already exists")) {
          _showErrorBottomSheet({
            "email": registrationData["email"],
            "mobile": registrationData["mobile"],
          });
        } else {
          throw Exception("Error: $responseBody");
        }
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  void _showLoadingDialog(String quote) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(
                "Please wait...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                quote,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorBottomSheet(Map<String, dynamic> responseData) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        final emailController = TextEditingController(text: responseData["email"]);
        final phoneController = TextEditingController(text: responseData["mobile"]);

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "We found the provided email or phone number already exists. Kindly change it.",
                style: TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _retryRegistration(
                    email: emailController.text.trim(),
                    phoneNumber: phoneController.text.trim(),
                  );
                },
                icon: Icon(Icons.check),
                label: Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _retryRegistration({required String email, required String phoneNumber}) {
    setState(() {
      arguments?["email"] = email;
      arguments?["phoneNumber"] = phoneNumber;
    });

    _registerUser(latitude: latitude, longitude: longitude);
  }

  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink[50],
          title: Text(
            "Success",
            style: TextStyle(color: Colors.pink),
          ),
          content: Text(
            message,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 100,
              color: Colors.pink,
            ),
            SizedBox(height: 20),
            Text(
              "Enable Your Location",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Choose your location to start finding people around you",
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
              onPressed: _getCurrentLocation,
              child: Text(
                "Allow Location Access",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _registerWithDummyLocation,
              child: Text(
                "Enter Location Manually",
                style: TextStyle(fontSize: 16, color: Colors.pink),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
