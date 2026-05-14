import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/glass_card.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class StabilizeTheNervousSystemRefinedWithTracking extends StatelessWidget {
  const StabilizeTheNervousSystemRefinedWithTracking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      // Success Icon with Glow
                      Center(
                        child: Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.bgGlowSplash,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentBlueLite.withOpacity(0.3),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                            border: Border.all(
                              color: AppColors.accentBlueLite.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: AppColors.accentBlueLite,
                            size: 44,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Main Text
                      const Text(
                        'You returned to the\npresent moment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.8,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your system moved from trigger toward stability.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 16,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Stability Score Card
                      _buildStabilityScoreCard(),

                      const SizedBox(height: 16),

                      // Detail Cards
                      _buildDetailCard(
                        icon: Icons.chat_bubble_outline_rounded,
                        label: 'TRIGGER TYPE',
                        value: "Someone's words",
                      ),
                      const SizedBox(height: 16),
                      _buildDetailCard(
                        icon: Icons.water_drop_rounded,
                        label: 'EMOTION MAPPED',
                        value: 'Sadness',
                        iconColor: AppColors.peachAccent,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailCard(
                        icon: Icons.monitor_heart_outlined,
                        label: 'BODY SIGNAL',
                        value: 'chest',
                        iconColor: AppColors.accentBlueLite,
                      ),
                      const SizedBox(height: 16),
                      _buildDetailCard(
                        icon: Icons.bolt_rounded,
                        label: 'CALM STREAK',
                        value: '1',
                        iconColor: AppColors.lightOrange,
                      ),

                      const SizedBox(height: 16),

                      // Latest Log Entry Card
                      _buildLatestLogCard(),

                      const SizedBox(height: 40),

                      // Start Again Button
                      PrimaryButton(
                        text: 'START AGAIN',
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                      ),

                      const SizedBox(height: 120),
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

  Widget _buildStabilityScoreCard() {
    return GlassCard(
      
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'STABILITY SCORE',
            style: TextStyle(
              color: AppColors.accentBlueLite,
              fontSize: 12,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 64,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          // Custom Progress Bar
          Container(
            width: 80,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.accentBlueLite,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
    Color? iconColor,
  }) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: 24,
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.textLiteBlue).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor ?? AppColors.textLiteBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLatestLogCard() {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: const DecorationImage(
          image: AssetImage('assets/pngs/the_ethereal_sanctuary.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'LATEST LOG ENTRY',
                  style: TextStyle(
                    color: AppColors.accentBlueLite,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Trauma Trigger\nTracking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Today at 14:24 • Neural resonance\nstable',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Icons.air_rounded,
                color: Colors.white54,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
