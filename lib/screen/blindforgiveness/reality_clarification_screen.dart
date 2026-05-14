import 'package:ai_emotion_app/screen/blindforgiveness/chain_connection_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class RealityClarificationScreen extends StatefulWidget {
  const RealityClarificationScreen({super.key});

  @override
  State<RealityClarificationScreen> createState() =>
      _RealityClarificationScreenState();
}

class _RealityClarificationScreenState
    extends State<RealityClarificationScreen> {
  int? _selectedIndex;

  final List<Map<String, dynamic>> _options = [
    {
      'title': 'No',
      'subtitle': 'DEFINITIVE CLARIFICATION',
      'icon': Icons.close_rounded,
    },
    {
      'title': "I'm not sure",
      'subtitle': 'EXPLORATION NEEDED',
      'icon': Icons.help_outline_rounded,
    },
    {
      'title': 'Yes',
      'subtitle': 'CURRENT PERSPECTIVE',
      'icon': Icons.check_rounded,
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
                    children: [
                      SizedBox(height: screenHeight * 0.01),

                      // --- Top Icon ---
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentBlueLite.withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.fact_check_rounded,
                          color: AppColors.accentBlueLite,
                          size: 24,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // --- Main Title & Subtitle ---
                      const Text(
                        'Does forgiveness\nmean the harm\nwas acceptable?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'This step protects you from confusing\nrelease with approval.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Option Cards ---
                      ListView.separated(
                        padding: EdgeInsets.zero,
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

                      SizedBox(height: screenHeight * 0.03),

                      _buildInsightCard(screenWidth, screenHeight),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ChainConnectionScreen(),
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
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  // --- Option Card Builder ---
  Widget _buildOptionCard({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required double screenWidth,
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? highlightColor.withOpacity(0.08)
              : AppColors.cardLikePillBg.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? highlightColor.withOpacity(0.6)
                : Colors.white.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Left Icon Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? highlightColor.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? highlightColor
                    : AppColors.accentBlueLite.withOpacity(0.6),
                size: 20,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),

            // Middle Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Right Radio Indicator
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? highlightColor
                      : Colors.white.withOpacity(0.2),
                  width: 2,
                ),
                color: isSelected ? highlightColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(Icons.circle, color: Colors.white, size: 8),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // --- Insight Image Card Builder ---
  Widget _buildInsightCard(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1.0),
        // Using a network image placeholder that matches the canyon/abstract vibe
        image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1485470733090-0aae1788d5af?q=80&w=1217&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.darken,
          ),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentBlueLite.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.lightbulb,
                color: AppColors.accentBlueLite,
                size: 20,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Text(
                'Insight: Clarity comes through\ndistinction.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
