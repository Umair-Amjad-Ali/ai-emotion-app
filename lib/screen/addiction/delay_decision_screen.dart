import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class DelayDecisionScreen extends StatefulWidget {
  const DelayDecisionScreen({super.key});

  @override
  State<DelayDecisionScreen> createState() => _DelayDecisionScreenState();
}

class _DelayDecisionScreenState extends State<DelayDecisionScreen> {
  int? _selectedIndex;

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
                    children: [
                      const ScreenHeader(
                        label: 'Interuption',
                        title: 'Delay Decision',
                        subtitle: 'Clarity emerges in the spaces\nbetween.',
                      ),

                      // --- Action Cards ---
                      _buildActionCard(
                        index: 0,
                        title: 'Yes (I can wait)',
                        subtitle: 'Commit to reflection.',
                        icon: Icons.check_circle_rounded,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      _buildActionCard(
                        index: 1,
                        title: 'Delay 2 Minutes',
                        subtitle: 'Just a short pause.',
                        icon: Icons.timer_rounded,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      // --- Blockquote Reminder Card ---
                      _buildQuoteCard(),

                      SizedBox(height: screenHeight * 0.035),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null ? () {} : () {},
                      ),

                      SizedBox(height: screenHeight * 0.11),
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

  Widget _buildActionCard({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = _selectedIndex == index;
    const highlightColor = AppColors.cardBackgroundColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isSelected
              ? highlightColor.withOpacity(0.1)
              : AppColors.darkCardBg,
          border: Border.all(
            color: isSelected
                ? highlightColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.09),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            // Icon in a circle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? highlightColor.withOpacity(0.2)
                    : AppColors.textPrimary.withOpacity(0.05),
              ),
              child: Icon(
                icon,
                color: isSelected ? highlightColor : AppColors.textSecondary,
                size: 20,
              ),
            ),

            SizedBox(width: screenWidth * 0.04),

            // Text Group
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Trailing Chevron
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.3),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  // --- Specialized Quote Reminder Card ---
  Widget _buildQuoteCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xB20C1222),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Label
          Row(
            children: [
              Icon(Icons.auto_awesome, color: AppColors.textLiteBlue, size: 14),
              const SizedBox(width: 8),
              Text(
                'GENTLE REMINDER',
                style: TextStyle(
                  color: AppColors.textLiteBlue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            "Clarity isn't found in speed.",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),

          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 2,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '"The space between stimulus and response is where our power and freedom lie."',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Bottom Community Stats Row
          Row(
            children: [
              SizedBox(
                width: 45,
                height: 24,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bgDark, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.blueGrey,
                          child: Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.bgDark, width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.deepOrangeAccent,
                          child: Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '12.4k users paused today',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
