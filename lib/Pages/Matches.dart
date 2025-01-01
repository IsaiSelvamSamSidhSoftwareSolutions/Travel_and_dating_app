import 'package:flutter/material.dart';

void main() {
  runApp(Match());
}

class Match extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MatchesPage(),
    );
  }
}

class MatchesPage extends StatelessWidget {
  final List<Map<String, String>> matches = List.generate(
    6,
        (index) => {
      "name": "Micheal Rose, 22",
      "location": "Delhi, India",
      "distance": "12 kms away",
      "image":
      "https://randomuser.me/api/portraits/women/${(index + 10)}.jpg", // Online profile images
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Matches",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterTab("All", true),
                _buildFilterTab("Newest", false),
                _buildFilterTab("Online", false),
                _buildFilterTab("Nearest", false),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Matches Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  return _buildMatchCard(
                    matches[index]["name"]!,
                    matches[index]["location"]!,
                    matches[index]["distance"]!,
                    matches[index]["image"]!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Filter Tab Widget
  Widget _buildFilterTab(String title, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.pinkAccent : Colors.transparent,
        border: Border.all(color: Colors.pinkAccent),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.pinkAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Match Card Widget
  Widget _buildMatchCard(
      String name, String location, String distance, String imageUrl) {
    return Stack(
      children: [
        // Card Container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image with Header Overlay
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Distance Label Overlay
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        distance,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Online Status Indicator
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      radius: 6,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              // Footer with Name and Location
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
