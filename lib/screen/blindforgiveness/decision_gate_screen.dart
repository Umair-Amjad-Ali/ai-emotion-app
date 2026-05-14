import 'package:ai_emotion_app/screen/blindforgiveness/break_emotional_chain_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class DecisionGateScreen extends StatefulWidget {
  const DecisionGateScreen({super.key});

  @override
  State<DecisionGateScreen> createState() => _DecisionGateScreenState();
}

class _DecisionGateScreenState extends State<DecisionGateScreen> {
  int? _selectedIndex = 0;

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

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.accentBlueLite.withOpacity(0.08),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.15),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentBlueLite.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/pngs/bran_left.png',
                          width: 36,
                          height: 36,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      const Text(
                        'What do you want\nto do with the\nchain?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'This is the turning point.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _buildChoiceCard(
                        index: 0,
                        title: 'Release the chain',
                        subtitle:
                            'Choose liberation and let go of the\nemotional weight that holds you back.',
                        image: 'assets/pngs/flower.png',
                        activeColor: AppColors.peachAccent,
                        isRecommended: true,
                        screenWidth: screenWidth,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildChoiceCard(
                        index: 1,
                        title: 'Hold onto the anger',
                        subtitle:
                            'Maintain your current stance.\nAcknowledge the feeling without letting go just yet.',
                        icon: Icons.lock_outline_rounded,
                        activeColor: AppColors.textSecondary,
                        screenWidth: screenWidth,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildVisualizationCard(screenHeight),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BreakEmotionalChainScreen(),
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

  Widget _buildChoiceCard({
    required int index,
    required String title,
    required String subtitle,
    IconData? icon,
    String? image,
    required Color activeColor,
    bool isRecommended = false,
    required double screenWidth,
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
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.08)
              : AppColors.cardLikePillBg.withOpacity(0.4),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? activeColor.withOpacity(0.5)
                : Colors.white.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.05),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Icon Container
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? activeColor.withOpacity(0.15)
                        : Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: image?.isNotEmpty ?? false
                      ? Image.asset(
                          image!,
                          color: isSelected ? activeColor : Colors.white60,
                          width: 20,
                          height: 20,
                        )
                      : Icon(
                          icon,
                          color: isSelected ? activeColor : Colors.white60,
                          size: 20,
                        ),
                ),
                const SizedBox(width: 12),

                if (isRecommended)
                  Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: activeColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisualizationCard(double screenHeight) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.08),
          width: 1.0,
        ),
        image: DecorationImage(
          image: const AssetImage('assets/pngs/decision_visuals.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.bgDark.withOpacity(0.35),
            BlendMode.srcOver,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.bgDark.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * 0.07),
          Text(
            'VISUALIZATION',
            style: TextStyle(
              color: AppColors.accentBlueLite,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Imagine the chain dissolving into light as you\nbreathe.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
