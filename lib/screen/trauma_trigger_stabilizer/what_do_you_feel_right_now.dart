import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/in_body.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class WhatDoYouFeelRightNowScreen extends StatefulWidget {
  const WhatDoYouFeelRightNowScreen({super.key});

  @override
  State<WhatDoYouFeelRightNowScreen> createState() =>
      _WhatDoYouFeelRightNowScreenState();
}

class _WhatDoYouFeelRightNowScreenState
    extends State<WhatDoYouFeelRightNowScreen> {
  String? _selectedEmotion;

  final List<String> _emotions = [
    'Fear',
    'Anxiety',
    'Sadness',
    'Anger',
    'Numbness',
    'Confusion',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    const ScreenHeader(
                      title: 'What do you feel\nright now?',
                      subtitle:
                          'Select the strongest emotion. This\ncreates distance between you and the\ntrigger.',
                    ),
                    const SizedBox(height: 32),
                    Center(child: _buildEmotionCircle()),
                    const SizedBox(height: 40),
                    _buildEmotionsGrid(),
                    PrimaryButton(
                      text: 'CONTINUE',
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InBodyScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 120),
                  ],
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

  Widget _buildEmotionCircle() {
    return Container(
      width: 240,
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.cardLikePillBg.withOpacity(0.6),
            AppColors.cardLikePillBg.withOpacity(0.6),
          ],
          radius: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlueLite.withOpacity(0.15),
            blurRadius: 50,
            spreadRadius: 10,
          ),
        ],
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.05),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.auto_awesome,
            color: AppColors.accentBlueLite,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'E M O T I O N',
            style: TextStyle(
              color: AppColors.accentBlueLite,
              fontSize: 12,
              letterSpacing: 6,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmotionsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 2.5,
      ),
      itemCount: _emotions.length,
      itemBuilder: (context, index) {
        return _buildEmotionOption(_emotions[index]);
      },
    );
  }

  Widget _buildEmotionOption(String text) {
    final bool isSelected = _selectedEmotion == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedEmotion = text;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardLikePillBg.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.textPrimary.withOpacity(0.9),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
