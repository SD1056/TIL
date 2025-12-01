import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/write_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // 🔥 const 전부 제거
  List<Widget> get _screens => [
        HomeScreen(),
        const Center(child: Text("동네생활")),
        const Center(child: Text("내 근처")),
        const Center(child: Text("채팅")),
        const Center(child: Text("나의 당근")),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WriteScreen()),
          );
          // 글쓰기 화면에서 돌아오면 이 setState가 다시 build() 호출
          setState(() {});
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: "동네생활"),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: "내 근처"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "채팅"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "나의 당근"),
        ],
      ),
    );
  }
}
