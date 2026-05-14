import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class AngerSummaryScreen extends StatelessWidget {
  const AngerSummaryScreen({super.key});

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
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'SESSION COMPLETE',
                          style: TextStyle(
                            color: AppColors.accentBlueLite.withOpacity(0.9),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Main Titles
                      const Text(
                        'You redirected the\nanger',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'The storm was interrupted before it became\nreaction. That is progress.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightDarkText.withOpacity(0.6),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Full Width Card: TRIGGER
                      _buildFullWidthCard(label: 'TRIGGER', value: 'Injustice'),

                      const SizedBox(height: 12),

                      // Split Cards: ANGER BEFORE & AFTER
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              label: 'ANGER BEFORE',
                              value: '5',
                              suffix: '/ 10',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              label: 'ANGER AFTER',
                              value: '3',
                              suffix: '/ 10',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Split Cards: REDUCTION & CALM POINTS with custom tinted backgrounds
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              label: 'REDUCTION',
                              value: '2',
                              icon: Icons.trending_down_rounded,
                              iconColor: AppColors.accentBlueLite,
                              labelColor: AppColors.accentBlueLite,
                              backgroundColor: AppColors.accentBlueLite
                                  .withOpacity(0.05),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              label: 'CALM POINTS EARNED',
                              value: '3',
                              icon: Icons.auto_awesome,
                              iconColor: AppColors.peachAccent,
                              labelColor: AppColors.peachAccent,
                              backgroundColor: AppColors.peachAccent
                                  .withOpacity(0.05),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Full Width Card: CHOSEN RESPONSE
                      _buildFullWidthCard(
                        label: 'CHOSEN RESPONSE',
                        value: '"Let it go"',
                        isItalic: true,
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // Tracked Metrics Info Text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.textPrimary.withOpacity(0.4),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Tracked metrics: sessions completed, total anger reduced, calm points.',
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.4),
                                fontSize: 11,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Start Again Button
                      PrimaryButton(
                        text: 'START AGAIN',
                        onPressed: () {
                          Navigator.pop(context);
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
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  // Helper method for full width cards (Trigger & Chosen Response)
  Widget _buildFullWidthCard({
    required String label,
    required String value,
    bool isItalic = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for the half-width stat cards (Now accepts a backgroundColor parameter)
  Widget _buildStatCard({
    required String label,
    required String value,
    String? suffix,
    IconData? icon,
    Color? iconColor,
    Color? labelColor,
    Color? backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        // Use custom background if provided, else use the default dark navy
        color: backgroundColor ?? AppColors.cardLikePillBg.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: labelColor != null
              ? labelColor.withOpacity(0.15)
              : AppColors.textPrimary.withOpacity(0.05),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: labelColor ?? AppColors.textPrimary.withOpacity(0.5),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: labelColor ?? AppColors.textPrimary,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 4),
                Text(
                  suffix,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              if (icon != null) ...[
                const SizedBox(width: 8),
                Icon(icon, color: iconColor ?? AppColors.textPrimary, size: 18),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
