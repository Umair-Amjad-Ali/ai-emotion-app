import 'package:ai_emotion_app/screen/dailyantitode/toxic_thought_detector_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart';
import '../../widgets/primary_button.dart';

class DailyAntidoteMindStateScreen extends StatefulWidget {
  const DailyAntidoteMindStateScreen({super.key});

  @override
  State<DailyAntidoteMindStateScreen> createState() =>
      _DailyAntidoteMindStateScreenState();
}

class _DailyAntidoteMindStateScreenState
    extends State<DailyAntidoteMindStateScreen> {
  String? _selectedState;

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
                                SizedBox(height: screenHeight * 0.005),
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
                          const CircularTimer(),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      Text(
                        'How does your mind feel\nright now?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Choose the dominant state.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Row 1
                      Row(
                        children: [
                          Expanded(
                            child: _buildHalfWidthCard(
                              title: 'Calm',
                              subtitle: 'Quiet and settled',
                              icon: Icons.dark_mode_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildHalfWidthCard(
                              title: 'Distracted',
                              subtitle: 'Fragmented attention',
                              icon: Icons.filter_center_focus_rounded,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      _buildFullWidthCard(
                        title: 'Worried',
                        subtitle: 'Underlying sense of unease',
                        icon: Icons.warning_amber_rounded,
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // Row 3
                      Row(
                        children: [
                          Expanded(
                            child: _buildHalfWidthCard(
                              title: 'Overthinking',
                              subtitle: 'Endless loops',
                              icon: Icons.sync_rounded,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildHalfWidthCard(
                              title: 'Mentally tired',
                              subtitle: 'Drained energy',
                              icon: Icons.battery_0_bar_rounded,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      _buildMindStateOrb(),
                      SizedBox(height: screenHeight * 0.06),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedState == null
                            ? () {}
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ToxicThoughtDetectorScreen(),
                                  ),
                                );
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
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  Widget _buildHalfWidthCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedState == title;
    final activeColor = AppColors.accentBlueLite;
    final inactiveColor = AppColors.textPrimary.withOpacity(0.8);

    return GestureDetector(
      onTap: () => setState(() => _selectedState = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? activeColor.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 20,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textPrimary.withOpacity(0.5),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullWidthCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isSelected = _selectedState == title;
    final activeColor = AppColors.accentBlueLite;
    final inactiveColor = AppColors.textPrimary.withOpacity(0.8);

    return GestureDetector(
      onTap: () => setState(() => _selectedState = title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? activeColor.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? activeColor.withOpacity(0.15)
                    : AppColors.textPrimary.withOpacity(0.05),
              ),
              child: Icon(
                icon,
                color: isSelected ? activeColor : inactiveColor,
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textPrimary.withOpacity(0.3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMindStateOrb() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        border: Border.all(
          color: AppColors.accentBlueLite.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlueLite.withOpacity(0.15),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/pngs/bran_left.png", height: 40, width: 40),
          const SizedBox(height: 8),
          Text(
            'MIND STATE',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ],
      ),
    );
  }
}
