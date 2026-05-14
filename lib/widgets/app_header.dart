import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import '../Utils.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback? onBackTap;
  final String level;
  // New parameter to toggle the brain/level display
  final bool showStatus;

  const AppHeader({
    super.key,
    this.onBackTap,
    this.level = 'LEVEL 1',
    this.showStatus = true, // Enabled by default
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    print("Rebuild___ app header");

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
            onPressed: onBackTap ?? () {
              Utils.goBack(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white70, size: 28),
          ),

          // Center: Logo Image
          Image.asset('assets/pngs/header.png', height: 25,),

          // Right: Brain Icon + Level Text (Conditional)
          SizedBox(
            width: 42, // Keep width fixed to maintain center alignment of logo
            child: showStatus ? Column(
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
                Text(
                    level,
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        height: -0.5
                    )
                ),
              ],
            ) : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}