import 'dart:math' as math;
import 'package:ai_emotion_app/screen/blindforgiveness/blind_forgiveness_summary_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class BreakEmotionalChainScreen extends StatefulWidget {
  const BreakEmotionalChainScreen({super.key});

  @override
  State<BreakEmotionalChainScreen> createState() =>
      _BreakEmotionalChainScreenState();
}

class _BreakEmotionalChainScreenState extends State<BreakEmotionalChainScreen>
    with SingleTickerProviderStateMixin {
  double _dragProgress = 0.0;
  bool _isBroken = false;

  late AnimationController _snapController;
  late Animation<double> _snapAnimation;

  @override
  void initState() {
    super.initState();
    _snapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _snapController.addListener(() {
      setState(() {
        _dragProgress = _snapAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details, double maxDragDistance) {
    if (_isBroken) return;

    setState(() {
      _dragProgress += details.delta.dx / maxDragDistance;
      _dragProgress = _dragProgress.clamp(0.0, 1.0);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isBroken) return;

    if (_dragProgress > 0.90) {
      // Snap to end and lock it
      setState(() {
        _dragProgress = 1.0;
        _isBroken = true;
      });
    } else {
      // Snap back to 0
      _snapAnimation = Tween<double>(begin: _dragProgress, end: 0.0).animate(
        CurvedAnimation(parent: _snapController, curve: Curves.easeOut),
      );
      _snapController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    final int breakPercentage = (_dragProgress * 100).toInt();

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
                      SizedBox(height: screenHeight * 0.015),

                      Text(
                        'Swipe all the way to shatter the\nconnection.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.8),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      Column(
                        children: [
                          Text(
                            'HUMILIATION',
                            style: TextStyle(
                              color: AppColors.peachAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.005),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'BREAKING: ',
                                style: TextStyle(
                                  color: AppColors.textPrimary.withOpacity(0.5),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              Text(
                                '$breakPercentage%',
                                style: TextStyle(
                                  color: AppColors.accentBlueLite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- Main Visual Card ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.bgDark.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Top Orb (Energy)
                            _buildTopOrb(),
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              'YOUR ENERGY',
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.8),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            SizedBox(
                              height: 100,
                              width: 60,
                              child: CustomPaint(
                                painter: _ShatterChainPainter(
                                  progress: _dragProgress,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            _buildBottomOrb(),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      _buildSwipeButton(screenWidth),

                      SizedBox(height: screenHeight * 0.03),

                      AnimatedOpacity(
                        opacity: _isBroken ? 1.0 : 0.5,
                        duration: const Duration(milliseconds: 300),
                        child: PrimaryButton(
                          text: 'CONTINUE',
                          onPressed: _isBroken
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          BlindForgivenessSummaryScreen(),
                                    ),
                                  );
                                }
                              : () {},
                        ),
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

  Widget _buildTopOrb() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accentBlueLite.withOpacity(0.15),
        border: Border.all(
          color: AppColors.accentBlueLite.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlueLite.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.bolt_rounded,
          color: AppColors.accentBlueLite,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildBottomOrb() {
    final double redGlowOpacity = (1.0 - _dragProgress).clamp(0.0, 1.0);

    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bgDark,
        border: Border.all(
          color: AppColors.peachAccent.withOpacity(0.4 * redGlowOpacity),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.peachAccent.withOpacity(0.25 * redGlowOpacity),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Center(
        child: Transform.rotate(
          angle: math.pi / 2,
          child: Icon(
            Icons.link_rounded,
            color: AppColors.textPrimary.withOpacity(
              0.3 + (0.2 * redGlowOpacity),
            ),
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _buildSwipeButton(double screenWidth) {
    const double thumbSize = 56.0;
    const double padding = 6.0;
    final double trackWidth = screenWidth - (screenWidth * 0.12);
    final double maxDragDistance = trackWidth - thumbSize - (padding * 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onHorizontalDragUpdate: (details) =>
              _onDragUpdate(details, maxDragDistance),
          onHorizontalDragEnd: _onDragEnd,
          child: Container(
            height: thumbSize + (padding * 2),
            width: trackWidth,
            decoration: BoxDecoration(
              color: AppColors.cardLikePillBg.withOpacity(0.8),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: AppColors.textPrimary.withOpacity(0.05),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.bgDark.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Center(
                  child: Text(
                    _isBroken ? 'BROKEN' : 'BREAK',
                    style: TextStyle(
                      color: AppColors.textPrimary.withOpacity(0.3),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),

                Positioned(
                  left: padding + (_dragProgress * maxDragDistance),
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentBlueLite,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentBlueLite.withOpacity(0.5),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        _isBroken
                            ? Icons.check_rounded
                            : Icons.chevron_right_rounded,
                        color: AppColors.bgDark,
                        size: 28,
                      ),
                    ),
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

class _ShatterChainPainter extends CustomPainter {
  final double progress;

  _ShatterChainPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    final linkWidth = 14.0;
    final linkHeight = 30.0;
    final spacing = 20.0;

    final double opacity = (1.0 - (progress / 0.9)).clamp(0.0, 1.0);

    if (opacity == 0.0) return;

    final strokePaint = Paint()
      ..color = AppColors.textPrimary.withOpacity(0.3 * opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final bgPaint = Paint()
      ..color = AppColors.bgDark.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    // Draw 3 overlapping chain links
    for (int i = 0; i < 4; i++) {
      // Calculate shattered outward offset based on progress
      double offsetX = 0.0;
      if (progress > 0) {
        // Link 0 moves left, Link 1 moves right, Link 2 moves left
        double direction = (i % 2 == 0) ? -1.0 : 1.0;
        offsetX = direction * (progress * 60.0);
      }

      final centerY = 20.0 + (i * spacing);

      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX + offsetX, centerY),
          width: linkWidth,
          height: linkHeight,
        ),
        const Radius.circular(8),
      );

      // Draw background to hide overlapping lines
      canvas.drawRRect(rect, bgPaint);
      // Draw visible link
      canvas.drawRRect(rect, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ShatterChainPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
