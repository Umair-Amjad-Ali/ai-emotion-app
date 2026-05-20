import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/screen/mind_clutter/ash_transformation_screen.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ResidualReleaseScreen extends StatefulWidget {
  const ResidualReleaseScreen({super.key});

  @override
  State<ResidualReleaseScreen> createState() => _ResidualReleaseScreenState();
}

class _ResidualReleaseScreenState extends State<ResidualReleaseScreen> {
  String? _selected; // 'yes' | 'no'

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.01),

                      Text(
                        "RESIDUAL RELEASE",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.lightPink,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'Any Part of this\n thought still holding\n on?',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      Text(
                        'Sometimes one last fragment remains.\n Acknowledge it directly instead \n pretending it is gone.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.65),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.6,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _optionPill(
                        keyLabel: 'yes',
                        label: 'Yes, something is still holding on',
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _optionPill(
                        keyLabel: 'no',
                        label: 'No, it feels released',
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AshTransformationScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 120),
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

  Widget _optionPill({required String keyLabel, required String label}) {
    final bool isSelected = _selected == keyLabel;

    return GestureDetector(
      onTap: () => setState(() => _selected = keyLabel),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected
                ? AppColors.textPrimary
                : AppColors.textPrimary.withOpacity(0.8),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
