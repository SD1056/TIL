import 'package:flutter/material.dart';
import '../widgets/category_item.dart';
import '../widgets/product_item.dart';
import '../models/mock_products.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      // 🔥 오른쪽에서 열리는 endDrawer 추가
      endDrawer: Drawer(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              child: Text(
                '메뉴',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('프로필'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('설정'),
            ),
          ],
        ),
      ),

      appBar: AppBar(
        elevation: 1,
        title: const Text("서초동"),
        actions: [
          // 🔥 메뉴 (오른쪽에서 endDrawer 열기)
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSnack(context, "검색 기능 준비 중 🧐");
            },
          ),

          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              _showSnack(context, "새 알림 없음 🔔");
            },
          ),
        ],
      ),

      body: Column(
        children: [
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                CategoryItem(icon: Icons.star, text: "인기매물"),
                SizedBox(width: 16),
                CategoryItem(icon: Icons.devices, text: "디지털"),
                SizedBox(width: 16),
                CategoryItem(icon: Icons.chair, text: "가구/인테리어"),
                SizedBox(width: 16),
                CategoryItem(icon: Icons.pets, text: "반려동물"),
                SizedBox(width: 16),
                CategoryItem(icon: Icons.sports_soccer, text: "스포츠"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mockProducts.length,
              itemBuilder: (context, index) {
                final product = mockProducts[index];
                return ProductItem(
                  imageUrl: product.imageUrl,
                  title: product.title,
                  location: product.location,
                  price: product.price,
                  likes: product.likes,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
