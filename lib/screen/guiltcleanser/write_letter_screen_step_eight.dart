import 'package:ai_emotion_app/screen/guiltcleanser/mind_feel_screen_step_nine.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';

class WriteLetterScreenStepEight extends StatefulWidget {
  const WriteLetterScreenStepEight({super.key});

  @override
  State<WriteLetterScreenStepEight> createState() =>
      _WriteLetterScreenStepEightState();
}

class _WriteLetterScreenStepEightState
    extends State<WriteLetterScreenStepEight> {
  // Track selected action option
  int? _selectedActionIndex;

  // Controller for the letter input
  final TextEditingController _letterController = TextEditingController();

  // Data for the action options
  final List<Map<String, dynamic>> _actions = [
    {
      'icon': Icons.lock_outline_rounded,
      'title': 'Save privately',
      'subtitle': 'Keep this message in your personal vault',
      'iconColor': Colors.white54,
    },
    {
      'icon': Icons.wind_power_outlined,
      'title': 'Cleanse and release',
      'subtitle': 'Symbolically release this weight',
      'iconColor': const Color(0xFFE28B78),
      'imagePath': 'assets/pngs/air.png',
    },
    {
      'icon': Icons.auto_awesome_rounded,
      'title': 'Convert into commitment',
      'subtitle': 'Turn these words into positive action',
      'iconColor': AppColors.accentBlueLite,
    },
  ];

  @override
  void dispose() {
    _letterController.dispose();
    super.dispose();
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlueLite.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'STEP 8 OF 10',
                          style: TextStyle(
                            color: AppColors.accentBlueLite,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Write what you\nwish you could say',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'This can be an apology, confession,\ntruth, or self-forgiveness statement.',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Container(
                        height: 280,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                            width: 2.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // TextField
                            TextField(
                              controller: _letterController,
                              maxLines: null,
                              expands: true,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 16,
                                height: 1.5,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Your letter will appear here.',
                                hintStyle: TextStyle(
                                  color: AppColors.textPrimary.withOpacity(0.3),
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.water_drop_outlined,
                                    color: AppColors.textPrimary.withOpacity(
                                      0.3,
                                    ),
                                    size: 10,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'FLOWING STATE',
                                    style: TextStyle(
                                      color: AppColors.textPrimary.withOpacity(
                                        0.3,
                                      ),
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),
                      ...List.generate(
                        _actions.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildActionCard(
                            index: index,
                            icon: _actions[index]['icon'],
                            title: _actions[index]['title'],
                            subtitle: _actions[index]['subtitle'],
                            iconColor: _actions[index]['iconColor'],
                            imagePath: _actions[index]['imagePath'],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedActionIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const MindFeelScreenStepNine(),
                                  ),
                                );
                              }
                            : () {},
                      ),
                      SizedBox(height: screenHeight * 0.12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      extendBody: true,
    );
  }

  Widget _buildActionCard({
    required int index,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    String? imagePath,
  }) {
    final isSelected = _selectedActionIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedActionIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? iconColor.withOpacity(0.4)
                : Colors.white.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 15,
              right: 15,
              child: Container(
                height: 0.5,
                decoration: BoxDecoration(
                  color: isSelected
                      ? iconColor.withOpacity(0.1)
                      : Colors.white.withOpacity(0.1),
                  // THIS ADDS THE CURVE TO THE ENDS OF THE LINE:
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(2),
                    bottomRight: Radius.circular(2),
                  ),
                ),
              ),
            ),

            // --- MAIN CONTENT ---
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon / Image
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: iconColor.withOpacity(0.2)),
                      ),
                      child: imagePath != null
                          ? Image.asset(
                              imagePath,
                              width: 20,
                              height: 20,
                              fit: BoxFit.contain,
                            )
                          : Icon(icon, color: iconColor, size: 20),
                    ),
                    const SizedBox(height: 12),
                    // Title
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Subtitle
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.textPrimary.withOpacity(0.5),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
