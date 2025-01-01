import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'SelectTransport.dart';
class TripDetailsScreen extends StatefulWidget {
  final String? imagePath;
  final String? tripTitle;
  final String? tripDetails;
  final DateTime? startDate;
  final DateTime? endDate;

  TripDetailsScreen({
    this.imagePath,
    this.tripTitle,
    this.tripDetails,
    this.startDate,
    this.endDate,
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
  int _currentTabIndex = 0;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  final TextEditingController _fromController1 = TextEditingController();
  final TextEditingController _toController1 = TextEditingController();
  final TextEditingController _membersController1 = TextEditingController();
  final TextEditingController _budgetController1 = TextEditingController();

  final TextEditingController _fromController2 = TextEditingController();
  final TextEditingController _toController2 = TextEditingController();
  final TextEditingController _membersController2 = TextEditingController();
  final TextEditingController _budgetController2 = TextEditingController();

  final TextEditingController _fromController3 = TextEditingController();
  final TextEditingController _toController3 = TextEditingController();
  final TextEditingController _membersController3 = TextEditingController();
  final TextEditingController _budgetController3 = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _dayTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _dayTabController.dispose();
    _fromController1.dispose();
    _toController1.dispose();
    _membersController1.dispose();
    _budgetController1.dispose();

    _fromController2.dispose();
    _toController2.dispose();
    _membersController2.dispose();
    _budgetController2.dispose();

    _fromController3.dispose();
    _toController3.dispose();
    _membersController3.dispose();
    _budgetController3.dispose();

    super.dispose();
  }

  Widget buildContentForTab() {
    switch (_currentTabIndex) {
      case 0:
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
                    _startTime == null
                        ? "Start Time"
                        : _startTime!.format(context),
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
                    _endTime == null
                        ? "End Time"
                        : _endTime!.format(context),
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        );
      case 1:
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "Enter Budget",
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16.0),
            ),
            keyboardType: TextInputType.number,
          ),
        );
      case 2:
        return Center(
          child: Text(
            "Add Activities Here",
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }

  Widget buildDayTab(String dayTitle, TextEditingController fromController,
      TextEditingController toController,
      TextEditingController membersController,
      TextEditingController budgetController) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: GlobalKey<FormState>(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$dayTitle",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFDBE0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        controller: fromController,
                        decoration: InputDecoration(
                          hintText: "From",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Transform.rotate(
                    angle: -122.52,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 24.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFDBE0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: toController,
                  decoration: InputDecoration(
                    hintText: "To",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFDBE0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextFormField(
                  controller: membersController,
                  decoration: InputDecoration(
                    hintText: "Number of Members",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
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
                            fontWeight: _currentTabIndex == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentTabIndex == 0
                                ? Colors.red
                                : Colors.black,
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
                            fontWeight: _currentTabIndex == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentTabIndex == 1
                                ? Colors.red
                                : Colors.black,
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
                          "Activities",
                          style: TextStyle(
                            fontWeight: _currentTabIndex == 2
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _currentTabIndex == 2
                                ? Colors.red
                                : Colors.black,
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
                child: buildContentForTab(),
              ),
              SizedBox(height: 16.0),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransportSelectionScreen(),
                        ),
                      );
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
                  )
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
            tabs: [
              Tab(text: "Day1"),
              Tab(text: "Day2"),
              Tab(text: "Day3"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _dayTabController,
              children: [
                buildDayTab("Day1", _fromController1, _toController1,
                    _membersController1, _budgetController1),
                buildDayTab("Day2", _fromController2, _toController2,
                    _membersController2, _budgetController2),
                buildDayTab("Day3", _fromController3, _toController3,
                    _membersController3, _budgetController3),
              ],
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