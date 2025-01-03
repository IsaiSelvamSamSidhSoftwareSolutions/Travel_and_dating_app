import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Driverprofile.dart';
import 'driver.dart';
// Driver List Page
class DriverList extends StatefulWidget {
  // Define the properties
  final Map<String, dynamic> carDetails;
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
  final List<Map<String, String>> schedule;

  // Constructor to initialize the properties
  const DriverList({
    Key? key,
    required this.carDetails,
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
    required this.schedule,
  }) : super(key: key);

  @override
  _DriverGridScreenState createState() => _DriverGridScreenState();
}

class _DriverGridScreenState extends State<DriverList> {
  late Future<List<Driver>> _drivers;
  final GetStorage _storage = GetStorage();

  Future<List<Driver>> fetchDrivers() async {
    final String jwtToken = _storage.read('jwttoken') ?? '';
    final String username = _storage.read('username') ?? '';
    final String email = _storage.read('email') ?? '';

    final response = await http.get(
      Uri.parse('https://demo.samsidh.com/api/v1/trips/drivers'),
      headers: {
        'Authorization': 'Bearer $jwtToken',
        'Content-Type': 'application/json',
        'username': username,
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> drivers = json.decode(response.body)['drivers'];
      return drivers.map((json) => Driver.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load drivers');
    }
  }

  @override
  void initState() {
    super.initState();
    _drivers = fetchDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Driver', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: FutureBuilder<List<Driver>>(
        future: _drivers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No drivers available'));
          }

          final drivers = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 3 / 4,
            ),
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];

              return GestureDetector(
                onTap: () {
                  // Debug print to confirm the data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DriverProfilePage(
                        carDetails: widget.carDetails,
                        carId: widget.carId,
                        imagePath: widget.imagePath,
                        tripTitle: widget.tripTitle,
                        tripDetails: widget.tripDetails,
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        numberofmembers: widget.numberofmembers,
                        budget: widget.budget,
                        schedule: widget.schedule,
                        driver: driver,
                      ),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          driver.imageUrl,
                          height: 180.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Icon(
                                Icons.person,
                                size: 50.0,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        driver.name,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        '${driver.rating} ★',
                        style: TextStyle(fontSize: 14.0, color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


