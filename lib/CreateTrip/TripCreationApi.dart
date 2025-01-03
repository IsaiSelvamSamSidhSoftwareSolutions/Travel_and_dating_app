import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'driver.dart';
class CreateTrip extends StatefulWidget {
  final Driver driver;
  final List<Map<String, String>> schedule;
  final String carId;
  final String? imagePath;
  final String? tripTitle;
  final String? tripDetails;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? numberofmembers;
  final Map<String, dynamic> budget;

  const CreateTrip({
    Key? key,
    required this.driver,
    required this.schedule,
    required this.carId,
    this.imagePath,
    this.tripTitle,
    this.tripDetails,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.numberofmembers,
    required this.budget,
  }) : super(key: key);

  @override
  _CreateTripState createState() => _CreateTripState();
}

class _CreateTripState extends State<CreateTrip> {
  final GetStorage _storage = GetStorage();
  bool _isPosting = false;
  final List<String> _quotes = [
    "Life is short, and the world is wide.",
    "Travel far enough to meet yourself.",
    "Wander often, wonder always.",
    "Collect moments, not things.",
  ];

  Future<void> _createTrip() async {
    // Retrieve stored values
    final String jwtToken = _storage.read('jwttoken') ?? '';
    final String username = _storage.read('username') ?? '';
    final String email = _storage.read('email') ?? '';

    // Validate the required values
    if (jwtToken.isEmpty || username.isEmpty || email.isEmpty) {
      Fluttertoast.showToast(
        msg: "Authentication data is missing!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // Prepare API request data
    final Map<String, dynamic> body = {
      'title': widget.tripTitle ?? 'N/A',
      'details': widget.tripDetails ?? 'N/A',
      'startDate': widget.startDate?.toIso8601String() ?? '',
      'endDate': widget.endDate?.toIso8601String() ?? '',
      'numberOfPersons': widget.numberofmembers ?? '0',
      'persons': jsonEncode(["66c88aeea5b3d31dc1b0bb4b", "66c89643a5b3d31dc1b0bb51"]),
      'schedule': jsonEncode(widget.schedule),
      'budget': jsonEncode(widget.budget),
      'isPrivate': 'true',
      'drivers': jsonEncode([widget.driver.id]),
      'transports': jsonEncode([widget.carId]),
    };

    setState(() {
      _isPosting = true;
    });

    Fluttertoast.showToast(
      msg: _quotes[DateTime.now().second % _quotes.length],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );

    try {
      final response = await http.post(
        Uri.parse('https://demo.samsidh.com/api/v1/trips/createTrip'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'email': email,
          'username': username,
        },
        body: body,
      );

      print("API Response: ${response.body}");

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        _showSuccessAlert(responseData);
      } else {
        print("API Error: ${response.statusCode}");
        print("Response: ${response.body}");
        Fluttertoast.showToast(
          msg: "Failed to create trip. Check API response.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      print("Exception: $e");
      Fluttertoast.showToast(
        msg: "An error occurred. Please try again!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isPosting = false;
      });
    }
  }

  void _showSuccessAlert(Map<String, dynamic> responseData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Trip Created Successfully!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Trip Title: ${responseData['title'] ?? 'N/A'}"),
              Text("Start Date: ${responseData['startDate'] ?? 'N/A'}"),
              Text("End Date: ${responseData['endDate'] ?? 'N/A'}"),
              Text("Number of Persons: ${responseData['numberOfPersons'] ?? 'N/A'}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Trip"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Trip Summary",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Driver: ${widget.driver.id}"),
            Text("Car ID: ${widget.carId}"),
            Text("Trip Title: ${widget.tripTitle ?? 'N/A'}"),
            Text("Trip Details: ${widget.tripDetails ?? 'N/A'}"),
            Text("Start Date: ${widget.startDate ?? 'N/A'}"),
            Text("End Date: ${widget.endDate ?? 'N/A'}"),
            Text("Number of Members: ${widget.numberofmembers ?? 'N/A'}"),
            Text("Budget: ${widget.budget['total']}"),
            const SizedBox(height: 20),
            _isPosting
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton.icon(
              onPressed: _createTrip,
              icon: const Icon(FontAwesomeIcons.paperPlane),
              label: const Text("Post Trip"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }
}

