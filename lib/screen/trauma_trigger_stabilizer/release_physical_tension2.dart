import 'dart:math' as math;

import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/stabilize_the_nervous_system_refined_with_tracking.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ReleasePhysicalTension2Screen extends StatefulWidget {
  const ReleasePhysicalTension2Screen({super.key});

  @override
  State<ReleasePhysicalTension2Screen> createState() =>
      _ReleasePhysicalTension2ScreenState();
}

class _ReleasePhysicalTension2ScreenState
    extends State<ReleasePhysicalTension2Screen>
    with SingleTickerProviderStateMixin {
  double _stabilityValue = 5.0;

  late AnimationController _iconAnimController;

  @override
  void initState() {
    super.initState();
    _iconAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _iconAnimController.dispose();
    super.dispose();
  }

  /// Normalized progress 0.0 (slider=1) to 1.0 (slider=10)
  double get _progress => (_stabilityValue - 1) / 9;

  /// Icon color transitions from peach (overwhelmed) to blue (grounded)
  Color get _iconColor =>
      Color.lerp(AppColors.peachAccent, AppColors.accentBlueLite, _progress)!;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    SizedBox(height: screenHeight * 0.025),
                    // Label
                    Center(
                      child: Text(
                        'CURRENT SESSION',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    // Title
                    const Text(
                      'Stability Check',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Gradient underline
                    Center(
                      child: Container(
                        width: 80,
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.peachAccent,
                              AppColors.accentBlueLite,
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    _buildStabilityCard(),
                    const SizedBox(height: 28),
                    const SizedBox(height: 28),
                    PrimaryButton(
                      text: 'FINISH',
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const StabilizeTheNervousSystemRefinedWithTracking(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 120),
                  ],
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

  Widget _buildStabilityCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.glassCardBorder, width: 1.0),
      ),
      child: Column(
        children: [
          // Question
          const Text(
            'How stable do you feel\nnow?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 12),
          // Instruction
          Text(
            'Move the slider to reflect your\ncurrent state.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),
          // Custom gradient slider
          _buildGradientSlider(),
          const SizedBox(height: 12),
          // Labels row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildScaleLabel('1', 'OVERWHELMED'),
              _buildScaleLabel('10', 'GROUNDED'),
            ],
          ),
          const SizedBox(height: 30),
          // Animated breathing icon
          _buildAnimatedIcon(),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    // Scale pulses stronger as stability increases
    final double pulseIntensity = 0.05 + (_progress * 0.12);
    // Glow radius grows with stability
    final double glowRadius = 4 + (_progress * 18);

    return AnimatedBuilder(
      animation: _iconAnimController,
      builder: (context, child) {
        // Gentle pulse: scale oscillates with sin wave
        final double pulse =
            1.0 + math.sin(_iconAnimController.value * 2 * math.pi) * pulseIntensity;
        // Slow rotation proportional to stability
        final double rotation =
            _iconAnimController.value * 2 * math.pi * (_progress * 0.5);

        return Transform.scale(
          scale: pulse,
          child: Transform.rotate(
            angle: rotation,
            child: Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _iconColor.withOpacity(0.08),
                border: Border.all(
                  color: _iconColor.withOpacity(0.25),
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _iconColor.withOpacity(0.2 * _progress),
                    blurRadius: glowRadius,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                Icons.air_rounded,
                color: _iconColor,
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGradientSlider() {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 8,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
        thumbColor: AppColors.accentBlueLite,
        overlayColor: AppColors.accentBlueLite.withOpacity(0.15),
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        trackShape: const RoundedRectSliderTrackShape(),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Gradient track background
          Container(
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: [
                  AppColors.peachAccent,
                  Color(0xFFD4A8B8),
                  AppColors.accentBlueLite,
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Slider
          Slider(
            value: _stabilityValue,
            min: 1,
            max: 10,
            divisions: 9,
            onChanged: (value) {
              setState(() {
                _stabilityValue = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildScaleLabel(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary.withOpacity(0.5),
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
