import 'package:ai_emotion_app/screen/anger/hold_to_pause_screen.dart';
import 'package:ai_emotion_app/widgets/session_progress_badge.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class AngerHeatMapScreen extends StatefulWidget {
  const AngerHeatMapScreen({super.key});

  @override
  State<AngerHeatMapScreen> createState() => _AngerHeatMapScreenState();
}

class _AngerHeatMapScreenState extends State<AngerHeatMapScreen> {
  final Set<String> _selectedItems = {};

  final List<Map<String, dynamic>> _options = [
    {
      'title': 'Chest tightness',
      'icon': Icons.monitor_heart_outlined,
      'target': 'chest',
    },
    {
      'title': 'Jaw clenching',
      'icon': Icons.health_and_safety_outlined,
      'target': 'head',
    },
    {
      'title': 'Muscle tension',
      'icon': Icons.fitness_center_outlined,
      'target': 'limbs',
    },
    {'title': 'Body heat', 'icon': Icons.thermostat_outlined, 'target': 'all'},
    {'title': 'Short breaths', 'icon': Icons.air_outlined, 'target': 'chest'},
    {
      'title': 'Stomach knots',
      'icon': Icons.warning_amber_rounded,
      'target': 'stomach',
    },
  ];

  void _toggleSelection(String title) {
    setState(() {
      if (_selectedItems.contains(title)) {
        _selectedItems.remove(title);
      } else {
        _selectedItems.add(title);
      }
    });
  }

  Set<String> _getActiveSpots() {
    final spots = <String>{};
    for (var option in _options) {
      if (_selectedItems.contains(option['title'])) {
        spots.add(option['target'] as String);
      }
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    final activeSpots = _getActiveSpots();

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
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Where do you feel it?',
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                'Observe your body. Notice the heat or  \n tension andmap your sensations.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),

                          const SessionProgressBadge(
                            currentSessions: 4,
                            totalSessions: 10,
                            size: 60,
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      SizedBox(
                        height: screenHeight * 0.46,
                        width: screenWidth * 0.6,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            CustomPaint(
                              size: Size(
                                screenWidth * 0.45,
                                screenHeight * 0.46,
                              ),
                              painter: BodyMapPainter(activeSpots: activeSpots),
                            ),
                            // Active Tension Pill Label - Always anchored to the head
                            if (activeSpots.isNotEmpty)
                              Positioned(
                                // Perfectly aligned with the center of the head oval
                                top: (screenHeight * 0.46) * 0.12 - 16,
                                right: -screenWidth * 0.15,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: AppColors.lightPink.withOpacity(
                                        0.5,
                                      ),
                                      width: 1.2,
                                    ),
                                    color: AppColors.lightPink.withOpacity(
                                      0.08,
                                    ),
                                  ),
                                  child: const Text(
                                    'ACTIVE TENSION',
                                    style: TextStyle(
                                      color: AppColors.lightPink,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- Selection Grid ---
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 1.7,
                            ),
                        itemCount: _options.length,
                        itemBuilder: (context, index) {
                          final option = _options[index];
                          final isSelected = _selectedItems.contains(
                            option['title'],
                          );
                          return _buildGridCard(
                            title: option['title'],
                            icon: option['icon'],
                            isSelected: isSelected,
                            onTap: () => _toggleSelection(option['title']),
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedItems.isNotEmpty
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HoldToPauseScreen(),
                                  ),
                                );
                              }
                            : () {},
                      ),
                      SizedBox(height: screenHeight * 0.14),
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

  // Specialized Card Builder matching the screenshot
  Widget _buildGridCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color highlightColor = AppColors.accentBlueLite;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? highlightColor.withOpacity(0.08)
              : AppColors.cardLikePillBg.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? highlightColor.withOpacity(0.8)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: isSelected ? highlightColor : Colors.white54,
              size: 24,
            ),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? highlightColor : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Custom Painter for the Body Map Outline & Heat Spots ---
class BodyMapPainter extends CustomPainter {
  final Set<String> activeSpots;

  BodyMapPainter({required this.activeSpots});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Draw Body Outline
    final outlinePaint = Paint()
      ..color = AppColors.textPrimary.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Head shape (Perfect Oval)
    final headRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.12),
      width: w * 0.38,
      height: h * 0.20,
    );
    path.addOval(headRect);

    // Shoulders, Torso, Arms, and Legs continuous path
    path.moveTo(w * 0.38, h * 0.21);
    path.quadraticBezierTo(w * 0.15, h * 0.23, w * 0.1, h * 0.35);
    path.lineTo(w * 0.05, h * 0.65);
    path.quadraticBezierTo(w * 0.08, h * 0.68, w * 0.15, h * 0.65);
    path.lineTo(w * 0.22, h * 0.40); // Inner left arm
    path.lineTo(w * 0.22, h * 0.65); // Left torso
    path.lineTo(w * 0.22, h * 0.98); // Outer left leg
    path.quadraticBezierTo(w * 0.28, h * 1.0, w * 0.32, h * 0.98); // Left foot
    path.lineTo(w * 0.45, h * 0.70); // Crotch inner left
    path.quadraticBezierTo(
      w * 0.5,
      h * 0.67,
      w * 0.55,
      h * 0.70,
    ); // Crotch curve
    path.lineTo(w * 0.68, h * 0.98); // Inner right leg
    path.quadraticBezierTo(w * 0.72, h * 1.0, w * 0.78, h * 0.98); // Right foot
    path.lineTo(w * 0.78, h * 0.65); // Outer right leg
    path.lineTo(w * 0.78, h * 0.40); // Right torso
    path.lineTo(w * 0.85, h * 0.65); // Inner right arm
    path.quadraticBezierTo(
      w * 0.92,
      h * 0.68,
      w * 0.95,
      h * 0.65,
    ); // Right hand
    path.lineTo(w * 0.9, h * 0.35); // Outer right arm
    path.quadraticBezierTo(
      w * 0.85,
      h * 0.23,
      w * 0.62,
      h * 0.21,
    ); // Right shoulder adjusted

    canvas.drawPath(path, outlinePaint);

    // 2. Draw Heat Spots (Glow)
    void drawGlow(Offset center, double radius) {
      final glowPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            const Color(0xFFFFB4A8).withOpacity(0.9), // Peach Core
            const Color(0xFFFF6E6E).withOpacity(0.4), // Soft Red Ring
            Colors.transparent,
          ],
          stops: const [0.0, 0.4, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, glowPaint);
    }

    final bool all = activeSpots.contains('all');

    if (activeSpots.contains('head') || all) {
      drawGlow(Offset(w * 0.5, h * 0.12), h * 0.06);
    }
    if (activeSpots.contains('chest') || all) {
      drawGlow(Offset(w * 0.5, h * 0.32), h * 0.08);
    }
    if (activeSpots.contains('stomach') || all) {
      drawGlow(Offset(w * 0.5, h * 0.52), h * 0.07);
    }
    if (activeSpots.contains('limbs') || all) {
      drawGlow(Offset(w * 0.13, h * 0.50), h * 0.06); // Left Arm
      drawGlow(Offset(w * 0.87, h * 0.50), h * 0.06); // Right Arm
    }
  }

  @override
  bool shouldRepaint(BodyMapPainter oldDelegate) {
    return oldDelegate.activeSpots != activeSpots;
  }
}
