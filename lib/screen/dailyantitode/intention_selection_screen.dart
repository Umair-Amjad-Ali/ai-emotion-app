import 'package:ai_emotion_app/screen/dailyantitode/mental_shield_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart';
import '../../widgets/primary_button.dart';

class IntentionSelectionScreen extends StatefulWidget {
  const IntentionSelectionScreen({super.key});

  @override
  State<IntentionSelectionScreen> createState() =>
      _IntentionSelectionScreenState();
}

class _IntentionSelectionScreenState extends State<IntentionSelectionScreen> {
  // Track which intention is selected (null means nothing selected yet)
  int? _selectedIndex;

  final List<String> _intentions = [
    'Noticing thoughts',
    'Releasing thoughts',
    'Focusing on the present',
    'Observing without reacting',
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
                      SizedBox(height: screenHeight * 0.01),

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

                      SizedBox(height: screenHeight * 0.025),

                      // --- Main Card (Contains Badge, Titles, and Options) ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.cardLikePillBg.withOpacity(
                                  0.2,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                              child: Text(
                                'Antidote Integration',
                                style: TextStyle(
                                  color: AppColors.textPrimary.withOpacity(0.6),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Titles
                            Text(
                              'Choose today\'s antidote\nintention',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Lock in the daily mental practice.',
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.6),
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Intention Options List
                            ...List.generate(
                              _intentions.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: _buildOptionPill(
                                  index: index,
                                  text: _intentions[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        // Optional: Disable button if nothing is selected yet
                        onPressed: _selectedIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MentalShieldScreen(),
                                  ),
                                );
                              }
                            : () {},
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
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  // --- Selectable Intention Pill ---
  Widget _buildOptionPill({required int index, required String text}) {
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          // Using a constant border width prevents the card from "jumping" when selected
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.6)
                : Colors.white.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected
                ? AppColors.textPrimary
                : AppColors.textPrimary.withOpacity(0.8),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
