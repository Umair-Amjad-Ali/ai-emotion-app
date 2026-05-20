import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/screen/mind_clutter/thought_loop.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ThoughtWeightScreen extends StatefulWidget {
  const ThoughtWeightScreen({super.key});

  @override
  State<ThoughtWeightScreen> createState() => _ThoughtWeightScreenState();
}

class _ThoughtWeightScreenState extends State<ThoughtWeightScreen> {
  // Ensure initial value lies within Slider's min..max (1..10)
  double _weightValue = 1.0;

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
                      const ScreenHeader(
                        title: 'How heavy does\nthis thought feel?',
                        subtitle: 'Adjust the slider to feel its weight',
                      ),

                      SizedBox(height: screenHeight * 0.01),
                      _buildAnimatedWeightDisplay(screenWidth, screenHeight),

                      SizedBox(height: screenHeight * 0.02),
                      // Custom Slider
                      _buildWeightSlider(),

                      SizedBox(height: screenHeight * 0.015),
                      // Slider Labels
                      _buildSliderLabels(),

                      SizedBox(height: screenHeight * 0.04),
                      _buildWeightStatusCard(),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ThoughtLoopScreen(),
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

  Widget _buildAnimatedWeightDisplay(double screenWidth, double screenHeight) {
    // Normalizing weight value for animation factors
    final double normalizedWeight = (_weightValue - 1) / 9;
    final double scaleFactor =
        1.0 + (normalizedWeight * 0.15); // Scales from 1.0 to 1.15
    final double glowIntensity =
        0.3 + (normalizedWeight * 0.5); // Glow intensity

    // 3. Make base sizes responsive to screen width
    final double baseSphereSize =
        screenWidth * 0.5; // Replaces fixed 200 width/height

    return SizedBox(
      height: screenHeight * 0.32,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Concentric Rings
          _buildConcentricRings(normalizedWeight, screenWidth),

          // The Glowing Sphere
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: scaleFactor),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: baseSphereSize, // Responsive
                  height: baseSphereSize, // Responsive
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      center: Alignment(-0.2, -0.3),
                      radius: 0.8,
                      colors: [
                        AppColors.accentBlueLite,
                        AppColors.midBlue,
                        AppColors.deeperBlue,
                        Color(0xFF0C1222),
                      ],
                      stops: [0.0, 0.4, 0.8, 1.0],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentBlueLite.withOpacity(
                          glowIntensity * 0.4,
                        ),
                        // Scale blur/spread relative to screen size slightly
                        blurRadius:
                            (screenWidth * 0.1) + (normalizedWeight * 20),
                        spreadRadius:
                            (screenWidth * 0.015) + (normalizedWeight * 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(10, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CURRENT\nSUBJECT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'REGRET',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Score Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        child: Text(
                          '${_weightValue.toInt()} / 10',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConcentricRings(double normalizedWeight, double screenWidth) {
    // 4. Base ring sizes dynamically off screen width instead of fixed numbers (240+)
    final double baseRingSize = screenWidth * 0.6; // Replaces fixed 240
    final double ringIncrement = screenWidth * 0.1; // Replaces fixed 40

    return Stack(
      alignment: Alignment.center,
      children: List.generate(3, (index) {
        final double ringSize = baseRingSize + (index * ringIncrement);
        return Container(
          width: ringSize,
          height: ringSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.textPrimary.withOpacity(
                0.03 + (normalizedWeight * 0.05),
              ),
              width: 1.0,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWeightSlider() {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 4,
        activeTrackColor: AppColors.textPrimary.withOpacity(0.2),
        inactiveTrackColor: AppColors.textPrimary.withOpacity(0.1),
        thumbColor: AppColors.accentBlueLite,
        overlayColor: AppColors.accentBlueLite.withOpacity(0.2),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
      ),
      child: Slider(
        value: _weightValue,
        min: 1,
        max: 10,
        divisions: 9,
        onChanged: (value) {
          setState(() {
            _weightValue = value;
          });
        },
      ),
    );
  }

  Widget _buildSliderLabels() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'WEIGHTLESS',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Fleeting like mist',
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'CRUSHING',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Immovable and dense',
              style: TextStyle(
                color: Colors.white.withOpacity(0.3),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightStatusCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Center(
        child: RichText(
          text: TextSpan(
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: [
              const TextSpan(text: 'Thought weight: '),
              TextSpan(
                text: '${_weightValue.toInt()} / 10',
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
