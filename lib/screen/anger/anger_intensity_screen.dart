import 'dart:math' as math;
import 'package:ai_emotion_app/screen/anger/anger_heat_map_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class AngerIntensityScreen extends StatefulWidget {
  const AngerIntensityScreen({super.key});

  @override
  State<AngerIntensityScreen> createState() => _AngerIntensityScreenState();
}

class _AngerIntensityScreenState extends State<AngerIntensityScreen> {
  double _intensity = 0.0;

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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      const Text(
                        'How intense is the\nanger right now?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      const Text(
                        'The storm responds to your intensity.Higher \n numbers create a stronger charge.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightDarkText,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.045,
                          horizontal: screenWidth * 0.035,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColors.cardLikePillBg.withOpacity(0.4),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    size: const Size(220, 220),
                                    painter: StormOrbPainter(
                                      intensity: _intensity,
                                    ),
                                  ),
                                  Text(
                                    _intensity.toInt().toString(),
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 60,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),

                            // 2. LINEAR GRADIENT SLIDER
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 8,
                                trackShape: GradientSliderTrackShape(),
                                thumbShape: const HollowGlowingThumbShape(),
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: _intensity,
                                min: 0,
                                max: 10,
                                onChanged: (val) {
                                  setState(() {
                                    _intensity = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),

                            // LABELS
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildLabel('SUBTLE', _intensity <= 3),
                                  _buildLabel(
                                    'MODERATE',
                                    _intensity > 3 && _intensity <= 7,
                                  ),
                                  _buildLabel('EXTREME', _intensity > 7),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 60),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AngerHeatMapScreen(),
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
      // bottomNavigationBar: const CustomBottomNavBar(),
      // extendBody: true,
    );
  }

  Widget _buildLabel(String text, bool active) {
    return Text(
      text,
      style: TextStyle(
        color: active ? const Color(0xFFFFB4A8) : AppColors.lightTextColor,
        fontSize: 11,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }
}

class StormOrbPainter extends CustomPainter {
  final double intensity;
  StormOrbPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Unified radius for the circle and the dots
    final orbRadius = size.width / 2.2;

    // 1. DYNAMIC OUTER SHADOW (Glow)
    final double dynamicBlur = 15.0 + (intensity * 4.5);
    final double dynamicSpread = 2.0 + (intensity * 1.3);
    final double shadowOpacity = 0.15 + (intensity * 0.035);

    final glowPaint = Paint()
      ..color = const Color(0xFFFFB4A8).withOpacity(shadowOpacity)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, dynamicBlur);
    canvas.drawCircle(center, orbRadius + dynamicSpread, glowPaint);

    // 2. STATIC RADIAL GRADIENT ORB (Base Colors)
    final orbPaint = Paint()
      ..shader = const RadialGradient(
        center: Alignment.center,
        radius: 0.8,
        colors: [
          Color.fromRGBO(255, 180, 168, 0.8),
          Color.fromRGBO(255, 110, 110, 0.4),
          Color.fromRGBO(255, 110, 110, 0.0),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: orbRadius));
    canvas.drawCircle(center, orbRadius, orbPaint);

    // 3. THICK, BLURRED INNER SHADOW (No Hard Border)
    canvas.save();
    canvas.clipPath(
      Path()..addOval(Rect.fromCircle(center: center, radius: orbRadius)),
    );

    final innerShadowPaint = Paint()
      ..color = AppColors.bgGlow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
    canvas.drawCircle(center, orbRadius, innerShadowPaint);
    canvas.restore();

    // 4. ROTATING DOTS
    final double baseAngle = (intensity / 10) * 2 * math.pi - (math.pi / 2);

    // Large Peach Dot
    final dot1Offset = Offset(
      center.dx + orbRadius * math.cos(baseAngle),
      center.dy + orbRadius * math.sin(baseAngle),
    );
    canvas.drawCircle(
      dot1Offset,
      6.0,
      Paint()..color = const Color(0xFFFFB4A8),
    );

    // Small White Dot
    final double oppositeAngle = baseAngle + math.pi;
    final dot2Offset = Offset(
      center.dx + orbRadius * math.cos(oppositeAngle),
      center.dy + orbRadius * math.sin(oppositeAngle),
    );
    canvas.drawCircle(dot2Offset, 3.0, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(StormOrbPainter old) => old.intensity != intensity;
}

// --- CUSTOM SLIDER TRACK FOR LINEAR GRADIENT ---
class GradientSliderTrackShape extends RoundedRectSliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 0,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
    );

    // Left side (Active Track)
    final Rect activeRect = Rect.fromLTRB(
      trackRect.left,
      trackRect.top,
      thumbCenter.dx,
      trackRect.bottom,
    );
    final activePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF7B3228), Color(0xFFFFB4A8)],
      ).createShader(trackRect);

    // Right side (Inactive Track)
    final Rect inactiveRect = Rect.fromLTRB(
      thumbCenter.dx,
      trackRect.top,
      trackRect.right,
      trackRect.bottom,
    );
    final inactivePaint = Paint()..color = const Color(0xFF2A2E3D);

    // Draw Tracks
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(inactiveRect, const Radius.circular(8)),
      inactivePaint,
    );
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(activeRect, const Radius.circular(8)),
      activePaint,
    );
  }
}

// --- EXACT CUSTOM HOLLOW THUMB SHAPE ---
class HollowGlowingThumbShape extends RoundSliderThumbShape {
  const HollowGlowingThumbShape() : super(enabledThumbRadius: 14);

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
    final canvas = context.canvas;
    final primaryColor = const Color(0xFFFFB4A8);

    // 1. Soft Outer Glow
    canvas.drawCircle(
      center,
      22,
      Paint()
        ..color = primaryColor.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );

    // 2. Dark Inner Background
    canvas.drawCircle(center, 14, Paint()..color = const Color(0xFF131722));

    // 3. Thick Outer Peach Ring
    canvas.drawCircle(
      center,
      14,
      Paint()
        ..color = primaryColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5,
    );

    // 4. Solid Center Peach Dot
    canvas.drawCircle(center, 5.5, Paint()..color = primaryColor);
  }
}
