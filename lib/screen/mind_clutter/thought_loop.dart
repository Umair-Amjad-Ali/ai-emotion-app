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
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        title: 'Mind Clutter\nCrematorium',
                        subtitle:
                            'Identify the core repetitive patterns that keep you anchored in the past.',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildAnimatedLoop(screenWidth),

                      SizedBox(height: screenHeight * 0.04),
                      // Instruction Pill
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.05),
                          ),
                        ),
                        child: const Text(
                          'TAP THE FRAGMENTS OF THE\nTHOUGHT LOOP',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2.5,
                            height: 1.2,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),
                      // Fragment Grid
                      _buildFragmentGrid(),
                      Text(
                        'FRAGMENTS COLLECTED: ${_selectedFragments.length} / 4',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      Container(
                        height: 4.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      PrimaryButton(text: 'CONTINUE', onPressed: () {}),

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

  // Pass screenWidth to make the sizes dynamic
  Widget _buildAnimatedLoop(double screenWidth) {
    // Dynamically calculate sizes instead of fixed 240/180
    final double outerLoopSize =
        screenWidth * 0.6; // Roughly 60% of screen width
    final double innerSphereSize =
        outerLoopSize * 0.75; // Maintain proportional scale

    return SizedBox(
      height: outerLoopSize,
      width: outerLoopSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed Outer Circle
          CustomPaint(
            size: Size(outerLoopSize, outerLoopSize),
            painter: DashedCirclePainter(),
          ),

          // Inner Ethereal Energy Sphere
          EtherealEnergySphere(size: innerSphereSize),
        ],
      ),
    );
  }

  Widget _buildFragmentGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
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
  final double size; // Accept dynamic size
  const EtherealEnergySphere({super.key, required this.size});

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
                width: widget.size, // Use dynamic size instead of fixed 180
                height: widget.size, // Use dynamic size instead of fixed 180
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
