import 'package:ai_emotion_app/screen/addiction/urge_intensity_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/urge_selection_card.dart';

// Enum to define the type of session
enum InterruptType { twoMinute, fiveMinute, tenMinute }

class UrgeSelectionScreen extends StatefulWidget {
  final InterruptType sessionType;

  const UrgeSelectionScreen({super.key, required this.sessionType});

  @override
  State<UrgeSelectionScreen> createState() => _UrgeSelectionScreenState();
}

class _UrgeSelectionScreenState extends State<UrgeSelectionScreen> {
  int? _selectedIndex;

  // Dynamic Data Getters based on the sessionType
  String get _timeString {
    switch (widget.sessionType) {
      case InterruptType.twoMinute:
        return '~2 MINS';
      case InterruptType.fiveMinute:
        return '~5 MINS';
      case InterruptType.tenMinute:
        return '~10 MINS';
    }
  }

  String get _titleString {
    switch (widget.sessionType) {
      case InterruptType.twoMinute:
        return '2 Minute Interrupt';
      case InterruptType.fiveMinute:
        return '5 Minute Urge Breaker';
      case InterruptType.tenMinute:
        return '10 Minute Deep Craving Reset';
    }
  }

  String get _reminderText {
    if (widget.sessionType == InterruptType.tenMinute) {
      return 'The urge is a wave. It will peak and then it will pass. Ten minutes of focused recovery is often all it takes to regain control.';
    }
    return 'Urges typically peak within 15 minutes. This quick interrupt helps your brain recalibrate and bridge the gap until the intensity fades.';
  }

  List<Map<String, dynamic>> get _urges {
    // 10-minute session has different subtitles as seen in your screenshot
    if (widget.sessionType == InterruptType.tenMinute) {
      return [
        {'title': 'Alcohol', 'subtitle': 'Step back', 'icon': Icons.wine_bar},
        {'title': 'Smoking', 'subtitle': 'Cool down', 'icon': Icons.air},
        {
          'title': 'Pornography',
          'subtitle': 'Deep reset',
          'icon': Icons.visibility_off_outlined,
        },
        {
          'title': 'Junk Food',
          'subtitle': 'Step back',
          'icon': Icons.fastfood_outlined,
        },
        {
          'title': 'Social Media',
          'subtitle': 'Cool down',
          'icon': Icons.share_outlined,
        },
        {'title': 'Other', 'subtitle': 'Deep reset', 'icon': Icons.more_horiz},
      ];
    }
    // 2-minute and 5-minute share the same list
    return [
      {'title': 'Alcohol', 'subtitle': 'Deep breath', 'icon': Icons.wine_bar},
      {'title': 'Smoking', 'subtitle': 'Fresh air', 'icon': Icons.air},
      {
        'title': 'Pornography',
        'subtitle': 'Visual reset',
        'icon': Icons.visibility_off_outlined,
      },
      {
        'title': 'Junk Food',
        'subtitle': 'Sip water',
        'icon': Icons.fastfood_outlined,
      },
      {
        'title': 'Social Media',
        'subtitle': 'Look away',
        'icon': Icons.share_outlined,
      },
      {'title': 'Other', 'subtitle': 'Acknowledge', 'icon': Icons.more_horiz},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final currentUrges = _urges;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      const Text(
                        'Interruption',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.white54,
                              size: 14,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'TIME TO COMPLETE: $_timeString',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      Text(
                        _titleString,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'What urge are you experiencing?',
                        style: TextStyle(color: Colors.white60, fontSize: 15),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.05,
                            ),
                        itemCount: currentUrges.length,
                        itemBuilder: (context, index) {
                          return UrgeSelectionCard(
                            title: currentUrges[index]['title'],
                            subtitle: currentUrges[index]['subtitle'],
                            icon: currentUrges[index]['icon'],
                            isSelected: _selectedIndex == index,
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      GlassCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    Icons.lightbulb_outline,
                                    color: Colors.white70,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Gentle Reminder',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _reminderText,
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const UrgeIntensityScreen(),
                                  ),
                                );
                              }
                            : () {},
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(),
      // extendBody: true,
    );
  }
}
