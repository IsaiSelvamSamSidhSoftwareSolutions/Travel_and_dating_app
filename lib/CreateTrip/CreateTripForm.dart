
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../CreateTrip/TripSchedule.dart';

class CreateTripScreen extends StatefulWidget {
  @override
  _CreateTripScreenState createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  String? _imagePath;
  DateTime? _startDate;
  DateTime? _endDate;
  final TextEditingController _tripTitleController = TextEditingController();
  final TextEditingController _tripDetailsController = TextEditingController();
  int _numberOfMembers = 1;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }
  void _validateAndNavigate() {
    if (_imagePath == null) {
      _showSnackBar("A beautiful trip needs a captivating image to set the mood.");
    } else if (_tripTitleController.text.isEmpty) {
      _showSnackBar("Every adventure deserves a charming title to remember it by.");
    } else if (_tripDetailsController.text.isEmpty) {
      _showSnackBar("Share the story of your journey to make it unforgettable.");
    } else if (_numberOfMembers <= 0) {
      _showSnackBar("No adventure is complete without companions to share it with.");
    } else if (_startDate == null) {
      _showSnackBar("When does this enchanting journey begin?");
    } else if (_endDate == null) {
      _showSnackBar("Every love story has its timeline—don't forget the end date.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripDetailsScreen(
            imagePath: _imagePath,
            tripTitle: _tripTitleController.text,
            tripDetails: _tripDetailsController.text,
            startDate: _startDate,
            endDate: _endDate,
            numberOfMembers: _numberOfMembers.toString(),
          ),
        ),
      );
    }
  }


  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message , style: TextStyle(color: Colors.black87 , fontSize: 15),),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Create A Trip"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 180.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: _imagePath == null
                        ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined, color: Colors.grey, size: 50.0),
                        SizedBox(height: 8.0),
                        Text(
                          "Add Image",
                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                        ),
                      ],
                    )
                        : Image.file(
                      File(_imagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text("Trip Title", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0)),
              SizedBox(height: 8.0),
              TextField(
                controller: _tripTitleController,
                decoration: InputDecoration(
                  hintText: "Trip To Goa",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text("Trip Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16.0)),
              SizedBox(height: 8.0),
              TextField(
                controller: _tripDetailsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "More details about the event come here",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text("Number of Members", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 16.0)),
              SizedBox(height: 8.0),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_numberOfMembers > 1) _numberOfMembers--;
                      });
                    },
                    icon: Icon(Icons.remove_circle_outline, color: Colors.pinkAccent),
                  ),
                  Text(
                    _numberOfMembers.toString(),
                    style: TextStyle(color: Colors.pink, fontSize: 16.0),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _numberOfMembers++;
                      });
                    },
                    icon: Icon(Icons.add_circle_outline, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 20.0, color: Colors.black87),
                            SizedBox(width: 8.0),
                            Text(
                              _startDate == null
                                  ? "Start Date"
                                  : "${_startDate!.day}-${_startDate!.month}-${_startDate!.year}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 20.0, color: Colors.black87),
                            SizedBox(width: 8.0),
                            Text(
                              _endDate == null
                                  ? "End Date"
                                  : "${_endDate!.day}-${_endDate!.month}-${_endDate!.year}",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
                  onPressed: _validateAndNavigate,
                  child: Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
