import 'package:ai_emotion_app/widgets/gentle_reminder_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/wave_intensity_dial.dart';

class WaveIntensityScreen extends StatefulWidget {
  const WaveIntensityScreen({super.key});

  @override
  State<WaveIntensityScreen> createState() => _WaveIntensityScreenState();
}

class _WaveIntensityScreenState extends State<WaveIntensityScreen> {
  double _currentIntensity = 7.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;

    // Helper
    Widget buildTickLabel(int threshold, String text) {
      bool isActive = false;
      if (threshold == 0 && _currentIntensity <= 3) isActive = true;
      if (threshold == 5 && _currentIntensity > 3 && _currentIntensity <= 8) {
        isActive = true;
      }
      if (threshold == 10 && _currentIntensity > 8) isActive = true;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
              fontSize: isActive ? 14 : 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              letterSpacing: 1.0,
              shadows: isActive
                  ? [
                      Shadow(
                        color: Colors.white.withOpacity(0.5),
                        blurRadius: 10,
                      ),
                    ]
                  : null,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          // The vertical line (Tick mark) - Start, Mid, End
          Container(
            width: isActive ? 2.5 : 2.0,
            height: isActive ? screenHeight * 0.02 : screenHeight * 0.01,
            decoration: BoxDecoration(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.6),
                        blurRadius: 6,
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
                        label: 'Interruption',
                        title: 'How strong is the\nwave?',
                        subtitle:
                            'Focus on the physical sensation. Where\ndoes it sit in your body right now?',
                      ),

                      // --- Main Interactive Card ---
                      Container(
                        padding: const EdgeInsets.only(
                          top: 40,
                          bottom: 24,
                          left: 24,
                          right: 24,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0x73262A32),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            WaveIntensityDial(intensity: _currentIntensity),

                            SizedBox(height: screenHeight * 0.03),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  buildTickLabel(0, 'MILD'),
                                  buildTickLabel(5, 'Strong'),
                                  buildTickLabel(10, 'OVERWHELMING'),
                                ],
                              ),
                            ),

                            const SizedBox(height: 8),

                            // 3. Custom Slider with glowing thumb
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 8.0,
                                activeTrackColor: const Color(0xFF8B9FB8),
                                inactiveTrackColor: Colors.black.withOpacity(
                                  0.3,
                                ),
                                overlayColor: Colors.white.withOpacity(0.1),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 20.0,
                                ),
                                thumbShape: const _GlowingThumbShape(
                                  thumbRadius: 10.0,
                                  borderWidth: 5.0,
                                  borderColor: Color(0xFF131722),
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
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      const CustomReminderCard(
                        title: 'Gentle Reminder',
                        icon: Icons.psychology,
                        description:
                            '"Urges are like waves. They peak, break, and eventually recede. You don\'t have to control it—just observe it."',
                      ),

                      const SizedBox(height: 32),

                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

                      SizedBox(height: screenHeight * 0.11),
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

class _GlowingThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double borderWidth;
  final Color borderColor;

  const _GlowingThumbShape({
    required this.thumbRadius,
    required this.borderWidth,
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

    final glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawCircle(center, thumbRadius + 8, glowPaint);

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius + borderWidth, borderPaint);

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, fillPaint);
  }
}
