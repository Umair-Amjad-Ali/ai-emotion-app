import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

class PainAttachmentScreenStepFive extends StatefulWidget {
  const PainAttachmentScreenStepFive({super.key});

  @override
  State<PainAttachmentScreenStepFive> createState() =>
      _PainAttachmentScreenStepFiveState();
}

class _PainAttachmentScreenStepFiveState
    extends State<PainAttachmentScreenStepFive> {
  int? _selectedIndex;
  final List<Map<String, dynamic>> _options = [
    {
      'icon': Icons.bolt_rounded,
      'title': 'My action',
      'subtitle': 'Attaching the pain to something\n I did',
    },
    {
      'icon': Icons.person_outline_rounded,
      'title': 'Who I believe I am',
      'subtitle': 'Attaching the pain to my\ncore essence',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.06),

                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // Ambient glow behind the icon
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.accentBlueLite.withOpacity(
                                  0.15,
                                ),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              Icons.spa_outlined,
                              color: AppColors.accentBlueLite.withOpacity(0.8),
                              size: 40,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // --- Main Title ---
                      Text(
                        'What is this pain\nattached to?',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),

                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.6),
                            fontSize: 14,
                            height: 1.5,
                          ),
                          children: const [
                            TextSpan(
                              text: 'If it is attached to identity, the ',
                            ),
                            TextSpan(
                              text: 'Shame\nBreaker',
                              style: TextStyle(
                                color: Color(0xFFE28B78),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: ' sequence activates.'),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Options List ---
                      ...List.generate(
                        _options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildOptionCard(
                            index: index,
                            icon: _options[index]['icon'],
                            title: _options[index]['title'],
                            subtitle: _options[index]['subtitle'],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null ? () {} : () {},
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

  // --- Interactive Selection Card ---
  Widget _buildOptionCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
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
              : AppColors.cardLikePillBg.withOpacity(0.15),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container (Left)
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.accentBlueLite.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Icon(
                icon,
                color: AppColors.textPrimary.withOpacity(0.6),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),

            // Text Content (Middle)
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
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.5),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentBlueLite
                      : AppColors.textPrimary.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentBlueLite,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
