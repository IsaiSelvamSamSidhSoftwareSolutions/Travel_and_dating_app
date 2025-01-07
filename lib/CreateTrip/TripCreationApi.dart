
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'driver.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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

  Future<void> _createTrip() async {
    final String jwtToken = _storage.read('jwttoken') ?? '';
    final String username = _storage.read('username') ?? '';
    final String email = _storage.read('email') ?? '';

    if (jwtToken.isEmpty || username.isEmpty || email.isEmpty) {
      _showToast("Authentication data is missing!");
      return;
    }

    if (widget.imagePath == null || widget.imagePath!.isEmpty) {
      _showToast("Image path is missing!");
      return;
    }

    final file = File(widget.imagePath!);
    if (!file.existsSync()) {
      _showToast("Image file does not exist!");
      return;
    }

    final mimeType = lookupMimeType(widget.imagePath!);
    if (mimeType == null || !mimeType.startsWith('image/')) {
      _showToast("Invalid file type! Only image files are allowed.");
      return;
    }

    setState(() => _isPosting = true);

    try {
      final uri = Uri.parse('https://demo.samsidh.com/api/v1/trips/createTrip');
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll({
        'Authorization': 'Bearer $jwtToken',
        'email': email,
        'username': username,
      });

      request.fields['title'] = widget.tripTitle ?? 'N/A';
      request.fields['details'] = widget.tripDetails ?? 'N/A';
      request.fields['startDate'] = widget.startDate?.toIso8601String() ?? '';
      request.fields['endDate'] = widget.endDate?.toIso8601String() ?? '';
      request.fields['numberOfPersons'] = widget.numberofmembers ?? '0';
      request.fields['persons'] =
          jsonEncode(["66c88aeea5b3d31dc1b0bb4b", "66c89643a5b3d31dc1b0bb51"]);
      request.fields['schedule'] = jsonEncode(widget.schedule);
      request.fields['budget'] = jsonEncode(widget.budget);
      request.fields['isPrivate'] = 'true';
      request.fields['drivers'] = jsonEncode([widget.driver.id]);
      request.fields['transports'] = jsonEncode([widget.carId]);

      request.files.add(
        await http.MultipartFile.fromPath(
          'images',
          widget.imagePath!,
          contentType: MediaType.parse(mimeType),
        ),
      );

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        _showSuccessAlert("Trip Created Sucessfully");
        print("API SUCESS REPONSE ${jsonDecode(responseData)}");
      } else {
        final errorData = await response.stream.bytesToString();
        print("API Error: ${response.statusCode}");
        print("Error Response: $errorData");
        _showToast("Failed to create trip. Check API response.");
      }
    } catch (e) {
      print("Exception: $e");
      _showToast("An error occurred. Please try again!");
    } finally {
      setState(() => _isPosting = false);
    }
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }


  Widget _buildDriverDetails() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            widget.imagePath ?? '',
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 100),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.driver.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
  void _showSuccessAlert(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
  Widget _buildBudgetDetails() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Budget Breakdown",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(widget.budget['breakdown'].length, (index) {
              final item = widget.budget['breakdown'][index];
              return ListTile(
                title: Text("Day ${index + 1}: ${item['category']}"),
                trailing: Text("₹${item['amount']}"),
              );
            }),
            const Divider(),
            ListTile(
              title: const Text("Total"),
              trailing: Text("₹${widget.budget['total']}"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleDetails() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...widget.schedule.map((activity) {
              return ListTile(
                title: Text("Date: ${activity['date']}"),
                subtitle: Text("Activity: ${activity['activity']}"),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Create Trip"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTripSummaryCard(),
            const SizedBox(height: 16),
            _buildBudgetDetails(),
            const SizedBox(height: 16),
            _buildScheduleDetails(),
            const SizedBox(height: 16),
            _buildDriverDetailsSection(),
            const SizedBox(height: 20),
            _buildPostTripButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTripSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trip Title: ${widget.tripTitle ?? 'N/A'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Trip Details: ${widget.tripDetails ?? 'N/A'}"),
            const SizedBox(height: 8),
            Text("Start Date: ${widget.startDate?.toIso8601String() ?? 'N/A'}"),
            const SizedBox(height: 8),
            Text("End Date: ${widget.endDate?.toIso8601String() ?? 'N/A'}"),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverDetailsSection() {
    return Column(
      children: [
        const Center(
          child: Text(
            "Driver Details",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
        Center(child: _buildDriverDetails()),
      ],
    );
  }

  Widget _buildPostTripButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _isPosting ? null : _createTrip,
        icon: const Icon(FontAwesomeIcons.paperPlane),
        label: const Text("Post Trip"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
    );
  }
}