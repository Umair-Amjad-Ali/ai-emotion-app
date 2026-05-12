import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ChooseASafePlaceScreen extends StatefulWidget {
  const ChooseASafePlaceScreen({super.key});

  @override
  State<ChooseASafePlaceScreen> createState() => _ChooseASafePlaceScreenState();
}

class _ChooseASafePlaceScreenState extends State<ChooseASafePlaceScreen> {
  int _selectedIndex = 0;

  final List<_SafePlace> _places = const [
    _SafePlace(label: 'Forest', icon: Icons.park_outlined),
    _SafePlace(label: 'Beach', icon: Icons.sailing_outlined),
    _SafePlace(label: 'Mountain', icon: Icons.landscape_outlined),
    _SafePlace(label: 'Quiet\nroom', icon: Icons.meeting_room_outlined),
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
                      title: 'Choose a safe place',
                      subtitle:
                          'Select the environment that feels most\nstabilizing right now.',
                    ),
                    const SizedBox(height: 12),
                    _buildPlacesGrid(),

                    PrimaryButton(
                      text: 'CONTINUE',
                      height: 60,
                      onPressed: () {
                        // Handle navigation to next screen
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

  Widget _buildPlacesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.05,
      ),
      itemCount: _places.length,
      itemBuilder: (context, index) {
        return _buildPlaceCard(index);
      },
    );
  }

  Widget _buildPlaceCard(int index) {
    final place = _places[index];
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.06)
              : AppColors.cardLikePillBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.6)
                : AppColors.glassCardBorder,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.accentBlueLite.withOpacity(0.15),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.accentBlueLite.withOpacity(0.12)
                    : AppColors.glassCardBg,
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentBlueLite.withOpacity(0.3)
                      : AppColors.textPrimary.withOpacity(0.04),
                  width: 1.0,
                ),
              ),
              child: Icon(
                place.icon,
                color: isSelected
                    ? AppColors.accentBlueLite
                    : AppColors.textPrimary.withOpacity(0.5),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            // Label
            Text(
              place.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withOpacity(0.6),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data model for a safe place option.
class _SafePlace {
  final String label;
  final IconData icon;

  const _SafePlace({required this.label, required this.icon});
}
