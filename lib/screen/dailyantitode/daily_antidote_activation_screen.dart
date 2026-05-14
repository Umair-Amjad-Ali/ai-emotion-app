import 'package:ai_emotion_app/screen/dailyantitode/choose_antidote_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart';
import '../../widgets/primary_button.dart';

class DailyAntidoteActivationScreen extends StatefulWidget {
  const DailyAntidoteActivationScreen({super.key});

  @override
  State<DailyAntidoteActivationScreen> createState() =>
      _DailyAntidoteActivationScreenState();
}

class _DailyAntidoteActivationScreenState
    extends State<DailyAntidoteActivationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    // Gentle breathing animation for the shield rings
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
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

                      _buildActivationCard(screenWidth, screenHeight),

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

  Widget _buildActivationCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.0),
      ),
      child: Column(
        children: [
          // Phase Label
          Text(
            'PHASE ACTIVE',
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          SizedBox(
            height: 210,
            width: 210,
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    // 1. Outer Ring (Largest)
                    Transform.scale(
                      scale: _pulseAnimation.value * 1.06,
                      child: Container(
                        width: 190,
                        height: 190,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.15),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),

                    // 2. Inner Ring
                    Transform.scale(
                      scale: _pulseAnimation.value * 1.02,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    // 3. Central Solid Circle with Bold Border & Icon
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppColors.cardLikePillBg.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.accentBlueLite.withOpacity(0.1),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardLikePillBg.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.shield_rounded,
                        color: AppColors.accentBlueLite,
                        size: 44,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          // Titles & Description
          Text(
            'Activate the antidote',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'The golden field slows the toxic\npattern before it becomes a\nloop.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.7),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          // Progress Bar Section
          _buildProgressBar(),

          SizedBox(height: screenHeight * 0.04),

          // Activate Button
          PrimaryButton(
            text: 'ACTIVATE',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChooseAntidoteScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    // Current progress: 3 out of 10
    const int currentProgress = 3;
    const int totalProgress = 10;
    const double progressFraction = currentProgress / totalProgress;

    return Column(
      children: [
        // Progress Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PROGRESS',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
            Text(
              '$currentProgress/$totalProgress',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Linear Bar
        Container(
          height: 6,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progressFraction,
            child: Container(
              decoration: BoxDecoration(
                // Use a soft white/blue for the filled portion matching the image
                color: Color.lerp(Colors.white, AppColors.accentBlueLite, 0.4),
                borderRadius: BorderRadius.circular(3),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
