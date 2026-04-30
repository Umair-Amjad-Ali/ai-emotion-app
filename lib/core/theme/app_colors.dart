import 'package:flutter/material.dart';

class AppColors {
  // Primary background colors
  static const Color bgDark = Color(0xFF050816);
  static const Color bgGlow = Color.fromARGB(
    255,
    24,
    38,
    63,
  ); // Subtly visible blue glow for general backgrounds
  static const Color bgGlowSplash = Color.fromARGB(255, 18, 29, 54);
  static const Color bgGlowBlue = Color.fromARGB(
    255,
    3,
    24,
    79,
  ); // Extremely subtle "lite lite" glow for splash

  // Highlight colors
  static const Color accentRed = Color(0xFFEF1B1B);

  // Gradient colors (for bottom overlay)
  static const Color gradientStart = Color(0x99050816);
  static const Color gradientEnd = Colors.transparent;

  // New Glass Card Specs
  static const Color glassCardBg = Color(0x08FFFFFF); // #FFFFFF08
  static const Color glassCardBorder = Color(0x14FFFFFF); // #FFFFFF14
  static const Color glassCardInset = Color(0x0DFFFFFF); // #FFFFFF0D

  // Warning Circle Specs
  static const Color warningCircleBg = Color(0x33B5C8E2); // #B5C8E233

  // Button Specs (from screenshot)
  static const Color buttonStart = Color(0xFF5B7BA3); // Lighter bluish color
  static const Color buttonEnd = Color(0xFF3A4D64); // Darker bluish color

  // Text colors
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;

  // Button
  static const Color solidBackgroundColor = Color.fromARGB(255, 63, 68, 82);

  // Card
  static const Color cardBackgroundColor = Color(0xFFB5C8E2);
}
