import 'package:flutter/material.dart';

class CarDetailsScreen extends StatelessWidget {
  final dynamic carDetails;

  CarDetailsScreen({required this.carDetails});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = carDetails['images'].isNotEmpty
        ? 'https://demo.samsidh.com/${carDetails['images'][0].replaceAll(r'\\', '/')}'
        : 'https://demo.samsidh.com/default-image.png';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Car Details',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car Image
              Center(
                child: Container(
                  height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10.0,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Text(
                            'Image not available',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              // Car Name
              Text(
                carDetails['name'] ?? 'Car Name',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              // Rating
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 4.0),
                  Text(
                    '4.6', // Example rating; replace dynamically if available
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              // Features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _featureIcon('Seats', '${carDetails['seats']} Seats', Icons.event_seat),
                  _featureIcon('Doors', '${carDetails['doors']} Doors', Icons.door_front_door),
                  _featureIcon('Manual', 'Manual', Icons.settings),
                  _featureIcon('A/C', 'A/C', Icons.ac_unit),
                ],
              ),
              SizedBox(height: 16.0),
              // Car Details
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFEAEA),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailRow('Model', carDetails['model']),
                    _detailRow('Capacity', '${carDetails['capacity']}L'),
                    _detailRow('Color', carDetails['color']),
                    _detailRow('Fuel Type', carDetails['fuelType']),
                    _detailRow('Speed', '${carDetails['speed']} KM/H'),
                    _detailRow('Power', '${carDetails['power']} KM'),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.red,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle selection
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text('Select'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFFFF5F7),
    );
  }

  Widget _featureIcon(String title, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 36.0, color: Colors.pink),
        SizedBox(height: 8.0),
        Text(
          value,
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}