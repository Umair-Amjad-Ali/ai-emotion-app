import 'dart:math' as math;
import 'package:ai_emotion_app/screen/blindforgiveness/blind_forgiveness_stabilization_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class BlindForgivenessSummaryScreen extends StatefulWidget {
  const BlindForgivenessSummaryScreen({super.key});

  @override
  State<BlindForgivenessSummaryScreen> createState() =>
      _BlindForgivenessSummaryScreenState();
}

class _BlindForgivenessSummaryScreenState
    extends State<BlindForgivenessSummaryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _orbitController.dispose();
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
                      SizedBox(height: screenHeight * 0.01),

                      const Text(
                        'BLIND FORGIVENESS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        'ENERGY RETURNED',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.accentBlueLite.withOpacity(0.05),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Text(
                          '"Let the energy come back to you.\nThe past does not need to keep\npulling from you."',
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.7),
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Text(
                        'CORE RECONSTRUCTION',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: double.infinity,
                        height: screenWidth * 0.7,
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                          ),
                          image: DecorationImage(
                            image: const AssetImage('assets/pngs/overlay.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              AppColors.bgDark.withOpacity(0.4),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        child: AnimatedBuilder(
                          animation: _orbitController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: CoreReconstructionPainter(
                                orbitProgress: _orbitController.value,
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Text(
                        'RESENTMENT TRACKING',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              value: '0',
                              label: 'SESSIONS COMPLETED',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              value: '0',
                              label: 'RELEASES COMPLETED',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              value: '0',
                              label: 'HELD RESENTMENT\nCHOICES',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              value: '0',
                              label: 'TOTAL WEIGHT\nRELEASED',
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  BlindForgivenessStabilizationScreen(),
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

  Widget _buildStatCard({required String value, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.4),
              fontSize: 8,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class CoreReconstructionPainter extends CustomPainter {
  final double orbitProgress;

  CoreReconstructionPainter({required this.orbitProgress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // 1. Draw Deep Space Nebula Glow Background
    final nebulaPaint1 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.2, -0.3),
        radius: 0.6,
        colors: [
          AppColors.accentBlueLite.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), nebulaPaint1);

    final nebulaPaint2 = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.3, 0.4),
        radius: 0.7,
        colors: [
          AppColors.accentBlueLite.withOpacity(0.08),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), nebulaPaint2);

    final innerOrbitRadius = size.width * 0.18;
    final outerOrbitRadius = size.width * 0.28;

    final orbitPaint = Paint()
      ..color = AppColors.textPrimary.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawCircle(center, innerOrbitRadius, orbitPaint);
    canvas.drawCircle(center, outerOrbitRadius, orbitPaint);

    // 3. Draw Orbiting Planets
    final innerAngle = -(orbitProgress * 2 * math.pi * 2.0);
    final innerPlanetOffset = Offset(
      center.dx + innerOrbitRadius * math.cos(innerAngle),
      center.dy + innerOrbitRadius * math.sin(innerAngle),
    );

    // Inner Planet Glow
    canvas.drawCircle(
      innerPlanetOffset,
      7.0,
      Paint()
        ..color = AppColors.peachAccent.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6.0),
    );
    // Inner Planet Core (Smaller and slightly blurry edge)
    canvas.drawCircle(
      innerPlanetOffset,
      2.5,
      Paint()
        ..color = AppColors.peachAccent
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0),
    );

    final outerAngle = (orbitProgress * 2 * math.pi) + math.pi;
    final outerPlanetOffset = Offset(
      center.dx + outerOrbitRadius * math.cos(outerAngle),
      center.dy + outerOrbitRadius * math.sin(outerAngle),
    );

    // Outer Planet Glow
    canvas.drawCircle(
      outerPlanetOffset,
      8.0,
      Paint()
        ..color = AppColors.accentBlueLite.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8.0),
    );
    // Outer Planet Core (Smaller and slightly blurry edge)
    canvas.drawCircle(
      outerPlanetOffset,
      3.5,
      Paint()
        ..color = AppColors.accentBlueLite
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5),
    );

    // 4. Draw Center Core Orb (Cyan)
    final coreRadius = size.width * 0.08;

    // Center Core Glow
    final coreGlowPaint = Paint()
      ..color = AppColors.accentBlueLite.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15.0);
    canvas.drawCircle(center, coreRadius + 5, coreGlowPaint);

    // Center Solid Core (Slightly blurry edge instead of hard solid)
    final corePaint = Paint()
      ..color = AppColors.accentBlueLite
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
    canvas.drawCircle(center, coreRadius, corePaint);
  }

  @override
  bool shouldRepaint(covariant CoreReconstructionPainter oldDelegate) {
    return oldDelegate.orbitProgress != orbitProgress;
  }
}
