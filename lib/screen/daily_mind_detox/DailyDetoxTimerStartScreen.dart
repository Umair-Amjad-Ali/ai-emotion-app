import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class DailyDetoxTimerStartScreen extends StatefulWidget {
  final int initialMinutes;

  const DailyDetoxTimerStartScreen({super.key, this.initialMinutes = 30});

  @override
  State<DailyDetoxTimerStartScreen> createState() => _DailyDetoxTimerStartScreenState();
}

class _DailyDetoxTimerStartScreenState extends State<DailyDetoxTimerStartScreen> with TickerProviderStateMixin {
  late Timer _timer;
  late int _secondsRemaining;
  int _currentIndex = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.initialMinutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0 && !_isPaused) {
        setState(() {
          _secondsRemaining--;
        });
      } else if (_secondsRemaining == 0) {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    int mins = seconds ~/ 60;
    int secs = seconds % 60;
    return "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double progress = _secondsRemaining / (widget.initialMinutes * 60);

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND
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
                const SizedBox(height: 20),
                const Text(
                  "Mind Detox in\nProgress",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "SESSION ACTIVE",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(height: 30,),

                // --- ANIMATED TIMER CIRCLE ---
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Glow Shadow
                      Container(
                        width: screenWidth * 0.62,
                        height: screenWidth * 0.62,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff7FD6FF).withOpacity(0.05),
                              blurRadius: 50,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      // Progress Ring
                      SizedBox(
                        width: screenWidth * 0.6,
                        height: screenWidth * 0.6,
                        child: CustomPaint(
                          painter: TimerPainter(
                            progress: progress,
                            color: const Color(0xff7FD6FF),
                          ),
                        ),
                      ),
                      // Time Text
                      Text(
                        _formatTime(_secondsRemaining),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.w300,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),


                // Instruction Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xff7FD6FF),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Color(0xff7FD6FF), blurRadius: 8)],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Focus on your breath",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),



                // Vertical Line Divider (matching design)
                SizedBox(height: 20,),



                // --- CONTROLS ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildControlButton(
                      icon: _isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
                      label: _isPaused ? "RESUME" : "PAUSE",
                      onTap: () => setState(() => _isPaused = !_isPaused),
                    ),
                    const SizedBox(width: 20),
                    _buildControlButton(
                      icon: Icons.music_note_rounded,
                      label: "AMBIENT",
                      iconColor: const Color(0xffFFB4A8),
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 120),
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

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = const Color(0xff7FD6FF),
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final double progress;
  final Color color;

  TimerPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint trackPaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.width / 2;

    canvas.drawCircle(center, radius, trackPaint);

    double angle = 2 * 3.1415926535 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926535 / 2,
      angle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}