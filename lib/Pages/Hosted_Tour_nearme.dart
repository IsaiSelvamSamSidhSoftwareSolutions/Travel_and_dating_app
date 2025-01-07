
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class HostedTourNearme extends StatefulWidget {
  @override
  _HostedTourNearmeState createState() => _HostedTourNearmeState();
}

class _HostedTourNearmeState extends State<HostedTourNearme> {
  final GetStorage storage = GetStorage();
  List<Map<String, dynamic>> hostedTours = [];
  List<Map<String, dynamic>> filteredTours = [];
  bool isLoading = true;
  String errorMessage = '';

  // Filter fields
  double minBudget = 0;
  double maxBudget = 10000;
  int minMembers = 1;
  int maxMembers = 10;
  int minDays = 1;
  int maxDays = 30;
  DateTime? startDate;
  DateTime? endDate;
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
        // Extract trip details
        final tripBudget = trip['budget']?['total'] ?? 0.0;
        final tripStartDate = DateTime.parse(trip['startDate']);
        final tripEndDate = DateTime.parse(trip['endDate']);
        final tripDays = tripEndDate.difference(tripStartDate).inDays + 1;
        final tripMembers = trip['numberOfPersons'] ?? 0;
        final tripDestination = trip['destination'] ?? '';

        // Check if trip budget is within the range
        if (tripBudget < minBudget || tripBudget > maxBudget) return false;

        // Check if trip members are within the range
        if (tripMembers < minMembers || tripMembers > maxMembers) return false;

        // Check if trip duration is within the range
        if (tripDays < minDays || tripDays > maxDays) return false;

        // Ensure trip starts within the selected start and end dates
        if (startDate != null && tripStartDate.isBefore(startDate!)) return false;
        if (endDate != null && tripStartDate.isAfter(endDate!)) return false;

        // Check if destination matches the filter
        if (destination.isNotEmpty &&
            !tripDestination.toLowerCase().contains(destination.toLowerCase())) {
          return false;
        }

