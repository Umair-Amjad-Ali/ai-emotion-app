import 'package:ai_emotion_app/screen/dailyantitode/daily_antidote_breathing_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart'; // Reusable timer widget
import '../../widgets/primary_button.dart';

class ChooseAntidoteScreen extends StatefulWidget {
  const ChooseAntidoteScreen({super.key});

  @override
  State<ChooseAntidoteScreen> createState() => _ChooseAntidoteScreenState();
}

class _ChooseAntidoteScreenState extends State<ChooseAntidoteScreen> {
  // Track selected option (0, 1, or 2). Defaulting to 0 to match the design.
  int _selectedIndex = 0;

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

                      SizedBox(height: screenHeight * 0.04),

                      // --- Main Titles ---
                      Text(
                        'Choose the antidote\nthought',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tap the statement that neutralizes the\nselected toxin.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.7),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Left Red Icon
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.peachAccent.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons
                                    .bolt_rounded, // Lightning icon indicating toxin/trigger
                                color: AppColors.peachAccent,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Texts
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'DETECTED TOXIN',
                                    style: TextStyle(
                                      color: AppColors.textPrimary.withOpacity(
                                        0.5,
                                      ),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'worry',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Right Mind/Brain Icon
                            Image.asset(
                              "assets/pngs/brain_setting.png",
                              height: 25,
                              width: 25,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Selectable Antidote Cards ---
                      _buildOptionCard(
                        index: 0,
                        labelInactive: 'THOUGHT PATTERN A',
                        labelActive: 'HEALING PERSPECTIVE',
                        text: 'Tomorrow is not happening now.',
                      ),
                      const SizedBox(height: 12),
                      _buildOptionCard(
                        index: 1,
                        labelInactive: 'THOUGHT PATTERN A',
                        labelActive: 'HEALING PERSPECTIVE',
                        text: 'I must keep thinking until this feels\nsolved.',
                      ),
                      const SizedBox(height: 12),
                      _buildOptionCard(
                        index: 2,
                        labelInactive: 'THOUGHT PATTERN B',
                        labelActive: 'HEALING PERSPECTIVE',
                        text: 'If I replay it enough, I will gain\ncontrol.',
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DailyAntidoteBreathingScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 120), // Bottom padding
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

  // --- Selectable Option Card ---
  Widget _buildOptionCard({
    required int index,
    required String labelInactive,
    required String labelActive,
    required String text,
  }) {
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.08)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.6)
                : Colors.white.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Label and Checkmark
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isSelected ? labelActive : labelInactive,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.accentBlueLite
                        : AppColors.textPrimary.withOpacity(0.4),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                Opacity(
                  opacity: isSelected ? 1.0 : 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentBlueLite.withOpacity(0.4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.accentBlueLite,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Main Antidote Thought Text
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withOpacity(0.7),
                fontSize: 15,
                fontWeight: FontWeight
                    .w600, // Fixed font weight to prevent text shifting
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
