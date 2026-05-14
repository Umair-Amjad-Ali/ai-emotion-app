import 'package:ai_emotion_app/screen/anger/anger_summary_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class AngerRecheckScreen extends StatefulWidget {
  const AngerRecheckScreen({super.key});

  @override
  State<AngerRecheckScreen> createState() => _AngerRecheckScreenState();
}

class _AngerRecheckScreenState extends State<AngerRecheckScreen> {
  double _intensity = 3.0;

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
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'THE NOT YOU',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      const Text(
                        'Anger Tamer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Main Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.04,
                          horizontal: screenWidth * 0.05,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColors.cardLikePillBg.withOpacity(0.3),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                'RE-CHECK INTENSITY',
                                style: TextStyle(
                                  color: AppColors.accentBlueLite.withOpacity(
                                    0.8,
                                  ),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.03),
                            const Text(
                              'Where is your anger\nnow?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Lower the storm as far as honestly\npossible. You are measuring change, not\nforcing perfection.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.5),
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.04),

                            // Dynamic Blue Orb
                            SizedBox(
                              width: 200,
                              height: 180,
                              child: Center(
                                child: CustomPaint(
                                  size: const Size(200, 180),
                                  painter: BlueStormOrbPainter(
                                    intensity: _intensity,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // Intensity Number positioned AFTER the circle
                            Text(
                              _intensity.toInt().toString(),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // Slider
                            SliderTheme(
                              data: SliderThemeData(
                                trackHeight: 4,
                                activeTrackColor: AppColors.textPrimary
                                    .withOpacity(0.2),
                                inactiveTrackColor: AppColors.textPrimary
                                    .withOpacity(0.1),
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 10,
                                  elevation: 5,
                                ),
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: _intensity,
                                min: 0,
                                max: 10,
                                activeColor: AppColors.accentBlueLite,
                                onChanged: (val) {
                                  setState(() => _intensity = val);
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'LOWER IS CALMER',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.3,
                                    ),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  'INTENSE',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.3,
                                    ),
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AngerSummaryScreen(),
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
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      extendBody: true,
    );
  }
}

class BlueStormOrbPainter extends CustomPainter {
  final double intensity;
  BlueStormOrbPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Dynamic radius based on intensity
    final baseRadius = size.width / 3.2;
    final dynamicRadius = baseRadius + (intensity * 3.0);

    // 1. Draw the small atmospheric dots (stars)
    final dotPaint = Paint()..color = AppColors.textPrimary.withOpacity(0.5);

    // Top-left dot
    canvas.drawCircle(
      Offset(center.dx - dynamicRadius * 0.7, center.dy - dynamicRadius * 0.9),
      2.0,
      dotPaint,
    );
    // Far-left tiny dot
    canvas.drawCircle(
      Offset(center.dx - dynamicRadius * 1.3, center.dy + dynamicRadius * 0.2),
      1.0,
      dotPaint,
    );

    // 2. Draw a subtle, controlled outer glow (Not too blurry)
    final glowPaint = Paint()
      ..color = AppColors.textPrimary.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
    canvas.drawCircle(center, dynamicRadius + 2, glowPaint);

    // 3. Draw the crisp, hard-edged main orb
    final orbPaint = Paint()
      ..shader = RadialGradient(
        colors: [AppColors.accentBlueLite, AppColors.accentBlue],
        stops: [0.1, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: dynamicRadius));
    canvas.drawCircle(center, dynamicRadius, orbPaint);
  }

  @override
  bool shouldRepaint(BlueStormOrbPainter old) => old.intensity != intensity;
}
