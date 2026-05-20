import 'dart:ui';
import 'package:ai_emotion_app/screen/guiltcleanser/write_letter_screen_step_eight.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/custom_video_player.dart';

class WashAwayIdentityScreenStepSeven extends StatefulWidget {
  const WashAwayIdentityScreenStepSeven({super.key});

  @override
  State<WashAwayIdentityScreenStepSeven> createState() =>
      _WashAwayIdentityScreenStepSevenState();
}

class _WashAwayIdentityScreenStepSevenState
    extends State<WashAwayIdentityScreenStepSeven> {
  // Tracks the drag position of the swipe bar
  double _dragPosition = 0.0;

  // Dimensions for the swipe bar
  final double _sliderHeight = 64.0;
  final double _thumbSize = 52.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    final double swipeBarWidth = screenWidth - (horizontalPadding * 2);
    final double maxDragDistance =
        swipeBarWidth - _thumbSize - 12; // 12 for padding
    double progress = (_dragPosition / maxDragDistance).clamp(0.0, 1.0);

    // Calculate blur based on progress (Starts at 20, ends at 0)
    final double currentBlur = 25.0 * (1.0 - progress);

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
                      SizedBox(height: screenHeight * 0.01),

                      // Main Headline
                      Text(
                        'Wash away identity\npunishment',
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
                        'Swipe across the bar until the\nchamber is visibly cleaner.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.7),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _buildVideoChamber(screenWidth, currentBlur),

                      SizedBox(height: screenHeight * 0.06),

                      _buildSwipeBar(swipeBarWidth, maxDragDistance),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: progress >= 0.95
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const WriteLetterScreenStepEight(),
                                  ),
                                );
                              }
                            : () {},
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

  Widget _buildVideoChamber(double screenWidth, double currentBlur) {
    final double containerWidth = screenWidth * 0.88;
    final double containerHeight = containerWidth * 0.8;

    return Center(
      child: Container(
        width: containerWidth,
        height: containerHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          // Strong outer glow mimicking the screenshot
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.15),
              blurRadius: 60,
              spreadRadius: 10,
            ),
          ],
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          // ImageFiltered applies the blur directly to the video widget
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: currentBlur,
              sigmaY: currentBlur,
            ),
            child: const CustomVideoPlayer(
              height: double.infinity,
              width: double.infinity,
              videoPath: 'assets/animations/water.mp4',
              isLooping: true,
              zoom: 1.25,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeBar(double barWidth, double maxDragDistance) {
    return Container(
      width: barWidth,
      height: _sliderHeight,
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.4),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Text & Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 40),
              Text(
                'C L E A N S E',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4.0,
                ),
              ),
            ],
          ),

          // Trailing double arrows
          Positioned(
            right: 24,
            child: Icon(
              Icons.keyboard_double_arrow_right_rounded,
              color: Colors.white.withOpacity(0.2),
              size: 16,
            ),
          ),

          // Draggable Thumb
          Positioned(
            left: _dragPosition + 6,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _dragPosition += details.delta.dx;

                  if (_dragPosition < 0) {
                    _dragPosition = 0;
                  } else if (_dragPosition > maxDragDistance) {
                    _dragPosition = maxDragDistance;
                  }
                });
              },
              child: Container(
                width: _thumbSize,
                height: _thumbSize,
                decoration: BoxDecoration(
                  color: AppColors.accentBlueLite,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentBlueLite.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF0D121F),
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
