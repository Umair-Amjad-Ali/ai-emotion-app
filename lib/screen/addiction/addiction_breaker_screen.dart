import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class AddictionBreakerScreen extends StatelessWidget {
  const AddictionBreakerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Main Titles
                      const Text(
                        'Addiction Breaker',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Interrupt urges before they take control.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                      const SizedBox(height: 30),

                      // Card 1: Rapid Shield (With top-left glow & icon glow)
                      _buildOptionCard(
                        context,
                        label: 'RAPID SHIELD',
                        title: '2 Minute Interrupt',
                        description:
                            'A quick breathing and physical movement cycle to break the immediate cognitive loop of a craving.',
                        buttonText: 'START INTERRUPT',
                        icon: Icons.timer_outlined,
                        isPrimary: true,
                        cardTopLeftGlow: true, // Custom Glow Added
                        iconGlow: true, // Custom Glow Added
                      ),

                      const SizedBox(height: 20),

                      // Card 2: Guided Resilience
                      _buildOptionCard(
                        context,
                        label: 'GUIDED RESILIENCE',
                        title: '5 Minute Urge Breaker',
                        description:
                            'Guided meditation and mental visualization to ride out the peak of the urge without reacting.',
                        buttonText: 'BEGIN SESSION',
                        icon: Icons.bolt_rounded,
                      ),

                      const SizedBox(height: 20),

                      // Card 3: Total Calibration (With wavy background)
                      _buildOptionCard(
                        context,
                        label: 'TOTAL CALIBRATION',
                        title: '10 Minute Deep Craving Reset',
                        description:
                            'Deep cognitive reframing exercise combined with sensory grounding to eliminate complex cravings.',
                        buttonText: 'DEEP RESET',
                        icon: Icons.psychology_outlined,
                        showBackgroundWaves: true, // Wavy watermark added
                      ),

                      const SizedBox(height: 20),

                      // Pro Tip Section (With Top-Left and Bottom-Right Glows)
                      GlassCard(
                        padding:
                            EdgeInsets.zero, // Padding handled inside Stack
                        child: Stack(
                          children: [
                            // Top Left Glow
                            Positioned(
                              top: -40,
                              left: -40,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.08),
                                      blurRadius: 50,
                                      spreadRadius: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Bottom Right Glow
                            Positioned(
                              bottom: -40,
                              right: -40,
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.bgGlowBlue.withOpacity(
                                        0.55,
                                      ),
                                      blurRadius: 50,
                                      spreadRadius: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Card Content
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First Row: Icon + Title
                                  Row(
                                    children: [
                                      // Glowing Circular Border Icon
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.textPrimary
                                                .withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                          color: AppColors.textPrimary
                                              .withOpacity(0.05),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.textPrimary
                                                  .withOpacity(0.2),
                                              blurRadius: 15,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.info_outline,
                                          color: AppColors.textPrimary,
                                          size: 20,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      const Text(
                                        'Pro Tip',
                                        style: TextStyle(
                                          color: AppColors.textPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  // Second Row: Description Text
                                  const Text(
                                    'Urges typically peak within 15 minutes. If you can bridge this gap using one of the tools above, the neural intensity will naturally decrease.',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100), // Space for nav bar
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required String label,
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    bool isPrimary = false,
    bool cardTopLeftGlow = false,
    bool iconGlow = false,
    bool showBackgroundWaves = false,
  }) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Stack(
          children: [
            // Optional: Background Waves for Card 3
            if (showBackgroundWaves)
              Positioned(
                top: 0,
                right: 0,
                width: 140,
                height: 120,
                child: Image.asset(
                  'assets/pngs/wave.png',
                  fit: BoxFit.contain,
                  color: Colors.white.withOpacity(0.9),
                  colorBlendMode: BlendMode.srcIn,
                ),
              ),

            // Optional: Top Left Glow for Card 1
            if (cardTopLeftGlow)
              Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.12),
                        blurRadius: 60,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),
              ),

            // Main Card Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Colors.white38,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      // Top Right Icon (Using Solid color if not primary)
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isPrimary
                              ? AppColors.textPrimary.withOpacity(0.05)
                              : AppColors.solidBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: iconGlow
                              ? [
                                  BoxShadow(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.15,
                                    ),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(icon, color: Colors.white70, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  isPrimary
                      ? PrimaryButton(
                          text: buttonText,
                          onPressed: () {},
                          height: 50,
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          // Changed to ElevatedButton to ensure a perfectly solid background
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.solidBackgroundColor,
                              elevation: 0, // Flat look
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: AppColors.textPrimary.withOpacity(
                                    0.05,
                                  ), // Very faint border
                                ),
                              ),
                            ),
                            child: Text(
                              buttonText,
                              style: const TextStyle(
                                color: Colors.white, // Bright white text
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
