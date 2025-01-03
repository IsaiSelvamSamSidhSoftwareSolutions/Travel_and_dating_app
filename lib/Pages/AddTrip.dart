import 'package:flutter/material.dart';
import 'package:travel_dating/Pages/ChooseTour.dart';
import '../CreateTrip/CreateTripForm.dart';
void main() {
  runApp(CreateTrip());
}

class CreateTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateTripPage(),
    );
  }
}

class CreateTripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Create a Trip Page",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // Page Title
            Text(
              "Explore New Adventures",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Create a new trip or join a trip",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            // "Create A New Trip" Card
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateTripScreen(),
                  ),
                );
              },
              child: _buildOptionCard(
                imagePath: "lib/assets/Trips/createtrip.png",
                label: "Create A New Trip",
                isNetwork: false,
              ),
            ),
            SizedBox(height: 40),
            // "Request Join" Card
            GestureDetector(
              onTap: () {
                // Add navigation logic for the "Request Join" screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CreateTripScreen(), // Replace with the appropriate page
                  ),
                );
              },
              child: _buildOptionCard(
                imagePath: "lib/assets/Trips/requestojoin.png",
                label: "Request Join",
                isNetwork: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Option Card Widget
  Widget _buildOptionCard(
      {required String imagePath, required String label, bool isNetwork = true}) {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: isNetwork
                ? Image.network(
              imagePath,
              height: 70,
              width: 70,
              fit: BoxFit.contain,
            )
                : Image.asset(
              imagePath,
              height: 70,
              width: 70,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
// Placeholder for "Request Join" navigation
class PlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Join"),
      ),
      body: Center(
        child: Text("Request Join Page"),
      ),
    );
  }
}
