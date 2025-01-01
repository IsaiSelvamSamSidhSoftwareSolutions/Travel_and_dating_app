import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class HostedTourNearme extends StatefulWidget {
  @override
  _HostedTourNearmeState createState() => _HostedTourNearmeState();
}

class _HostedTourNearmeState extends State<HostedTourNearme> {
  final storage = GetStorage(); // Initialize GetStorage
  List<Map<String, dynamic>> hostedTours = [];
  List<Map<String, dynamic>> upcomingTours = [];
  bool isLoadingHosted = true;
  bool isLoadingUpcoming = true;

  @override
  void initState() {
    super.initState();
    fetchHostedTours();
    fetchUpcomingTours();
  }

  Future<void> fetchHostedTours() async {
    final String apiUrl = 'https://demo.samsidh.com/api/v1/trips';
    final String? token = storage.read('jwttoken');
    final String? email = storage.read('email');
    final String? username = storage.read('username');

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'email': email!,
          'username': username!,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          hostedTours = List<Map<String, dynamic>>.from(data['trips']);
          isLoadingHosted = false;
        });
      } else {
        print("Failed to fetch hosted tours: ${response.body}");
      }
    } catch (e) {
      print("Error fetching hosted tours: $e");
    }
  }

  Future<void> fetchUpcomingTours() async {
    final String apiUrl = 'https://demo.samsidh.com/api/v1/trips';
    final String? token = storage.read('jwttoken');
    final String? email = storage.read('email');
    final String? username = storage.read('username');

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'email': email!,
          'username': username!,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final now = DateTime.now();

        setState(() {
          upcomingTours = List<Map<String, dynamic>>.from(data['trips'])
              .where((tour) {
            final startDate = DateTime.parse(tour['startDate']);
            return startDate.isAfter(now); // Filter upcoming tours
          }).toList();
          isLoadingUpcoming = false;
        });
      } else {
        print("Failed to fetch upcoming tours: ${response.body}");
      }
    } catch (e) {
      print("Error fetching upcoming tours: $e");
    }
  }

  Widget hostedTourCard(Map<String, dynamic> tour) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: tour['images'] != null && tour['images'].isNotEmpty
                ? Image.network(
              'https://demo.samsidh.com/${tour['images'][0]}',
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            )
                : Image.network(
              'https://via.placeholder.com/90',
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4),
          Text(
            tour['title'] ?? 'Unknown',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget upcomingTourCard(Map<String, dynamic> tour) {
    final startDate = DateTime.parse(tour['startDate']);
    final difference = startDate.difference(DateTime.now());
    final daysRemaining =
    difference.inDays > 0 ? '${difference.inDays} Days Only' : 'Today';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: tour['images'] != null && tour['images'].isNotEmpty
                  ? Image.network(
                'https://demo.samsidh.com/${tour['images'][0]}',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Image.network(
                'https://via.placeholder.com/150',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tour['title'] ?? 'No Title',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    daysRemaining,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Upcoming Tours Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Upcoming Tours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        isLoadingUpcoming
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: upcomingTours
                .map((tour) => upcomingTourCard(tour))
                .toList(),
          ),
        ),
        SizedBox(height: 20),

        // Near By Tours Hosted Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Near By Tours Hosted',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        isLoadingHosted
            ? Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: hostedTours.length,
            itemBuilder: (context, index) {
              return hostedTourCard(hostedTours[index]);
            },
          ),
        ),
      ],
    );
  }
}
