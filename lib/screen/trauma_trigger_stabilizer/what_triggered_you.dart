import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class WhatTriggeredYouScreen extends StatefulWidget {
  const WhatTriggeredYouScreen({super.key});

  @override
  State<WhatTriggeredYouScreen> createState() => _WhatTriggeredYouScreenState();
}

class _WhatTriggeredYouScreenState extends State<WhatTriggeredYouScreen> {
  String? _selectedTrigger;

  final List<Map<String, dynamic>> _triggers = [
    {'text': 'Someone\'s words', 'icon': Icons.chevron_right_rounded},
    {'text': 'A memory', 'icon': Icons.chevron_right_rounded},
    {'text': 'A place or environment', 'icon': Icons.chevron_right_rounded},
    {'text': 'A relationship situation', 'icon': Icons.chevron_right_rounded},
    {'text': 'I\'m not sure', 'icon': Icons.help_outline_rounded},
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
                      title: 'What triggered\nyou?',
                      subtitle:
                          'Keep it simple. Naming the trigger helps\ninterrupt the nervous system surge.',
                    ),
                    ..._triggers.map(
                      (trigger) => _buildTriggerOption(
                        trigger['text'] as String,
                        trigger['icon'] as IconData,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildImageCard(),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: 'CONTINUE',
                      height: 60,
                      onPressed: () {
                        // Handle navigation
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

  Widget _buildTriggerOption(String text, IconData defaultIcon) {
    final bool isSelected = _selectedTrigger == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTrigger = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: AppColors.cardLikePillBg.withOpacity(0.6),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: 1.5,
          ),
          // To implement the blue left border line effect as seen in the image
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(-5, 0),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.9),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.accentBlueLite,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.cardLikePillBg,
                  size: 16,
                ),
              )
            else
              SizedBox(
                width: 24,
                height: 24,
                child: Icon(
                  defaultIcon,
                  color: AppColors.textPrimary.withOpacity(0.3),
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/pngs/what_triggered_you.png'),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: AppColors.textPrimary.withOpacity(0.05),
          width: 1,
        ),
      ),
    );
  }
}
