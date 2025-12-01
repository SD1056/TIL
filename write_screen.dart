import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/mock_products.dart';
import '../models/selected_location.dart';
import 'map_select_screen.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  SelectedLocation? _selectedLocation;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _openMapSelect() async {
    final result = await Navigator.push<SelectedLocation>(
      context,
      MaterialPageRoute(
        builder: (_) => const MapSelectScreen(),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedLocation = result;
      });
    }
  }

  void _submit() {
    final String title = _titleController.text.trim();
    final String priceText = _priceController.text.trim();
    final String desc = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("제목을 입력해주세요.")),
      );
      return;
    }

    int price = 0;
    if (priceText.isNotEmpty) {
      price = int.tryParse(priceText.replaceAll(",", "")) ?? 0;
    }

    final String locationText = _selectedLocation == null
        ? "거래 장소 미설정 · 방금 전"
        : "${_selectedLocation!.name} · 방금 전";

    final Product newProduct = Product(
      imageUrl: "assets/images/sample.jpg",
      title: title,
      location: locationText,
      price: price,
      likes: 0,
      latitude: _selectedLocation?.latitude,
      longitude: _selectedLocation?.longitude,
    );

    // 🔥 리스트에 추가
    mockProducts.insert(0, newProduct);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final String locationDisplay = _selectedLocation == null
        ? "거래 장소를 설정해주세요"
        : _selectedLocation!.name;

    return Scaffold(
      appBar: AppBar(
        title: const Text("중고거래 글쓰기"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey.shade300,
                child: const Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "제목",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "가격 (원)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _openMapSelect,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.place, color: Colors.orange),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          locationDisplay,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: "상품 설명",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: _submit,
          child: const Text(
            "등록하기",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
