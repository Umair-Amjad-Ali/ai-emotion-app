import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/screen/restfullmind/night_reset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FinalNightScreen extends StatelessWidget {
  // Data from previous screens — can be passed via constructor
  final int residueReleased;
  final String forgivenessReset;
  final String bodyTensionReleased;
  final String sleepIntention;

  const FinalNightScreen({
    super.key,
    this.residueReleased = 1,
    this.forgivenessReset = 'Release both',
    this.bodyTensionReleased = '5/5',
    this.sleepIntention = 'Tomorrow can wait.',
  });

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
                const SizedBox(height: 16),

                // ====== CONTAINER 1: Main Content ======
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff1B1F2E).withOpacity(0.35),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Tags
                      Row(
                        children: [
                          // Sleep Mode Tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE88A8A).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE88A8A).withOpacity(0.4),
                              ),
                            ),
                            child: const Text(
                              'Sleep Mode',
                              style: TextStyle(
                                color: Color(0xFFE88A8A),
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          // Sleep Transition Active Tag
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5BC0EB).withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF5BC0EB).withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF5BC0EB),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Sleep transition active',
                                  style: TextStyle(
                                    color: Color(0xFF5BC0EB),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Title
                      const Text(
                        'The day is now\nclosed',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          height: 1.15,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Subtitle
                      Text(
                        'You have put away the day. Nothing else is\nrequired tonight.',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Globe / Tomorrow can wait container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        decoration: BoxDecoration(
                          color: const Color(0xff1B1F2E).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: Column(
                          children: [
                            // Globe SVG
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF5BC0EB,
                                    ).withOpacity(0.15),
                                    blurRadius: 40,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: SvgPicture.asset(
                                'assets/svg/tomorrowcanwait.svg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Tomorrow can wait.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Choose a final night action.',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Soundscape Options
                      _buildSoundscapeOption('Play Ocean Soundscape'),
                      const SizedBox(height: 10),
                      _buildSoundscapeOption('Play Rain Soundscape'),
                      const SizedBox(height: 10),
                      _buildSoundscapeOption('Play Forest Soundscape'),
                      const SizedBox(height: 10),
                      _buildSoundscapeOption('Play White Noise'),

                      const SizedBox(height: 24),

                      // Action Buttons Row
                      Row(
                        children: [
                          // Close to Home Button
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Close to Home',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Run Again Button
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFE88A8A),
                                    Color(0xFFFF6B6B),
                                  ],
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Run Again',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ====== CONTAINER 2: Night Reset Summary ======
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xff1B1F2E).withOpacity(0.35),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Night Reset Summary Header
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE88A8A).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'NIGHT RESET SUMMARY',
                          style: TextStyle(
                            color: Color(0xFFE88A8A),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Summary Cards
                      _buildInnerSummaryCard(
                        'RESIDUE RELEASED',
                        '$residueReleased',
                      ),
                      const SizedBox(height: 10),
                      _buildInnerSummaryCard(
                        'FORGIVENESS RESET',
                        forgivenessReset,
                      ),
                      const SizedBox(height: 10),
                      _buildInnerSummaryCard(
                        'BODY TENSION RELEASED',
                        bodyTensionReleased,
                      ),
                      const SizedBox(height: 10),
                      _buildInnerSummaryCard('SLEEP INTENTION', sleepIntention),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Start Again Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PrimaryButton(
                    text: 'START AGAIN',
                    height: 60,
                    onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const NightResetScreen()), (route) => false),
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

  Widget _buildSoundscapeOption(String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInnerSummaryCard(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
