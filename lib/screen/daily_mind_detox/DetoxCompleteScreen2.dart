import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';
import 'DailyDetoxTimerStartScreen.dart';

class DetoxCompleteScreen2 extends StatefulWidget {
  const DetoxCompleteScreen2({super.key});

  @override
  State<DetoxCompleteScreen2> createState() => _DetoxCompleteScreen2State();
}

class _DetoxCompleteScreen2State extends State<DetoxCompleteScreen2> {
  int _currentIndex = 0;
  double _sessionLength = 10.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Take a moment to be present with your thoughts.\nNo judgment, just awareness.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          "Would you like to sit with your\nthoughts right now?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Even a few minutes can help you reconnect and\nreset.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- SESSION LENGTH CARD ---
                        _buildSliderCard(screenWidth),

                        const SizedBox(height: 40),

                        // START NOW BUTTON
                        PrimaryButton(
                          text: "START NOW",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyDetoxTimerStartScreen()));
                          },
                        ),

                        const SizedBox(height: 24),

                        // NOT NOW BUTTON
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            "NOT NOW",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 120),

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

  Widget _buildSliderCard(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            "SESSION LENGTH",
            style: TextStyle(
              color: const Color(0xff7FD6FF).withOpacity(0.5),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // ANIMATED NUMBER
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  "${_sessionLength.toInt()}",
                  key: ValueKey<int>(_sessionLength.toInt()),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "min",
                style: TextStyle(
                  color: const Color(0xff7FD6FF).withOpacity(0.7),
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          //const SizedBox(height: 30),

          // CUSTOM THEMED SLIDER
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4,
              activeTrackColor: const Color(0xff7FD6FF).withOpacity(0.3),
              inactiveTrackColor: Colors.white.withOpacity(0.05),
              thumbColor: const Color(0xff070B16),
              overlayColor: const Color(0xff7FD6FF).withOpacity(0.1),
              thumbShape: const _CustomThumbShape(),
              trackShape: const RoundedRectSliderTrackShape(),
            ),
            child: Slider(
              value: _sessionLength,
              min: 1,
              max: 30,
              onChanged: (value) {
                setState(() {
                  _sessionLength = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1 MIN", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.bold)),
                Text("30 MIN", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Custom Slider Thumb to match the Glow effect in the UI
class _CustomThumbShape extends SliderComponentShape {
  const _CustomThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(24, 24);

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
      ..color = const Color(0xff7FD6FF).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawCircle(center, 14, glowPaint);

    // Stroke Ring
    final Paint strokePaint = Paint()
      ..color = const Color(0xff7FD6FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, 10, strokePaint);

    // Inner Fill (matching background)
    final Paint fillPaint = Paint()..color = const Color(0xff111F45);
    canvas.drawCircle(center, 9, fillPaint);
  }
}