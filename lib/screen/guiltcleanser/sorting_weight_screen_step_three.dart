import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

class SortingWeightScreenStepThree extends StatefulWidget {
  const SortingWeightScreenStepThree({super.key});

  @override
  State<SortingWeightScreenStepThree> createState() =>
      _SortingWeightScreenStepThreeState();
}

class _SortingWeightScreenStepThreeState
    extends State<SortingWeightScreenStepThree> {
  // Track the selected statement index
  int? _selectedIndex;

  // The statements presented to the user
  final List<String> _statements = [
    '"This happened because of many factors, not just my actions."',
    '"I made a mistake, but I am still a good person capable of growth."',
    '"I cannot change the past, but I can choose how I respond now."',
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
                        'SORTING THE WEIGHT',
                        style: TextStyle(
                          color: AppColors.accentBlueLite.withOpacity(0.8),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // --- Main Title ---
                      Text(
                        'Which statement feels\nclosest to the truth?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Vertical Graphic (Over-blame -> Responsibility) ---
                      _buildFlowGraphic(),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Options List ---
                      ...List.generate(
                        _statements.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildStatementOption(
                            index: index,
                            text: _statements[index],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        // Optional: Only enable if an option is selected
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

  Widget _buildFlowGraphic() {
    return Column(
      children: [
        // Top "Over-blame" Pill (Faded)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.cardLikePillBg.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.cloud_outlined,
                color: AppColors.textPrimary.withOpacity(0.4),
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                'OVER-BLAME',
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.4),
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),

        // Connecting Vertical Line
        Container(width: 1, height: 30, color: Colors.white.withOpacity(0.1)),

        // Bottom "Real Responsibility" Circle (Glowing at the top)
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cardLikePillBg.withOpacity(0.1),
            border: Border.all(
              color: AppColors.accentBlueLite.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              // Cyan Glow pushed UPWARDS using Offset
              BoxShadow(
                color: AppColors.accentBlueLite.withOpacity(0.35),
                blurRadius: 70,
                spreadRadius: 15,
                offset: const Offset(0, -35),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.filter_center_focus,
                color: AppColors.accentBlueLite,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                'REAL\nRESPONSIBILITY',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.9),
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Interactive Radio Button List Item ---
  Widget _buildStatementOption({required int index, required String text}) {
    final isSelected = _selectedIndex == index;

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
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Custom Radio Button Visual
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 20,
              height: 20,
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
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  height: 1.4, // Gives breathing room to multi-line quotes
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
