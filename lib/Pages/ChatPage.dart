import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatListPage(),
    );
  }
}

class ChatListPage extends StatelessWidget {
  final List<Map<String, dynamic>> chats = [
    {
      'name': 'Jessica Mervin',
      'profileImage': 'https://i.pravatar.cc/150?img=5',
      'time': '7:20 AM',
      'isRead': false,
    },
    {
      'name': 'Micheal Rose',
      'profileImage': 'https://i.pravatar.cc/150?img=3',
      'time': '6:40 AM',
      'isRead': true,
    },
    {
      'name': 'Saira',
      'profileImage': 'https://i.pravatar.cc/150?img=2',
      'time': '6:40 AM',
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink.shade50,
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MessagePage(
                    name: chat['name'],
                    profileImage: chat['profileImage'],
                  ),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chat['profileImage']),
              ),
              title: Text(
                chat['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Hi'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(chat['time'], style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  chat['isRead']
                      ? Icon(Icons.check, color: Colors.grey, size: 16)
                      : Icon(Icons.circle, color: Colors.pink, size: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MessagePage extends StatefulWidget {
  final String name;
  final String profileImage;

  const MessagePage({required this.name, required this.profileImage});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String? selectedFileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.pink.shade50,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profileImage),
            ),
            SizedBox(width: 10),
            Text(
              widget.name,
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
        actions: [
          Icon(Icons.call, color: Colors.pink),
          SizedBox(width: 15),
          Icon(Icons.videocam, color: Colors.pink),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: "Hi Rahul",
                    isSender: false,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    message: "Hi Jessica! How's your day going?",
                    isSender: true,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    message: "It’s going well, thanks. How about yours?",
                    isSender: false,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    message:
                    "Not too bad, thanks. Just wrapped up work and now looking forward to some downtime.",
                    isSender: true,
                  ),
                ),
              ],
            ),
          ),
          if (selectedFileName != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected File: $selectedFileName',
                style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
            ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file, color: Colors.pink),
                  onPressed: _pickFile,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type Here',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.pink),
                  onPressed: () {
                    // Handle message send
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSender ? Colors.pink : Colors.pink.shade100,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: isSender ? Radius.circular(12) : Radius.zero,
          bottomRight: isSender ? Radius.zero : Radius.circular(12),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isSender ? Colors.white : Colors.black,
          fontSize: 13,
        ),
      ),
    );
  }
}
