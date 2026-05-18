import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

class HonestFeelingScreen extends StatefulWidget {
  const HonestFeelingScreen({super.key});

  @override
  State<HonestFeelingScreen> createState() => _HonestFeelingScreenState();
}

class _HonestFeelingScreenState extends State<HonestFeelingScreen> {
  int? _selectedIndex;

  final List<Map<String, dynamic>> _feelings = [
    {
      'icon': Icons.history_rounded,
      'title': 'I regret something I did',
      'subtitle': 'Looking back on actions taken',
      'iconColor': AppColors.accentBlueLite,
    },
    {
      'icon': Icons.person_off_outlined,
      'title': 'I feel unworthy',
      'subtitle': 'Struggling with self-value',
      'iconColor': const Color(0xFFFCA5A5),
    },
    {
      'icon': Icons.heart_broken_rounded,
      'title': 'I failed someone',
      'subtitle': 'A feeling of letting others down',
      'iconColor': const Color(0xFFFCD34D),
      'imagePath': 'assets/pngs/hurt2.png',
    },
    {
      'icon': Icons.lock_outline_rounded,
      'title': 'I am hiding a secret',
      'subtitle': 'Carrying an unspoken truth',
      'iconColor': Colors.white54,
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
                      SizedBox(height: screenHeight * 0.01),

                      // --- Pre-title ---
                      Text(
                        'HONESTY IS THE FIRST STEP',
                        style: TextStyle(
                          color: AppColors.accentBlueLite.withOpacity(0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // --- Main Title ---
                      Text(
                        'What are you feeling\nmost right now?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      // --- Central Graphic (Image WITH Blur Shadow) ---
                      Center(
                        child: Container(
                          width: 340,
                          height: 340,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentBlueLite.withOpacity(
                                  0.15,
                                ),
                                blurRadius: 90,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/pngs/circular_orb.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),
                      ...List.generate(
                        _feelings.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildFeelingOption(
                            index: index,
                            icon: _feelings[index]['icon'],
                            title: _feelings[index]['title'],
                            subtitle: _feelings[index]['subtitle'],
                            iconColor: _feelings[index]['iconColor'],
                            imagePath: _feelings[index]['imagePath'],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null ? () {} : () {},
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
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildFeelingOption({
    required int index,
    IconData? icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    String? imagePath,
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
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? iconColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Icon / Image Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: iconColor.withOpacity(0.1)),
              ),
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      width: 18,
                      height: 18,
                      fit: BoxFit.contain,
                    )
                  : Icon(icon, color: iconColor, size: 22),
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
          ],
        ),
      ),
    );
  }
}
