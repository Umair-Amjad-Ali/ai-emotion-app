import 'package:ai_emotion_app/widgets/gentle_reminder_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/screen_header.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/trigger_selection_card.dart';

class TriggerAnalysisScreen extends StatefulWidget {
  const TriggerAnalysisScreen({super.key});

  @override
  State<TriggerAnalysisScreen> createState() => _TriggerAnalysisScreenState();
}

class _TriggerAnalysisScreenState extends State<TriggerAnalysisScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _triggers = [
    {'title': 'Stress', 'subtitle': 'Work or pressure', 'icon': Icons.bolt},
    {
      'title': 'Boredom',
      'subtitle': 'Seeking stimulation',
      'icon': Icons.hourglass_empty,
    },
    {
      'title': 'Habit Time',
      'subtitle': 'Routine trigger',
      'icon': Icons.update,
    },
    {
      'title': 'Emotion',
      'subtitle': 'Internal tension',
      'icon': Icons.psychology_outlined,
    },
    {
      'title': 'Environment',
      'subtitle': 'Place or people',
      'icon': Icons.location_on_outlined,
    },
    {'title': 'Other', 'subtitle': 'Acknowledge', 'icon': Icons.more_horiz},
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
                        title: 'What triggered the\nurge?',
                        subtitle:
                            "Reflecting on the 'why' helps you\nunderstand the 'how' to heal.",
                      ),

                      // --- Trigger Selection Grid ---
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.25,
                            ),
                        itemCount: _triggers.length,
                        itemBuilder: (context, index) {
                          return TriggerSelectionCard(
                            title: _triggers[index]['title'],
                            subtitle: _triggers[index]['subtitle'],
                            icon: _triggers[index]['icon'],
                            isSelected: _selectedIndex == index,
                            // Set isCentered to true ONLY for the last 'Other' item
                            isCentered: index == _triggers.length - 1,
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
                        icon: Icons.waves,
                        description:
                            'Triggers are just signals, not commands. You have the power to observe them without reacting.',
                      ),

                      SizedBox(height: screenHeight * 0.035),

                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

                      SizedBox(
                        height: screenHeight * 0.11,
                      ), // Space for nav bar
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
