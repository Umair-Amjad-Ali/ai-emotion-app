import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/glass_card.dart';
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
                      SizedBox(height: screenHeight * 0.02),

                      const Text(
                        'Interruption',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      const Text(
                        'What triggered the\nurge?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Reflecting on the \'why\' helps you\nunderstand the \'how\' to heal.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

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

                      SizedBox(height: screenHeight * 0.02),

                      // --- Gentle Reminder Card ---
                      GlassCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                              ),
                              child: const Icon(
                                Icons.waves,
                                color: Colors.white70,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Gentle Reminder',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Triggers are just signals, not commands. You have the power to observe them without reacting.',
                                    style: TextStyle(
                                      color: Colors.white60,
                                      fontSize: 12,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

                      SizedBox(height: screenHeight * 0.08), // Space for nav bar
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
