import 'package:flutter/material.dart';

void main() {
  runApp(ChooseTours());
}

class ChooseTours extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectJoinTripPage(),
    );
  }
}

class SelectJoinTripPage extends StatelessWidget {
  final List<Map<String, String>> tours = [
    {"name": "Kandy", "image": "https://images.unsplash.com/photo-1570601544978-6c77e70b38d3"},
    {"name": "Galle", "image": "https://images.unsplash.com/photo-1543248939-4296b31e0bba"},
    {"name": "Nekombo", "image": "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0"},
    {"name": "Kandy", "image": "https://images.unsplash.com/photo-1533105079780-91e9d12b54e0"},
    {"name": "Galle", "image": "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267"},
    {"name": "Nekombo", "image": "https://images.unsplash.com/photo-1519681393784-d120267933ba"},
    {"name": "Kandy", "image": "https://images.unsplash.com/photo-1529068755536-a5ade0dcb4e3"},
    {"name": "Galle", "image": "https://images.unsplash.com/photo-1516912481808-3406841bd33e"},
    {"name": "Nekombo", "image": "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0"},
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Select join trip Page",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Tours",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            // Filter Tabs
            Row(
              children: [
                _buildFilterTab("All", true),
                SizedBox(width: 8),
                _buildFilterTab("Upcoming", false),
                SizedBox(width: 8),
                _buildFilterTab("Nearest", false),
              ],
            ),
            SizedBox(height: 20),
            // GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemCount: tours.length,
                itemBuilder: (context, index) {
                  return _buildTourCard(
                    tours[index]['image']!,
                    tours[index]['name']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Filter Tab Widget
  Widget _buildFilterTab(String title, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? Colors.pinkAccent : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pinkAccent),
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

  // Tour Card Widget
  Widget _buildTourCard(String imageUrl, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
