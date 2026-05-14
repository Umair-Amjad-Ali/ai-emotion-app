import 'package:ai_emotion_app/screen/blindforgiveness/blind_forgiveness_triggers_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';

class BlindForgivenessScreen extends StatelessWidget {
  const BlindForgivenessScreen({super.key});

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
                      SizedBox(height: screenHeight * 0.02),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.007,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlueLite.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.accentBlueLite,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'BLIND FORGIVENESS',
                              style: TextStyle(
                                color: AppColors.accentBlueLite,
                                fontSize: screenWidth * 0.025,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      // --- Main Title & Subtitle ---
                      Text(
                        'Release the emotional\nchain',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.07,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Detach from the weight of the past without needing to\nrelive it. A guided journey toward complete emotional\nliberation.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: screenWidth * 0.033,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Active Sessions Section ---
                      _buildSectionHeader('ACTIVE SESSIONS', screenWidth),
                      SizedBox(height: screenHeight * 0.02),

                      _buildSessionCard(
                        title: 'Quick Release',
                        subtitle: '5 minute intensive grounding',
                        icon: Icons.bolt_rounded,
                        iconColor: AppColors.accentBlueLite,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        context: context,
                        targetScreen: const BlindForgivenessTriggersScreen(),
                      ),
                      _buildSessionCard(
                        title: 'Emotional Unhook',
                        subtitle: '15 minute neural decoupling',
                        icon: Icons.link_off_rounded,
                        iconColor: AppColors.peachAccent,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        context: context,
                        targetScreen: const BlindForgivenessTriggersScreen(),
                      ),
                      _buildSessionCard(
                        title: 'Deep Forgiveness Reset',
                        subtitle: '30 minute core restoration',
                        icon: Icons.sync_rounded,
                        iconColor: Colors.white70,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        context: context,
                        targetScreen: const BlindForgivenessTriggersScreen(),
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSectionHeader(
                            'RESENTMENT TRACKING',
                            screenWidth,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025,
                              vertical: screenHeight * 0.005,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'LIVE DATA',
                              style: TextStyle(
                                color: AppColors.accentBlueLite,
                                fontSize: screenWidth * 0.022,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTrackingStatCard(
                              label: 'SESSIONS\nCOMPLETED',
                              value: '42',
                              progress: 0.6,
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: _buildTrackingStatCard(
                              label: 'RELEASES\nCOMPLETED',
                              value: '128',
                              subtext: '+12 this week',
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.015),

                      // Held Choices Card
                      _buildHeldChoicesCard(screenWidth, screenHeight),
                      SizedBox(height: screenHeight * 0.015),

                      // Total Weight Released Card
                      _buildTotalWeightCard(screenWidth, screenHeight),

                      SizedBox(height: screenHeight * 0.1),
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

  // --- Helpers ---

  Widget _buildSectionHeader(String title, double screenWidth) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.textPrimary.withOpacity(0.8),
        fontSize: screenWidth * 0.028,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildSessionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required double screenWidth,
    required double screenHeight,
    required BuildContext context,
    required Widget targetScreen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => targetScreen),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: AppColors.cardLikePillBg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.04),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: iconColor.withOpacity(0.1),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: screenWidth * 0.06),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.5),
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textPrimary.withOpacity(0.3),
              size: screenWidth * 0.06,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStatCard({
    required String label,
    required String value,
    double? progress,
    String? subtext,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Label
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: screenWidth * 0.022,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              height: 1.4,
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          // Main Value
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (progress != null) ...[
            SizedBox(height: screenHeight * 0.02),
            Stack(
              children: [
                Container(
                  height: 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.accentBlueLite,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Conditional Bottom Element: Subtext
          if (subtext != null) ...[
            SizedBox(height: screenHeight * 0.015),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                subtext,
                style: TextStyle(
                  color: AppColors.peachAccent,
                  fontSize: screenWidth * 0.025,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeldChoicesCard(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HELD RESENTMENT CHOICES',
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    fontSize: screenWidth * 0.022,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  '08',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Responsive Overlapping Letter Avatars
          SizedBox(
            width: screenWidth * 0.22,
            height: screenWidth * 0.09,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: _buildMiniLetterAvatar('R', screenWidth),
                ),
                Positioned(
                  left: screenWidth * 0.055,
                  child: _buildMiniLetterAvatar('P', screenWidth),
                ),
                Positioned(
                  left: screenWidth * 0.11,
                  child: _buildMiniLetterAvatar('S', screenWidth),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniLetterAvatar(String letter, double screenWidth) {
    final size = screenWidth * 0.09;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF262C40).withOpacity(0.8),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF262C40).withOpacity(0.4),
          width: 2.5,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTotalWeightCard(double screenWidth, double screenHeight) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              width: screenWidth,
              height: screenHeight * 0.1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.12),
                    blurRadius: 40,
                    spreadRadius: 15,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(screenWidth * 0.08),
            child: Column(
              children: [
                Text(
                  'TOTAL WEIGHT RELEASED',
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    fontSize: screenWidth * 0.025,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '24.5',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: screenWidth * 0.13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        'kg',
                        style: TextStyle(
                          color: AppColors.accentBlueLite,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Calculated emotional load based on neural\ntelemetry',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.4),
                    fontSize: screenWidth * 0.028,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Bright Glowing Bottom Line
          Positioned(
            bottom: 0,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            child: Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.accentBlueLite.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
