import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

enum _TrackingCardType { resolved, frequency, intensity, streak }

class GuiltCleanserFinalResultScreen extends StatelessWidget {
  const GuiltCleanserFinalResultScreen({super.key});

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
                      SizedBox(height: screenHeight * 0.025),

                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentBlueLite.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            "assets/pngs/tick.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Step Indicator ---
                      Text(
                        'STEP 10 OF 10',
                        style: TextStyle(
                          color: AppColors.accentBlueLite.withOpacity(0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- Main Title ---
                      Text(
                        'You faced the truth and\nreleased the punishment',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- Subtitle ---
                      Text(
                        'The goal was not denial. The goal was\nhonesty without self-destruction.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Session Summary Section ---
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'SESSION SUMMARY',
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildSummaryRow(
                        iconAssetPath: 'assets/pngs/path.png',
                        label: 'Path used',
                        value: 'Shame Breaker',
                      ),
                      _buildSummaryRow(
                        iconAssetPath: 'assets/pngs/brain_color.png',
                        label: 'Load identified',
                        value: "I don't know",
                      ),
                      _buildSummaryRow(
                        iconAssetPath: 'assets/pngs/repair.png',
                        label: 'Repair or release',
                        value: 'Maybe — partially',
                      ),
                      _buildSummaryRow(
                        icon: Icons.favorite_border_rounded,
                        label: 'Peace score',
                        value: '',
                        iconColor: const Color(0xFFFF9A8B),
                        customValue: _buildPeaceScore(6, 10),
                      ),
                      _buildSummaryRow(
                        icon: Icons.mail_outline_rounded,
                        label: 'Letter action',
                        value: 'Save privately',
                      ),
                      _buildSummaryRow(
                        iconAssetPath: 'assets/pngs/session.png',
                        label: 'Sessions completed',
                        value: '1',
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'GUILT + SHAME TRACKING',
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.8),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 2x2 Grid for Tracking Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildTrackingCard(
                              title: 'RESOLVED',
                              mainText: '15%',
                              type: _TrackingCardType.resolved,
                              progress: 0.15,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTrackingCard(
                              title: 'FREQUENCY',
                              mainText: 'Weekly',
                              type: _TrackingCardType.frequency,
                              activeDots: 3,
                              totalDots: 4,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTrackingCard(
                              title: 'INTENSITY',
                              mainText: 'Medium',
                              type: _TrackingCardType.intensity,
                              progress: 0.6,
                              accentColor: const Color(0xFFE28B78),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildTrackingCard(
                              title: 'STREAK',
                              mainText: '3',
                              type: _TrackingCardType.streak,
                              suffixText: 'days',
                              boltCount: 3,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- Start Again Button ---
                      PrimaryButton(
                        text: 'START AGAIN',
                        onPressed: () {
                          // Handle restart or navigation
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

  // --- Summary List Row Item ---
  Widget _buildSummaryRow({
    IconData? icon,
    String? iconAssetPath,
    required String label,
    required String value,
    Widget? customValue,
    Color? iconColor,
    Color? iconBackgroundColor,
  }) {
    assert(
      icon != null || iconAssetPath != null,
      'Either icon or iconAssetPath must be provided',
    );

    final Color effectiveIconBackground =
        iconBackgroundColor ?? AppColors.accentBlueLite.withOpacity(0.1);
    final Color effectiveIconColor =
        iconColor ?? AppColors.accentBlueLite.withOpacity(0.8);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(16, 0, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // Icon Container
              Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: effectiveIconBackground,
                  shape: BoxShape.circle,
                ),
                child: iconAssetPath != null
                    ? Image.asset(iconAssetPath, fit: BoxFit.contain)
                    : Icon(icon, color: effectiveIconColor, size: 25),
              ),
              const SizedBox(width: 12),
              // Label
              Text(
                label,
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.6),
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              // Value (either standard text or custom widget like the Peace Score)
              customValue ??
                  Text(
                    value,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            ],
          ),
        ],
      ),
    );
  }

  // Custom widget for "6 / 10" formatting
  Widget _buildPeaceScore(int score, int total) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$score ',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '/ $total',
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBaseTrackingCard({
    required String title,
    required Widget content,
  }) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? AppColors.accentBlueLite
            : Colors.white.withOpacity(0.2),
      ),
    );
  }

  Widget _buildTrackingCard({
    required String title,
    required String mainText,
    required _TrackingCardType type,
    double progress = 0.0,
    int activeDots = 0,
    int totalDots = 4,
    Color? accentColor,
    String? suffixText,
    int boltCount = 3,
  }) {
    final Color accent = accentColor ?? AppColors.accentBlueLite;

    Widget content;
    switch (type) {
      case _TrackingCardType.resolved:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final filledWidth =
                    constraints.maxWidth * progress.clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Container(
                      height: 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      height: 3,
                      width: filledWidth,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
        break;
      case _TrackingCardType.frequency:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(totalDots, (index) {
                return Row(
                  children: [
                    _buildDot(isActive: index < activeDots),
                    if (index < totalDots - 1) const SizedBox(width: 4),
                  ],
                );
              }),
            ),
          ],
        );
        break;
      case _TrackingCardType.intensity:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: TextStyle(
                color: accent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            LayoutBuilder(
              builder: (context, constraints) {
                final filledWidth =
                    constraints.maxWidth * progress.clamp(0.0, 1.0);
                return Stack(
                  children: [
                    Container(
                      height: 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Container(
                      height: 3,
                      width: filledWidth,
                      decoration: BoxDecoration(
                        color: accent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        );
        break;
      case _TrackingCardType.streak:
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontFamily: 'Inter'),
                children: [
                  TextSpan(
                    text: '$mainText ',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: suffixText ?? 'days',
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(boltCount, (index) {
                return Row(
                  children: [
                    Icon(Icons.bolt_rounded, color: accent, size: 14),
                    if (index < boltCount - 1) const SizedBox(width: 4),
                  ],
                );
              }),
            ),
          ],
        );
        break;
    }

    return _buildBaseTrackingCard(title: title, content: content);
  }
}
