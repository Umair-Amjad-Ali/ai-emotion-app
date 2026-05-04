import 'dart:math' as math;
import 'dart:ui';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/gentle_reminder_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class WaveScreen extends StatefulWidget {
  const WaveScreen({super.key});

  @override
  State<WaveScreen> createState() => _WaveScreenState();
}

class _WaveScreenState extends State<WaveScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();

    // Pulse animation (breathing effect)
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Wave animation (horizontal movement)
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        label: 'Interruption',
                        title: 'Ride The Urge\nWave',
                        subtitle: 'Urges rise and fall like waves.',
                      ),

                      const Spacer(),

                      // --- The Animated Circle ---
                      ScaleTransition(
                        scale: Tween<double>(begin: 1.0, end: 0.6).animate(
                          CurvedAnimation(
                            parent: _pulseController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: Size(screenWidth * 0.7, screenWidth * 0.7),
                              painter: _GlassShadowPainter(),
                            ),
                            ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 24,
                                  sigmaY: 24,
                                ),
                                child: Container(
                                  width: screenWidth * 0.7,
                                  height: screenWidth * 0.7,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardBackgroundColor
                                        .withOpacity(0.25), // #FFFFFF26
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.cardBackgroundColor
                                          .withOpacity(0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned.fill(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0x1AFFFFFF),
                                                Colors.transparent,
                                                Colors.transparent,
                                              ],
                                              stops: [0.0, 0.05, 1.0],
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Animated Wave at the bottom
                                      Positioned.fill(
                                        child: ClipOval(
                                          child: AnimatedBuilder(
                                            animation: _waveController,
                                            builder: (context, child) {
                                              return CustomPaint(
                                                painter: WavePainter(
                                                  progress:
                                                      _waveController.value,
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),

                                      // Badge: WAVE 3 ACTIVE
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color: Colors.white24,
                                          ),
                                          color: AppColors.textPrimary
                                              .withOpacity(0.05),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.water_drop_outlined,
                                              color: AppColors.textPrimary,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'WAVE 3 ACTIVE',
                                              style: TextStyle(
                                                color: AppColors.textPrimary
                                                    .withOpacity(0.8),
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      PrimaryButton(text: 'STILL HERE', onPressed: () {}),

                      SizedBox(height: screenHeight * 0.035),

                      CustomReminderCard(
                        title: 'GENTLE REMINDER',
                        icon: Icons.waves,
                        description:
                            'You don\'t have to act on this sensation. It will pass in its own time.',
                      ),

                      SizedBox(height: screenHeight * 0.035),
                    ],
                  ),
                ),
              ),

              const CustomBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final Color color;

  WavePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    // Starting height of the wave (near the bottom)
    final double waveHeight = size.height * 0.75;
    final double amplitude = 15.0;

    path.moveTo(0, waveHeight);

    for (double i = 0; i <= size.width; i++) {
      // Create a sine wave that moves with progress
      path.lineTo(
        i,
        waveHeight +
            math.sin(
                  (i / size.width * 2 * math.pi) + (progress * 2 * math.pi),
                ) *
                amplitude,
      );
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _GlassShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // The exact bounds of the circle
    final ovalPath = Path()
      ..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    // A huge box surrounding everything
    final boundsPath = Path()
      ..addRect(Rect.fromLTRB(-200, -200, size.width + 200, size.height + 200));

    // Hollow out the center so NO SHADOW is painted inside the circle!
    final clipPath = Path.combine(
      PathOperation.difference,
      boundsPath,
      ovalPath,
    );

    canvas.save();
    canvas.clipPath(clipPath);

    // CSS: box-shadow: 0px 20px 60px -10px #000000B2;
    // Spread: -10 means the shadow shape is smaller by 10px on all sides.
    // Offset: 0, 20
    final shadowRect = Rect.fromLTWH(
      10,
      10 + 20,
      size.width - 20,
      size.height - 20,
    );
    final shadowPath = Path()..addOval(shadowRect);

    final shadowPaint = Paint()
      ..color = Colors.black
          .withOpacity(0.7) // #000000B2
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        30,
      ); // 30 sigma is roughly 60 CSS blur

    canvas.drawPath(shadowPath, shadowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
