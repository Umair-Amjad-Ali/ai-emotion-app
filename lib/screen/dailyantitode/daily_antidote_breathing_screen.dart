import 'package:ai_emotion_app/screen/dailyantitode/daily_antidote_reconnect_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart'; // Reusable timer widget
import '../../widgets/primary_button.dart';

class DailyAntidoteBreathingScreen extends StatefulWidget {
  const DailyAntidoteBreathingScreen({super.key});

  @override
  State<DailyAntidoteBreathingScreen> createState() =>
      _DailyAntidoteBreathingScreenState();
}

class _DailyAntidoteBreathingScreenState
    extends State<DailyAntidoteBreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _breatheController;
  late Animation<double> _breatheAnimation;

  @override
  void initState() {
    super.initState();
    // 4 seconds to inhale, 4 seconds to exhale
    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _breatheAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _breatheController.dispose();
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

                      SizedBox(height: screenHeight * 0.025),
                      Row(
                        children: [
                          Expanded(
                            child: _buildMetricCard(
                              label: 'FOCUS',
                              value: 'Clarity Flow',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildMetricCard(
                              label: 'INTENSITY',
                              value: 'Subtle',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildBreathingCard(screenWidth, screenHeight),

                      SizedBox(height: screenHeight * 0.12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  Widget _buildMetricCard({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // --- Large Breathing Visualizer Card ---
  Widget _buildBreathingCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // Titles
          Text(
            'Breathe with the antidote',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Each exhale weakens the active\ntoxin pattern.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 13,
              height: 1.4,
            ),
          ),

          SizedBox(height: screenHeight * 0.03),

          // Animated Breathing Circle
          SizedBox(
            height: 220,
            width: 220,
            child: AnimatedBuilder(
              animation: _breatheAnimation,
              builder: (context, child) {
                // Determine text based on animation direction
                String breatheText =
                    _breatheController.status == AnimationStatus.reverse
                    ? 'E X H A L E'
                    : 'I N H A L E';

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer faint ring (expands the most)
                    Transform.scale(
                      scale: _breatheAnimation.value * 1.15,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    // Central Solid Circle
                    Transform.scale(
                      scale: _breatheAnimation.value,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentBlueLite.withOpacity(0.05),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.1),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentBlueLite.withOpacity(0.05),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            breatheText,
                            style: TextStyle(
                              color: AppColors.textPrimary.withOpacity(0.9),
                              fontSize: 14,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(height: screenHeight * 0.035),

          // Continue Button
          PrimaryButton(
            text: 'CONTINUE',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DailyAntidoteReconnectScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
