import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/screen/restfullmind/mind_carries.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NightResetScreen extends StatelessWidget {
  const NightResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AppHeader(level: 'LEVEL 1'),
                const SizedBox(height: 24),

                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Let the mind put the\nday away',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Subtitle
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'This tile releases the day\'s mental\nresidue so the mind can enter rest\nwithout carrying unfinished emotional\nnoise into sleep.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Card 1 (Main)
                GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MindCarriesScreen())),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xff1B1F2E).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'STEP 1 OF 10',
                                    style: TextStyle(
                                      color: const Color(
                                        0xFF5BC0EB,
                                      ).withOpacity(0.8),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Night Reset (6\nmin)',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF5BC0EB),
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xFF161A29),
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Center(
                            child: Image.asset(
                              'assets/pngs/nightreset.png',
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),

                const SizedBox(height: 16),

                // Card 2
                GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MindCarriesScreen())),
                child: _buildSecondaryCard(
                  svgAsset: 'assets/svg/quickquiet.svg',
                  iconColor: const Color(0xFFE88A8A),
                  time: '3 min',
                  title: 'Quick Quiet',
                  subtitle: 'Rapid decompression for busy minds.',
                ),
                ),

                const SizedBox(height: 16),

                // Card 3
                GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MindCarriesScreen())),
                child: _buildSecondaryCard(
                  svgAsset: 'assets/svg/deepsleep.svg',
                  iconColor: const Color(0xFF5BC0EB),
                  time: '10 min',
                  title: 'Deep Sleep Preparation',
                  subtitle: 'Enter a state of profound stillness.',
                ),
                ),

                const SizedBox(height: 32),

                // Rest Tracking
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Rest Tracking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'View Trends',
                          style: TextStyle(
                            color: Color(0xFF5BC0EB),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Tracking Grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          '24',
                          'SESSIONS\nCOMPLETED',
                          Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          '12',
                          'NIGHT STREAK',
                          const Color(0xFF5BC0EB),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          '84%',
                          'RESIDUE RELEASED',
                          Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStatCard(
                          '156',
                          'SOUNDSCAPE USES',
                          Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PrimaryButton(
                    text: 'CONTINUE',
                    height: 60,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MindCarriesScreen())),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildSecondaryCard({
    required String svgAsset,
    required Color iconColor,
    required String time,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                svgAsset,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                width: 16,
                height: 16,
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.white60, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Text(
                'Start Session',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, color: Colors.white, size: 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, Color valueColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
