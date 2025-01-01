import 'package:flutter/material.dart';

void main() {
  runApp(NotificationApp());
}

class NotificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotificationPage(),
    );
  }
}

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [
    {
      "name": "David Silbia",
      "message": "Invite Trip to Srilanka - Colombo",
      "time": "Just now",
      "image": "https://i.pravatar.cc/150?img=1"
    },
    {
      "name": "Adnan Safi",
      "message": "Started following you",
      "time": "5 min ago",
      "image": "https://i.pravatar.cc/150?img=2"
    },
    {
      "name": "Joan Baker",
      "message": "Invite A virtual Evening of Smooth Jazz",
      "time": "20 min ago",
      "image": "https://i.pravatar.cc/150?img=3"
    },
    {
      "name": "Ronald C. Kinch",
      "message": "Like your events",
      "time": "1 hr ago",
      "image": "https://i.pravatar.cc/150?img=4"
    },
    {
      "name": "Clara Tolson",
      "message": "Join your Event Gala Music Festival",
      "time": "9 hr ago",
      "image": "https://i.pravatar.cc/150?img=5"
    },
    {
      "name": "Jennifer Fritz",
      "message": "Invite you International Kids Safe",
      "time": "Tue, 5:10 pm",
      "image": "https://i.pravatar.cc/150?img=6"
    },
    {
      "name": "Eric G. Prickett",
      "message": "Started following you",
      "time": "Wed, 3:30 pm",
      "image": "https://i.pravatar.cc/150?img=7"
    },
  ];

  int selectedTab = 0; // Track selected tab (0: All, 1: Invites)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pinkAccent),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: Text(
          "Notification",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(
                  notification['image'],
                  notification['name'],
                  notification['message'],
                  notification['time'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTab = 0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selectedTab == 0 ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  "All",
                  style: TextStyle(
                    color: selectedTab == 0 ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => selectedTab = 1),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selectedTab == 1 ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  "Invites",
                  style: TextStyle(
                    color: selectedTab == 1 ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotificationItem(
      String imageUrl, String name, String message, String time) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$name ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: message,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(time, style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Row(
            children: [
              _buildButton("Reject", Colors.black, Colors.white),
              SizedBox(width: 8),
              _buildButton("Accept", Colors.pinkAccent, Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
