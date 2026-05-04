import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/screen_header.dart';

class BodyRelaxationScanScreen extends StatefulWidget {
  const BodyRelaxationScanScreen({super.key});

  @override
  State<BodyRelaxationScanScreen> createState() =>
      _BodyRelaxationScanScreenState();
}

class _BodyRelaxationScanScreenState extends State<BodyRelaxationScanScreen> {
  // 5 tension points total. True means tension is active (visible).
  final List<bool> _tensionActive = [true, true, true, true, true];

  int get _releasedCount => _tensionActive.where((v) => !v).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),

              const ScreenHeader(
                title: 'Tap where the day is still\nstored',
                subtitle: 'Scan your body and release physical\nimprints.',
              ),

              // Body area
              Expanded(
                child: Stack(
                  children: [
                    // Body Outline
                    Center(
                      child: SizedBox(
                        width: 240,
                        height: 420,
                        child: CustomPaint(painter: BodyOutlinePainter()),
                      ),
                    ),

                    // Tension Points Overlay
                    Center(
                      child: SizedBox(
                        width: 240,
                        height: 420,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // 0: Head
                            _buildTensionPoint(0, const Alignment(0.0, -1)),
                            // 1: Chest
                            _buildTensionPoint(1, const Alignment(0.0, -0.4)),
                            // 2: Stomach
                            _buildTensionPoint(2, const Alignment(0.0, 0.05)),
                            // 3: Lower Abdomen
                            _buildTensionPoint(3, const Alignment(0.0, 0.45)),
                            // 4: Knees / Between Legs
                            _buildTensionPoint(4, const Alignment(0.0, 0.85)),

                            // Active Tension Label
                            // We position it next to the first active tension point
                            if (_tensionActive.contains(true))
                              _buildActiveTensionLabel(),
                          ],
                        ),
                      ),
                    ),
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

  Widget _buildTensionPoint(int index, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: AnimatedOpacity(
        opacity: _tensionActive[index] ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: GestureDetector(
          onTap: () {
            if (_tensionActive[index]) {
              setState(() {
                _tensionActive[index] = false;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16.0), // Hit area
            color: Colors.transparent,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.relaxScan.withOpacity(0.2),

                boxShadow: [
                  BoxShadow(
                    color: AppColors.relaxScan.withOpacity(0.6),
                    blurRadius: 10,
                    spreadRadius: 8,
                  ),
                  BoxShadow(
                    color: AppColors.relaxScan.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTensionLabel() {
    // Find first active index to position the label next to it
    int firstActive = _tensionActive.indexOf(true);
    if (firstActive == -1) return const SizedBox.shrink();

    // Map index to approximate alignment Y
    double yPos = 0;
    switch (firstActive) {
      case 0:
        yPos = -0.85;
        break;
      case 1:
        yPos = -0.3;
        break;
      case 2:
        yPos = 0.15;
        break;
      case 3:
        yPos = 0.5;
        break;
      case 4:
        yPos = 0.85;
        break;
    }

    return Align(
      alignment: Alignment(1.3, yPos), // Offset to the right
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 300),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color(0xFF5A5D72)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'ACTIVE TENSION',
            style: GoogleFonts.inter(
              color: const Color(0xFFD66B6B),
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Pill
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFF161A29), // Very dark blue/gray
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Text(
                  'RELEASED TENSION POINTS: $_releasedCount / 5',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFA1A3AC),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    bool isReleased = index < _releasedCount;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isReleased
                            ? const Color(0xFF5A9BDB)
                            : Colors.transparent,
                        border: Border.all(
                          color: const Color(0xFF5A9BDB),
                          width: 1,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // CONTINUE Button
          PrimaryButton(text: 'CONTINUE', onPressed: () {}),
          const SizedBox(height: 24),

          // BOTTOM NAV BAR
          const CustomBottomNavBar(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class BodyOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A4E69).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final w = size.width;
    final h = size.height;

    final path = Path();

    // Head (Circle)
    final headCenter = Offset(w * 0.5, h * 0.1);
    final headRadius = w * 0.18;
    path.addOval(Rect.fromCircle(center: headCenter, radius: headRadius));

    // Neck
    final neckY = h * 0.1 + headRadius;
    path.moveTo(w * 0.45, neckY);

    // Left shoulder
    path.quadraticBezierTo(w * 0.35, neckY + 10, w * 0.25, neckY + 20);
    // Left outer arm down
    path.lineTo(w * 0.2, h * 0.55);
    // Left hand curve
    path.quadraticBezierTo(w * 0.2, h * 0.58, w * 0.25, h * 0.58);
    // Left inner arm up
    path.lineTo(w * 0.3, h * 0.35);

    // Left torso down
    path.lineTo(w * 0.32, h * 0.6);
    // Left leg down
    path.lineTo(w * 0.32, h * 0.95);
    // Left foot curve
    path.quadraticBezierTo(w * 0.32, h * 0.98, w * 0.38, h * 0.98);
    // Left inner leg up
    path.lineTo(w * 0.45, h * 0.85);

    // Crotch peak
    path.lineTo(w * 0.5, h * 0.8);

    // Right inner leg down
    path.lineTo(w * 0.55, h * 0.85);
    path.lineTo(w * 0.62, h * 0.98);
    // Right foot curve
    path.quadraticBezierTo(w * 0.68, h * 0.98, w * 0.68, h * 0.95);
    // Right leg up
    path.lineTo(w * 0.68, h * 0.6);
    // Right torso up
    path.lineTo(w * 0.7, h * 0.35);

    // Right inner arm down
    path.lineTo(w * 0.75, h * 0.58);
    // Right hand curve
    path.quadraticBezierTo(w * 0.8, h * 0.58, w * 0.8, h * 0.55);
    // Right outer arm up
    path.lineTo(w * 0.75, neckY + 20);
    // Right shoulder
    path.quadraticBezierTo(w * 0.65, neckY + 10, w * 0.55, neckY);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
