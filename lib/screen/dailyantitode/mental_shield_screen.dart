import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/circular_timer.dart'; // Reusable timer widget
import '../../widgets/primary_button.dart';

class MentalShieldScreen extends StatefulWidget {
  const MentalShieldScreen({super.key});

  @override
  State<MentalShieldScreen> createState() => _MentalShieldScreenState();
}

class _MentalShieldScreenState extends State<MentalShieldScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    // Continuous rotation for the orbiting particles
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.01),

                      // --- Session Time Header ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Session Time',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'BUILD MENTAL IMMUNITY',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.6,
                                    ),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Reusable Timer Widget
                          const CircularTimer(borderColor: Colors.red),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Main Shield Generator Card ---
                      _buildShieldCard(screenWidth),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          // Handle Navigation logic here
                        },
                      ),

                      SizedBox(height: screenHeight * 0.12), // Bottom padding
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

  Widget _buildShieldCard(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cardLikePillBg.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.textPrimary.withOpacity(0.05),
                width: 1.0,
              ),
            ),
            child: Text(
              'Mental Shield Generator',
              style: TextStyle(
                color: AppColors.orangeAccent.withOpacity(0.6),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Titles
          Text(
            'Generate the\nantidote shield',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'The shield represents awareness\nbefore reaction.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 13,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 24),
          // --- Enhanced Shield Orb ---
          _buildShieldOrb(),
        ],
      ),
    );
  }

  Widget _buildShieldOrb() {
    // Increased standard size of the component to fit all rings
    const double componentSize = 320.0;
    const double innerOrbSize = 130.0;

    // Define the exact sizes for the 6 Concentric Rings (matching image depth)
    const List<double> ringSizes = [160, 190, 220, 250, 280, 320];

    // Define the Opacity decreasing from Inner to Outer. Inner bright, outer faint.
    const List<double> ringOpacities = [0.35, 0.25, 0.18, 0.12, 0.08, 0.04];

    // Define colors for alternating rings - cyan and red pattern
    List<Color> ringColors = [
      AppColors.accentBlueLite, // Ring 0
      const Color.fromARGB(255, 168, 8, 8).withOpacity(0.1), // Ring 1
      AppColors.accentBlueLite, // Ring 2
      AppColors.textPrimary, // Ring 3
      AppColors.accentBlueLite, // Ring 4
      AppColors.accentBlueLite, // Ring 5
    ];

    return SizedBox(
      height: componentSize,
      width: componentSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // --- Dynamic Multi-Rings Generation (6 Rings) ---
          for (int i = 0; i < ringSizes.length; i++)
            Container(
              width: ringSizes[i],
              height: ringSizes[i],
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  // Rings alternate between cyan and red, getting progressively dimmer
                  color: ringColors[i].withOpacity(ringOpacities[i]),
                  width: 1.0,
                ),
              ),
            ),

          // --- Rotating Particles Layer ---
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _orbitController.value * 2.0 * math.pi,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(width: componentSize, height: componentSize),

                    // Cyan particle on Ring 4 (Top)
                    Positioned(
                      top: (componentSize - ringSizes[3]) / 2 - 3,
                      child: _buildParticle(
                        color: AppColors.accentBlueLite,
                        size: 6.0,
                      ),
                    ),

                    // Peach particle on Ring 3 (Bottom Right)
                    Positioned(
                      bottom: (componentSize - ringSizes[2]) / 2 + 10,
                      right: (componentSize - ringSizes[2]) / 2 + 10,
                      child: _buildParticle(
                        color: const Color(0xFFE28B78),
                        size: 5.0,
                      ),
                    ),

                    // Peach particle on Ring 2 (Bottom Left)
                    Positioned(
                      bottom: (componentSize - ringSizes[1]) / 2 - 2,
                      left: (componentSize - ringSizes[1]) / 2 + 25,
                      child: _buildParticle(
                        color: const Color(0xFFE28B78).withOpacity(0.7),
                        size: 4.0,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          Container(
            width: innerOrbSize,
            height: innerOrbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentBlueLite.withOpacity(0.1),

              // Inner depth gradient mimicking a bubble shield
              // Solid, very light cyan-white
              border: Border.all(
                color: AppColors.accentBlueLite.withOpacity(0.2),
                width:
                    2.0, // Increased border thickness for a more "forged" look
              ),
              boxShadow: [
                // Pure white internal bloom/sheen
                BoxShadow(
                  color: Colors.white.withOpacity(0.2),
                  blurRadius: 150,
                  spreadRadius: 15,
                ),
                // Cyan outer glow spreading past the border
                BoxShadow(
                  color: AppColors.accentBlueLite.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 8,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ), // Nudge text slightly lower as in image
                child: Text(
                  'Protected\nmind',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors
                        .textPrimary, // Dark text to stand out against the solid light orb
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w800, // Slightly chunkier font weight
                    letterSpacing: 0.5,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for orbiting glowing dots
  Widget _buildParticle({required Color color, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.8),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}
