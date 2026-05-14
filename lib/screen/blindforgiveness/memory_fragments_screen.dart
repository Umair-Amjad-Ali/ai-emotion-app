import 'dart:math' as math;
import 'package:ai_emotion_app/screen/blindforgiveness/emotional_weight_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class MemoryFragmentsScreen extends StatefulWidget {
  const MemoryFragmentsScreen({super.key});

  @override
  State<MemoryFragmentsScreen> createState() => _MemoryFragmentsScreenState();
}

class _MemoryFragmentsScreenState extends State<MemoryFragmentsScreen> {
  int? _selectedFragmentIndex;

  final List<Map<String, dynamic>> _fragments = [
    {'title': 'Argument', 'icon': Icons.chat_bubble_outline_rounded},
    {'title': 'Betrayal', 'icon': Icons.image_outlined},
    {'title': 'Humiliation', 'icon': Icons.sentiment_dissatisfied_rounded},
    {'title': 'Disrespect', 'icon': Icons.error_outline_rounded},
    {'title': 'Abandonment', 'icon': Icons.person_off_outlined},
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
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      const Text(
                        'Which fragment still\nhurts most?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          height: 1.25,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Tap the memory fragment that carries the\nstrongest emotional charge.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _fragments.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: screenHeight * 0.01),
                        itemBuilder: (context, index) {
                          return _buildFragmentCard(
                            index: index,
                            title: _fragments[index]['title'],
                            icon: _fragments[index]['icon'],
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      CoreMemoryOrb(size: screenWidth * 0.65),

                      SizedBox(height: screenHeight * 0.03),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedFragmentIndex != null
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EmotionalWeightScreen(),
                                  ),
                                );
                              }
                            : () {},
                      ),

                      SizedBox(height: screenHeight * 0.12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  Widget _buildFragmentCard({
    required int index,
    required String title,
    required IconData icon,
    required double screenWidth,
    required double screenHeight,
  }) {
    final isSelected = _selectedFragmentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFragmentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.012,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.textLiteBlue.withOpacity(0.12)
              : AppColors.cardLikePillBg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? AppColors.textLiteBlue.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.textLiteBlue.withOpacity(0.25)
                    : AppColors.textLiteBlue.withOpacity(0.15),
              ),
              child: Icon(
                icon,
                color: AppColors.textLiteBlue,
                size: screenWidth * 0.06,
              ),
            ),

            SizedBox(width: screenWidth * 0.03),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.9),
                  fontSize: screenWidth * 0.038,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  height: 1.3,
                ),
              ),
            ),

            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textLiteBlue,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppColors.textPrimary,
                  size: 14,
                ),
              )
            else
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textPrimary.withOpacity(0.2),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class CoreMemoryOrb extends StatefulWidget {
  final double size;

  const CoreMemoryOrb({super.key, required this.size});

  @override
  State<CoreMemoryOrb> createState() => _CoreMemoryOrbState();
}

class _CoreMemoryOrbState extends State<CoreMemoryOrb>
    with TickerProviderStateMixin {
  late AnimationController _slowRotationController;
  late AnimationController _fastRotationController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _slowRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _fastRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _slowRotationController.dispose();
    _fastRotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final innerOrbSize = widget.size * 0.7;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _PulsePainter(
                  progress: _pulseController.value,
                  baseRadius: innerOrbSize / 2,
                  color: AppColors.textLiteBlue,
                ),
              );
            },
          ),

          Container(
            width: innerOrbSize,
            height: innerOrbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF040814),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textLiteBlue.withOpacity(0.15),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),

          ClipOval(
            child: SizedBox(
              width: innerOrbSize,
              height: innerOrbSize,
              child: AnimatedBuilder(
                animation: _slowRotationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _slowRotationController.value * 2 * math.pi,
                    child: Image.asset(
                      'assets/pngs/abstract.png',
                      width: innerOrbSize,
                      height: innerOrbSize,
                      fit: BoxFit.cover,
                      color: AppColors.textLiteBlue.withOpacity(0.6),
                      colorBlendMode: BlendMode.modulate,
                    ),
                  );
                },
              ),
            ),
          ),

          Text(
            'CORE MEMORY',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: widget.size * 0.045,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.8),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
                Shadow(
                  color: AppColors.textLiteBlue.withOpacity(0.5),
                  blurRadius: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double progress;
  final double baseRadius;
  final Color color;

  _PulsePainter({
    required this.progress,
    required this.baseRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxExpansion = 40.0;

    // Loop to draw 3 concentric ripples
    for (int i = 0; i < 3; i++) {
      double rippleProgress = (progress + (i * 0.33)) % 1.0;

      final currentRadius = baseRadius + (maxExpansion * rippleProgress);
      final opacity = (1.0 - rippleProgress).clamp(0.0, 1.0);

      final shadowPaint = Paint()
        ..color = color.withOpacity(opacity * 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0);

      final linePaint = Paint()
        ..color = color.withOpacity(opacity * 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      canvas.drawCircle(center, currentRadius, shadowPaint);
      canvas.drawCircle(center, currentRadius, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _PulsePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
