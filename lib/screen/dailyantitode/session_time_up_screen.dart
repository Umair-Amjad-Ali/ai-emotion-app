import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class SessionTimeUpScreen extends StatelessWidget {
  const SessionTimeUpScreen({super.key});

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
                      SizedBox(height: screenHeight * 0.03),

                      // --- Glowing Checkmark Graphic ---
                      _buildGlowingCheckmark(),

                      SizedBox(height: screenHeight * 0.06),

                      // --- Main Titles & Subtitles ---
                      Text(
                        'Session Complete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You\'ve completed your session.\nTake a moment to notice how\nyou feel.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.9),
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Come back tomorrow to continue your\njourney',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      // --- Activity Impact Card ---
                      _buildActivityImpactCard(),

                      const SizedBox(height: 120), // Bottom padding
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

  Widget _buildGlowingCheckmark() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. Massive Background Glow
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentBlueLite.withOpacity(0.35),
                blurRadius: 60,
                spreadRadius: 20,
              ),
            ],
          ),
        ),

        // 2. Outer Semi-transparent Ring
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accentBlueLite.withOpacity(0.15),
          ),
        ),

        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.accentBlueLite.withOpacity(0.7),
          ),
        ),

        // 3. Inner Solid Circle
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkCardBg.withOpacity(0.8),
          ),
          child: const Center(
            child: Icon(
              Icons.check_rounded,
              color: AppColors.accentBlueLite,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityImpactCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          // Header Row: Icon + Label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4),

                child: Icon(
                  Icons.access_time_filled_rounded,
                  color: AppColors.peachAccent.withOpacity(0.7), // Peach color
                  size: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'ACTIVITY IMPACT',
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Duration Text (Mixed colors for matching the design)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: 'Duration completed: ',
                  style: TextStyle(color: Colors.white),
                ),
                TextSpan(
                  text: '30\nminutes',
                  style: TextStyle(
                    color: AppColors.accentBlueLite.withOpacity(0.8),
                    height:
                        1.4, // Adds proper spacing between "30" and "minutes"
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Gradient Divider Line
          Container(
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                colors: [
                  AppColors.accentBlueLite,
                  AppColors.peachAccent, // Peach Accent
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
