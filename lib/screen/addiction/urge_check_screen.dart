import 'package:ai_emotion_app/widgets/gentle_reminder_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class UrgeCheckScreen extends StatefulWidget {
  const UrgeCheckScreen({super.key});

  @override
  State<UrgeCheckScreen> createState() => _UrgeCheckScreenState();
}

class _UrgeCheckScreenState extends State<UrgeCheckScreen> {
  double _currentIntensity = 4.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    Widget buildStatusDot(String text, bool isActive) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
              fontSize: 11,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          // The Dot
          Container(
            width: screenWidth * 0.015,
            height: screenHeight * 0.01,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? AppColors.cardBackgroundColor
                  : AppColors.textPrimary.withOpacity(0.1),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: AppColors.cardBackgroundColor.withOpacity(0.8),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
          ),
        ],
      );
    }

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
                    children: [
                      const ScreenHeader(
                        label: 'Interuption',
                        title: 'Urge Check Again',
                        subtitle: 'Where is the urge now?',
                      ),

                      // --- Main
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.03,
                          horizontal: screenWidth * 0.06,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.08),
                            width: 1.5,
                          ),

                          gradient: RadialGradient(
                            center: Alignment.topCenter,
                            radius: 1.5,
                            colors: [
                              AppColors.textPrimary.withOpacity(0.08),
                              const Color(0x73262A32),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: screenWidth * 0.2,
                              height: screenWidth * 0.2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    AppColors.textPrimary.withOpacity(0.15),
                                    Colors.transparent,
                                  ],
                                ),
                                border: Border.all(
                                  color: AppColors.textPrimary.withOpacity(0.3),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.2,
                                    ),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),

                                  BoxShadow(
                                    color: AppColors.cardBackgroundColor
                                        .withOpacity(0.12),
                                    blurRadius: 60,
                                    spreadRadius: 25,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.self_improvement_rounded,
                                color: AppColors.textPrimary,
                                size: 36,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.04),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'MINIMAL',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  _currentIntensity.toInt().toString().padLeft(
                                    2,
                                    '0',
                                  ),
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                    height: 1.0,
                                  ),
                                ),
                                Text(
                                  'INTENSE',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.4,
                                    ),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: screenHeight * 0.025),

                            // Custom Slider
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 6.0,
                                activeTrackColor: const Color(0xFF8B9FB8),
                                inactiveTrackColor: Colors.black.withOpacity(
                                  0.4,
                                ),
                                overlayColor: AppColors.textPrimary.withOpacity(
                                  0.1,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 5.0,
                                ),

                                thumbShape: const _RoundedSquareThumbShape(
                                  thumbSize: 22.0,
                                  borderRadius: 6.0,
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

                            SizedBox(height: screenHeight * 0.016),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildStatusDot(
                                  'Subsided',
                                  _currentIntensity <= 3,
                                ),
                                buildStatusDot(
                                  'Manageable',
                                  _currentIntensity > 3 &&
                                      _currentIntensity <= 7,
                                ),
                                buildStatusDot(
                                  'Critical',
                                  _currentIntensity > 7,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      const Text(
                        '"Urge is same still start again"',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      PrimaryButton(text: 'START AGAIN', onPressed: () {}),
                      SizedBox(height: screenHeight * 0.025),
                      PrimaryButton(text: 'NEXT', onPressed: () {}),

                      SizedBox(height: screenHeight * 0.035),

                      const CustomReminderCard(
                        title: 'Gentle Reminder',
                        icon: Icons.lightbulb_outline,
                        description:
                            '"Urges are like waves. They rise, peak, and inevitably subside. By simply noticing where it is now, you\'ve already weakened its hold on you."',
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
}

class _RoundedSquareThumbShape extends SliderComponentShape {
  final double thumbSize;
  final double borderRadius;

  const _RoundedSquareThumbShape({
    required this.thumbSize,
    required this.borderRadius,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbSize, thumbSize);
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

    // Draw the rounded square
    final RRect thumbRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: thumbSize, height: thumbSize),
      Radius.circular(borderRadius),
    );

    // Subtle drop shadow for depth
    final Paint shadowPaint = Paint()
      ..color = AppColors.textPrimary.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
    canvas.drawRRect(thumbRRect.shift(const Offset(0, 0)), shadowPaint);

    // White fill
    final Paint fillPaint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.fill;
    canvas.drawRRect(thumbRRect, fillPaint);
  }
}
