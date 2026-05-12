import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ConfirmPresentSafetyScreen extends StatefulWidget {
  const ConfirmPresentSafetyScreen({super.key});

  @override
  State<ConfirmPresentSafetyScreen> createState() =>
      _ConfirmPresentSafetyScreenState();
}

class _ConfirmPresentSafetyScreenState
    extends State<ConfirmPresentSafetyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ScreenHeader(
                  title: 'Confirm present\nsafety',
                  subtitle: 'Only tap this if it is true right now.',
                ),
              ),
              Expanded(child: Center(child: _buildSafeNowCircle())),
              // Button pinned above the nav bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: PrimaryButton(
                  text: 'YES AM SURE',
                  height: 60,
                  onPressed: () {
                    // Handle navigation to next screen
                  },
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildSafeNowCircle() {
    return Center(
      child: SizedBox(
        width: 280,
        height: 280,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer ring
            Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.textPrimary.withOpacity(0.04),
                  width: 1.5,
                ),
              ),
            ),
            // Inner ring
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.textPrimary.withOpacity(0.06),
                  width: 1.5,
                ),
              ),
            ),
            // Inner circle with text
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cardLikePillBg.withOpacity(0.6),
                    AppColors.cardLikePillBg.withOpacity(0.6),
                  ],
                  radius: 0.85,
                ),
                border: Border.all(
                  color: AppColors.accentBlueLite.withOpacity(0.08),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.08),
                    blurRadius: 40,
                    spreadRadius: 8,
                  ),
                  BoxShadow(
                    color: AppColors.bgDark.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'S T A B L E',
                    style: TextStyle(
                      color: AppColors.accentBlueLite.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'SAFE NOW',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
