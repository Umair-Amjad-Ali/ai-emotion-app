import 'package:ai_emotion_app/screen/guiltcleanser/wash_away_identity_screen_step_seven.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/custom_video_player.dart';

class RepairSelfStoryScreenStepSix extends StatefulWidget {
  const RepairSelfStoryScreenStepSix({super.key});

  @override
  State<RepairSelfStoryScreenStepSix> createState() =>
      _RepairSelfStoryScreenStepSixState();
}

class _RepairSelfStoryScreenStepSixState
    extends State<RepairSelfStoryScreenStepSix> {
  String? _selectedOption;

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.03),

                      _buildVideoSection(screenWidth),

                      SizedBox(height: screenHeight * 0.03),

                      Text(
                        'Repair the broken\nself-story',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),

                      // 3. Body Description
                      Text(
                        'Watch the cracked mirror restore itself\nwith gold. You are more than your worst\nmoment.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.65),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      _buildOptionTile(
                        id: 'more_than_moment',
                        label: 'I am more than this moment',
                      ),
                      const SizedBox(height: 12),
                      _buildOptionTile(
                        id: 'action_doesnt_define',
                        label: 'One action does not define me',
                      ),
                      const SizedBox(height: 12),
                      _buildOptionTile(
                        id: 'can_grow',
                        label: 'I can grow beyond this',
                      ),
                      const SizedBox(height: 12),
                      _buildOptionTile(
                        id: 'worthy_of_respect',
                        label: 'I am still worthy of respect',
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const WashAwayIdentityScreenStepSeven(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 120),
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

  // --- Widget Builders ---

  Widget _buildVideoSection(double screenWidth) {
    final double videoHeight = screenWidth * 0.85;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Video Card
          Container(
            width: double.infinity,
            height: videoHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF0D121F),
              borderRadius: BorderRadius.circular(36),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlueLite.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: const CustomVideoPlayer(
                height: double.infinity,
                width: double.infinity,
                videoPath: 'assets/animations/stone.mp4',
                isLooping: true,
              ),
            ),
          ),

          // Floating Sparkle Button (Top Right Overlap)
          Positioned(
            top: -15,
            right: -12,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF33202A),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.05),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.auto_awesome, // Sparkle icon
                color: AppColors.lightPink.withOpacity(
                  0.8,
                ), // Using the pinkish highlight
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile({required String id, required String label}) {
    final bool isSelected = _selectedOption == id;

    return GestureDetector(
      onTap: () => setState(() => _selectedOption = id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentBlueLite.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.accentBlueLite.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Option Text
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Radio Indicator (Right Aligned)
            Container(
              width: 22,
              height: 22,
              margin: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentBlueLite
                      : AppColors.textPrimary.withOpacity(0.4),
                  width: isSelected ? 6 : 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
