import 'package:ai_emotion_app/screen/blindforgiveness/blind_forgiveness_cost_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class ChainConnectionScreen extends StatefulWidget {
  const ChainConnectionScreen({super.key});

  @override
  State<ChainConnectionScreen> createState() => _ChainConnectionScreenState();
}

class _ChainConnectionScreenState extends State<ChainConnectionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flowController;

  @override
  void initState() {
    super.initState();
    _flowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  void dispose() {
    _flowController.dispose();
    super.dispose();
  }

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
                      SizedBox(height: screenHeight * 0.015),

                      Text(
                        'See the\nemotional\ncontract',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.085,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'The chain shows how energy keeps\nflowing from you into the past.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      // --- Visual Component: Z-Index Stack Layout ---
                      SizedBox(
                        height: 380,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Positioned.fill(
                              child: AnimatedBuilder(
                                animation: _flowController,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: _TwoChainPainter(
                                      flowProgress: _flowController.value,
                                    ),
                                  );
                                },
                              ),
                            ),

                            // 2. LAYER TWO: Top Node (Energy)
                            Positioned(
                              top: 0,
                              child: Column(
                                children: [
                                  _buildOrb(
                                    glowColor: AppColors.accentBlueLite,
                                    innerContent: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.accentBlueLite
                                                .withOpacity(0.6),
                                            AppColors.accentBlueLite
                                                .withOpacity(0.1),
                                          ],
                                          stops: const [0.85, 1.0],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.bolt_rounded,
                                        color: AppColors.accentBlueLite,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  _buildPillLabel(
                                    'YOUR ENERGY',
                                    AppColors.accentBlueLite,
                                  ),
                                ],
                              ),
                            ),

                            // 3. LAYER THREE: Bottom Node (Humiliation)
                            Positioned(
                              bottom: 0,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildOrb(
                                    glowColor: AppColors.peachAccent,
                                    innerContent: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            AppColors.peachAccent.withOpacity(
                                              0.6,
                                            ),
                                            AppColors.peachAccent.withOpacity(
                                              0.0,
                                            ),
                                          ],
                                          stops: const [0.85, 1.0],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.sentiment_dissatisfied_rounded,
                                        color: AppColors.peachAccent,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.015),
                                  _buildPillLabel(
                                    'HUMILIATION',
                                    AppColors.peachAccent,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlindForgivenessCostScreen(),
                            ),
                          );
                        },
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

  Widget _buildOrb({required Color glowColor, required Widget innerContent}) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cardLikePillBg,
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.12),
            blurRadius: 40,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Center(child: innerContent),
    );
  }

  Widget _buildPillLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.0),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.5,
        ),
      ),
    );
  }
}

// --- Custom Painter for Flowing Line & Two Chain Links ---
class _TwoChainPainter extends CustomPainter {
  final double flowProgress;

  _TwoChainPainter({required this.flowProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    // Based on the layout dimensions above:
    // Top Orb is 110px tall. So the bottom border of the top orb is at Y = 110.
    final double startY = 110.0;

    // Bottom Node total height is approx 158px.
    // Top border of the bottom orb is at size.height - 158.
    final double endY = size.height - 158.0;

    // 1. Draw Faint Background Line (Connects Orb to Orb precisely)
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(centerX, startY), Offset(centerX, endY), linePaint);

    // Expanding progress ensures smooth entry/exit
    final double smoothProgress = -0.5 + (flowProgress * 2.0);

    // 2. Draw the Animated Energy Flow Line
    final flowPaint = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          AppColors.accentBlueLite.withOpacity(0.8),
          AppColors.peachAccent.withOpacity(0.8),
          Colors.transparent,
        ],
        stops: [
          (smoothProgress - 0.4).clamp(0.0, 1.0),
          (smoothProgress - 0.1).clamp(0.0, 1.0),
          (smoothProgress + 0.1).clamp(0.0, 1.0),
          (smoothProgress + 0.4).clamp(0.0, 1.0),
        ],
      ).createShader(Rect.fromLTWH(0, startY, size.width, endY - startY));

    canvas.drawLine(Offset(centerX, startY), Offset(centerX, endY), flowPaint);

    // 3. Draw the Physical Chain Links
    final strokePaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final bgPaint = Paint()
      ..color = AppColors.bgDark
      ..style = PaintingStyle.fill;

    final double linkWidth = 14.0;
    final double linkHeight = 32.0;

    // Position the bottom chain so it sinks slightly below 'endY'
    // This allows the Bottom Circle (drawn over it) to hide the bottom 30%
    final double bottomChainCenterY = endY - 10.0;

    // Position the top chain connected to the bottom one
    final double topChainCenterY = bottomChainCenterY - 24.0;

    // Top Link
    final Rect topRect = Rect.fromCenter(
      center: Offset(centerX, topChainCenterY),
      width: linkWidth,
      height: linkHeight,
    );
    final RRect topRRect = RRect.fromRectAndRadius(
      topRect,
      const Radius.circular(8),
    );

    // Bottom Link
    final Rect bottomRect = Rect.fromCenter(
      center: Offset(centerX, bottomChainCenterY),
      width: linkWidth,
      height: linkHeight,
    );
    final RRect bottomRRect = RRect.fromRectAndRadius(
      bottomRect,
      const Radius.circular(8),
    );

    // Paint Top Link
    canvas.drawRRect(topRRect, bgPaint);
    canvas.drawRRect(topRRect, strokePaint);

    // Paint Bottom Link
    canvas.drawRRect(bottomRRect, bgPaint);
    canvas.drawRRect(bottomRRect, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _TwoChainPainter oldDelegate) {
    return oldDelegate.flowProgress != flowProgress;
  }
}
