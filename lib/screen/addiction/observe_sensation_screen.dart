import 'package:ai_emotion_app/widgets/gentle_reminder_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/sensation_selection_card.dart';

class ObserveSensationScreen extends StatefulWidget {
  const ObserveSensationScreen({super.key});

  @override
  State<ObserveSensationScreen> createState() => _ObserveSensationScreenState();
}

class _ObserveSensationScreenState extends State<ObserveSensationScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _sensations = [
    {
      'title': 'Body\nTension',
      'subtitle': 'Physical tightness',
      'icon': Icons.bolt,
    },
    {
      'title': 'Restlessness',
      'subtitle': 'Unable to sit still',
      'icon': Icons.waves,
    },
    {
      'title': 'Racing\nThoughts',
      'subtitle': 'Fast-paced mind',
      'icon': Icons.psychology_outlined,
    },
    {
      'title': 'Emotional\nPressure',
      'subtitle': 'Internal weight',
      'icon': Icons.favorite_border_rounded,
    },
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
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        label: 'Interruption',
                        title: 'Observe The\nSensation',
                        subtitle: 'Where do you feel the urge?',
                      ),

                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.0,
                            ),
                        itemCount: _sensations.length,
                        itemBuilder: (context, index) {
                          return SensationSelectionCard(
                            title: _sensations[index]['title'],
                            subtitle: _sensations[index]['subtitle'],
                            icon: _sensations[index]['icon'],
                            isSelected: _selectedIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      CustomReminderCard(
                        title: 'GENTLE REMINDER',
                        icon: Icons.lightbulb_outline,
                        description:
                            '"Physical sensations are just signals. They will pass as you observe them."',
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

                      SizedBox(height: screenHeight * 0.12),
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
}
