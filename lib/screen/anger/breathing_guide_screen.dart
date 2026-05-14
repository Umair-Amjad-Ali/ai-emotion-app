import 'dart:ui';
import 'package:ai_emotion_app/screen/anger/response_choice_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class BreathingGuideScreen extends StatefulWidget {
  const BreathingGuideScreen({super.key});

  @override
  State<BreathingGuideScreen> createState() => _BreathingGuideScreenState();
}

class _BreathingGuideScreenState extends State<BreathingGuideScreen>
    with TickerProviderStateMixin {
  late AnimationController _breatheController;
  late Animation<double> _scaleAnimation;

  late AnimationController _rippleController;

  bool _isInhaling = true;
  final int _phaseDurationSeconds = 5;

  @override
  void initState() {
    super.initState();

    // 1. Breathing Controller (Inhale/Exhale)
    _breatheController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _phaseDurationSeconds),
    );

    _scaleAnimation = Tween<double>(begin: 0.75, end: 1.05).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOutSine),
    );

    _breatheController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        setState(() => _isInhaling = true);
      } else if (status == AnimationStatus.reverse) {
        setState(() => _isInhaling = false);
      }
    });

    _breatheController.repeat(reverse: true);

    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _breatheController.dispose();
    _rippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final double innerCircleBaseSize = screenWidth * 0.7;
    final double maxRippleSize = screenWidth;

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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      // --- Headers ---
                      Text(
                        'Breathe with the circle',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Inhale for 5 seconds. Exhale for 5 seconds.\nFollow the circle and stay with the\ninstruction.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Animated Breathing Area ---
                      SizedBox(
                        width: maxRippleSize,
                        height: maxRippleSize,
                        child: AnimatedBuilder(
                          animation: Listenable.merge([
                            _breatheController,
                            _rippleController,
                          ]),
                          builder: (context, child) {
                            int secondsLeft;
                            if (_isInhaling) {
                              secondsLeft =
                                  _phaseDurationSeconds -
                                  (_breatheController.value *
                                          (_phaseDurationSeconds - 0.01))
                                      .floor();
                            } else {
                              secondsLeft =
                                  (_breatheController.value *
                                          (_phaseDurationSeconds - 0.01))
                                      .floor() +
                                  1;
                            }

                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                // 1. Expanding Fading Ripples
                                CustomPaint(
                                  size: Size(maxRippleSize, maxRippleSize),
                                  painter: BreathingRipplePainter(
                                    animationValue: _rippleController.value,
                                    baseRadius:
                                        (innerCircleBaseSize / 2) *
                                        _scaleAnimation.value,
                                    color: AppColors.accentBlueLite,
                                  ),
                                ),

                                // 2. Animated Expanding/Contracting 3D Sphere
                                Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: SizedBox(
                                    width: innerCircleBaseSize,
                                    height: innerCircleBaseSize,
                                    child: ClipOval(
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 12,
                                          sigmaY: 12,
                                        ),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            // A. Deep base background color
                                            Container(
                                              color: AppColors.cardLikePillBg
                                                  .withOpacity(0.1),
                                            ),

                                            // B. Top-Left 3D Highlight
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: RadialGradient(
                                                  center: const Alignment(
                                                    -0.3,
                                                    -0.4,
                                                  ),
                                                  radius: 0.85,
                                                  colors: [
                                                    AppColors.textPrimary
                                                        .withOpacity(0.15),
                                                    AppColors.cardLikePillBg
                                                        .withOpacity(0.1),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // C. BOTTOM BRIGHT GLOW (Matches your screenshot)
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: RadialGradient(
                                                  center:
                                                      Alignment.bottomCenter,
                                                  radius: 0.65,
                                                  colors: [
                                                    AppColors.accentBlueLite
                                                        .withOpacity(0.65),
                                                    AppColors.cardLikePillBg
                                                        .withOpacity(0.1),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // D. Clean Single Border (Drawn on top)
                                            Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColors.textPrimary
                                                      .withOpacity(0.15),
                                                  width: 1.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // 3. Static Text Overlay
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'PHASE',
                                      style: TextStyle(
                                        color: AppColors.accentBlueLite
                                            .withOpacity(0.8),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.5,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      _isInhaling ? 'Inhale' : 'Exhale',
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.013),
                                    Text(
                                      secondsLeft.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        color: AppColors.textPrimary,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w300,
                                        height: 1.0,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Text(
                                      'SECONDS',
                                      style: TextStyle(
                                        color: AppColors.textPrimary
                                            .withOpacity(0.4),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResponseChoiceScreen(),
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
      // bottomNavigationBar: const CustomBottomNavBar(),
      // extendBody: true,
    );
  }
}

// --- Custom Painter for Expanding Ripples ---
class BreathingRipplePainter extends CustomPainter {
  final double animationValue;
  final double baseRadius;
  final Color color;

  BreathingRipplePainter({
    required this.animationValue,
    required this.baseRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final maxRadius = size.width / 2;

    for (int i = 0; i < 3; i++) {
      double progress = (animationValue + (i * 0.33)) % 1.0;

      double radius = baseRadius + ((maxRadius - baseRadius) * progress);
      double opacity = (1.0 - progress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = color.withOpacity(opacity * 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant BreathingRipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.baseRadius != baseRadius;
  }
}
