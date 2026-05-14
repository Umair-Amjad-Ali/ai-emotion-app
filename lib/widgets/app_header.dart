import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onBackTap;
  final String level;

  const AppHeader({super.key, this.onBackTap, this.level = 'LEVEL 1'});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    print("Rebuild___ app header");
    final baseFontSize = screenWidth * 0.045;
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
                'THE',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    fontFamily: 'bankgothicmdbt'
                ),
              ),
              Text(
                'NOT',
                style: TextStyle(
                  color: AppColors.accentRed,
                  fontSize: baseFontSize * 1.6,
                  fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    fontFamily: 'bankgothicmdbt'
                ),
              ),
              SizedBox(width: 3,),
              Text(
                'YOU',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: baseFontSize,
                  fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    fontFamily: 'bankgothicmdbt'
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
                width: 42,
                height: 42,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.psychology,
                  color: AppColors.accentRed,
                  size: 32,
                ),
              ),
              const Text("LEVEL 1", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold, height: -0.5)),
            ],
          ),
        ],
      ),
    );
  }
}
