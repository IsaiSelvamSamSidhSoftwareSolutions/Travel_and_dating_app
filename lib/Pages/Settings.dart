import 'package:flutter/material.dart';

void main() {
  runApp(SettingsApp());
}

class SettingsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Switch state for Dark Mode

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Light pink background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.pinkAccent),
        //   onPressed: () => {},
        // ),
        title: Text(
          "App settings",
          style: TextStyle(color: Colors.grey[800], fontSize: 18),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),

            // Rounded Container with Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: Colors.pink[100], // Light pink rounded background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildSettingsOption(Icons.lock, "Privacy"),
                    _buildSettingsOption(Icons.notifications, "Notification"),
                    _buildSettingsOption(
                        Icons.person_add_alt, "Add Social Account"),
                    _buildSettingsOption(Icons.sos, "Emergency SOS"),
                    _buildSettingsOption(Icons.info_outline, "About"),
                    _buildDarkModeOption(), // Switch for Dark Mode
                    _buildSettingsOption(Icons.logout, "Logout"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for settings option row
  Widget _buildSettingsOption(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent, size: 24),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Widget for Dark Mode with Switch
  Widget _buildDarkModeOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.nightlight_round, color: Colors.pinkAccent, size: 24),
              SizedBox(width: 12),
              Text(
                "Dark mode",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Switch(
            value: _isDarkMode,
            activeColor: Colors.pinkAccent,
            onChanged: (value) {
              setState(() {
                _isDarkMode = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
