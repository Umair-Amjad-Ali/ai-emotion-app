import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onBackTap;
  final String level;

  const AppHeader({super.key, this.onBackTap, this.level = 'LEVEL 1'});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive font sizes matching splash screen proportions
    final baseFontSize = screenWidth * 0.045; // Slightly smaller for header
    final titleLetterSpacing = screenWidth * 0.01;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back Arrow
          IconButton(
            onPressed: onBackTap ?? () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white70, size: 28),
          ),

          // Center: THE NOT YOU
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'THE ',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: titleLetterSpacing,
                ),
              ),
              Text(
                'NOT',
                style: TextStyle(
                  color: AppColors.accentRed,
                  fontSize: baseFontSize * 1.5,
                  fontWeight: FontWeight.w900,
                  letterSpacing: titleLetterSpacing,
                ),
              ),
              Text(
                ' YOU',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: titleLetterSpacing,
                ),
              ),
            ],
          ),

          // Right: Brain Icon + Level Text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/pngs/brain.png',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.psychology,
                  color: AppColors.accentRed,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
