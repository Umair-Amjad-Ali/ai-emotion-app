import 'dart:math' as math;
import 'package:ai_emotion_app/screen/blindforgiveness/reality_clarification_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class EmotionalWeightScreen extends StatefulWidget {
  const EmotionalWeightScreen({super.key});

  @override
  State<EmotionalWeightScreen> createState() => _EmotionalWeightScreenState();
}

class _EmotionalWeightScreenState extends State<EmotionalWeightScreen> {
  double _intensity = 0.0;

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
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.03),

                      // --- Main Card ---
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.06,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.01),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'How heavy is it right\nnow?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              'The heavier the slider, the more charged\nthe stone becomes.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.6),
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.05),

                            SizedBox(
                              width: 200,
                              height: 200,
                              child: CustomPaint(
                                painter: WeightOrbPainter(
                                  intensity: _intensity,
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.05),

                            // --- Weight Intensity Row ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'WEIGHT INTENSITY',
                                      style: TextStyle(
                                        color: AppColors.textPrimary
                                            .withOpacity(0.5),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          _intensity.toInt().toString(),
                                          style: const TextStyle(
                                            color: AppColors.textPrimary,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          '/10',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.balance_rounded,
                                  color: AppColors.accentBlueLite,
                                  size: 32,
                                ),
                              ],
                            ),

                            SizedBox(height: screenHeight * 0.02),

                            // --- Custom Slider ---
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 4.0,
                                activeTrackColor: AppColors.accentBlueLite
                                    .withOpacity(0.5),
                                inactiveTrackColor: Colors.white.withOpacity(
                                  0.2,
                                ),
                                overlayShape: SliderComponentShape.noOverlay,
                                thumbShape: _GlowingCyanThumbShape(
                                  thumbRadius: 12.0,
                                  glowColor: AppColors.accentBlueLite
                                      .withOpacity(0.8),
                                ),
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

                            SizedBox(height: screenHeight * 0.015),

                            // --- Labels ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'FEATHER',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  'ANCHOR',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RealityClarificationScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }
}

// --- Custom Painter for the 3D Glowing Stone ---
class WeightOrbPainter extends CustomPainter {
  final double intensity;

  WeightOrbPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width * 0.35;

    final dynamicRadius = baseRadius + (intensity * 1.5);
    final glowOpacity = 0.3 + (intensity * 0.05);

    final math.Random rand = math.Random(42);
    final particlePaint = Paint();

    for (int i = 0; i < 40; i++) {
      final angle = rand.nextDouble() * 2 * math.pi;
      final dist = dynamicRadius + rand.nextDouble() * 60;
      final dx = center.dx + dist * math.cos(angle);
      final dy = center.dy + dist * math.sin(angle);

      final isBlue = rand.nextBool();
      particlePaint.color =
          (isBlue ? AppColors.accentBlueLite : AppColors.peachAccent)
              .withOpacity(rand.nextDouble() * glowOpacity);

      canvas.drawCircle(Offset(dx, dy), rand.nextDouble() * 2.5, particlePaint);
    }

    // 2. Outer atmospheric glow
    final outerGlowPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.accentBlueLite.withOpacity(glowOpacity * 0.5),
              AppColors.peachAccent.withOpacity(glowOpacity * 0.3),
              Colors.transparent,
            ],
            stops: const [0.0, 0.4, 1.0],
          ).createShader(
            Rect.fromCircle(center: center, radius: dynamicRadius * 2),
          );
    canvas.drawCircle(center, dynamicRadius * 1.8, outerGlowPaint);

    // 3. The Solid Glass Orb Base
    final orbBasePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.2),
        radius: 1.0,
        colors: [
          Colors.white.withOpacity(0.9),
          const Color(0xFF63B8FF).withOpacity(0.9),
          const Color(0xFFFF8B7B).withOpacity(0.8),
          const Color(0xFF131A2A),
        ],
        stops: const [0.0, 0.4, 0.8, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: dynamicRadius));
    canvas.drawCircle(center, dynamicRadius, orbBasePaint);

    // 4. Inner Glass Edge Highlight (Top left reflection)
    final highlightPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.4, -0.5),
        radius: 0.6,
        colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.0)],
      ).createShader(Rect.fromCircle(center: center, radius: dynamicRadius));
    canvas.drawCircle(center, dynamicRadius, highlightPaint);

    // 5. Outer Glass Ring (Crisp border)
    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, dynamicRadius, borderPaint);
  }

  @override
  bool shouldRepaint(WeightOrbPainter oldDelegate) =>
      oldDelegate.intensity != intensity;
}

// --- Custom Slider Thumb matching the design ---
class _GlowingCyanThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final Color glowColor;

  const _GlowingCyanThumbShape({
    required this.thumbRadius,
    required this.glowColor,
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

    // Outer Glow
    final Paint glowPaint = Paint()
      ..color = glowColor.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);
    canvas.drawCircle(center, thumbRadius + 6, glowPaint);

    // White Outer Ring
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, borderPaint);

    // Cyan Inner Core
    final Paint fillPaint = Paint()
      ..color = glowColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius - 3.5, fillPaint);
  }
}
