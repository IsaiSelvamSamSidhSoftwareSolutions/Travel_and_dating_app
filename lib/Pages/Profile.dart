import 'package:flutter/material.dart';
import 'Edit_Profile.dart';
import 'Settings.dart';
void main() {
  runApp(AccountProfileApp());
}

class AccountProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AccountProfile(),
    );
  }
}

class AccountProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Light pink background
      appBar: AppBar(
        title: Text(
          "Profile Page",
          style: TextStyle(color: Colors.grey[800]),
        ),
        backgroundColor: Colors.grey[300],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildProfileHeader(),
            SizedBox(height: 20),
            _buildProfileOptions(context), // Pass context here
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.pink[100],
              child: CircleAvatar(
                radius: 65,
                backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/300"), // Replace with profile image
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withOpacity(0.3),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "50% Complete",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Rahul Sharma",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Text(
          "Traveler",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
        children: [
          ProfileOption(
            icon: Icons.edit,
            label: "Edit Profile",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );
            },
          ),
          ProfileOption(
            icon: Icons.settings,
            label: "Settings",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsApp()),
              );
              // Add navigation for Settings Page
            },
          ),
          ProfileOption(
            icon: Icons.security,
            label: "Security",
            onTap: () {
              // Add navigation for Security Page
            },
          ),
          ProfileOption(
            icon: Icons.help,
            label: "Help & Support",
            onTap: () {
              // Add navigation for Help & Support Page
            },
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap; // Callback for tap navigation

  ProfileOption({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // Trigger navigation here
      borderRadius: BorderRadius.circular(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink[50],
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.4),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.pink[100],
              child: Icon(
                icon,
                size: 36,
                color: Colors.pinkAccent,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
