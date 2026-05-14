import 'package:ai_emotion_app/screen/daily_mind_detox/DetoxCompleteScreen.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class BreathingStabilizationScreen extends StatefulWidget {
  const BreathingStabilizationScreen({super.key});

  @override
  State<BreathingStabilizationScreen> createState() => _BreathingStabilizationScreenState();
}

class _BreathingStabilizationScreenState extends State<BreathingStabilizationScreen> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _breathingController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    // 4 second breath cycle (inhale 4s, exhale 4s)
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOutSine),
    );

    _glowAnimation = Tween<double>(begin: 20.0, end: 60.0).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Synchronize your breath with the expanding orb to lower heart rate and center your focus.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),

                        const Spacer(),

                        // ANIMATED BREATHING ORB
                        AnimatedBuilder(
                          animation: _breathingController,
                          builder: (context, child) {
                            return Container(
                              width: screenWidth * 0.55 * _scaleAnimation.value,
                              height: screenWidth * 0.55 * _scaleAnimation.value,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(0xff7BD3E9).withOpacity(0.4),
                                    const Color(0xff1C2A4D).withOpacity(0.6),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                                boxShadow: [
                                  // Outer Glow
                                  BoxShadow(
                                    color: const Color(0xff7BD3E9).withOpacity(0.15),
                                    blurRadius: _glowAnimation.value,
                                    spreadRadius: _glowAnimation.value / 4,
                                  ),
                                  // Inner Glow logic via shadow
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.05),
                                    blurRadius: 10,
                                    //inset: true,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const Spacer(),

                        // STABILIZING STATUS
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white.withOpacity(0.05)),
                          ),
                          child: const Center(
                            child: Text(
                              "STABILIZING...",
                              style: TextStyle(
                                color: Color(0xff7FD6FF),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // CONTINUE BUTTON
                        PrimaryButton(
                          text: "CONTINUE",
                          onPressed: () {
                            // Navigation logic
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetoxCompleteScreen()));
                          },
                        ),

                        const SizedBox(height: 120), // Bottom Nav space
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