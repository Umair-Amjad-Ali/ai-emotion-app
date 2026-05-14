import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/what_triggered_you.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class StabilizeNervousSystem extends StatefulWidget {
  const StabilizeNervousSystem({super.key});

  @override
  State<StabilizeNervousSystem> createState() => _StabilizeNervousSystemState();
}

class _StabilizeNervousSystemState extends State<StabilizeNervousSystem> {
  bool _voiceGuidance = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppHeader(level: 'LEVEL 1'),
                const ScreenHeader(
                  label: 'TRAUMA TRIGGER STABILIZER',
                  title: 'Stabilize the nervous\nsystem',
                  subtitle:
                      'Choose the protocol that matches your\ncurrent intensity level.',
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _buildProtocolCard(
                        icon: Icons.bolt_rounded,
                        title: 'Trigger Interrupt',
                        duration: '(2 MIN)',
                        subtitle: 'Rapid sensory refocusing',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      _buildProtocolCard(
                        icon: Icons.waves_rounded,
                        title: 'Emotional Stabilizer',
                        duration: '(5 MIN)',
                        subtitle: 'Vagus nerve activation',
                        onTap: () {},
                      ),
                      const SizedBox(height: 16),
                      _buildProtocolCard(
                        icon: Icons.accessibility_new_rounded,
                        title: 'Trauma Reset Protocol',
                        duration: '(10 MIN)',
                        subtitle: 'Full somatic release sequence',
                        onTap: () {},
                      ),

                      const SizedBox(height: 32),
                      const Divider(color: Colors.white10, height: 1),
                      const SizedBox(height: 32),

                      _buildTrackedProgress(),

                      const SizedBox(height: 16),
                      _buildSettingsSection(),

                      const SizedBox(height: 16),
                      _buildTriggerTracking(),

                      const SizedBox(height: 40),
                      _buildSanctuaryCard(),

                      const SizedBox(height: 40),
                      PrimaryButton(
                        text: 'CONTINUE',
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WhatTriggeredYouScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildProtocolCard({
    required IconData icon,
    required String title,
    required String duration,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardLikePillBg.withOpacity(0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.textPrimary.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColors.glassCardBg.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        duration,
                        style: const TextStyle(
                          color: AppColors.accentBlueLite,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.play_circle_outline_rounded,
              color: AppColors.textPrimary.withOpacity(0.4),
              size: 26,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackedProgress() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TRACKED PROGRESS',
            style: TextStyle(
              color: AppColors.accentBlueLite,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProgressItem('SESSIONS COMPLETED', '0'),
                    const SizedBox(height: 14),
                    _buildProgressItem('TOTAL RECOVERY GAINED', '0%'),
                    const SizedBox(height: 14),
                    _buildProgressItem('CALM STREAK', '0 DAYS'),
                  ],
                ),
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accentBlueLite.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.accentBlueLite,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(String label, String value) {
    return Row(
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.4),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SETTINGS',
            style: TextStyle(
              color: AppColors.accentBlueLite,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Voice Guidance: ${_voiceGuidance ? "On" : "Off"}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: _voiceGuidance,
                  onChanged: (value) {
                    setState(() {
                      _voiceGuidance = value;
                    });
                  },
                  activeColor: AppColors.accentBlueLite,
                  activeTrackColor: AppColors.accentBlueLite.withOpacity(0.3),
                  inactiveThumbColor: AppColors.textPrimary.withOpacity(0.6),
                  inactiveTrackColor: AppColors.textPrimary.withOpacity(0.05),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTriggerTracking() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'TRIGGER TRACKING',
              style: TextStyle(
                color: AppColors.lightOrange,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your most recent trigger log stays on the device in this browser.',
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No trigger logs yet.',
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 13,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSanctuaryCard() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/pngs/the_ethereal_sanctuary.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, AppColors.bgDark.withOpacity(0.85)],
            stops: const [0.3, 1.0],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The Ethereal Sanctuary',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Your safe space for emotional regulation',
              style: TextStyle(
                color: AppColors.textPrimary.withOpacity(0.7),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
