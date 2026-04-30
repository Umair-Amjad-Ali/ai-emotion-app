import 'dart:ui';
import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class UrgeIntensityScreen extends StatefulWidget {
  const UrgeIntensityScreen({super.key});

  @override
  State<UrgeIntensityScreen> createState() => _UrgeIntensityScreenState();
}

class _UrgeIntensityScreenState extends State<UrgeIntensityScreen> {
  double _currentIntensity = 7.5;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        label: 'Interruption',
                        title: 'Urge Intensity',
                        subtitle: 'How strong is the urge?',
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 40,
                              horizontal: 24,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(32),

                              border: Border.all(
                                color: AppColors.cardBackgroundColor
                                    .withOpacity(0.3),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.glassCardInset.withOpacity(
                                    0.05,
                                  ),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Huge Dynamic Number
                                Text(
                                  _currentIntensity.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 72,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),
                                Text(
                                  'INTENSITY LEVEL',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.5,
                                    ),
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.05),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildSliderLabel('MILD'),
                                      _buildSliderLabel('STRONG'),
                                      _buildSliderLabel('OVERWHELMING'),
                                    ],
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.015),

                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 12.0,
                                    activeTrackColor:
                                        AppColors.cardBackgroundColor,
                                    inactiveTrackColor: Colors.black
                                        .withOpacity(0.6),
                                    overlayColor: AppColors.cardBackgroundColor
                                        .withOpacity(0.15),
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 8.0,
                                    ),
                                    thumbShape: _GlowingThumbShape(
                                      thumbRadius: 12.0,
                                      glowColor: AppColors.cardBackgroundColor,
                                      fillColor: AppColors.cardBackgroundColor,
                                      borderColor: AppColors.bgDark,
                                    ),
                                  ),
                                  child: Slider(
                                    value: _currentIntensity,
                                    min: 0.0,
                                    max: 10.0,
                                    onChanged: (value) {
                                      setState(() {
                                        _currentIntensity = value;
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(height: screenHeight * 0.015),

                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(11, (index) {
                                      return Container(
                                        width: 2,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: AppColors.textPrimary
                                              .withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

                      SizedBox(height: screenHeight * 0.02),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                        ),
                        child: Text(
                          'Rating your urge helps you build\nawareness and find the right strategy to\nnavigate it.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                            height: 1.6,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.1),
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

  Widget _buildSliderLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.0,
      ),
    );
  }
}

class _GlowingThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final Color glowColor;
  final Color fillColor;
  final Color borderColor;

  const _GlowingThumbShape({
    required this.thumbRadius,
    required this.glowColor,
    required this.fillColor,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint glowPaint = Paint()
      ..color = glowColor.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0);
    canvas.drawCircle(center, thumbRadius, glowPaint);

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, borderPaint);

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius - 4, fillPaint);
  }
}
