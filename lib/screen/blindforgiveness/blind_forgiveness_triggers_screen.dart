import 'package:ai_emotion_app/screen/blindforgiveness/memory_fragments_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class BlindForgivenessTriggersScreen extends StatefulWidget {
  const BlindForgivenessTriggersScreen({super.key});

  @override
  State<BlindForgivenessTriggersScreen> createState() =>
      _BlindForgivenessTriggersScreenState();
}

class _BlindForgivenessTriggersScreenState
    extends State<BlindForgivenessTriggersScreen> {
  int? _selectedTriggerIndex;

  final List<Map<String, dynamic>> _triggers = [
    {
      'title': 'Someone hurt me\ndeeply',
      'icon': Icons.heart_broken_rounded,
      'imagePath': 'assets/pngs/hurt.png',
    },
    {
      'title': 'Someone betrayed my\ntrust',
      'icon': Icons.gpp_bad_outlined,
      'imagePath': 'assets/pngs/lock.png',
    },
    {
      'title': 'Someone disrespected\nme',
      'icon': Icons.person_off_outlined,
      'imagePath': 'assets/pngs/me.png',
    },
    {
      'title': 'I replay something that\nhappened',
      'icon': Icons.history_rounded,
    },
    {
      'title': 'I feel resentment toward\nsomeone',
      'icon': Icons.sentiment_very_dissatisfied_rounded,
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
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.04),

                      Text(
                        'What is still pulling\non you?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      Text(
                        'NAME THE KIND OF WOUND\nFIRST.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: screenWidth * 0.032,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _triggers.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: screenHeight * 0.01),
                        itemBuilder: (context, index) {
                          return _buildTriggerOption(
                            index: index,
                            title: _triggers[index]['title'],
                            icon: _triggers[index]['icon'],
                            imagePath: _triggers[index]['imagePath'],
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedTriggerIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MemoryFragmentsScreen(),
                                  ),
                                );
                              }
                            : () {},
                      ),

                      SizedBox(height: screenHeight * 0.15),
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

  Widget _buildTriggerOption({
    required int index,
    required String title,
    required IconData icon,
    String? imagePath,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = _selectedTriggerIndex == index;

    // Alternating color logic:
    // Even indexes (0, 2, 4 -> 1st, 3rd, 5th items) get Blue
    // Odd indexes (1, 3 -> 2nd, 4th items) get Peach/Red
    final Color itemColor = index % 2 == 0
        ? AppColors.textLiteBlue
        : AppColors.peachAccent;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTriggerIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? itemColor.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? itemColor.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.035),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? itemColor.withOpacity(0.25)
                    : itemColor.withOpacity(0.15),
              ),
              child: imagePath != null
                  ? Image.asset(
                      imagePath,
                      color: itemColor,
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                    )
                  : Icon(icon, color: itemColor, size: screenWidth * 0.06),
            ),

            SizedBox(width: screenWidth * 0.05),

            // Text Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withOpacity(0.9),
                  fontSize: screenWidth * 0.038,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
