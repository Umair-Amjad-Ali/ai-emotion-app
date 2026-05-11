import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class ScreenHeader extends StatelessWidget {
  final String? label;
  final String title;
  final String subtitle;

  const ScreenHeader({
    super.key,
     this.label,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: screenHeight * 0.025),
        if (label != null && label!.isNotEmpty) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
        ],
        SizedBox(height: screenHeight * 0.015),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            height: 1.1,
          ),
        ),
        SizedBox(height: screenHeight * 0.015),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 15,
            height: 1.4,
          ),
        ),
        SizedBox(height: screenHeight * 0.035),
      ],
    );
  }
}
