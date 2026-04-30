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
    const Color highlightColor = Color(0xFFB5C8E2);

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
                      ? highlightColor.withOpacity(0.2)
                      : highlightColor.withOpacity(0.08),
                  highlightColor.withOpacity(0.0),
                ],
              ),
              border: Border.all(
                color: isSelected
                    ? highlightColor.withOpacity(0.4)
                    : Colors.white.withOpacity(0.05),
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
    const Color highlightColor = Color(0xFFB5C8E2);

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
              color: highlightColor.withOpacity(0.9),
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
                  color: highlightColor,
                  boxShadow: [
                    BoxShadow(
                      color: highlightColor,
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
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // The 'Other' card layout: Everything centered with a big ambient glow
  Widget _buildCenteredLayout() {
    const Color highlightColor = Color(0xFFB5C8E2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: highlightColor.withOpacity(isSelected ? 0.2 : 0.05),
            boxShadow: [
              BoxShadow(
                color: highlightColor.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(icon, color: highlightColor.withOpacity(0.9), size: 24),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
