import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

class MentalImmunitySanctuaryScreen extends StatelessWidget {
  const MentalImmunitySanctuaryScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Build mental\nimmunity',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Strengthen your resilience against\ndigital toxicity and external noise.',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.7,
                                    ),
                                    fontSize: 11,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // 70% Core Indicator
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.accentBlueLite,
                                width: 2.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accentBlueLite.withOpacity(
                                    0.2,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '70%',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'CORE',
                                  style: TextStyle(
                                    color: AppColors.accentBlueLite,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.025),
                      // --- Active Protocols Section ---
                      Text(
                        'ACTIVE PROTOCOLS',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildProtocolCard(
                        icon: Icons.bolt_rounded,
                        iconColor: const Color(0xFFE28B78),
                        title: 'Micro Antidote',
                        subtitle: 'Rapid reset for immediate\ndigital fatigue.',
                      ),
                      const SizedBox(height: 10),
                      _buildProtocolCard(
                        icon: Icons.shield_rounded,
                        iconColor: AppColors.accentBlueLite,
                        title: 'Daily Immunity Builder',
                        subtitle: 'Sustained practice for long-\nterm focus.',
                      ),
                      const SizedBox(height: 10),
                      _buildProtocolCard(
                        icon: Icons.layers_rounded,
                        iconColor: AppColors.textPrimary.withOpacity(
                          0.8,
                        ), // White/Grey
                        title: 'Deep Antidote Protocol',
                        subtitle:
                            'Intensive recalibration for high-\nstress peaks.',
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'MENTAL TOXICITY TRACKING',
                            style: TextStyle(
                              color: AppColors.textPrimary.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.sync_rounded,
                                color: AppColors.textPrimary.withOpacity(0.5),
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'REAL-TIME SYNC',
                                style: TextStyle(
                                  color: AppColors.textPrimary.withOpacity(0.5),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildTrackingCard(),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: _buildSmallMetricCard(
                              label: 'RESILIENCE',
                              value: '+12%',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSmallMetricCard(
                              label: 'EXPOSURE',
                              value: '-4.2h',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          // Handle Navigation
                        },
                      ),

                      SizedBox(height: screenHeight * 0.12),
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

  Widget _buildProtocolCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          // Texts
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.6),
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
          // Arrow
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textPrimary.withOpacity(0.3),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CURRENT THRESHOLD',
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE28B78).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE28B78).withOpacity(0.3),
                  ),
                ),
                child: const Text(
                  'DECREASING',
                  style: TextStyle(
                    color: Color(0xFFE28B78),
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '14.2',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  'μT',
                  style: TextStyle(
                    color: AppColors.accentBlueLite,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Simulated Bar Chart (Fixed Overflow and added Responsiveness)
          SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildChartBar(height: 30, isFocused: false),
                _buildChartBar(height: 65, isFocused: false),
                _buildChartBar(height: 35, isFocused: false),
                _buildChartBar(
                  height: 70,
                  isFocused: true,
                ), // Main highlighted bar fits safely
                _buildChartBar(height: 40, isFocused: false),
                _buildChartBar(height: 25, isFocused: false),
                _buildChartBar(height: 35, isFocused: false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar({required double height, required bool isFocused}) {
    // Wrapped in Expanded so bars dynamically resize to fit any screen width
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isFocused)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  'T',
                  style: TextStyle(
                    color: AppColors.accentBlueLite,
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Container(
              // Removed fixed width so it perfectly fills the Expanded space
              height: height,
              decoration: BoxDecoration(
                color: isFocused
                    ? AppColors.accentBlueLite.withOpacity(0.8)
                    : Colors.white.withOpacity(0.05),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: isFocused
                    ? [
                        BoxShadow(
                          color: AppColors.accentBlueLite.withOpacity(0.4),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallMetricCard({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
