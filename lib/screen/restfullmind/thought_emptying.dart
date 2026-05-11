import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/screen/restfullmind/moon_breathing.dart';

class ThoughtEmptyingScreen extends StatefulWidget {
  const ThoughtEmptyingScreen({super.key});

  @override
  State<ThoughtEmptyingScreen> createState() => _ThoughtEmptyingScreenState();
}

class _ThoughtEmptyingScreenState extends State<ThoughtEmptyingScreen> {
  double _sliderValue = 0.0;
  final int _totalParticles = 18;

  @override
  Widget build(BuildContext context) {
    int percentage = (_sliderValue * 100).toInt();
    int hiddenParticles = (_sliderValue * _totalParticles).toInt();

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppHeader(level: 'LEVEL 1'),
                const SizedBox(height: 16),

                // Title and Subtitle
                const ScreenHeader(
                  title: 'Empty the mind\ncontainer',
                  subtitle:
                      'Swipe all the way to lift the\nremaining particles out of the mind.',
                ),

                const SizedBox(height: 32),

                // Central Container
                Container(
                  height: 320,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff1B1F2E).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.05),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Particles Area
                      Expanded(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32.0,
                              vertical: 24.0,
                            ),
                            child: Wrap(
                              spacing: 24,
                              runSpacing: 24,
                              alignment: WrapAlignment.center,
                              children: List.generate(_totalParticles, (index) {
                                bool isVisible =
                                    index < (_totalParticles - hiddenParticles);
                                // Colors based on the image (some blue, some reddish)
                                Color particleColor =
                                    (index == 2 ||
                                        index == 7 ||
                                        index == 12 ||
                                        index == 16)
                                    ? const Color(0xFFE88A8A)
                                    : const Color(0xFF5BC0EB);

                                return AnimatedOpacity(
                                  opacity: isVisible ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: particleColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: particleColor.withOpacity(0.6),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),

                      // Center Sparkle Icon
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                          color: const Color(0xFF161A29).withOpacity(0.5),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Color(0xFF5BC0EB),
                          size: 32,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Percentage Text
                      Text(
                        'EMPTYING: $percentage%',
                        style: const TextStyle(
                          color: Color(0xFF5BC0EB),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Progress Bar
                      Container(
                        height: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FractionallySizedBox(
                            widthFactor: _sliderValue,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF5BC0EB),
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF5BC0EB,
                                    ).withOpacity(0.5),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Custom Slider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final double maxWidth = constraints.maxWidth;
                      const double thumbWidth = 60.0;
                      final double maxDrag = maxWidth - thumbWidth;

                      return Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF161A29).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Background Text
                            Center(
                              child: Text(
                                'RELEASE TO EMPTY',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ),

                            // Thumb Slider
                            Positioned(
                              left: _sliderValue * maxDrag,
                              top: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onHorizontalDragUpdate: (details) {
                                  setState(() {
                                    double newValue =
                                        _sliderValue +
                                        (details.delta.dx / maxDrag);
                                    _sliderValue = newValue.clamp(0.0, 1.0);
                                  });
                                },
                                child: Container(
                                  width: thumbWidth,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.white,
                                        const Color(
                                          0xFF5BC0EB,
                                        ).withOpacity(0.8),
                                      ],
                                      radius: 0.8,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF5BC0EB,
                                        ).withOpacity(0.6),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xFF161A29),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 32),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PrimaryButton(
                    text: 'CONTINUE',
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const MoonBreathingScreen()));
                    },
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }
}
