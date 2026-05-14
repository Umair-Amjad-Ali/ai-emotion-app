import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart'; // For Haptic Feedback
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'ThoughtDiffusionScreen.dart';

class EmergencyBreathingResetScreen extends StatefulWidget {
  const EmergencyBreathingResetScreen({super.key});

  @override
  State<EmergencyBreathingResetScreen> createState() => _EmergencyBreathingResetScreenState();
}

class _EmergencyBreathingResetScreenState extends State<EmergencyBreathingResetScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;
  int _currentIndex = 0;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    // Setting a duration for a full inhale cycle (e.g., 5 seconds)
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  void _onLongPressStart(LongPressStartDetails details) {
    setState(() => _isHolding = true);
    _breathingController.forward();
    HapticFeedback.mediumImpact();
  }

  void _onLongPressEnd(LongPressEndDetails details) {
    setState(() => _isHolding = false);
    _breathingController.reverse(); // Smoothly reset if let go
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff111F45), Color(0xff070B16)],
              ),
            ),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                const AppHeader(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          "Focus on the center. Let each pulse guide\nyour breath back to a state of calm.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),

                        // --- RADAR BREATHING WIDGET (PRESS & HOLD) ---
                        GestureDetector(
                          onLongPressStart: _onLongPressStart,
                          onLongPressEnd: _onLongPressEnd,
                          child: AnimatedBuilder(
                            animation: _breathingController,
                            builder: (context, child) {
                              return Container(
                                width: screenWidth * 0.88,
                                height: screenWidth * 0.88,
                                decoration: BoxDecoration(
                                  color: const Color(0xff1A1F2E).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(48),
                                  border: Border.all(color: Colors.white.withOpacity(0.03)),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // The Radar Custom Painter
                                    CustomPaint(
                                      size: Size(screenWidth * 0.75, screenWidth * 0.75),
                                      painter: RadarPainter(
                                        progress: _breathingController.value,
                                        isHolding: _isHolding,
                                      ),
                                    ),
                                    // Center Text
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "BREATHE",
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.3),
                                            fontSize: 11,
                                            letterSpacing: 3,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          _isHolding ? "Inhale" : "Hold to start",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),

                        const Spacer(),

                        // --- CONTINUE BUTTON ---
                        PrimaryButton(text: "CONTINUE", onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ThoughtDiffusionScreen()));
                        }),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. BOTTOM NAV
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              selectedIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}

class RadarPainter extends CustomPainter {
  final double progress;
  final bool isHolding;
  RadarPainter({required this.progress, required this.isHolding});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // 1. Draw concentric circles (Grid)
    canvas.drawCircle(center, maxRadius, linePaint);
    canvas.drawCircle(center, maxRadius * 0.75, linePaint);
    canvas.drawCircle(center, maxRadius * 0.5, linePaint);
    canvas.drawCircle(center, maxRadius * 0.25, linePaint);

    // 2. Draw radial lines (8 directions)
    for (int i = 0; i < 8; i++) {
      double angle = (i * 45) * math.pi / 180;
      canvas.drawLine(
        center,
        Offset(center.dx + maxRadius * math.cos(angle), center.dy + maxRadius * math.sin(angle)),
        linePaint,
      );
    }

    // 3. Draw the pulsing orange indicator dot
    // The dot moves from the innermost circle to the outermost as you hold
    final dotPaint = Paint()
      ..color = const Color(0xffFF8A65)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, isHolding ? 6 : 2);

    // Animation logic: moves vertically up from center based on progress
    double currentRadius = (maxRadius * 0.25) + (progress * (maxRadius * 0.75));
    double dotY = center.dy - currentRadius;

    // Draw Glow
    canvas.drawCircle(
      Offset(center.dx, dotY),
      8 + (progress * 4),
      Paint()..color = const Color(0xffFF8A65).withOpacity(0.2 * progress),
    );

    // Draw Main Dot
    canvas.drawCircle(Offset(center.dx, dotY), 4, dotPaint);
  }

  @override
  bool shouldRepaint(covariant RadarPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isHolding != isHolding;
}