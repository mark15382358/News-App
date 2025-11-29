import 'package:flutter/material.dart';
import 'package:news_app/features/bookmark/book_mark.dart';
import 'package:news_app/features/home/home_screen.dart';
import 'package:news_app/features/profile/profile.dart';
import 'package:news_app/features/search/search_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screen = [
    HomeScreen(),
    SearchScreen(),
    BookMark(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (int? index) {
          setState(() {
            currentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_add),
            label: "Bookmark",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
      body: _screen[currentIndex],
    );

    
  }
}
