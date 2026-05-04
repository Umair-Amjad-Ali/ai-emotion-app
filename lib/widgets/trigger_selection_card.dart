import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class TriggerSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final bool isCentered;
  final VoidCallback onTap;

  const TriggerSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    this.isCentered = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isSelected
                      ? AppColors.cardBackgroundColor.withOpacity(0.2)
                      : AppColors.cardBackgroundColor.withOpacity(0.08),
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
            child: isCentered ? _buildCenteredLayout() : _buildTopLeftLayout(),
          ),
        ),
      ),
    );
  }

  // The fixed layout: Grouped together and vertically centered
  Widget _buildTopLeftLayout() {
    return Column(
      // Centers the whole group (icon + text) inside the card
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon with tiny glowing dot
        Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: AppColors.cardBackgroundColor.withOpacity(0.9),
              size: 28, // Slightly larger to match the image
            ),
            // The tiny glowing dot
            Positioned(
              top: -2,
              right: -6,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cardBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardBackgroundColor,
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Fixed spacing instead of a Spacer()! This fixes the huge gap issue.
        const SizedBox(height: 12),

        // Text Group
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: AppColors.textPrimary.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // The 'Other' card layout: Everything centered with a big ambient glow
  Widget _buildCenteredLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cardBackgroundColor.withOpacity(
              isSelected ? 0.2 : 0.05,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.cardBackgroundColor.withOpacity(0.15),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.cardBackgroundColor.withOpacity(0.9),
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textPrimary.withOpacity(0.5),
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
