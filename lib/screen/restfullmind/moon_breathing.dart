import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/screen/restfullmind/slowing_down.dart';
import 'package:flutter/material.dart';

class MoonBreathingScreen extends StatelessWidget {
  const MoonBreathingScreen({super.key});

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
                const SizedBox(height: 20),

                // Title
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Breathe with the\nmoon',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                ),

                // const SizedBox(height: 60),

                // Moon Area
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Subtle background glow behind the moon
                    // Container(
                    //   width: 520,
                    //   height: 520,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: const Color(0xFF5BC0EB).withOpacity(0.15),
                    //         blurRadius: 50,
                    //         spreadRadius: 10,
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    // The Moon Image
                    Image.asset(
                      'assets/pngs/moonbreathing.png',
                      width: 460,
                      height: 460,
                      fit: BoxFit.contain,
                    ),

                    // Text over the moon
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          '4',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'EXHALE',
                          style: TextStyle(
                            color: Color(
                              0xFF161A29,
                            ), // Very dark blue matching background
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 4.0,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // const SizedBox(height: 60),

                // Subtitle
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Inhale for 4. Exhale for 8.\nNothing needs solving tonight.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PrimaryButton(
                    text: 'CONTINUE',
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const SlowingDownScreen()));
                    },
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
}
