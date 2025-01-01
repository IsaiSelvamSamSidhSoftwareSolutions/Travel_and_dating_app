//
// import 'package:flutter/material.dart';
// import 'create_account_page.dart';
//
// class SignUpPage extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.pink[50], // Light pink background color
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return SingleChildScrollView(
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 minHeight: constraints.maxHeight,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(height: 50),
//                     Text(
//                       "Let’s Sign Up With Your Email",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 40),
//                     _buildTextField(
//                       controller: emailController,
//                       hintText: "Enter your Email",
//                       icon: Icons.email, // Email Icon
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: passwordController,
//                       hintText: "Enter Password",
//                       icon: Icons.lock, // Lock Icon
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildTextField(
//                       controller: confirmPasswordController,
//                       hintText: "Confirm Password",
//                       icon: Icons.lock, // Lock Icon
//                       obscureText: true,
//                     ),
//                     const SizedBox(height: 32),
//                     GestureDetector(
//                       onTap: () {
//                         if (passwordController.text ==
//                             confirmPasswordController.text) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CreateAccountPage(
//                                 email: emailController.text,
//                                 password: passwordController.text,
//                               ),
//                             ),
//                           );
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                               content: Text("Passwords do not match!"),
//                             ),
//                           );
//                         }
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 16.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.pink,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: const Center(
//                           child: Text(
//                             "Continue",
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: const [
//                         Expanded(
//                           child: Divider(thickness: 1, color: Colors.grey),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8.0),
//                           child: Text(
//                             "Or Sign Up With",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ),
//                         Expanded(
//                           child: Divider(thickness: 1, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildSocialButton(
//                           icon: Icons.facebook,
//                           color: Colors.blue,
//                           onTap: () {
//                             print("Facebook Button Pressed");
//                           },
//                         ),
//                         const SizedBox(width: 20),
//                         _buildSocialButton(
//                           icon: Icons.g_mobiledata,
//                           color: Colors.red,
//                           onTap: () {
//                             print("Google Button Pressed");
//                           },
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushNamed(context, '/login');
//                       },
//                       child: const Center(
//                         child: Text.rich(
//                           TextSpan(
//                             text: "Already have an account? ",
//                             style: TextStyle(color: Colors.black),
//                             children: [
//                               TextSpan(
//                                 text: "Sign In",
//                                 style: TextStyle(
//                                   color: Colors.pink,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     bool obscureText = false,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       decoration: InputDecoration(
//         hintText: hintText,
//         filled: true,
//         fillColor: Colors.white,
//         prefixIcon: Icon(icon, color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSocialButton({
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.3),
//               blurRadius: 5,
//               offset: Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Icon(icon, size: 40, color: color),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'create_account_page.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Light pink background color
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      "Let’s Sign Up With Your Email",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    _buildTextField(
                      controller: emailController,
                      hintText: "Enter your Email",
                      icon: Icons.email, // Email Icon
                      errorMessage: "Email is required",
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: passwordController,
                      hintText: "Enter Password",
                      icon: Icons.lock, // Lock Icon
                      obscureText: true,
                      errorMessage: "Password is required",
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
                      icon: Icons.lock, // Lock Icon
                      obscureText: true,
                      errorMessage: "Confirm Password is required",
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () {
                        String? errorMessage = _validateFields();
                        if (errorMessage != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage)),
                          );
                          return;
                        }

                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateAccountPage(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Passwords do not match!"),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                        ),
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
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Or Sign Up With",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Divider(thickness: 1, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.facebook,
                          color: Colors.blue,
                          onTap: () {
                            print("Facebook Button Pressed");
                          },
                        ),
                        const SizedBox(width: 20),
                        _buildSocialButton(
                          icon: Icons.g_mobiledata,
                          color: Colors.red,
                          onTap: () {
                            print("Google Button Pressed");
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Center(
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String? _validateFields() {
    if (emailController.text.isEmpty) {
      return "Email is required";
    }
    if (passwordController.text.isEmpty) {
      return "Password is required";
    }
    if (confirmPasswordController.text.isEmpty) {
      return "Confirm Password is required";
    }
    return null;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    required String errorMessage,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
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
        child: Icon(icon, size: 40, color: color),
      ),
    );
  }
}
