import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String imageUrl;

  ProfilePage({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Top Section with Curved Image and Icons
            Stack(
              children: [
                ClipPath(
                  clipper: CurvedImageClipper(),
                  child: Image.network(
                    imageUrl,
                    height: 350,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 40,
                  right: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '90% Match',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -30,
                  left: MediaQuery.of(context).size.width / 2 - 90,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red, size: 40),
                        onPressed: () {},
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.favorite, color: Colors.white, size: 40),
                      ),
                      IconButton(
                        icon: Icon(Icons.star, color: Colors.yellow, size: 40),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            // Name Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name, 22',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Professional Model',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: Colors.pink),
                      SizedBox(width: 5),
                      Text(
                        'Delhi, India • 12 KM',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // About Section
                  Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'My name is Micheal Rose and I enjoy meeting new people and finding ways to help them have an uplifting experience. I enjoy reading.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 16),

                  // Interests Section
                  Text(
                    'Interest',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      InterestButton(label: 'Fashion'),
                      InterestButton(label: 'Photography'),
                      InterestButton(label: 'Music'),
                      InterestButton(label: 'Travel'),
                      InterestButton(label: 'Pets'),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Physical Profile Section
                  Text(
                    'Physical Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PhysicalDetail(title: 'Age', value: '22 years'),
                      PhysicalDetail(title: 'Height', value: '167 cm'),
                      PhysicalDetail(title: 'Weight', value: '55 kg'),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Gallery Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gallery',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://i.pravatar.cc/150?img=${index + 1}',
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),

                  // Social Media Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.facebook, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.camera_alt, color: Colors.pink),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.chat, color: Colors.blueAccent),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Report and Block Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Report',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Block'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Clipper for Image Curve
class CurvedImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Interest Button Widget
class InterestButton extends StatelessWidget {
  final String label;

  InterestButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.pink.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.pink, width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Physical Detail Widget
class PhysicalDetail extends StatelessWidget {
  final String title;
  final String value;

  PhysicalDetail({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Text(value, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
