import 'dart:ui';
import 'package:ai_emotion_app/screen/anger/rage_dump_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class HoldToPauseScreen extends StatefulWidget {
  const HoldToPauseScreen({super.key});

  @override
  State<HoldToPauseScreen> createState() => _HoldToPauseScreenState();
}

class _HoldToPauseScreenState extends State<HoldToPauseScreen>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _timerController;

  bool _isHolding = false;
  bool _completed = false;
  final double _maxDuration = 10.0;

  @override
  void initState() {
    super.initState();
    // Controls the expanding ripples
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Controls the 10 second progress
    _timerController =
        AnimationController(
          vsync: this,
          duration: Duration(seconds: _maxDuration.toInt()),
        )..addListener(() {
          setState(() {});
          if (_timerController.isCompleted && !_completed) {
            _onComplete();
          }
        });
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  void _onPressStart(TapDownDetails details) {
    if (_completed) return;
    setState(() {
      _isHolding = true;
    });
    _rippleController.repeat();
    _timerController.forward();
  }

  void _onPressEnd() {
    if (_completed) return;
    setState(() {
      _isHolding = false;
    });
    _rippleController.stop();
    _rippleController.reset();
    _timerController.reverse();
  }

  void _onComplete() {
    setState(() {
      _isHolding = false;
      _completed = true;
    });
    _rippleController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate current seconds based on animation value
    final currentSeconds = (_timerController.value * _maxDuration);
    // Format to 00.0
    final timeString = currentSeconds.toStringAsFixed(1).padLeft(4, '0');

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
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'INTENTIONAL SILENCE',
                        style: TextStyle(
                          color: AppColors.accentBlueLite.withOpacity(0.7),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Hold to pause',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 36,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                            height: 1.5,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Press and maintain your focus for ',
                            ),
                            TextSpan(
                              text: '10\nseconds',
                              style: TextStyle(
                                color: AppColors.accentBlueLite.withOpacity(
                                  0.9,
                                ),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const TextSpan(text: ' to reset your space.'),
                          ],
                        ),
                      ),

                      // --- Interactive Hold Button ---
                      GestureDetector(
                        onTapDown: _onPressStart,
                        onTapUp: (_) => _onPressEnd(),
                        onTapCancel: _onPressEnd,
                        child: SizedBox(
                          width: screenWidth,
                          height: screenWidth,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // 1. The Expanding Ripples (CustomPainter)
                              AnimatedBuilder(
                                animation: _rippleController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    size: Size(screenWidth, screenWidth),
                                    painter: RipplePainter(
                                      animationValue: _rippleController.value,
                                      isHolding: _isHolding,
                                      color: AppColors.lightPink,
                                    ),
                                  );
                                },
                              ),

                              // 2. Static Outer Peach Ring (Glow Removed)
                              Container(
                                width: screenWidth * 0.65,
                                height: screenWidth * 0.65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.lightPink,
                                    width: 4.0,
                                  ),
                                ),
                              ),

                              // 3. Inner Glass/Dark Circle
                              ClipOval(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    width: screenWidth * 0.61,
                                    height: screenWidth * 0.61,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.lightPink.withOpacity(
                                        0.08,
                                      ),
                                      border: Border.all(
                                        color: AppColors.textPrimary
                                            .withOpacity(0.05),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Spacer(flex: 3),
                                        // Fingerprint Icon
                                        AnimatedScale(
                                          scale: _isHolding ? 1.1 : 1.0,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          child: Icon(
                                            Icons.fingerprint_rounded,
                                            size: 54,
                                            color: _isHolding
                                                ? AppColors.lightPink
                                                : AppColors.lightPink
                                                      .withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          _completed
                                              ? 'COMPLETED'
                                              : 'HOLD TO PAUSE',
                                          style: TextStyle(
                                            color: _completed
                                                ? AppColors.successGreen
                                                : AppColors.textPrimary
                                                      .withOpacity(0.8),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 2.0,
                                          ),
                                        ),
                                        const Spacer(flex: 2),
                                        // Glowing Dot at bottom
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.lightPink,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.lightPink,
                                                blurRadius: 8,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.03),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // --- Timer Display ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            timeString,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.008),
                          Text(
                            's',
                            style: TextStyle(
                              color: AppColors.textPrimary.withOpacity(0.4),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      // --- Progress Dots ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final dotProgressLimit = (index + 1) / 5;
                          final isActive =
                              _timerController.value >= dotProgressLimit;

                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? AppColors.lightPink
                                  : AppColors.textPrimary.withOpacity(0.2),
                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: AppColors.lightPink,
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: screenHeight * 0.06),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                        ),
                        child: AnimatedOpacity(
                          opacity: _completed ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 600),
                          child: IgnorePointer(
                            ignoring: !_completed,
                            child: PrimaryButton(
                              text: 'CONTINUE',
                              onPressed: _completed
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              const RageDumpScreen(),
                                        ),
                                      );
                                    }
                                  : () {},
                            ),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        height: _completed ? screenHeight * 0.12 : 0.0,
                      ),
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
class RipplePainter extends CustomPainter {
  final double animationValue;
  final bool isHolding;
  final Color color;

  RipplePainter({
    required this.animationValue,
    required this.isHolding,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (!isHolding) return;

    final center = Offset(size.width / 2, size.height / 2);

    final baseRadius = size.width * 0.305;

    // Expands outwards toward the edge of the screen
    final maxRadius = size.width * 0.5;

    // Draw 3 concentric circles
    for (int i = 0; i < 3; i++) {
      double progress = (animationValue + (i * 0.33)) % 1.0;

      // Expand outwards
      double radius = baseRadius + ((maxRadius - baseRadius) * progress);

      // Fade out as it expands
      double opacity = 1.0 - progress;

      final paint = Paint()
        ..color = color.withOpacity(opacity * 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.isHolding != isHolding;
  }
}
