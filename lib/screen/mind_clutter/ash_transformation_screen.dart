import 'package:ai_emotion_app/screen/mind_clutter/mind_space_reset_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/custom_video_player.dart'; // Make sure this path matches your project

class AshTransformationScreen extends StatelessWidget {
  const AshTransformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetch screen dimensions for responsiveness
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

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                          children: [
                            const TextSpan(text: 'Energy released\nreturns\n'),
                            TextSpan(
                              text: 'to awareness',
                              style: TextStyle(
                                color: AppColors.accentBlueLite,
                                shadows: [
                                  Shadow(
                                    color: AppColors.accentBlueLite.withOpacity(
                                      0.5,
                                    ),
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // Body Description
                      Text(
                        'The thought is gone. What remains is\nusable attention.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.65),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _buildGlowingVideoOrb(screenWidth),

                      SizedBox(height: screenHeight * 0.06),

                      // Continue Button
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MindSpaceResetScreen(),
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

  Widget _buildGlowingVideoOrb(double screenWidth) {
    final double outerRingSize = screenWidth * 0.75;
    final double innerVideoSize = screenWidth * 0.45;

    return Center(
      child: Container(
        width: outerRingSize,
        height: outerRingSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Faint outer circular line
          border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
        ),
        alignment: Alignment.center,
        child: Container(
          width: innerVideoSize,
          height: innerVideoSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // Soft glow aura behind the video
            boxShadow: [
              BoxShadow(
                color: AppColors.accentBlueLite.withOpacity(0.35),
                blurRadius: 60,
                spreadRadius: 10,
              ),
            ],
          ),
          child: ClipOval(
            child: CustomVideoPlayer(
              height: innerVideoSize,
              width: innerVideoSize,
              videoPath: 'assets/animations/energy.mp4',
              isLooping: true,
              zoom: 1.05,
            ),
          ),
        ),
      ),
    );
  }
}
