import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/screen/restfullmind/star_release.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SlowingDownScreen extends StatelessWidget {
  const SlowingDownScreen({super.key});

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

                // Title and Subtitle
                const ScreenHeader(
                  title: 'The mind is\nslowingdown',
                  subtitle: 'Let the remaining movement become\nstill.',
                ),

                // const SizedBox(height: 20),

                // Graphic Area
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Subtle background glow behind the globe
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF5BC0EB).withOpacity(0.15),
                            blurRadius: 50,
                            spreadRadius: 50,
                          ),
                        ],
                      ),
                    ),

                    // The SVG Image
                    SvgPicture.asset(
                      'assets/svg/sowingdown.svg',
                      width: 280,
                      height: 280,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),

                // const SizedBox(height: 60),

                // Bottom Text
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const StarReleaseScreen()));
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
