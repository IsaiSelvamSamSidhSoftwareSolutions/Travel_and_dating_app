// import 'package:flutter/material.dart';
// import 'driver.dart';
//
//
// class DriverProfilePage extends StatelessWidget {
//   final Driver driver; // Driver object
//   final Map<String, dynamic> carDetails;
//   final String carId;
//   final String? imagePath;
//   final String? tripTitle;
//   final String? tripDetails;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final TimeOfDay? startTime;
//   final TimeOfDay? endTime;
//   final String? numberofmembers;
//   final Map<String, dynamic> budget;
//   final List<Map<String, String>> schedule;
//
//   const DriverProfilePage({
//     Key? key,
//     required this.driver,
//     required this.schedule,
//     required this.carDetails,
//     required this.carId,
//     this.imagePath,
//     this.tripTitle,
//     this.tripDetails,
//     this.startDate,
//     this.endDate,
//     this.startTime,
//     this.endTime,
//     this.numberofmembers,
//     required this.budget,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFDBE0),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.pink),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Driver Details',
//           style: TextStyle(color: Colors.black, fontSize: 18),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 60,
//               backgroundImage: NetworkImage(driver.imageUrl),
//               onBackgroundImageError: (_, __) => Icon(Icons.person, size: 60),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               driver.name,
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 5),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.star, color: Colors.amber, size: 20),
//                 SizedBox(width: 5),
//                 Text(
//                   driver.rating.toString(),
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFFFEAEA),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _detailRow('Phone', driver.phone ?? 'N/A'),
//                   _detailRow('Email', driver.email ?? 'N/A'),
//                   _detailRow('Address', driver.address ?? 'N/A'),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _detailRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             value,
//             style: TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'driver.dart';
import 'TripCreationApi.dart';
class DriverProfilePage extends StatelessWidget {
  final Driver driver; // Driver object
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

  const DriverProfilePage({
    Key? key,
    required this.driver,
    required this.schedule,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug print all the passed arguments
    print('Driver: ${driver.toString()}');
    print('Car Details: $carDetails');
    print('Car ID: $carId');
    print('Image Path: $imagePath');
    print('Trip Title: $tripTitle');
    print('Trip Details: $tripDetails');
    print('Start Date: $startDate');
    print('End Date: $endDate');
    print('Start Time: $startTime');
    print('End Time: $endTime');
    print('Number of Members: $numberofmembers');
    print('Budget: $budget');
    print('Schedule: $schedule');

    return Scaffold(
      backgroundColor: const Color(0xFFFFDBE0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.pink),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Driver Details',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(driver.imageUrl),
              onBackgroundImageError: (_, __) =>
              const Icon(Icons.person, size: 60),
            ),
            const SizedBox(height: 10),
            Text(
              driver.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 5),
                Text(
                  driver.rating.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEAEA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _detailRow('Phone', driver.phone ?? 'N/A'),
                  _detailRow('Email', driver.email ?? 'N/A'),
                  _detailRow('Address', driver.address ?? 'N/A'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTrip(
                      driver: driver,
                      schedule: schedule,
                      carId: carId,
                      imagePath: imagePath,
                      tripTitle: tripTitle,
                      tripDetails: tripDetails,
                      startDate: startDate,
                      endDate: endDate,
                      startTime: startTime,
                      endTime: endTime,
                      numberofmembers: numberofmembers,
                      budget: budget,
                    ),
                  ),
                );
              },
              child: const Text('Create Trip'),
            ),
          ],
        ),
      ),
    );
  }
  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}