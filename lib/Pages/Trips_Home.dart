import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class TripsHome extends StatefulWidget {
  @override
  _HostedTourNearmeState createState() => _HostedTourNearmeState();
}

class _HostedTourNearmeState extends State<TripsHome> {
  final GetStorage storage = GetStorage();
  List<Map<String, dynamic>> hostedTours = [];
  List<Map<String, dynamic>> filteredTours = [];
  bool isLoading = true;
  String errorMessage = '';

  // Filter fields
  double? minBudget;
  double? maxBudget;
  DateTime? startDate;
  DateTime? endDate;
  int? minDays;
  int? maxDays;
  String destination = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchHostedTours();
    });
  }

  Future<void> fetchHostedTours() async {
    final String apiUrl = 'https://demo.samsidh.com/api/v1/trips';

    final String? token = storage.read('jwttoken');
    final String? email = storage.read('email');
    final String? username = storage.read('username');

    if (token == null || email == null || username == null) {
      setState(() {
        errorMessage = "Authentication details are missing.";
        isLoading = false;
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'email': email,
          'username': username,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          hostedTours = List<Map<String, dynamic>>.from(data['trips'] ?? []);
          filteredTours = hostedTours; // Initialize filtered tours
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Failed to fetch hosted tours: ${response.body}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching hosted tours: $e";
        isLoading = false;
      });
    }
  }

  void applyFilters() {
    setState(() {
      filteredTours = hostedTours.where((trip) {
        final tripBudget = trip['budget']['total'] ?? 0.0;
        final tripStartDate = DateTime.parse(trip['startDate']);
        final tripEndDate = DateTime.parse(trip['endDate']);
        final tripDays = tripEndDate.difference(tripStartDate).inDays + 1;
        final tripDestination = trip['destination'] ?? '';

        // Apply filters
        if (minBudget != null && tripBudget < minBudget!) return false;
        if (maxBudget != null && tripBudget > maxBudget!) return false;
        if (startDate != null && tripStartDate.isBefore(startDate!)) return false;
        if (endDate != null && tripEndDate.isAfter(endDate!)) return false;
        if (minDays != null && tripDays < minDays!) return false;
        if (maxDays != null && tripDays > maxDays!) return false;
        if (destination.isNotEmpty &&
            !tripDestination.toLowerCase().contains(destination.toLowerCase())) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Trips"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Min Budget"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => minBudget = double.tryParse(value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Max Budget"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => maxBudget = double.tryParse(value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Min Days"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => minDays = int.tryParse(value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Max Days"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => maxDays = int.tryParse(value),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Destination"),
                  onChanged: (value) => destination = value,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        startDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                      },
                      child: Text("Pick Start Date"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        endDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                      },
                      child: Text("Pick End Date"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                applyFilters();
                Navigator.pop(context);
              },
              child: Text("Apply Filters"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hosted Tours Near Me"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: openFilterDialog,
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : filteredTours.isEmpty
          ? Center(child: Text("No trips match your filters."))
          : GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.8,
        ),
        itemCount: filteredTours.length,
        itemBuilder: (context, index) {
          final trip = filteredTours[index];
          final truncatedTitle = _truncateToTwoWords(trip['title'] ?? 'No Title');
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        trip['images'].isNotEmpty
                            ? 'https://demo.samsidh.com/${trip['images'][0]}'
                            : 'https://via.placeholder.com/150',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    truncatedTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "₹${trip['budget']['total'] ?? '0'}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Duration: ${_calculateDays(trip['startDate'], trip['endDate'])} Days",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _truncateToTwoWords(String text) {
    final words = text.split(' ');
    return words.length > 2 ? '${words[0]} ${words[1]}...' : text;
  }

  String _calculateDays(String startDate, String endDate) {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      return (end.difference(start).inDays + 1).toString();
    } catch (e) {
      return "Unknown";
    }
  }
}
