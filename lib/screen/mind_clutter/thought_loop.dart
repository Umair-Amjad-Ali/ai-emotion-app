import 'dart:math' as math;
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ThoughtLoopScreen extends StatefulWidget {
  const ThoughtLoopScreen({super.key});

  @override
  State<ThoughtLoopScreen> createState() => _ThoughtLoopScreenState();
}

class _ThoughtLoopScreenState extends State<ThoughtLoopScreen>
    with SingleTickerProviderStateMixin {
  final Set<int> _selectedFragments = {};

  final List<Map<String, dynamic>> _fragments = [
    {'label': 'What if...', 'icon': Icons.psychology_outlined},
    {'label': 'I should have...', 'icon': Icons.history_rounded},
    {'label': 'Why did I...', 'icon': Icons.help_outline_rounded},
    {'label': 'This will fail...', 'icon': Icons.warning_amber_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        title: 'Mind Clutter\nCrematorium',
                        subtitle:
                            'Identify the core repetitive patterns that keep you anchored in the past.',
                      ),
                      const SizedBox(height: 20),

                      // Animated Neural Loop
                      _buildAnimatedLoop(),

                      const SizedBox(height: 32),

                      // Instruction Pill
                      _buildInstructionPill(),

                      const SizedBox(height: 32),

                      // Fragment Grid
                      _buildFragmentGrid(),

                      const SizedBox(height: 32),

                      // Fragments Collected Text
                      Text(
                        'FRAGMENTS COLLECTED: ${_selectedFragments.length} / 4',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          // Handle continue
                        },
                      ),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildAnimatedLoop() {
    return SizedBox(
      height: 240,
      width: 240,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed Outer Circle
          CustomPaint(
            size: const Size(240, 240),
            painter: DashedCirclePainter(),
          ),

          // Inner Ethereal Energy Sphere
          const EtherealEnergySphere(),
        ],
      ),
    );
  }

  Widget _buildInstructionPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: const Text(
        'TAP THE FRAGMENTS OF THE\nTHOUGHT LOOP',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildFragmentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: _fragments.length,
      itemBuilder: (context, index) {
        final isSelected = _selectedFragments.contains(index);
        final fragment = _fragments[index];

        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedFragments.remove(index);
              } else {
                _selectedFragments.add(index);
              }
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.accentBlueLite.withOpacity(0.1)
                  : AppColors.cardLikePillBg.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? AppColors.accentBlueLite.withOpacity(0.4)
                    : AppColors.textPrimary.withOpacity(0.05),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  fragment['icon'],
                  color: isSelected ? AppColors.accentBlueLite : Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 12),
                Text(
                  fragment['label'],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.white70,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 5;
    double startAngle = 0;

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );

    while (startAngle < 2 * math.pi) {
      canvas.drawArc(
        rect,
        startAngle,
        dashWidth / (size.width / 2),
        false,
        paint,
      );
      startAngle += (dashWidth + dashSpace) / (size.width / 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class EtherealEnergySphere extends StatefulWidget {
  const EtherealEnergySphere({super.key});

  @override
  State<EtherealEnergySphere> createState() => _EtherealEnergySphereState();
}

class _EtherealEnergySphereState extends State<EtherealEnergySphere>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Calculate a 'breathing' pulse using a sine wave
        final double pulse =
            1.0 + (0.05 * math.sin(_controller.value * 2 * math.pi));

        return Center(
          child: Transform.rotate(
            // Slow clockwise rotation
            angle: _controller.value * 2 * math.pi,
            child: Transform.scale(
              scale: pulse,
              child: Container(
                width: 180, // Matched size to previous container
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/pngs/Overlay+Border+Shadow.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

