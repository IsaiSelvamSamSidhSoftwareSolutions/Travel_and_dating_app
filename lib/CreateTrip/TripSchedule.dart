
import 'package:flutter/material.dart';

import 'SelectTransport.dart';

class TripDetailsScreen extends StatefulWidget {
  final String? imagePath;
  final String? tripTitle;
  final String? tripDetails;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? numberOfMembers;

  TripDetailsScreen({
    this.imagePath,
    this.tripTitle,
    this.tripDetails,
    this.startDate,
    this.endDate,
    this.numberOfMembers,
  }) {
    // Print all arguments to the console
    print('Image Path: $imagePath');
    print('Trip Title: $tripTitle');
    print('Trip Details: $tripDetails');
    print('Start Date: $startDate');
    print('End Date: $endDate');
  }

  @override
  _TripDetailsScreenState createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _dayTabController;
  late int _numberOfDays;
  int _currentTabIndex = 0;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  // List of controllers for each day
  List<Map<String, TextEditingController>> dayControllers = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _numberOfDays = widget.endDate!.difference(widget.startDate!).inDays + 1;
    _dayTabController = TabController(length: _numberOfDays, vsync: this);

    // Initialize controllers for each day
    for (int i = 0; i < _numberOfDays; i++) {
      dayControllers.add({
        "budget": TextEditingController(),
        "activity": TextEditingController(),
        "category": TextEditingController(),
      });
    }
  }

  @override
  void dispose() {
    // Dispose all controllers
    for (var controllers in dayControllers) {
      controllers.forEach((key, controller) => controller.dispose());
    }
    _dayTabController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Widget buildContentForTab(Map<String, TextEditingController> controllers) {
    switch (_currentTabIndex) {
      case 0: // Time Tab
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, true),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _startTime == null ? "Start Time" : _startTime!.format(context),
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, false),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    _endTime == null ? "End Time" : _endTime!.format(context),
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        );

      case 1: // Budget Tab
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: controllers["category"],
                decoration: InputDecoration(
                  hintText: "Enter Category",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Category is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: controllers["budget"],
                decoration: InputDecoration(
                  hintText: "Enter Amount",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount is required';
                  }
                  return null;
                },
              ),
            ),
          ],
        );

      case 2: // Activity Tab
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: controllers["activity"],
                decoration: InputDecoration(
                  hintText: "Enter Activity Details",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Activity details are required';
                  }
                  return null;
                },
              ),
            ),
          ],
        );

      default:
        return SizedBox.shrink();
    }
  }
  Widget buildDayTab(int dayIndex) {
    final controllers = dayControllers[dayIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Day ${dayIndex + 1}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentTabIndex = 0;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                            fontWeight: _currentTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                            color: _currentTabIndex == 0 ? Colors.red : Colors.black,
                          ),
                        ),
                        if (_currentTabIndex == 0)
                          Container(
                            height: 2.0,
                            width: 40.0,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentTabIndex = 1;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Budget",
                          style: TextStyle(
                            fontWeight: _currentTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                            color: _currentTabIndex == 1 ? Colors.red : Colors.black,
                          ),
                        ),
                        if (_currentTabIndex == 1)
                          Container(
                            height: 2.0,
                            width: 40.0,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentTabIndex = 2;
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          "Activity",
                          style: TextStyle(
                            fontWeight: _currentTabIndex == 2 ? FontWeight.bold : FontWeight.normal,
                            color: _currentTabIndex == 2 ? Colors.red : Colors.black,
                          ),
                        ),
                        if (_currentTabIndex == 2)
                          Container(
                            height: 2.0,
                            width: 40.0,
                            color: Colors.red,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFDBE0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildContentForTab(controllers),
                    SizedBox(height: 16.0),
                    if (dayIndex == _numberOfDays - 1)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                'lib/assets/Trips/transport.png',
                                height: 100, // Set height
                                width: 100,  // Set width
                                fit: BoxFit.cover, // Adjust fit as needed
                              ),

                              SizedBox(height: 8.0),
                              Text("Add Transport"),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                List<Map<String, dynamic>> breakdown = dayControllers.map((dayController) {
                                  return {
                                    "category": dayController["category"]!.text.trim(),
                                    "amount": double.tryParse(dayController["budget"]!.text.trim()) ?? 0.0,
                                  };
                                }).toList();

                                // Calculate the total dynamically
                                double total = breakdown.fold(0.0, (sum, item) => sum + (item['amount'] as double));

                                // Create the final budget map
                                Map<String, dynamic> budget = {
                                  "total": total,
                                  "breakdown": breakdown,
                                };



                                // Collect schedule data dynamically from controllers
                                List<Map<String, String>> schedule = dayControllers.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  Map<String, TextEditingController> dayController = entry.value;

                                  return {
                                    "date": widget.startDate?.add(Duration(days: index)).toIso8601String() ?? "",
                                    "activity": dayController["activity"]!.text.trim(),
                                  };
                                }).toList();

                                // Navigate to TransportSelectionScreen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      // Print the arguments to the console for debugging
                                      print("Navigating to TransportSelectionScreen with arguments:");
                                      print("Image Path: ${widget.imagePath}");
                                      print("Trip Title: ${widget.tripTitle}");
                                      print("Trip Details: ${widget.tripDetails}");
                                      print("Number of Members: ${widget.numberOfMembers}");
                                      print("Start Date: ${widget.startDate}");
                                      print("End Date: ${widget.endDate}");
                                      print("Start Time: ${_startTime?.format(context)}");
                                      print("End Time: ${_endTime?.format(context)}");
                                      print("Budget: $budget");
                                      print("Schedule: $schedule");

                                      // Navigate to the TransportSelectionScreen
                                      return TransportSelectionScreen(
                                        imagePath: widget.imagePath,
                                        tripTitle: widget.tripTitle,
                                        numberofmembers: widget.numberOfMembers,
                                        tripDetails: widget.tripDetails,
                                        startDate: widget.startDate,
                                        endDate: widget.endDate,
                                        startTime: _startTime,
                                        endTime: _endTime,
                                        budget: budget,
                                        schedule: schedule,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                // Show dialog for incomplete fields
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Incomplete Information"),
                                      content: Text("Some fields are not filled. Please complete all fields."),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  'lib/assets/Trips/driver.png',
                                  height: 100, // Set height
                                  width: 100,  // Set width
                                  fit: BoxFit.cover, // Adjust fit as needed
                                ),
                                SizedBox(height: 8.0),
                                Text("Add Driver"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 16.0),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _dayTabController,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.red,
            tabs: List.generate(_numberOfDays, (index) => Tab(text: "Day ${index + 1}")),
          ),
          Expanded(
            child: TabBarView(
              controller: _dayTabController,
              children: List.generate(_numberOfDays, (index) => buildDayTab(index)),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TripDetailsScreen(),
  ));
}
