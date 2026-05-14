import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/circular_timer.dart'; // Reusable timer widget
import '../../widgets/primary_button.dart';

class ClarityReportScreen extends StatelessWidget {
  const ClarityReportScreen({super.key});

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

                      // --- Main Unified Report Card ---
                      _buildMainReportCard(),

                      SizedBox(height: screenHeight * 0.025),

                      // --- Start Again Button ---
                      PrimaryButton(text: 'START AGAIN', onPressed: () {}),

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

  Widget _buildMainReportCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.orangeAccent.withOpacity(0.15), // Peach tint
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.orangeAccent.withOpacity(0.3),
                width: 1.0,
              ),
            ),
            child: const Text(
              'Mind Clarity Report',
              style: TextStyle(
                color: AppColors.orangeAccent, // Peach color from the image
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Titles
          Text(
            'Your antidote is active',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Today\'s mental toxins were recognized and\nneutralized before they could become loops.',
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 13,
              height: 1.4,
            ),
          ),

          const SizedBox(height: 20),

          // --- Vertical Data List ---
          _buildDataPill(
            label: 'MIND STATE',
            value: 'distracted',
            valueColor: AppColors.accentBlueLite.withOpacity(0.8),
          ),
          const SizedBox(height: 10),
          _buildDataPill(
            label: 'TOXINS NEUTRALIZED',
            value: '1',
            valueColor: AppColors.textPrimary,
          ),
          const SizedBox(height: 10),
          _buildDataPill(
            label: 'ANTIDOTE INTENTION',
            value: 'releasing thoughts',
            valueColor: AppColors.accentBlueLite.withOpacity(0.8),
          ),
          const SizedBox(height: 10),
          _buildDataPill(
            label: 'DAILY STREAK',
            value: '3',
            valueColor: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  // Individual data row inside the main card
  Widget _buildDataPill({
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.4),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
