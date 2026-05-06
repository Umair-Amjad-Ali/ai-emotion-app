import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/screen/restfullmind/final_night_screen.dart';

class FinalThoughtScreen extends StatefulWidget {
  const FinalThoughtScreen({super.key});

  @override
  State<FinalThoughtScreen> createState() => _FinalThoughtScreenState();
}

class _FinalThoughtScreenState extends State<FinalThoughtScreen> {
  String? _selectedThought;

  final List<String> _thoughts = [
    'Tomorrow can wait.',
    'The mind can rest.',
    'The day is complete.',
    'Let sleep come naturally.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.bgDark,
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              ScreenHeader(
                title: 'Choose tonight\'s\nfinal thought',
                subtitle: 'This becomes the last mental message\nbefore rest.',
              ),
              Expanded(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                  itemCount: _thoughts.length,
                  itemBuilder: (context, index) {
                    return _buildThoughtOption(_thoughts[index]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: PrimaryButton(
                  text: 'FINISH',
                  height: 60,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const FinalNightScreen()));
                  },
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildThoughtOption(String text) {
    final bool isSelected = _selectedThought == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedThought = text;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xff1B1F2E).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                fontWeight: FontWeight.w500, // Keep font weight constant
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xff7FD6FF)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
