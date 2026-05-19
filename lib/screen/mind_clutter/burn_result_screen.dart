import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';

class BurnResultScreen extends StatelessWidget {
  const BurnResultScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      Column(
                        children: [
                          // Glowing Flame Icon
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF1B2236).withOpacity(0.5),
                              border: Border.all(
                                color: AppColors.accentBlueLite.withOpacity(
                                  0.3,
                                ),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.accentBlueLite.withOpacity(
                                    0.15,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.local_fire_department_rounded,
                              color: AppColors.accentBlueLite,
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Headlines
                          const Text(
                            'Your thought has\nbeen burned',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'The clutter has been processed and\nreleased.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // 2. Info Extraction Pills
                      _buildInfoTile(
                        overline: 'SUBJECT',
                        imageAsset: 'assets/pngs/brain_color.png',
                        text: 'Thought burned: Self-criticism',
                      ),
                      _buildInfoTile(
                        overline: 'EXTRACTION',
                        icon: Icons.view_column_outlined,
                        text: 'Fragments destroyed: 0/4',
                      ),
                      _buildInfoTile(
                        overline: 'RELEASE',
                        icon: Icons.balance,
                        text: 'Weight released: 5/10',
                      ),
                      _buildInfoTile(
                        overline: 'POST-RITUAL',
                        icon: Icons.auto_awesome,
                        text: 'Mind state: Much lighter',
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildImageCard(),

                      SizedBox(height: screenHeight * 0.03),

                      // 4. Recent History Section
                      _buildRecentHeader(),
                      const SizedBox(height: 16),
                      _buildHistoryTile(
                        title: 'Past anxieties about tomorrow',
                        time: 'Burned 2 hours ago',
                      ),
                      _buildHistoryTile(
                        title: 'Regret over morning coffee interaction',
                        time: 'Burned 5 hours ago',
                      ),
                      _buildHistoryTile(
                        title: 'Imposter syndrome cycle',
                        time: 'Burned yesterday',
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // 5. Start Again Button
                      PrimaryButton(text: 'START AGAIN', onPressed: () {}),

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

  Widget _buildInfoTile({
    required String overline,
    IconData? icon,
    String? imageAsset,
    required String text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overline,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (imageAsset != null)
                Image.asset(imageAsset, width: 15, height: 15)
              else if (icon != null)
                Icon(icon, color: AppColors.accentBlueLite, size: 18),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageCard() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        image: const DecorationImage(
          // Abstract fluid/ash-like network image as placeholder
          image: AssetImage('assets/pngs/ash.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Dark bottom gradient overlay to make text readable
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),
          // Bottom Left Text
          const Positioned(
            bottom: 16,
            left: 20,
            child: Text(
              'Ashes of the past',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // Bottom Right Text
          Positioned(
            bottom: 20,
            right: 20,
            child: Text(
              'DECOMPOSITION ACTIVE',
              style: TextStyle(
                color: AppColors.accentBlueLite,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Recent burned thoughts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'View All',
            style: TextStyle(
              color: AppColors
                  .lightPink, // Or accentBlueLite depending on your exact theme setup
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryTile({required String title, required String time}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        children: [
          // Circular Icon Container
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.history,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Trailing Chevron
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.white.withOpacity(0.3),
            size: 24,
          ),
        ],
      ),
    );
  }
}
