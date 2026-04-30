import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UrgeSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const UrgeSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isSelected
                      ? AppColors.cardBackgroundColor.withOpacity(0.2)
                      : AppColors.cardBackgroundColor.withOpacity(0.1),
                  AppColors.cardBackgroundColor.withOpacity(0.0),
                ],
              ),
              border: Border.all(
                color: isSelected
                    ? AppColors.cardBackgroundColor.withOpacity(0.4)
                    : AppColors.textPrimary.withOpacity(0.05),
                width: isSelected ? 1.5 : 1.0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cardBackgroundColor.withOpacity(
                      isSelected ? 0.25 : 0.12,
                    ),
                    border: Border.all(
                      color: AppColors.textPrimary.withOpacity(0.15),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.bgDark.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                      if (isSelected)
                        BoxShadow(
                          color: AppColors.cardBackgroundColor.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.cardBackgroundColor.withOpacity(0.9),
                    size: 24,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
