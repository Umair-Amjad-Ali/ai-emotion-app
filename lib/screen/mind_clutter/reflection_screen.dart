import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';

class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({super.key});

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      // Subtitle
                      Text(
                        "MIND SPACE RESET",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.accentBlueLite,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 4.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      // Main Headline
                      Text(
                        'How does your mind\nfeel now?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      // Body Description
                      Text(
                        'Choose the closest reflection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // Selection Options List
                      _buildOptionTile(
                        id: 'much_lighter',
                        label: 'Much lighter',
                        iconData: Icons.air,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildOptionTile(
                        id: 'slightly_lighter',
                        label: 'Slightly lighter',
                        iconData: Icons.cloud_outlined,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildOptionTile(
                        id: 'about_same',
                        label: 'About the same',
                        iconData: Icons.balance,
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      // Continue Button
                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

                      const SizedBox(
                        height: 120,
                      ), // Padding to prevent bottom nav overlap
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  // Custom widget for the selectable option tiles
  Widget _buildOptionTile({
    required String id,
    required String label,
    required IconData iconData,
  }) {
    final bool isSelected = _selectedOption == id;

    return GestureDetector(
      onTap: () => setState(() => _selectedOption = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Leading Icon inside a circular background
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accentBlueLite.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(iconData, color: AppColors.accentBlueLite, size: 20),
            ),

            const SizedBox(width: 16),

            // Text Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Trailing Radio Indicator
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentBlueLite
                      : AppColors.textPrimary.withOpacity(0.3),
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
