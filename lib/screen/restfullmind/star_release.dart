import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StarReleaseScreen extends StatefulWidget {
  const StarReleaseScreen({super.key});

  @override
  State<StarReleaseScreen> createState() => _StarReleaseScreenState();
}

class _StarReleaseScreenState extends State<StarReleaseScreen> {
  // 5 stars total. True means visible.
  final List<bool> _starVisible = [true, true, true, true, true];

  int get _starsReleased => _starVisible.where((v) => !v).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              // _buildTopBar(),
              _buildHeaderTexts(),

              // Stars area
              Expanded(
                child: ClipRect(
                  child: Stack(
                    children: [
                      // Detailed Multicolor Nebula Background restricted to this area
                      _buildNebulaBackground(),

                      // Star 1: Top Left
                      _buildStar(0, const Alignment(-0.4, -0.4), 28),
                      // Star 2: Bottom Left (largest)
                      _buildStar(1, const Alignment(-0.55, 0.45), 40),
                      // Star 3: Center Bottom
                      _buildStar(2, const Alignment(0.25, 0.45), 24),
                      // Star 4: Center Right
                      _buildStar(3, const Alignment(0.45, -0.05), 26),
                      // Star 5: Far Right
                      _buildStar(4, const Alignment(0.7, 0.1), 32),
                    ],
                  ),
                ),
              ),

              _buildBottomControls(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTexts() {
    return Column(
      children: [
        const ScreenHeader(
          // label: 'Interruption',
          title: 'Release the final\nthoughts into the\nstars',
          subtitle: 'Tap 5 stars. Let each one take a final\nthought with it.',
        ),
      ],
    );
  }

  Widget _buildStar(int index, Alignment alignment, double size) {
    return Align(
      alignment: alignment,
      child: AnimatedOpacity(
        opacity: _starVisible[index] ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: GestureDetector(
          onTap: () {
            if (_starVisible[index]) {
              setState(() {
                _starVisible[index] = false;
              });
            }
          },
          child: Container(
            // Adding transparent padding makes the hit target larger
            padding: const EdgeInsets.all(16.0),
            color: Colors.transparent,
            child: Icon(
              Icons.star,
              color: const Color(0xFFE2F0FF),
              size: size,
              // Adding shadow to simulate glow
              shadows: [
                Shadow(
                  color: const Color(0xFF8AB4F8).withOpacity(0.8),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // STARS RELEASED Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF161A29), // Very dark blue/gray
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'STARS RELEASED: $_starsReleased / 5',
            style: GoogleFonts.inter(
              color: const Color(0xFF5A9BDB),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 20),

        // CONTINUE Button
        Container(
          padding: const EdgeInsets.only(
            top: 4,
            bottom: 4,
            left: 24,
            right: 24,
          ),
          child: PrimaryButton(text: 'CONTINUE', onPressed: () {}, height: 60),
        ),
        const SizedBox(height: 24),

        // BOTTOM NAV BAR
        const CustomBottomNavBar(),
      ],
    );
  }

  Widget _buildNebulaBackground() {
    return Transform.scale(
      scale: 1.15, // Adjust this value to make the galaxy larger/smaller
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/pngs/galaxy.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
