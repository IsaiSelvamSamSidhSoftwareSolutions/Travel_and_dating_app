import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'car_details_screen.dart';
class AvailableCarsScreen extends StatefulWidget {
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

  const AvailableCarsScreen({
    Key? key,
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
  State<AvailableCarsScreen> createState() => _AvailableCarsScreenState();
}

class _AvailableCarsScreenState extends State<AvailableCarsScreen> {
  final GetStorage _storage = GetStorage();
  List<dynamic> cars = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCars();
  }

  Future<void> fetchCars() async {
    final String jwtToken = _storage.read('jwttoken') ?? '';
    final String username = _storage.read('username') ?? '';
    final String email = _storage.read('email') ?? '';

    try {
      final response = await http.get(
        Uri.parse('https://demo.samsidh.com/api/v1/trips/transports'),
        headers: {
          'Authorization': 'Bearer $jwtToken',
          'username': username,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          cars = data['transports'];
          isLoading = false;
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.tripTitle ?? "Available Cars",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 600 ? 4 : 2, // Adjust for responsiveness
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 0.7, // Adjust for better card fit
          ),
          itemCount: cars.length,
          itemBuilder: (context, index) {
            final car = cars[index];
            final imageUrl = car['images'].isNotEmpty
                ? 'https://demo.samsidh.com/${car['images'][0].replaceAll(r'\\', '/')}'
                : widget.imagePath; // Fallback to provided image
            final carid = car['_id'];
            return GestureDetector(
              onTap: () {
                // Navigate to details screen
                Navigator.push(
                  context,
                    MaterialPageRoute(
                      builder: (context) => CarDetailsScreen(
                        carDetails: car,
                        carId: carid,
                        imagePath: widget.imagePath,
                        tripTitle: widget.tripTitle,
                        tripDetails: widget.tripDetails,
                        startDate: widget.startDate,
                        endDate: widget.endDate,
                        startTime: widget.startTime,
                        endTime: widget.endTime,
                        numberofmembers: widget.numberofmembers,
                        budget: (widget.budget.isNotEmpty && widget.budget is Map<String, dynamic>)
                            ? widget.budget
                            : {
                          "total": 0.0,
                          "breakdown": [
                            {'category': 'Default', 'amount': 0.0},
                          ],
                        },
                        schedule: widget.schedule,
                      ),
                    )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12.0),
                      ),
                      child: SizedBox(
                        height: 120.0,
                        width: double.infinity,
                        child: Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error,
                                size: 50, color: Colors.red);
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            car['name'] ?? 'Car Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            '${car['seats']} seats | ${car['fuelType']}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child:ElevatedButton(
                        onPressed: () {
                          // Print the arguments being passed
                          print('Navigating to CarDetailsScreen with arguments:');
                          print('Car ID: $carid');
                          print('Car Details: $car');
                          print('Image Path: ${widget.imagePath}');
                          print('Trip Title: ${widget.tripTitle}');
                          print('Trip Details: ${widget.tripDetails}');
                          print('Start Date: ${widget.startDate}');
                          print('End Date: ${widget.endDate}');
                          print('Start Time: ${widget.startTime}');
                          print('End Time: ${widget.endTime}');
                          print('Number of Members: ${widget.numberofmembers}');
                          print('Budget: ${widget.budget}');
                          print('Schedule: ${widget.schedule}');

                          // Navigate to CarDetailsScreen
                          Navigator.push(
                            context,
                              MaterialPageRoute(
                                builder: (context) => CarDetailsScreen(
                                  carDetails: car,
                                  carId: carid,
                                  imagePath: widget.imagePath,
                                  tripTitle: widget.tripTitle,
                                  tripDetails: widget.tripDetails,
                                  startDate: widget.startDate,
                                  endDate: widget.endDate,
                                  startTime: widget.startTime,
                                  endTime: widget.endTime,
                                  numberofmembers: widget.numberofmembers,
                                  budget: (widget.budget.isNotEmpty && widget.budget is Map<String, dynamic>)
                                      ? widget.budget
                                      : {
                                    "total": 0.0,
                                    "breakdown": [
                                      {'category': 'Default', 'amount': 0.0},
                                    ],
                                  },
                                  schedule: widget.schedule,
                                ),
                              )
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'View Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFFFFF5F7),
    );
  }
}


