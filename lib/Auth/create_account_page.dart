// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:country_picker/country_picker.dart';
//
// class CreateAccountPage extends StatefulWidget {
//   final String email;
//   final String password;
//
//   CreateAccountPage({required this.email, required this.password});
//
//   @override
//   _CreateAccountPageState createState() => _CreateAccountPageState();
// }
//
// class _CreateAccountPageState extends State<CreateAccountPage> {
//   final _formKey = GlobalKey<FormState>();
//   String? selectedGender;
//   String? name;
//   String? dateOfBirth;
//   String? phoneNumber;
//   String countryCode = "+1"; // Default country code
//   String? age;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Back Button
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       padding: const EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             blurRadius: 5,
//                             offset: Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(Icons.arrow_back, color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Title
//                 Text(
//                   "Create Your Account",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   "Let’s get started by setting up your Account Details",
//                   style: TextStyle(fontSize: 14, color: Colors.black54),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Gender Selection
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedGender = "Male";
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.male,
//                             size: 50,
//                             color: selectedGender == "Male"
//                                 ? Colors.pink
//                                 : Colors.grey,
//                           ),
//                           Text(
//                             "MALE",
//                             style: TextStyle(
//                               color: selectedGender == "Male"
//                                   ? Colors.pink
//                                   : Colors.grey,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           selectedGender = "Female";
//                         });
//                       },
//                       child: Column(
//                         children: [
//                           Icon(
//                             Icons.female,
//                             size: 50,
//                             color: selectedGender == "Female"
//                                 ? Colors.pink
//                                 : Colors.grey,
//                           ),
//                           Text(
//                             "FEMALE",
//                             style: TextStyle(
//                               color: selectedGender == "Female"
//                                   ? Colors.pink
//                                   : Colors.grey,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Name Field
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Enter your name",
//                     labelText: "Name",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Name is required";
//                     }
//                     return null;
//                   },
//                   onSaved: (value) => name = value,
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Phone Number Field with Country Picker
//                 Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         showCountryPicker(
//                           context: context,
//                           onSelect: (Country country) {
//                             setState(() {
//                               countryCode = "+${country.phoneCode}";
//                             });
//                           },
//                         );
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                           border: Border.all(color: Colors.grey[300]!),
//                         ),
//                         child: Text(
//                           countryCode,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: "Enter your phone number",
//                           labelText: "Phone Number",
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Phone number is required";
//                           }
//                           if (!RegExp(r'^\d{7,15}$').hasMatch(value)) {
//                             return "Enter a valid phone number";
//                           }
//                           return null;
//                         },
//                         onSaved: (value) => phoneNumber = value,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//
//                 // Date of Birth Field
//                 GestureDetector(
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime.now(),
//                       firstDate: DateTime(1900),
//                       lastDate: DateTime.now(),
//                     );
//
//                     if (pickedDate != null) {
//                       setState(() {
//                         dateOfBirth = DateFormat('dd-MM-yyyy').format(pickedDate);
//                         age = (DateTime.now().year - pickedDate.year).toString();
//                       });
//                     }
//                   },
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: "DD-MM-YYYY",
//                         labelText: "Date Of Birth",
//                         filled: true,
//                         fillColor: Colors.white,
//                         suffixIcon: const Icon(Icons.calendar_today),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (dateOfBirth == null || dateOfBirth!.isEmpty) {
//                           return "Date of Birth is required";
//                         }
//                         return null;
//                       },
//                       controller: TextEditingController(text: dateOfBirth),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//
//                 // Age Display
//                 if (age != null)
//                   Text(
//                     "Your age is $age years",
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 const SizedBox(height: 32),
//
//                 // Continue Button
//                 GestureDetector(
//                   onTap: () {
//                     if (_formKey.currentState!.validate()) {
//                       _formKey.currentState!.save();
//
//                       Navigator.pushReplacementNamed(
//                         context,
//                         '/category',
//                         arguments: {
//                           'name': name,
//                           'email': widget.email,
//                           'dateOfBirth': dateOfBirth,
//                           'gender': selectedGender,
//                           'phoneNumber': "$countryCode $phoneNumber",
//                           'password': widget.password,
//                         },
//                       );
//                     }
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     decoration: BoxDecoration(
//                       color: Colors.pink,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "Continue",
//                         style: TextStyle(fontSize: 18, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:country_picker/country_picker.dart';

class CreateAccountPage extends StatefulWidget {
  final String email;
  final String password;

  CreateAccountPage({required this.email, required this.password});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedGender;
  String? name;
  String? dateOfBirth;
  String? phoneNumber;
  String countryCode = "+1"; // Default country code
  String? age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  "Create Your Account",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Let’s get started by setting up your Account Details",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // Gender Selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = "Male";
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.male,
                            size: 50,
                            color: selectedGender == "Male"
                                ? Colors.pink
                                : Colors.grey,
                          ),
                          Text(
                            "MALE",
                            style: TextStyle(
                              color: selectedGender == "Male"
                                  ? Colors.pink
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedGender = "Female";
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.female,
                            size: 50,
                            color: selectedGender == "Female"
                                ? Colors.pink
                                : Colors.grey,
                          ),
                          Text(
                            "FEMALE",
                            style: TextStyle(
                              color: selectedGender == "Female"
                                  ? Colors.pink
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (selectedGender == null)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Gender is required",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),

                // Name Field
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    labelText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  onSaved: (value) => name = value,
                ),
                const SizedBox(height: 16),

                // Phone Number Field with Country Picker
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (Country country) {
                            setState(() {
                              countryCode = "+${country.phoneCode}";
                            });
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Text(
                          countryCode,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter your phone number",
                          labelText: "Phone Number",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Phone number is required";
                          }
                          if (!RegExp(r'^\d{7,15}$').hasMatch(value)) {
                            return "Enter a valid phone number";
                          }
                          return null;
                        },
                        onSaved: (value) => phoneNumber = value,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Date of Birth Field
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      setState(() {
                        dateOfBirth = DateFormat('dd-MM-yyyy').format(pickedDate);
                        age = (DateTime.now().year - pickedDate.year).toString();
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "DD-MM-YYYY",
                        labelText: "Date Of Birth",
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (dateOfBirth == null || dateOfBirth!.isEmpty) {
                          return "Date of Birth is required";
                        }
                        return null;
                      },
                      controller: TextEditingController(text: dateOfBirth),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Age Display
                if (age != null)
                  Text(
                    "Your age is $age years",
                    style: TextStyle(color: Colors.black54),
                  ),
                const SizedBox(height: 32),

                // Continue Button
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate() &&
                        selectedGender != null &&
                        dateOfBirth != null) {
                      _formKey.currentState!.save();

                      Navigator.pushReplacementNamed(
                        context,
                        '/category',
                        arguments: {
                          'name': name,
                          'email': widget.email,
                          'dateOfBirth': dateOfBirth,
                          'gender': selectedGender,
                          'phoneNumber': "$countryCode $phoneNumber",
                          'password': widget.password,
                        },
                      );
                    } else if (selectedGender == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gender is required")),
                      );
                    } else if (dateOfBirth == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Date of Birth is required")),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
