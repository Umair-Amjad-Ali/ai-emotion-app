import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:ai_emotion_app/screen/restfullmind/body_relaxation_scan.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgivenessResetScreen extends StatefulWidget {
  const ForgivenessResetScreen({super.key});

  @override
  State<ForgivenessResetScreen> createState() => _ForgivenessResetScreenState();
}

class _ForgivenessResetScreenState extends State<ForgivenessResetScreen> {
  bool _isReleased = false;

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
                  title: 'What are you ready\nto release tonight?',
                  subtitle:
                      'Forgiveness here means you are not carrying\nthe emotional knot into sleep.',
                ),
                const SizedBox(height: 20),

                // Top two cards that fade out
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 1500),
                  opacity: _isReleased ? 0.0 : 1.0,
                  curve: Curves.easeOut,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildCard(
                            svgAsset: 'assets/svg/forgiveothers.svg',
                            label: 'OTHERS',
                            title: 'Forgive\nothers',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildCard(
                            svgAsset: 'assets/svg/forgivemyself.svg',
                            label: 'SELF',
                            title: 'Forgive\nmyself',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Release Both card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _buildReleaseBothCard(),
                ),

                const SizedBox(height: 40),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PrimaryButton(
                    text: 'CONTINUE',
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const BodyRelaxationScanScreen()));
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

  Widget _buildCard({
    required String svgAsset,
    required String label,
    required String title,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xff1B1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(svgAsset, width: 20, height: 20),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReleaseBothCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isReleased = true; // Triggers the fade out of the top two cards
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: const Color(0xff1B1F2E).withOpacity(0.5),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF161A29),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(
                Icons.filter_none,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Release both',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'A complete emotional reset',
                    style: TextStyle(color: Colors.white54, fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
