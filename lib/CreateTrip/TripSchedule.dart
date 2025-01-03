//
// import 'package:flutter/material.dart';
//
// import 'SelectTransport.dart';
//
// class TripDetailsScreen extends StatefulWidget {
//   final String? imagePath;
//   final String? tripTitle;
//   final String? tripDetails;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? numberOfMembers;
//
//   TripDetailsScreen({
//     this.imagePath,
//     this.tripTitle,
//     this.tripDetails,
//     this.startDate,
//     this.endDate,
//     this.numberOfMembers,
//   }) {
//     // Print all arguments to the console
//     print('Image Path: $imagePath');
//     print('Trip Title: $tripTitle');
//     print('Trip Details: $tripDetails');
//     print('Start Date: $startDate');
//     print('End Date: $endDate');
//   }
//
//   @override
//   _TripDetailsScreenState createState() => _TripDetailsScreenState();
// }
//
// class _TripDetailsScreenState extends State<TripDetailsScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _dayTabController;
//   late int _numberOfDays;
//   int _currentTabIndex = 0;
//   TimeOfDay? _startTime;
//   TimeOfDay? _endTime;
//
//   // List of controllers for each day
//   List<Map<String, TextEditingController>> dayControllers = [];
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _numberOfDays = widget.endDate!.difference(widget.startDate!).inDays + 1;
//     _dayTabController = TabController(length: _numberOfDays, vsync: this);
//
//     // Initialize controllers for each day
//     for (int i = 0; i < _numberOfDays; i++) {
//       dayControllers.add({
//         "budget": TextEditingController(),
//         "activity": TextEditingController(),
//         "category": TextEditingController(),
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     // Dispose all controllers
//     for (var controllers in dayControllers) {
//       controllers.forEach((key, controller) => controller.dispose());
//     }
//     _dayTabController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _selectTime(BuildContext context, bool isStartTime) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartTime) {
//           _startTime = picked;
//         } else {
//           _endTime = picked;
//         }
//       });
//     }
//   }
//
//   Widget buildContentForTab(Map<String, TextEditingController> controllers) {
//     switch (_currentTabIndex) {
//       case 0: // Time Tab
//         return Row(
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _selectTime(context, true),
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _startTime == null ? "Start Time" : _startTime!.format(context),
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 16.0),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => _selectTime(context, false),
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   child: Text(
//                     _endTime == null ? "End Time" : _endTime!.format(context),
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//
//       case 1: // Budget Tab
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: TextFormField(
//                 controller: controllers["category"],
//                 decoration: InputDecoration(
//                   hintText: "Enter Category",
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.all(16.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Category is required';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//             SizedBox(height: 16.0),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: TextFormField(
//                 controller: controllers["budget"],
//                 decoration: InputDecoration(
//                   hintText: "Enter Amount",
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.all(16.0),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Amount is required';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         );
//
//       case 2: // Activity Tab
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(8.0),
//               ),
//               child: TextFormField(
//                 controller: controllers["activity"],
//                 decoration: InputDecoration(
//                   hintText: "Enter Activity Details",
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.all(16.0),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Activity details are required';
//                   }
//                   return null;
//                 },
//               ),
//             ),
//           ],
//         );
//
//       default:
//         return SizedBox.shrink();
//     }
//   }
//
//   Widget buildDayTab(int dayIndex) {
//     final controllers = dayControllers[dayIndex];
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Day ${dayIndex + 1}",
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentTabIndex = 0;
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           "Time",
//                           style: TextStyle(
//                             fontWeight: _currentTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
//                             color: _currentTabIndex == 0 ? Colors.red : Colors.black,
//                           ),
//                         ),
//                         if (_currentTabIndex == 0)
//                           Container(
//                             height: 2.0,
//                             width: 40.0,
//                             color: Colors.red,
//                           ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentTabIndex = 1;
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           "Budget",
//                           style: TextStyle(
//                             fontWeight: _currentTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
//                             color: _currentTabIndex == 1 ? Colors.red : Colors.black,
//                           ),
//                         ),
//                         if (_currentTabIndex == 1)
//                           Container(
//                             height: 2.0,
//                             width: 40.0,
//                             color: Colors.red,
//                           ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _currentTabIndex = 2;
//                       });
//                     },
//                     child: Column(
//                       children: [
//                         Text(
//                           "Activity",
//                           style: TextStyle(
//                             fontWeight: _currentTabIndex == 2 ? FontWeight.bold : FontWeight.normal,
//                             color: _currentTabIndex == 2 ? Colors.red : Colors.black,
//                           ),
//                         ),
//                         if (_currentTabIndex == 2)
//                           Container(
//                               height: 2.0,
//                               width: 40.0,
//                               color: Colors.red ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.all(16.0),
//                 decoration: BoxDecoration(
//                   color: Color(0xFFFFDBE0),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: buildContentForTab(controllers),
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     children: [
//                       Image.network(
//                         'https://s3-alpha-sig.figma.com/img/a3c3/f062/3a2ef53a763b536788fd2c25f561c2f0?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Lyrdb3EgP6d-2s1IeI6TBwSxSoM4JoFKFbLO3FK4nCKdw0ZyKfT4id5Zgk~2C9FMZz9guHWShtR~n0YBmbL6z~8j-bn7-OKptcahWQy-PhtY5XENWMhx2jjQt6I1g4y8a7eiP8ClgxX1QhvAdcNcSpPaMxXznXDEA5OPBcCbgwJtKn5KZ~ZK-g1jZCeHuRmQol04owWMNKmW9ptkckmlsnYYOQEk~NqRQ18LIZmx6VHGBR67ovz2fpaC9ynMNle7rUkADv30Og98Vm7kb75MI3SW8DB2nanGdI7nONfAY~uGNJWuD6zbYi5uAiUgoyba3scXY4rkJrWIiIapHYod3w__',
//                         height: 80.0,
//                       ),
//                       SizedBox(height: 8.0),
//                       Text("Add Transport"),
//                     ],
//                   ),
//                   InkWell(
//                     onTap: () {
//                       if (_formKey.currentState!.validate()) {
//                         // Collect budget data dynamically from controllers
//                         List<Map<String, dynamic>> budget = dayControllers.map((dayController) {
//                           return {
//                             "category": dayController["category"]!.text.trim(),
//                             "amount": double.tryParse(dayController["budget"]!.text.trim()) ?? 0.0,
//                           };
//                         }).toList();
//
//                         // Collect schedule data dynamically from controllers
//                         List<Map<String, String>> schedule = dayControllers.asMap().entries.map((entry) {
//                           int index = entry.key;
//                           Map<String, TextEditingController> dayController = entry.value;
//
//                           return {
//                             "date": widget.startDate?.add(Duration(days: index)).toIso8601String() ?? "",
//                             "activity": dayController["activity"]!.text.trim(),
//                           };
//                         }).toList();
//
//                         // Navigate to TransportSelectionScreen
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) {
//                               // Print the arguments to the console for debugging
//                               print("Navigating to TransportSelectionScreen with arguments:");
//                               print("Image Path: ${widget.imagePath}");
//                               print("Trip Title: ${widget.tripTitle}");
//                               print("Trip Details: ${widget.tripDetails}");
//                               print("Number of Members: ${widget.numberOfMembers}");
//                               print("Start Date: ${widget.startDate}");
//                               print("End Date: ${widget.endDate}");
//                               print("Start Time: ${_startTime?.format(context)}");
//                               print("End Time: ${_endTime?.format(context)}");
//                               print("Budget: $budget");
//                               print("Schedule: $schedule");
//
//                               // Navigate to the TransportSelectionScreen
//                               return TransportSelectionScreen(
//                                 imagePath: widget.imagePath,
//                                 tripTitle: widget.tripTitle,
//                                 numberofmembers: widget.numberOfMembers,
//                                 tripDetails: widget.tripDetails,
//                                 startDate: widget.startDate,
//                                 endDate: widget.endDate,
//                                 startTime: _startTime,
//                                 endTime: _endTime,
//                                 budget: budget,
//                                 schedule: schedule,
//                               );
//                             },
//                           ),
//                         );
//                       }
//                     },
//                     child: Column(
//                       children: [
//                         Image.network(
//                           'https://s3-alpha-sig.figma.com/img/ae24/129a/f22ce81acff12db8118e903d4365c563?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=nJaC-uOTIYgnA9jhtQPmsh~1q M6N0a1qpP9JcgaeL9AZVfzfmVRGlzZooxfsu5SQ~FH5Rb1KO8BxsJuiGk7BMWEmB-W3Lm1sbj~KXZab77uXy32L6eljzUMThpKluW0OiJU2sGKVO585w34oXAxFkMKuAC1NjVpusxiC5pffp~BQwEI~ZOp07KODSTp1isQudpEgMKAa~YqfzLLg7SSoYK-TJUegwApw8JVYZTfofcNd177Nw043x2EW7vl-Qn8RaHQf-XIoE1Xz4aA9BzqoKwMWgKVRYsc44vesv8BwVMEwlsjjTm5ZsS3Vu7zh-wirJDWDq73yo9qJWValnPjLWQ__',
//                           height: 80.0,
//                         ),
//                         SizedBox(height: 8.0),
//                         Text("Add Driver"),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.0),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Add Another Destination Button Logic
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFFF5069),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: Text(
//                     "Add Another Destination",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           TabBar(
//             controller: _dayTabController,
//             labelColor: Colors.red,
//             unselectedLabelColor: Colors.black,
//             indicatorColor: Colors.red,
//             tabs: List.generate(_numberOfDays, (index) => Tab(text: "Day ${index + 1}")),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _dayTabController,
//               children: List.generate(_numberOfDays, (index) => buildDayTab(index)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: TripDetailsScreen(),
//   ));
// }
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
                              Image.network(
                                'https://s3-alpha-sig.figma.com/img/a3c3/f062/3a2ef53a763b536788fd2c25f561c2f0?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Lyrdb3EgP6d-2s1IeI6TBwSxSoM4JoFKFbLO3FK4nCKdw0ZyKfT4id5Zgk~2C9FMZz9guHWShtR~n0YBmbL6z~8j-bn7-OKptcahWQy-PhtY5XENWMhx2jjQt6I1g4y8a7eiP8ClgxX1QhvAdcNcSpPaMxXznXDEA5OPBcCbgwJtKn5KZ~ZK-g1jZCeHuRmQol04owWMNKmW9ptkckmlsnYYOQEk~NqRQ18LIZmx6VHGBR67ovz2fpaC9ynMNle7rUkADv30Og98Vm7kb75MI3SW8DB2nanGdI7nONfAY~uGNJWuD6zbYi5uAiUgoyba3scXY4rkJrWIiIapHYod3w__',
                                height: 80.0,
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
                                Image.network(
                                  'https://s3-alpha-sig.figma.com/img/ae24/129a/f22ce81acff12db8118e903d4365c563?Expires=1736726400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=nJaC-uOTIYgnA9jhtQPmsh~1qM6N0a1qpP9JcgaeL9AZVfzfmVRGlzZooxfsu5SQ~FH5Rb1KO8BxsJuiGk7BMWEmB-W3Lm1sbj~KXZab77uXy32L6eljzUMThpKluW0OiJU2sGKVO585w34oXAxFkMKuAC1NjVpusxiC5pffp~BQwEI~ZOp07KODSTp1isQudpEgMKAa~YqfzLLg7SSoYK-TJUegwApw8JVYZTfofcNd177Nw043x2EW7vl-Qn8RaHQf-XIoE1Xz4aA9BzqoKwMWgKVRYsc44vesv8BwVMEwlsjjTm5ZsS3Vu7zh-wirJDWDq73yo9qJWValnPjLWQ__',
                                  height: 80.0,
                                ),
                                SizedBox(height: 8.0),
                                Text("Add Driver"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add Another Destination Button Logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFF5069),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          "Add Another Destination",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
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