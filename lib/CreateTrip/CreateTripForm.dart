// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'TripSchedule.dart';
// class CreateTripScreen extends StatefulWidget {
//   @override
//   _CreateTripScreenState createState() => _CreateTripScreenState();
// }
//
// class _CreateTripScreenState extends State<CreateTripScreen> {
//   String? _imagePath;
//   DateTime? _startDate;
//   DateTime? _endDate;
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imagePath = pickedFile.path;
//       });
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = picked;
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
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
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 16.0),
//               Center(
//                 child: GestureDetector(
//                   onTap: _pickImage,
//                   child: Container(
//                     height: 180.0,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(16.0),
//                     ),
//                     child: _imagePath == null
//                         ? Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.image_outlined,
//                           color: Colors.grey,
//                           size: 50.0,
//                         ),
//                         SizedBox(height: 8.0),
//                         Text(
//                           "Add Image",
//                           style: TextStyle(color: Colors.grey, fontSize: 14.0),
//                         ),
//                       ],
//                     )
//                         : Image.file(
//                       File(_imagePath!),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 24.0),
//               Text(
//                 "Trip Title",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
//               ),
//               SizedBox(height: 8.0),
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Trip To Goa",
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Text(
//                 "Trip Details",
//                 style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0),
//               ),
//               SizedBox(height: 8.0),
//               TextField(
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   hintText: "More Details about the event comes here",
//                   filled: true,
//                   fillColor: Colors.grey[100],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Start Date",
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0 , color: Colors.black87),
//                         ),
//                         SizedBox(height: 8.0),
//                         GestureDetector(
//                           onTap: () => _selectDate(context, true),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0,),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.calendar_today_outlined, size: 20.0, color: Colors.black87),
//                                 SizedBox(width: 8.0),
//                                 Text(
//                                   _startDate == null
//                                       ? "dd-mm-yyyy"
//                                       : "${_startDate!.day}-${_startDate!.month}-${_startDate!.year}",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 16.0),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "End Date",
//                           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0 , color: Colors.black87),
//                         ),
//                         SizedBox(height: 8.0),
//                         GestureDetector(
//                           onTap: () => _selectDate(context, false),
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[100],
//                               borderRadius: BorderRadius.circular(8.0),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.calendar_today_outlined, size: 20.0, color: Colors.black),
//                                 SizedBox(width: 8.0),
//                                 Text(
//                                   _endDate == null
//                                       ? "dd-mm-yyyy"
//                                       : "${_endDate!.day}-${_endDate!.month}-${_endDate!.year}",
//                                   style: TextStyle(color: Colors.grey),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 24.0),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Handle create trip schedule action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFFFDBE0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(12.0),
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0),
//                   ),
//                   child: Text(
//                     "Create Trip Schedule",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                         builder: (context) => TripDetailsScreen(),
//                     ) );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFFFE506B),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(12.0),
//                       ),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0),
//                   ),
//                   child: Text(
//                     "Continue",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

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
  final TextEditingController _numberOfMembersController = TextEditingController();

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
      _showSnackBar("Image is required");
    } else if (_tripTitleController.text.isEmpty) {
      _showSnackBar("Trip Title is required");
    } else if (_tripDetailsController.text.isEmpty) {
      _showSnackBar("Trip Details are required");
    } else if (_numberOfMembersController.text.isEmpty) {
      _showSnackBar("Number of Members is required");
    } else if (_startDate == null) {
      _showSnackBar("Start Date is required");
    } else if (_endDate == null) {
      _showSnackBar("End Date is required");
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
            numberOfMembers: _numberOfMembersController.text,
          ),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
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
              Text("Trip Title", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
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
              Text("Trip Details", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0)),
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
              TextField(
                controller: _numberOfMembersController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Number of Members",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
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
                  onPressed: _validateAndNavigate,
                  child: Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
