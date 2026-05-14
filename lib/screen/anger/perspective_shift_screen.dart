import 'package:ai_emotion_app/screen/anger/breathing_guide_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class PerspectiveShiftScreen extends StatefulWidget {
  const PerspectiveShiftScreen({super.key});

  @override
  State<PerspectiveShiftScreen> createState() => _PerspectiveShiftScreenState();
}

class _PerspectiveShiftScreenState extends State<PerspectiveShiftScreen> {
  int? _selectedIndex;

  final List<Map<String, dynamic>> _options = [
    {
      'title': 'Yes',
      'subtitle': 'IT HAS LONG-TERM IMPACT',
      'icon': Icons.check_circle_outline_rounded,
    },
    {
      'title': 'No',
      'subtitle': 'THIS IS A TEMPORARY STORM',
      'icon': Icons.cancel_outlined,
    },
    {
      'title': 'Not sure',
      'subtitle': 'PROCESSING MY PERSPECTIVE',
      'icon': Icons.help_outline_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.01),

                      // --- Top Pill Label ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.accentBlue,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.015),
                            const Text(
                              'PERSPECTIVE SHIFT',
                              style: TextStyle(
                                color: AppColors.lightDarkText,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      const Text(
                        'Will this matter in 24\nhours?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.012),
                      Text(
                        'Distance reduces emotional distortion.\nChoose the most honest answer.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // --- Selection List ---
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _options.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: screenHeight * 0.015),
                        itemBuilder: (context, index) {
                          return _buildOptionCard(
                            index: index,
                            title: _options[index]['title'],
                            subtitle: _options[index]['subtitle'],
                            icon: _options[index]['icon'],
                            screenWidth: screenWidth,
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const BreathingGuideScreen(),
                                  ),
                                );
                              }
                            : () {},
                      ),

                      SizedBox(height: screenHeight * 0.04),
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

  // Custom Option Card Builder
  Widget _buildOptionCard({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required screenWidth,
  }) {
    final isSelected = _selectedIndex == index;
    final highlightColor = AppColors.accentBlueLite;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? highlightColor.withOpacity(0.08)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? highlightColor.withOpacity(0.8)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              children: [
                // Left Icon Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: isSelected
                        ? highlightColor.withOpacity(0.2)
                        : Colors.white.withOpacity(0.05),
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? highlightColor
                        : AppColors.lightDarkText,
                    size: screenWidth * 0.05,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),

                // Texts
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
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: isSelected
                              ? highlightColor
                              : AppColors.lightDarkText,
                          fontSize: screenWidth * 0.025,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                // Right Checkmark (Only when selected)
                if (isSelected)
                  Icon(Icons.check_rounded, color: highlightColor, size: 24),
              ],
            ),

            if (isSelected)
              Positioned(
                top: -12,
                right: -4,
                child: Icon(
                  Icons.star_rounded,
                  color: highlightColor,
                  size: 16,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
