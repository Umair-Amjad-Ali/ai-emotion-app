import 'dart:ui';

import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/circular_timer.dart';
import '../../widgets/primary_button.dart';

class ToxicThoughtDetectorScreen extends StatefulWidget {
  const ToxicThoughtDetectorScreen({super.key});

  @override
  State<ToxicThoughtDetectorScreen> createState() =>
      _ToxicThoughtDetectorScreenState();
}

class _ToxicThoughtDetectorScreenState
    extends State<ToxicThoughtDetectorScreen> {
  final Set<String> _selectedToxins = {};

  void _toggleToxin(String toxin) {
    setState(() {
      _selectedToxins.add(toxin);
    });
  }

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
                          const CircularTimer(),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      Text(
                        'Which toxins are active\ntoday?',
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
                        'Select one or more thought toxins.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      SizedBox(
                        height: screenHeight * 0.35,
                        width: double.infinity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(0, 10),
                              child: Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.accentBlueLite.withOpacity(
                                    0.15,
                                  ),
                                  border: Border.all(
                                    color: AppColors.accentBlueLite.withOpacity(
                                      0.3,
                                    ),
                                    width: 1.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.accentBlueLite
                                          .withOpacity(0.2),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'M I N D',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            _buildToxinBubble(
                              id: 'replay',
                              label: 'replay',
                              size: 65,
                              offset: const Offset(-110, 0),
                            ),
                            _buildToxinBubble(
                              id: 'worry',
                              label: 'worry',
                              size: 85,
                              offset: const Offset(-60, -90),
                            ),

                            _buildToxinBubble(
                              id: 'criticism',
                              label: 'criticism',
                              size: 100,
                              offset: const Offset(-55, 90),
                            ),
                            _buildToxinBubble(
                              id: 'regret',
                              label: 'regret',
                              size: 90,
                              offset: const Offset(85, -30),
                            ),
                            _buildToxinBubble(
                              id: 'prediction',
                              label: 'prediction',
                              size: 75,
                              offset: const Offset(90, 70),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      _buildBottomPanel(),
                      SizedBox(height: screenHeight * 0.12),
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

  Widget _buildToxinBubble({
    required String id,
    required String label,
    required double size,
    required Offset offset,
  }) {
    final isSelected = _selectedToxins.contains(id);

    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        onTap: () => _toggleToxin(id),
        child: AnimatedScale(
          scale: isSelected ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInBack,
          child: AnimatedOpacity(
            opacity: isSelected ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.bgDark.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.accentBlueLite.withOpacity(0.15),
                        width: 1.0,
                      ),
                      color: AppColors.accentBlueLite.withOpacity(0.25),
                    ),
                    child: Center(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Bottom Control Panel ---
  Widget _buildBottomPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SELECTED: ${_selectedToxins.length}',
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedToxins.clear();
                  });
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          PrimaryButton(text: 'CONTINUE', onPressed: () {}),
        ],
      ),
    );
  }
}
