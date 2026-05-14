import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';
// Import your settings screen here

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _currentIndex = 0;

  // List of screens for the navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const SettingsScreen(), // Replace with your actual SettingsScreen()
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set to false so the background gradient covers the whole screen
      extendBody: true,
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. Current Page Content
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // 2. Floating Bottom Navigation Bar
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              selectedIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}