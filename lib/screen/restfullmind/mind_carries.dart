import 'dart:ui';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MindBubble {
  final String text;
  final Alignment alignment;

  MindBubble(this.text, this.alignment);
}

class MindCarriesScreen extends StatefulWidget {
  const MindCarriesScreen({super.key});

  @override
  State<MindCarriesScreen> createState() => _MindCarriesScreenState();
}

class _MindCarriesScreenState extends State<MindCarriesScreen> {
  final Set<String> _selectedBubbles = {};

  final List<MindBubble> _bubbles = [
    MindBubble('hurt', const Alignment(-0.8, -0.8)),
    MindBubble('worry', const Alignment(0.8, -0.6)),
    MindBubble('unfinished tasks', const Alignment(-0.7, -0.1)),
    MindBubble('guilt', const Alignment(0.8, 0.1)),
    MindBubble('replayed conversation', const Alignment(-0.75, 0.6)),
    MindBubble('anger', const Alignment(0.6, 0.7)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              _buildHeaderTexts(),
              Expanded(
                child: Stack(
                  children: [
                    _buildBackgroundRings(),
                    _buildCenterOrb(),
                    ..._bubbles.map((bubble) => _buildBubble(bubble)),
                  ],
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
    return ScreenHeader(
      title: 'What did your mind\ncarry today?',
      subtitle: 'Tap the bubbles that reflect what\nstayed with you.',
    );
  }

  Widget _buildBackgroundRings() {
    return Center(
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.04), width: 1),
        ),
        child: Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCenterOrb() {
    return Center(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xFFF3A1CB), Color(0xFF5BC0EB)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5BC0EB).withOpacity(0.3),
              blurRadius: 40,
              spreadRadius: 10,
            ),
            BoxShadow(
              color: const Color(0xFFF3A1CB).withOpacity(0.2),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBubble(MindBubble bubble) {
    bool isSelected = _selectedBubbles.contains(bubble.text);
    return Align(
      alignment: bubble.alignment,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedBubbles.remove(bubble.text);
            } else {
              _selectedBubbles.add(bubble.text);
            }
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1E3A5F).withOpacity(0.7)
                    : const Color(0xFF161A29).withOpacity(0.5),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF4A90E2).withOpacity(0.8)
                      : Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4A90E2).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: Text(
                bubble.text,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF161A29),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Text(
            'SELECTED: ${_selectedBubbles.length}',
            style: GoogleFonts.inter(
              color: const Color(0xFF5A9BDB),
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: PrimaryButton(text: 'CONTINUE', onPressed: () {}, height: 60),
        ),
        const SizedBox(height: 24),
        const CustomBottomNavBar(),
      ],
    );
  }
}
