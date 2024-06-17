import 'package:flutter/material.dart';
import 'package:movietime/src/page/screen/homepage.dart';
import 'package:movietime/src/page/screen/profile.dart';
import 'package:movietime/src/page/screen/search.dart';
import 'package:movietime/src/page/screen/watch.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

final List<Widget> page = [
  Homepage(),
  SearchScreen(),
  VideoScreen(),
  ProfileScreen(),
];

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  // void _onDestinationSelected(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(
            icon: Icon(Icons.video_call_rounded),
            label: 'Watch',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
      ),
    );
  }
}
