import 'package:flutter/material.dart';

import '../../widgets/custom_bottom_bar_fun.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';
import '../settings/settings_screen.dart';

class AppLayout extends StatefulWidget {
  // Added initialIndex parameter, defaulting to 0
  final int initialIndex;

  const AppLayout({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    // Initialize state with the value passed from the constructor
    _currentIndex = widget.initialIndex;
  }

  // List of screens for the navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: CustomBottomNavBarFunctional(
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
