import 'package:ai_emotion_app/screen/dailyantitode/daily_antidote_mind_state_screen.dart';
import 'package:ai_emotion_app/widgets/circular_timer.dart';
import 'package:ai_emotion_app/widgets/global_timer_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';

class DailyAntidoteScreen extends StatefulWidget {
  const DailyAntidoteScreen({super.key});

  @override
  State<DailyAntidoteScreen> createState() => _DailyAntidoteScreenState();
}

class _DailyAntidoteScreenState extends State<DailyAntidoteScreen> {
  bool _isVoiceGuidedActive = true;

  @override
  void initState() {
    super.initState();
    GlobalTimerService().startOrResetTimer(minutes: 30);
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Session Time',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.005),
                                Text(
                                  'BUILD MENTAL IMMUNITY',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.6,
                                    ),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const CircularTimer(),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      _buildToggleCard(),
                      SizedBox(height: screenHeight * 0.02),
                      _buildActionCard(
                        icon: Icons.bolt_rounded,
                        title: 'Micro Antidote',
                        subtitle: '2 MIN • RAPID RECALIBRATION',
                        iconColor: AppColors.accentBlueLite,
                        context: context,
                        targetScreen: const DailyAntidoteMindStateScreen(),
                      ),
                      const SizedBox(height: 12),
                      _buildActionCard(
                        icon: Icons.shield_rounded,
                        title: 'Daily Immunity Builder',
                        subtitle: '5 MIN • CORE FORTIFICATION',
                        iconColor: AppColors.accentBlueLite,
                        isRecommended: true,
                        context: context,
                        targetScreen: const DailyAntidoteMindStateScreen(),
                      ),
                      const SizedBox(height: 12),
                      _buildActionCard(
                        icon: Icons.dark_mode_rounded,
                        title: 'Deep Antidote Protocol',
                        subtitle: '10 MIN • TOTAL RESTORATION',
                        iconColor: AppColors.accentBlueLite,
                        context: context,
                        targetScreen: const DailyAntidoteMindStateScreen(),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Tracking Header ---
                      const Text(
                        'Mental Toxicity Tracking',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'LIVE BIOSYNC DATA',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.history_rounded,
                              value: '0',
                              label: 'SESSIONS COMPLETED',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.local_fire_department_rounded,
                              value: '0',
                              label: 'ANTIDOTE STREAK',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.cleaning_services_rounded,
                              value: '0',
                              label: 'TOXINS NEUTRALIZED',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.psychology_rounded,
                              value: '0',
                              label: 'CLARITY BOOST\nTOTAL',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      _buildCurrentStateBanner(screenHeight),

                      SizedBox(height: screenHeight * 0.12),
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

  Widget _buildToggleCard() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: _isVoiceGuidedActive
            ? [
                BoxShadow(
                  color: AppColors.accentBlueLite.withOpacity(0.1),
                  offset: const Offset(-4, 0),
                  blurRadius: 10,
                ),
              ]
            : [],
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.volume_up_rounded,
                  color: AppColors.accentBlueLite.withOpacity(0.8),
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'VOICE GUIDED IMMUNITY',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        _isVoiceGuidedActive ? 'ACTIVE' : 'INACTIVE',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                CupertinoSwitch(
                  value: _isVoiceGuidedActive,
                  activeColor: AppColors.accentBlueLite,
                  trackColor: AppColors.textPrimary.withOpacity(0.1),
                  onChanged: (value) {
                    setState(() {
                      _isVoiceGuidedActive = value;
                    });
                  },
                ),
              ],
            ),
          ),

          // Left accent line (Merged flush to the border, only shows if active)
          if (_isVoiceGuidedActive)
            Positioned(
              left: 0,
              top: 12,
              bottom: 12,
              child: Container(
                width: 4,
                decoration: const BoxDecoration(
                  color: AppColors.accentBlueLite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    bool isRecommended = false,
    required BuildContext context,
    required Widget targetScreen,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
        ),
        child: Stack(
          children: [
            // --- Main Content ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  // Icon Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: iconColor, size: 24),
                  ),
                  const SizedBox(width: 16),

                  // Texts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.5),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Right Arrow
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textPrimary.withOpacity(0.3),
                    size: 24,
                  ),
                ],
              ),
            ),

            // --- Top Right RECOMMENDED Badge ---
            if (isRecommended)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.accentBlueLite,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      color: AppColors.bgDark,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.accentBlueLite.withOpacity(0.8),
            size: 20,
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 8,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStateBanner(double screenHeight) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.18,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
        image: DecorationImage(
          image: const AssetImage('assets/pngs/antitide_visuals.png'),
          fit: BoxFit.cover,
          opacity: 0.4,
          colorFilter: ColorFilter.mode(
            AppColors.bgDark.withOpacity(0.3),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'CURRENT STATE',
            style: TextStyle(
              color: AppColors.accentBlueLite,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              children: [
                TextSpan(
                  text: 'Equilibrium ',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
                TextSpan(
                  text: 'Stable',
                  style: TextStyle(color: AppColors.accentBlueLite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