        // All filters passed
        return true;
      }).toList();
    });
  }

  void clearFilters() {
    setState(() {
      minBudget = 0;
      maxBudget = 10000;
      minMembers = 1;
      maxMembers = 10;
      minDays = 1;
      maxDays = 30;
      startDate = null;
      endDate = null;
      destination = '';
      filteredTours = List.from(hostedTours); // Reset to full data
    });
  }

  // void _showTripDetails(BuildContext context, Map<String, dynamic> tour) {
  //   final startDate = DateTime.parse(tour['startDate']);
  //   final endDate = DateTime.parse(tour['endDate']);
  //   bool isExpanded = false; // State for showing/hiding breakdown
  //
  //   showModalBottomSheet(
  //     context: context,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (BuildContext context, StateSetter setModalState) {
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   // Handle
  //                   Center(
  //                     child: Container(
  //                       width: 60,
  //                       height: 6,
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey[300],
  //                         borderRadius: BorderRadius.circular(3),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 16),
  //                   // Tour Image
  //                   Center(
  //                     child: ClipRRect(
  //                       borderRadius: BorderRadius.circular(12),
  //                       child: tour['images'] != null &&
  //                           tour['images'].isNotEmpty
  //                           ? Image.network(
  //                         'https://demo.samsidh.com/${tour['images'][0]}',
  //                         height: 200,
  //                         width: double.infinity,
  //                         fit: BoxFit.cover,
  //                       )
  //                           : Image.network(
  //                         'https://via.placeholder.com/200',
  //                         height: 200,
  //                         width: double.infinity,
  //                         fit: BoxFit.cover,
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(height: 16),
  //                   // Title
  //                   Text(
  //                     tour['title'] ?? 'Unknown',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                   SizedBox(height: 8),
  //                   // Start & End Date
  //                   Text(
  //                     "Start Date: ${startDate.toLocal().toString().split(
  //                         ' ')[0]}",
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                   Text(
  //                     "End Date: ${endDate.toLocal().toString().split(' ')[0]}",
  //                     style: TextStyle(fontSize: 16),
  //                   ),
  //                   SizedBox(height: 8),
  //                   // Budget
  //                   Text(
  //                     "Budget: ₹${tour['budget']['total']}",
  //                     style: TextStyle(
  //                         fontSize: 16, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(height: 8),
  //                   // Breakdown Toggle
  //                   GestureDetector(
  //                     onTap: () {
  //                       setModalState(() {
  //                         isExpanded = !isExpanded;
  //                       });
  //                     },
  //                     child: Row(
  //                       children: [
  //                         Text(
  //                           isExpanded ? 'Hide Breakdown' : 'Show Breakdown',
  //                           style: TextStyle(color: Colors.blue, fontSize: 16),
  //                         ),
  //                         Icon(
  //                           isExpanded
  //                               ? Icons.keyboard_arrow_up
  //                               : Icons.keyboard_arrow_down,
  //                           color: Colors.blue,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   // Budget Breakdown
  //                   if (isExpanded)
  //                     ListView.builder(
  //                       shrinkWrap: true,
  //                       physics: NeverScrollableScrollPhysics(),
  //                       itemCount: tour['budget']['breakdown']?.length ?? 0,
  //                       itemBuilder: (context, index) {
  //                         final breakdown = tour['budget']['breakdown'][index];
  //                         return ListTile(
  //                           contentPadding: EdgeInsets.zero,
  //                           title: Text(
  //                             breakdown['category'] ?? 'Unknown',
  //                             style: TextStyle(fontSize: 14),
  //                           ),
  //                           trailing: Text(
  //                             "₹${breakdown['amount']}",
  //                             style: TextStyle(fontSize: 14),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   SizedBox(height: 16),
  //                   // Activities
  //                   Text(
  //                     "Activities:",
  //                     style: TextStyle(
  //                         fontSize: 18, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(height: 8),
  //                   ListView.builder(
  //                     shrinkWrap: true,
  //                     physics: NeverScrollableScrollPhysics(),
  //                     itemCount: tour['schedule']?.length ?? 0,
  //                     itemBuilder: (context, index) {
  //                       final activity = tour['schedule'][index];
  //                       final activityDate =
  //                       DateTime.parse(activity['date']).toLocal();
  //                       return ListTile(
  //                         contentPadding: EdgeInsets.zero,
  //                         leading: Icon(Icons.mode_of_travel,
  //                             color: Colors.green),
  //                         title: Text(activity['activity'] ?? 'No Activity'),
  //                         subtitle: Text(
  //                           activityDate.toString().split(' ')[0],
  //                           style: TextStyle(fontSize: 12, color: Colors.grey),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                   SizedBox(height: 16),
  //                   // Join Trip Button
  //                   Center(
  //                     child: ElevatedButton(
  //                       onPressed: () {
  //                         print("Join Trip clicked for ${tour['title']}");
  //                       },
  //                       child: Text("Join Trip"),
  //                       style: ElevatedButton.styleFrom(
  //                         minimumSize: Size(double.infinity, 50),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(12),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  void _showTripDetails(BuildContext context, Map<String, dynamic> tour) {
    final startDate = DateTime.parse(tour['startDate']);
    final endDate = DateTime.parse(tour['endDate']);
    final summary = (tour['details']);
    final isStartWeekend = startDate.weekday == 6 || startDate.weekday == 7;
    final isEndWeekend = endDate.weekday == 6 || endDate.weekday == 7;
    final isBudgetFriendly = (tour['budget']?['total'] ?? 0.0) < 4000;

    // Dummy data for Alcohol-friendly status
    final isAlcoholFriendly = tour['alcoholFriendly'] ?? true; // Default value

    bool isExpanded = false;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle
                    Center(
                      child: Container(
                        width: 60,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Tour Image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: tour['images'] != null && tour['images'].isNotEmpty
                            ? Image.network(
                          'https://demo.samsidh.com/${tour['images'][0]}',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                            : Image.network(
                          'https://via.placeholder.com/200',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Title and Details
                    Row(
                      children: [
                        Icon(Icons.trip_origin, color: Colors.blue), // Icon for details
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tour['title'] ?? 'Unknown', // Title
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.notes, color: Colors.grey), // Icon for summary/details
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tour['details'] ?? 'No details available', // Details as summary
                            style: TextStyle(
                              fontSize: 16, // Smaller font size for subtitle
                              fontWeight: FontWeight.normal, // Regular font weight
                              color: Colors.grey[700], // Subtle color for subtitle
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Start & End Date
                    Text(
                      "Start Date: ${startDate.toLocal().toString().split(' ')[0]} ${isStartWeekend ? '(Weekend)' : ''}",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "End Date: ${endDate.toLocal().toString().split(' ')[0]} ${isEndWeekend ? '(Weekend)' : ''}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    // Number of Members
                    Row(
                      children: [
                        Icon(Icons.group, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          "Number of Members: ${tour['numberOfPersons'] ?? 'N/A'}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Budget
                    Row(
                      children: [
                        Text(
                          "Budget: ₹${tour['budget']['total'] ?? 0}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        if (isBudgetFriendly)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Chip(
                              label: Text("Budget Friendly"),
                              backgroundColor: Colors.green[100],
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Alcohol-Friendly/Non-Alcohol-Friendly
                    Row(
                      children: [
                        Icon(
                          isAlcoholFriendly
                              ? Icons.local_bar
                              : Icons.no_drinks,
                          color: isAlcoholFriendly ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          isAlcoholFriendly
                              ? "Alcohol Friendly"
                              : "Non-Alcohol Friendly",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Breakdown Toggle
                    GestureDetector(
                      onTap: () {
                        setModalState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Row(
                        children: [
                          Text(
                            isExpanded ? 'Hide Breakdown' : 'Show Breakdown',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    // Budget Breakdown
                    if (isExpanded)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: tour['budget']['breakdown']?.length ?? 0,
                        itemBuilder: (context, index) {
                          final breakdown = tour['budget']['breakdown'][index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              Icons.monetization_on,
                              color: Colors.blue,
                            ),
                            title: Text(
                              breakdown['category'] ?? 'Unknown',
                              style: TextStyle(fontSize: 14),
                            ),
                            trailing: Text(
                              "₹${breakdown['amount']}",
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        },
                      ),
                    SizedBox(height: 16),
                    // Activities
                    Text(
                      "Activities:",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: tour['schedule']?.length ?? 0,
                      itemBuilder: (context, index) {
                        final activity = tour['schedule'][index];
                        final activityDate =
                        DateTime.parse(activity['date']).toLocal();
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(Icons.mode_of_travel, color: Colors.green),
                          title: Text(activity['activity'] ?? 'No Activity'),
                          subtitle: Text(
                            activityDate.toString().split(' ')[0],
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    // Join Trip Button
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          print("Join Trip clicked for ${tour['title']}");
                        },
                        child: Text("Join Trip"),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void openFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Filter Trips",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      Divider(thickness: 1),
                      SizedBox(height: 16),
                      Text(
                        "Budget Range",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RangeSlider(
                        values: RangeValues(minBudget, maxBudget),
                        min: 0,
                        max: 10000,
                        divisions: 100,
                        labels: RangeLabels(
                          '₹${minBudget.toInt()}',
                          '₹${maxBudget.toInt()}',
                        ),
                        onChanged: (values) {
                          setDialogState(() {
                            minBudget = values.start;
                            maxBudget = values.end;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Number of Members",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RangeSlider(
                        values: RangeValues(
                          minMembers.toDouble(),
                          maxMembers.toDouble(),
                        ),
                        min: 1,
                        max: 20,
                        divisions: 19,
                        labels: RangeLabels(
                          minMembers.toString(),
                          maxMembers.toString(),
                        ),
                        onChanged: (values) {
                          setDialogState(() {
                            minMembers = values.start.toInt();
                            maxMembers = values.end.toInt();
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: startDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  setDialogState(() {
                                    startDate = selectedDate;
                                  });
                                }
                              },
                              child: Text(
                                startDate != null
                                    ? "Start: ${startDate!.toLocal()
                                    .toString()
                                    .split(' ')[0]}"
                                    : "Pick Start Date",
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Flexible(
                            child: ElevatedButton(
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: endDate ?? DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                                if (selectedDate != null) {
                                  setDialogState(() {
                                    endDate = selectedDate;
                                  });
                                }
                              },
                              child: Text(
                                endDate != null
                                    ? "End: ${endDate!.toLocal()
                                    .toString()
                                    .split(' ')[0]}"
                                    : "Pick End Date",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.grey[300],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                            ),
                            onPressed: () {
                              applyFilters();
                              Navigator.pop(context);
                            },
                            child: Text("Apply Filters"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/profile'); // Navigate to Profile Page
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
            ),
          ),
        ),
        title: Text(
          "Find and create your trip",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: openFilterDialog,
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: () {
              clearFilters();
              fetchHostedTours();
            },
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
          return GestureDetector(
            onTap: () {
              _showTripDetails(context, trip); // Call bottom sheet
            },
            child: Card(
              color: Colors.white, // Set your desired background color here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Updated border radius
              ),
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20), // Match the card's border radius
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
                      trip['title'] ?? 'No Title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "₹${trip['budget']['total'] ?? 'Unknown'}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
