import 'package:ai_emotion_app/screen/mind_clutter/reflection_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/custom_video_player.dart';

class MindSpaceResetScreen extends StatelessWidget {
  const MindSpaceResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    return Scaffold(
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
                          letterSpacing: 2.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Main Headline
                      Text(
                        'Notice the quiet\nspace left behind',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // Body Description
                      Text(
                        'You do not need to refill the space with\nmore thinking. Just rest in it for a\nmoment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.65),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Central Layered Video Component
                      _buildConcentricVideoPlayer(screenWidth),

                      SizedBox(height: screenHeight * 0.04),

                      // Continue Button
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReflectionScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 120),
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

  // --- Widget Builder for the Multi-Border / Shadowed Video Area ---
  Widget _buildConcentricVideoPlayer(double screenWidth) {
    // Determine the sizing
    final double innerVideoSize = screenWidth * 0.45;
    final double ringThickness = screenWidth * 0.08;

    return Center(
      // OUTERMOST RING
      child: Container(
        padding: EdgeInsets.all(ringThickness * 0.5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.02),
          border: Border.all(color: Colors.white.withOpacity(0.03), width: 1),
        ),
        child: Container(
          // OUTER RING
          padding: EdgeInsets.all(ringThickness * 0.8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.05), // Very faint background
            border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
          ),
          child: Container(
            // MIDDLE RING
            padding: EdgeInsets.all(ringThickness),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.04),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ),
            ),
            child: Container(
              width: innerVideoSize,
              height: innerVideoSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accentBlueLite.withOpacity(0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.2),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipOval(
                child: CustomVideoPlayer(
                  height: innerVideoSize,
                  width: innerVideoSize,
                  videoPath: 'assets/animations/mind_space.mp4',
                  isLooping: true,
                  offset: const Offset(0, 5),
                  zoom: 1.05,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
