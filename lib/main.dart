import 'package:flutter/material.dart';
import 'Auth/signup_page.dart'; // Import SignUpPage
import 'Auth/login_page.dart'; // Import LoginPage
import 'Auth/create_account_page.dart'; // Import CreateAccountPage
import 'Auth/category_page.dart'; // Import CategoryPage
import 'Auth/upload_photo_page.dart'; // Import UploadPhotoPage
import 'Auth/location_permission_page.dart' as auth; // Alias for location_permission_page
import 'Pages/HomePage.dart'; // Import HomePage for the main app page
import 'Pages/ChatPage.dart';
import 'Pages/Profile.dart';
import 'Pages/Matches.dart';
import 'Pages/AddTrip.dart';
import 'Pages/ChooseTour.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Dating',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      // Initial page of the app
      home: SignUpPage(),
      // Define routes for navigation
      routes: {
        '/signup': (context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        // '/createAccount': (context) => CreateAccountPage(),
        '/createAccount': (context) => CreateAccountPage(
          email: '',
          password: '',
        ),
        '/profile': (context) => AccountProfile(),
        '/category': (context) => CategoryPage(),
        '/uploadPhoto': (context) => UploadPhotoPage(),
        '/locationPermission': (context) => auth.LocationPermissionPage(),
        '/HomePage': (context) => MainPage(),
        '/ChooseTours': (context) => ChooseTours(),
      },
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Track the current index for BottomNavigationBar

  // Define the pages for navigation
  final List<Widget> _pages = [
    HomePage(),
    ChatPage(),
    Match(),
    CreateTrip(),
  ];

  /// Dummy logout function
  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false, // Clear the navigation stack
    );
  }

  /// Show logout confirmation dialog
  Future<void> _showLogoutConfirmationDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancel
              child: Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Confirm
              child: Text('Yes'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _logout(); // Perform logout
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          // If on the home tab, show logout confirmation dialog
          await _showLogoutConfirmationDialog();
          return false; // Prevent default back navigation
        } else {
          // If not on the home tab, navigate back to the home tab
          setState(() {
            _currentIndex = 0;
          });
          return false; // Prevent default back navigation
        }
      },
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
