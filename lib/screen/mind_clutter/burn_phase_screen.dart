import 'dart:math' as math;
import 'package:ai_emotion_app/screen/mind_clutter/residual_release.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/custom_video_player.dart';

class BurnCycleScreen extends StatelessWidget {
  const BurnCycleScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      // Main Headline
                      Text(
                        'Burn Cycle',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      Text(
                        'Let the thought dissolve and vanish into\nthe infinite.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.65),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _buildInteractiveCardSection(screenWidth),

                      SizedBox(height: screenHeight * 0.06),

                      // Continue Button
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResidualReleaseScreen(),
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

  Widget _buildInteractiveCardSection(double screenWidth) {
    final double cardWidth = math.min(screenWidth * 0.8, 380.0);
    final double cardHeight = cardWidth * 1.15;
    final double videoSize = cardWidth * 0.5;

    // UI Constants
    const double cornerRadius = 40.0;
    final Color lineColor = const Color(0xFF4A5578).withOpacity(0.3);

    return Center(
      child: Stack(
        clipBehavior:
            Clip.none, // Allows the side cards to break outside the bounds
        alignment: Alignment.center,
        children: [
          // 1. THE MAIN CARD
          Container(
            width: cardWidth,
            height: cardHeight,
            decoration: BoxDecoration(
              color: AppColors.cardLikePillBg.withOpacity(
                0.3,
              ), // Deep smooth dark blue
              borderRadius: BorderRadius.circular(cornerRadius),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: cornerRadius,
                  right: cornerRadius,
                  height: 1.5,
                  child: Container(color: lineColor),
                ),

                Positioned(
                  left: 0,
                  top: cornerRadius,
                  bottom: cornerRadius,
                  width: 1.5,
                  child: Container(color: lineColor),
                ),
                Positioned(
                  right: 0,
                  top: cornerRadius,
                  bottom: cornerRadius,
                  width: 1.5,
                  child: Container(color: lineColor),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.lightPink.withOpacity(0.2),
                            width: 1,
                          ),
                          color: AppColors.lightPink.withOpacity(0.05),
                        ),
                        child: Text(
                          'SEALED',
                          style: TextStyle(
                            color: AppColors.lightPink,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),

                      // Center: Circular Video with Ring
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(
                              0.1,
                            ), // Outer ring
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightPink.withOpacity(0.1),
                              blurRadius: 40,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: CustomVideoPlayer(
                            height: videoSize,
                            width: videoSize,
                            videoPath: 'assets/animations/burn.mp4',
                            isLooping: true,
                          ),
                        ),
                      ),

                      // Bottom: Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'The thought is being reduced to ash.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.5),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: -20,
            child: Transform.rotate(
              angle: -math.pi / 16,
              child: _buildFloatingSideCard(
                Icons.cyclone_rounded,
                AppColors.solidBackgroundColor.withOpacity(0.9),
              ),
            ),
          ),

          Positioned(
            right: -20,
            child: Transform.rotate(
              angle: math.pi / 16,
              child: _buildFloatingSideCard(
                Icons.local_fire_department_rounded,
                AppColors.lightPink.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingSideCard(IconData icon, color) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.07),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(child: Icon(icon, color: color, size: 22)),
    );
  }
}
