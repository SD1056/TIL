class Product {
  final String imageUrl;
  final String title;
  final String location;
  final int price;
  final int likes;
  final double? latitude;
  final double? longitude;

  Product({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.likes,
    this.latitude,
    this.longitude,
  });
}
