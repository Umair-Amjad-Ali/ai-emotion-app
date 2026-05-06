import 'package:ai_emotion_app/screen/anger/anger_intensity_screen.dart';
import 'package:ai_emotion_app/widgets/session_progress_badge.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class AngerTamerTriggersScreen extends StatefulWidget {
  const AngerTamerTriggersScreen({super.key});

  @override
  State<AngerTamerTriggersScreen> createState() =>
      _AngerTamerTriggersScreenState();
}

class _AngerTamerTriggersScreenState extends State<AngerTamerTriggersScreen> {
  int? _selectedTriggerIndex;

  final List<String> _triggers = [
    'Someone said something',
    'Disrespect',
    'Frustration',
    'Injustice',
    'Stress overload',
    "I don't know",
  ];

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
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.psychology_outlined,
                                color: AppColors.textLiteBlue,
                                size: 24,
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Text(
                                'ANGER TAMER',
                                style: TextStyle(
                                  color: AppColors.textLiteBlue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          // Simple Circular Progress Badge
                          const SessionProgressBadge(
                            currentSessions: 2,
                            totalSessions: 10,
                            size: 60,
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              'THE NOT YOU',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPill('QUICK COOLDOWN (2 MIN)'),
                                SizedBox(width: screenWidth * 0.025),
                                _buildPill(
                                  'VOICE GUIDED',
                                  icon: Icons.graphic_eq_rounded,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.05),

                      // --- Title & Description ---
                      const Text(
                        'What triggered your\nanger?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Naming the trigger helps shift control back to\nthe thinking part of your mind.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.035),

                      // List
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _triggers.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          return _buildTriggerCard(index, _triggers[index]);
                        },
                      ),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedTriggerIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const AngerIntensityScreen(),
                                  ),
                                );
                              }
                            : () {},
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
      // bottomNavigationBar: const CustomBottomNavBar(),
      // extendBody: true,
    );
  }

  Widget _buildPill(String text, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.textLiteBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.textLiteBlue, size: 14),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: TextStyle(
              color: AppColors.textLiteBlue,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerCard(int index, String title) {
    final isSelected = _selectedTriggerIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTriggerIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.textLiteBlue.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.25),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.textLiteBlue
                : AppColors.textPrimary.withOpacity(0.3),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withOpacity(0.9),
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
}
