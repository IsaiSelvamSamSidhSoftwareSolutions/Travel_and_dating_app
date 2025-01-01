// import 'package:flutter/material.dart';
//
// class CategoryPage extends StatefulWidget {
//   @override
//   _CategoryPageState createState() => _CategoryPageState();
// }
//
// class _CategoryPageState extends State<CategoryPage> {
//   String? selectedCategory;
//   Map<String, dynamic>? receivedData; // To store data passed from CreateAccountPage
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Retrieve arguments passed from CreateAccountPage
//     receivedData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50],
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // Back Button
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     padding: const EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           blurRadius: 5,
//                           offset: Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(Icons.arrow_back, color: Colors.black),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Title
//               Text(
//                 "I’m Looking For...",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 "Provide us with further insights into your preferences",
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//
//               // Dot Slider
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(5, (index) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 4.0),
//                     width: index == 2 ? 12 : 8,
//                     height: index == 2 ? 12 : 8,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: index == 2 ? Colors.pink : Colors.pink[100],
//                     ),
//                   );
//                 }),
//               ),
//               const SizedBox(height: 20),
//
//               // Category Options
//               _buildCategoryOption("A relationship"),
//               const SizedBox(height: 8),
//               _buildCategoryOption("Something casual"),
//               const SizedBox(height: 8),
//               _buildCategoryOption("I’m not sure yet"),
//               const SizedBox(height: 8),
//               _buildCategoryOption("Prefer not to say"),
//               const SizedBox(height: 32),
//
//               // Continue Button
//               GestureDetector(
//                 onTap: () {
//                   if (selectedCategory == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Please select an option"),
//                       ),
//                     );
//                   } else {
//                     print("Selected Category: $selectedCategory");
//                     print({
//                       'name': receivedData?['name'],
//                       'email': receivedData?['email'],
//                       'dateOfBirth': receivedData?['dateOfBirth'],
//                       'gender': receivedData?['gender'],
//                       'phoneNumber': receivedData?['phoneNumber'],
//                       'password': receivedData?['password'],
//                       'selectedCategory': selectedCategory,
//                     });
//                     // Pass data to UploadPhotoPage
//                     Navigator.pushReplacementNamed(
//                       context,
//                       '/uploadPhoto',
//                       arguments: {
//                         'name': receivedData?['name'],
//                         'email': receivedData?['email'],
//                         'dateOfBirth': receivedData?['dateOfBirth'],
//                         'gender': receivedData?['gender'],
//                         'phoneNumber': receivedData?['phoneNumber'],
//                         'password': receivedData?['password'],
//                         'selectedCategory': selectedCategory,
//                       },
//                     );
//                   }
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.pink,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Center(
//                     child: Text(
//                       "Continue",
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white,
//                       ),
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
//
//   Widget _buildCategoryOption(String category) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedCategory = category;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: selectedCategory == category ? Colors.pink : Colors.grey[300]!,
//             width: 2,
//           ),
//         ),
//         child: Text(
//           category,
//           style: TextStyle(
//             fontSize: 16,
//             color: selectedCategory == category ? Colors.pink : Colors.black,
//             fontWeight: selectedCategory == category ? FontWeight.bold : FontWeight.normal,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? selectedCategory;
  Map<String, dynamic>? receivedData; // To store data passed from CreateAccountPage

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve arguments passed from CreateAccountPage
    receivedData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                "I’m Looking For...",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Provide us with further insights into your preferences",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Dot Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    width: index == 2 ? 12 : 8,
                    height: index == 2 ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 2 ? Colors.pink : Colors.pink[100],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Category Options
              _buildCategoryOption("A relationship"),
              const SizedBox(height: 8),
              _buildCategoryOption("Something casual"),
              const SizedBox(height: 8),
              _buildCategoryOption("I’m not sure yet"),
              const SizedBox(height: 8),
              _buildCategoryOption("Prefer not to say"),
              const SizedBox(height: 32),

              // Continue Button
              GestureDetector(
                onTap: () {
                  if (selectedCategory == null) {
                    // Display an error message if no category is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select an option"),
                      ),
                    );
                  } else {
                    // Ensure all required fields are present in receivedData
                    if (receivedData == null ||
                        receivedData!['name'] == null ||
                        receivedData!['email'] == null ||
                        receivedData!['dateOfBirth'] == null ||
                        receivedData!['gender'] == null ||
                        receivedData!['phoneNumber'] == null ||
                        receivedData!['password'] == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Some required data is missing."),
                        ),
                      );
                      return;
                    }

                    print("Selected Category: $selectedCategory");
                    print({
                      'name': receivedData!['name'],
                      'email': receivedData!['email'],
                      'dateOfBirth': receivedData!['dateOfBirth'],
                      'gender': receivedData!['gender'],
                      'phoneNumber': receivedData!['phoneNumber'],
                      'password': receivedData!['password'],
                      'selectedCategory': selectedCategory,
                    });

                    // Pass data to UploadPhotoPage
                    Navigator.pushReplacementNamed(
                      context,
                      '/uploadPhoto',
                      arguments: {
                        'name': receivedData!['name'],
                        'email': receivedData!['email'],
                        'dateOfBirth': receivedData!['dateOfBirth'],
                        'gender': receivedData!['gender'],
                        'phoneNumber': receivedData!['phoneNumber'],
                        'password': receivedData!['password'],
                        'selectedCategory': selectedCategory,
                      },
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
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryOption(String category) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selectedCategory == category ? Colors.pink : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            fontSize: 16,
            color: selectedCategory == category ? Colors.pink : Colors.black,
            fontWeight: selectedCategory == category ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
