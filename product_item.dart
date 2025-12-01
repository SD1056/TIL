import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final int price;
  final int likes;

  const ProductItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(
              imageUrl: imageUrl,
              title: title,
              location: location,
              price: price,
              likes: likes,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(location, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 6),
                  Text(
                    price == 0 ? "나눔" : "$price 원",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Icon(Icons.favorite_border, size: 16),
                const SizedBox(height: 4),
                Text(likes.toString()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
