// lib/models/driver.dart
class Driver {
  final String id;
  final String name;
  final double rating;
  final String imageUrl;
  final String? phone;
  final String? email;
  final String? address;
  final List<String> drivingLicenseImages;

  Driver({
    required this.id,
    required this.name,
    required this.rating,
    required this.imageUrl,
    this.phone,
    this.email,
    this.address,
    required this.drivingLicenseImages,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    final imageUrl = json['drivingLicenseImages'] != null &&
        json['drivingLicenseImages'].isNotEmpty
        ? 'https://demo.samsidh.com/${json['drivingLicenseImages'][0].replaceAll(r'\\', '/')}'
        : 'https://demo.samsidh.com/uploads/driver/default_user_icon.png';

    final licenseImages = (json['drivingLicenseImages'] as List<dynamic>?)
        ?.map((image) =>
    'https://demo.samsidh.com/${image.replaceAll(r'\\', '/')}')
        .toList() ??
        [];

    return Driver(
      id: json['_id'],
      name: json['name'],
      rating: json['rating'] ?? 0.0,
      imageUrl: imageUrl,
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      drivingLicenseImages: licenseImages,
    );
  }
}
