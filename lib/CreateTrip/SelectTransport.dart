import 'package:flutter/material.dart';
import 'Listofcars.dart';

class TransportSelectionScreen extends StatelessWidget {
  final String? imagePath;
  final String? tripTitle;
  final String? tripDetails;
  final DateTime? startDate;
  final DateTime? endDate;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final Map<String, dynamic> budget;
  final List<Map<String, String>> schedule;
  final String? numberofmembers;

  TransportSelectionScreen({
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
  });

  final List<Map<String, dynamic>> transports = [
    {'name': 'Car', 'icon': Icons.directions_car},
    {'name': 'Bike', 'icon': Icons.pedal_bike},
    {'name': 'Cycle', 'icon': Icons.directions_bike},
    {'name': 'Taxi', 'icon': Icons.local_taxi},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Select Your Transport',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            childAspectRatio: 1.0,
          ),
          itemCount: transports.length,
          itemBuilder: (context, index) {
            final transport = transports[index];
            return GestureDetector(
              onTap: () {
                if (transport['name'] == 'Car') {
                  Navigator.push(
                    context,
                      MaterialPageRoute(
                        builder: (context) => AvailableCarsScreen(
                          imagePath: imagePath ?? 'assets/default_image.png',
                          tripTitle: tripTitle ?? 'Trip Title',
                          tripDetails: tripDetails ?? 'Trip Details',
                          startDate: startDate,
                          endDate: endDate,
                          startTime: startTime,
                          endTime: endTime,
                          numberofmembers: numberofmembers ?? '1',
                          budget: budget.isNotEmpty
                              ? budget
                              : {
                            "total": 0.0,
                            "breakdown": [
                              {'category': 'Default', 'amount': 0.0}
                            ],
                          },
                          schedule: schedule
                        ),
                      )
                  );
                } else {
                  // Handle other transport selections here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Feature for ${transport['name']} coming soon!')),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.pink, width: 2.0),
                    ),
                    child: Icon(
                      transport['icon'],
                      size: 50.0,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    transport['name']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: Color(0xFFFFF5F7),
    );
  }
}
