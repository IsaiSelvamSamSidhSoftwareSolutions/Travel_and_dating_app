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
                  MaterialPageRoute(builder: (context) => CreateTripScreen()),
                );
              },
              child: _buildOptionCard(
                imageUrl: "https://s3-alpha-sig.figma.com/img/c82d/6e3c/da862b51ca2c77d062a9ce32475d7ce6?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=gsE7cH4vh01oaqJvleeO6Igi3F5TB~zVkIII0vmp93jflwqiyLpmqPxsYCJf7S5-WwudLUZ544X4w5eIMu4cr7oFypzVr0a4QsGao7MwRRPMIwsTmdcjCuj36DC588J-P0m0tgzYneJeXA9wxf2X-xY9uTgOVE~II4YfH~0WWZdaBfDVxG0BVKyCmykPWI0nsuVgezhG98DwnsCf1ACWL1iE5PTJ4U0Z00rHO4HVmj8kI3U80u7R1I5yCKWhOQ59SSXqaInP8eEgUuRS4-yoQwwcpC0Ss5Lu6ffkU5aDUCGeZbwIuyUa73Hmueb5B2d6iS0SH8q99hFxrcXN5umsSw__",
                label: "Create A New Trip",
              ),
            ),
            SizedBox(height: 40),
            // "Request Join" Card
            GestureDetector(
              onTap: () {
                // Add navigation logic for the "Request Join" screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CreateTripScreen()), // Replace with the appropriate page
                );
              },
              child: _buildOptionCard(
                imageUrl: "https://s3-alpha-sig.figma.com/img/94c3/0306/1d0620d3a441ba702e25be0808bc34a6?Expires=1735516800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=cAn8B99ftZNlmqf71ca0obtWCuZOtQcKW8moOQCidyrYF~G8sq-ydgoNMLAk1OeR9nJZSnJSlBi~Qg1t3jC6xM6t~DLOLplVHo3F~GRZTfnXH-PdaCgC7sRK6uLEXTooB1cGZaOzO~CK8ZSzvkxqb~iKLh6V1jBpKbHe1y1mVrXomUDFceH9fszmyr9~7nFcF0FA9XDYMGycXMsyolBc1JWK1cjh3qFFR6F96fb1lfGUlrkbA6f6I1pGCiITHv4JVikUL6a7QhRKJUpgGifYs4FXW5LoxHn0Rtor3OxkzDo2oIVtht2PJT7J-6cD5ErTagckHkKv1YHbAZB3uCeszw__",
                label: "Request Join",
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Option Card Widget
  Widget _buildOptionCard({required String imageUrl, required String label}) {
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
            child: Image.network(
              imageUrl,
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
