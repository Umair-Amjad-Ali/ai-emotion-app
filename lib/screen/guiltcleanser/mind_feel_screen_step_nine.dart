import 'dart:ui';
import 'package:ai_emotion_app/screen/guiltcleanser/guilt_cleanser_final_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/custom_video_player.dart';

class MindFeelScreenStepNine extends StatefulWidget {
  const MindFeelScreenStepNine({super.key});

  @override
  State<MindFeelScreenStepNine> createState() => _MindFeelScreenStepNineState();
}

class _MindFeelScreenStepNineState extends State<MindFeelScreenStepNine> {
  double _weightValue = 0.0;

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
                      SizedBox(height: screenHeight * 0.01),

                      // Main Headline
                      Text(
                        'How Clear does your mind\n feel now?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.015),

                      // Body Description
                      Text(
                        'Measure the weight of your burden.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.65),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      _buildVideoCard(screenWidth),

                      SizedBox(height: screenHeight * 0.025),
                      _buildSliderSection(),
                      SizedBox(height: screenHeight * 0.02),

                      // Continue Button
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const GuiltCleanserFinalResultScreen(),
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

  Widget _buildVideoCard(double screenWidth) {
    // Determine card dimensions
    final cardHeight = screenWidth * 1.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. The Main Video Card with Thicker Border
        Container(
          width: double.infinity,
          height: cardHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF0D121F),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: const Color(0xFF2A344A), width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // The Video Player (Clipped to fit inside the thick border)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: const CustomVideoPlayer(
                    height: double.infinity,
                    width: double.infinity,
                    videoPath: 'assets/animations/smoke.mp4',
                    isLooping: true,
                    zoom: 1.3,
                  ),
                ),
              ),

              // Top visual drag handle
              Positioned(
                top: 16,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Floating Glassmorphic Weight Pill (Overlapping)
        Positioned(
          right: -15,
          top: cardHeight * 0.3,
          child: _buildGlassyWeightPill(),
        ),
      ],
    );
  }

  Widget _buildGlassyWeightPill() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1B2336).withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF3F4C6B), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentBlueLite.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _weightValue.toInt().toString(),
                style: const TextStyle(
                  color: Color(0xFF81D4FA),
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'kg',
                style: TextStyle(
                  color: const Color(0xFF81D4FA).withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderSection() {
    return Column(
      children: [
        // Labels Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'UNCLEAR',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
            Text(
              'CLEAR',
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Custom Slider
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 6.0,
            activeTrackColor: AppColors.accentBlueLite,
            inactiveTrackColor: Colors.white.withOpacity(0.08),
            thumbColor: Colors.white,
            overlayColor: AppColors.accentBlueLite.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12.0,
              elevation: 4.0,
            ),
          ),
          child: Slider(
            value: _weightValue,
            min: 0,
            max: 100,
            onChanged: (newValue) {
              setState(() {
                _weightValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
