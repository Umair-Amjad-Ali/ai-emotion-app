import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/screen/anger/anger_tamer_triggers_screen.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/session_progress_badge.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';

class AngerTamerScreen extends StatefulWidget {
  const AngerTamerScreen({super.key});

  @override
  State<AngerTamerScreen> createState() => _AngerTamerScreenState();
}

class _AngerTamerScreenState extends State<AngerTamerScreen> {
  int _selectedSessionIndex = 0; // Default to 'Quick Cooldown'
  bool _voiceGuidanceEnabled = true;

  // Custom Light Blue Accent from your screenshot

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
                      SizedBox(height: screenHeight * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CURRENT PATH',
                                style: TextStyle(
                                  color: AppColors.accentBlueLite.withOpacity(
                                    0.7,
                                  ),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Daily Sanctuary',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SessionProgressBadge(
                            currentSessions: 1,
                            totalSessions: 10,
                            size: 60,
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // --- Session Selection Card ---
                      _build3DCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.self_improvement_rounded,
                                    color: AppColors.accentBlueLite,
                                    size: 22,
                                  ),
                                ),
                                SizedBox(width: screenHeight * 0.01),
                                const Text(
                                  'Session Selection',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            // Description Text
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'Intercept anger before it ',
                                  ),
                                  const TextSpan(
                                    text: 'reacts for you',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '. Choose your path to clarity.',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            // Interactive Session Options
                            _buildSessionOption(
                              index: 0,
                              title: 'Quick Cooldown',
                              subtitle: '2 MIN SESSION',
                              icon: Icons.bolt_rounded,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            _buildSessionOption(
                              index: 1,
                              title: 'Calm Reset',
                              subtitle: '5 MIN SESSION',
                              icon: Icons.eco_outlined,
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            _buildSessionOption(
                              index: 2,
                              title: 'Deep De-escalation',
                              subtitle: '10 MIN SESSION',
                              icon: Icons.waves,
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            // Voice Guidance Toggle
                            GestureDetector(
                              onTap: () => setState(
                                () => _voiceGuidanceEnabled =
                                    !_voiceGuidanceEnabled,
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  color: _voiceGuidanceEnabled
                                      ? AppColors.peachAccent.withOpacity(0.1)
                                      : AppColors.textPrimary.withOpacity(0.03),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: _voiceGuidanceEnabled
                                        ? AppColors.peachAccent.withOpacity(0.3)
                                        : AppColors.textPrimary.withOpacity(
                                            0.05,
                                          ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Voice Guidance',
                                          style: TextStyle(
                                            color: _voiceGuidanceEnabled
                                                ? AppColors.peachAccent
                                                : AppColors.textPrimary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.007),
                                        Text(
                                          _voiceGuidanceEnabled
                                              ? 'ENABLED'
                                              : 'DISABLED',
                                          style: TextStyle(
                                            color: _voiceGuidanceEnabled
                                                ? AppColors.peachAccent
                                                      .withOpacity(0.7)
                                                : AppColors.textPrimary
                                                      .withOpacity(0.5),
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.record_voice_over_outlined,
                                      color: _voiceGuidanceEnabled
                                          ? AppColors.peachAccent
                                          : AppColors.textPrimary,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // --- Progress Snapshot Card ---
                      _build3DCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timeline_rounded,
                                      color: AppColors.accentBlue,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'PROGRESS\nSNAPSHOT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                        height: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'VIEW HISTORY',
                                  style: TextStyle(
                                    color: AppColors.accentBlueLite,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),

                            // Stats List
                            _buildProgressStat(
                              'SESSIONS COMPLETED',
                              '1',
                              Icons.check_circle_outline,
                              AppColors.accentBlueLite,
                            ),
                            const SizedBox(height: 12),
                            _buildProgressStat(
                              'TOTAL ANGER REDUCED',
                              '4',
                              Icons.trending_down_rounded,
                              AppColors.peachAccent,
                            ),
                            const SizedBox(height: 12),
                            // Calm Points with the left edge highlight
                            _buildProgressStat(
                              'CALM POINTS',
                              '5',
                              Icons.auto_awesome,
                              AppColors.accentBlueLite,
                              hasLeftAccent: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // --- Bottom Quote / Image Card ---
                      Container(
                        width: double.infinity,
                        height: 200,
                        alignment: Alignment.bottomLeft,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.1),
                          ),
                          image: DecorationImage(
                            image: const NetworkImage(
                              'https://images.unsplash.com/photo-1777195680745-9fb67291b216?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.4),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: const Text(
                          '"The quieter you become, the more\nyou are able to hear."',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 8),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: "Continue",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AngerTamerTriggersScreen(),
                            ),
                          );
                        },
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
      // bottomNavigationBar: const CustomBottomNavBar(),
      // extendBody: true,
    );
  }

  // --- Reusable 3D Card Builder (Maintained from previous fix) ---
  Widget _build3DCard({required Widget child, required EdgeInsets padding}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgGlowBlue.withOpacity(0.8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [Padding(padding: padding, child: child)],
        ),
      ),
    );
  }

  // --- Session Selection Option Builder ---
  Widget _buildSessionOption({
    required int index,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final isActive = _selectedSessionIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => _selectedSessionIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.accentBlueLite
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? AppColors.accentBlueLite
                : Colors.white.withOpacity(0.05),
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.accentBlue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF0C1222)
                        : AppColors.accentBlueLite,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF0C1222).withOpacity(0.7)
                        : AppColors.lightDarkText,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            Icon(
              icon,
              color: isActive
                  ? const Color(0xFF0C1222)
                  : AppColors.accentBlueLite,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // --- Progress Stat Box Builder ---
  Widget _buildProgressStat(
    String label,
    String value,
    IconData icon,
    Color iconColor, {
    bool hasLeftAccent = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allow accent to reach card edge
        children: [
          // Left Edge Accent (Stitched to card's outer border)
          if (hasLeftAccent)
            Positioned(
              left: -20, // Move left to meet the card's edge
              top: -8, // Extend slightly above the item box
              bottom: -8,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: AppColors.accentBlue,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(icon, color: iconColor, size: 20),
            ],
          ),
        ],
      ),
    );
  }
}
