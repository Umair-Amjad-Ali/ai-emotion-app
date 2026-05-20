import 'package:ai_emotion_app/screen/guiltcleanser/pain_attachment_screen_step_five.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

class RepairAssessmentScreenStepFour extends StatefulWidget {
  const RepairAssessmentScreenStepFour({super.key});

  @override
  State<RepairAssessmentScreenStepFour> createState() =>
      _RepairAssessmentScreenStepFourState();
}

class _RepairAssessmentScreenStepFourState
    extends State<RepairAssessmentScreenStepFour> {
  // Track selected option
  int? _selectedIndex;

  // Data for the repair options
  final List<Map<String, dynamic>> _options = [
    {
      'icon': Icons.handshake_outlined,
      'title': 'Yes, with direct action',
      'subtitle': 'Active apology or restitution',
      'iconColor': AppColors.accentBlueLite,
    },
    {
      'icon': Icons.model_training_rounded,
      'title': 'Only through self-change',
      'subtitle': 'Lessons learned for future paths',
      'iconColor': AppColors.accentBlueLite,
      'imagePath': 'assets/pngs/self.png',
    },
    {
      'icon': Icons.timer_off_outlined,
      'title': 'No, it\'s permanently gone',
      'subtitle': 'Focusing on radical acceptance',
      'iconColor': AppColors.accentBlueLite,
    },
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
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cardLikePillBg.withOpacity(0.2),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.15),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentBlueLite.withOpacity(0.15),
                              blurRadius: 25,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color: AppColors.accentBlueLite.withOpacity(0.9),
                            size: 32,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Main Title ---
                      Text(
                        'Can anything still be\nrepaired?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // --- Subtitle ---
                      Text(
                        'This step distinguishes accountability from\nendless punishment.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      ...List.generate(
                        _options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildOptionCard(
                            index: index,
                            icon: _options[index]['icon'],
                            title: _options[index]['title'],
                            subtitle: _options[index]['subtitle'],
                            iconColor: _options[index]['iconColor'],
                            imagePath: _options[index]['imagePath'],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const PainAttachmentScreenStepFive(),
                                  ),
                                );
                              }
                            : () {},
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

  // --- Interactive Selection Card ---
  Widget _buildOptionCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    String? imagePath,
  }) {
    final isSelected = _selectedIndex == index;
    AppColors.textPrimary.withOpacity(0.5);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.4)
                : Colors.white.withOpacity(0.08),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon / Image Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentBlueLite.withOpacity(0.1)
                    : Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentBlueLite.withOpacity(0.3)
                      : Colors.white.withOpacity(0.1),
                ),
              ),
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      width: 22,
                      height: 22,
                      fit: BoxFit.contain,
                    )
                  : Icon(
                      icon,
                      color: isSelected ? AppColors.accentBlueLite : iconColor,
                      size: 22,
                    ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? AppColors.textPrimary
                          : AppColors.textPrimary.withOpacity(0.9),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.5),
                      fontSize: 11,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            // Chevron Arrow
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textPrimary.withOpacity(0.3),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
