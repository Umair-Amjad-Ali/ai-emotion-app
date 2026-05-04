import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart'; // Make sure to import this for bgDark

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
      // Added a subtle shadow so the bar pops out from the scrolling text
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          // Strong blur to distort any text scrolling behind it
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              // "Lite solid" background: mostly dark but slightly translucent
              color: AppColors.bgDark.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.grid_view_rounded,
                  color: Colors
                      .white, // Made the first icon fully white (active state)
                  size: 26,
                ),
                Icon(Icons.settings_outlined, color: Colors.white54, size: 26),
                Icon(Icons.person_outline, color: Colors.white54, size: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
