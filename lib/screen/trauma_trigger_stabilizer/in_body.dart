import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/reconnect_to_what_is_real.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/glass_card.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class InBodyScreen extends StatefulWidget {
  const InBodyScreen({super.key});

  @override
  State<InBodyScreen> createState() => _InBodyScreenState();
}

class _InBodyScreenState extends State<InBodyScreen> {
  // Toggle states for the 6 body areas
  final Map<String, bool> _activeAreas = {
    'CHEST': true,
    'THROAT': true,
    'DIGESTION': true,
    'MIND': true,
    'FRAME': true,
    'STATE': true,
  };

  void _toggleArea(String area) {
    setState(() {
      _activeAreas[area] = !(_activeAreas[area] ?? false);
    });
  }

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ScreenHeader(
                        title: 'Where do you feel the\ntrigger in your body?',
                        subtitle:
                            'Tap the strongest area. Turning overwhelm\ninto physical awareness helps reduce chaos.',
                      ),

                      // Body Diagram
                      SizedBox(
                        height: 350,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Body Outline
                            CustomPaint(
                              size: const Size(200, 350),
                              painter: BodyOutlinePainter(),
                            ),
                            // Glowing Dots (Vertical Line)
                            _buildGlowDot('MIND', const Alignment(0, -0.72)),
                            _buildGlowDot('THROAT', const Alignment(0, -0.42)),
                            _buildGlowDot('CHEST', const Alignment(0, -0.15)),
                            _buildGlowDot(
                              'DIGESTION',
                              const Alignment(0, 0.12),
                            ),
                            _buildGlowDot('STATE', const Alignment(0, 0.45)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Emergency Panic Button
                      _buildPanicButton(),

                      const SizedBox(height: 24),

                      // Selection Grid
                      Row(
                        children: [
                          Expanded(
                            child: _buildSelectionBox(
                              'CHEST',
                              'Racing heart /\nchest',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSelectionBox('THROAT', 'Tight throat'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSelectionBox(
                              'DIGESTION',
                              'Stomach tension',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSelectionBox('MIND', 'Head pressure'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSelectionBox(
                              'FRAME',
                              'Shoulders / upper\nbody',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildSelectionBox(
                              'STATE',
                              'Whole body /\nfrozen',
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Secondary Action Button
                      _buildGroundingButton(),

                      const SizedBox(height: 32),

                      // Continue Button
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReconnectToWhatIsRealScreen(),
                            ),
                          );
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

  Widget _buildGlowDot(
    String area,
    Alignment alignment, {
    bool isShoulder = false,
  }) {
    bool isActive = _activeAreas[area] ?? false;
    return Align(
      alignment: alignment,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: isActive ? 1.0 : 0.0,
        child: Container(
          width: isShoulder ? 8 : 12,
          height: isShoulder ? 8 : 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.relaxScan.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.relaxScan.withOpacity(0.8),
                blurRadius: isShoulder ? 15 : 20,
                spreadRadius: isShoulder ? 5 : 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanicButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.darkRedBrown,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.bgDark.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.emergency_share_rounded,
            color: AppColors.textPrimary,
            size: 24,
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'EMERGENCY CARE - PANIC BUTTON',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textPrimary.withOpacity(0.6),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionBox(String area, String value) {
    bool isActive = _activeAreas[area] ?? false;
    return GestureDetector(
      onTap: () => _toggleArea(area),
      child: Container(
        height: 85,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.textPrimary.withOpacity(0.05)
              : AppColors.glassCardBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? AppColors.accentBlueLite.withOpacity(0.3)
                : AppColors.glassCardBorder,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              area,
              style: TextStyle(
                color: isActive
                    ? AppColors.accentBlueLite
                    : AppColors.textPrimary.withOpacity(0.4),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroundingButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.5)),
      ),
      child: Center(
        child: Text(
          'Need to feel the ground',
          style: TextStyle(
            color: AppColors.textPrimary.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class BodyOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final w = size.width;
    final h = size.height;

    final path = Path();

    // Head (Circle)
    final headCenter = Offset(w * 0.5, h * 0.12);
    final headRadius = w * 0.14;
    path.addOval(Rect.fromCircle(center: headCenter, radius: headRadius));

    // Body Outline - simplified smooth silhouette
    // Left side
    path.moveTo(w * 0.44, h * 0.22); // Neck start left
    path.quadraticBezierTo(w * 0.3, h * 0.25, w * 0.25, h * 0.3); // Shoulder
    path.lineTo(w * 0.22, h * 0.45); // Left arm outer
    path.quadraticBezierTo(w * 0.22, h * 0.47, w * 0.25, h * 0.47); // Hand
    path.lineTo(w * 0.3, h * 0.35); // Left arm inner
    path.lineTo(w * 0.32, h * 0.6); // Torso left
    path.lineTo(w * 0.32, h * 0.88); // Leg left outer
    path.quadraticBezierTo(w * 0.32, h * 0.92, w * 0.4, h * 0.92); // Foot left
    path.lineTo(w * 0.46, h * 0.8); // Leg left inner

    // Crotch
    path.lineTo(w * 0.5, h * 0.76);

    // Right side
    path.lineTo(w * 0.54, h * 0.8); // Leg right inner
    path.lineTo(w * 0.6, h * 0.92); // Foot right
    path.quadraticBezierTo(
      w * 0.68,
      h * 0.92,
      w * 0.68,
      h * 0.88,
    ); // Leg right outer
    path.lineTo(w * 0.68, h * 0.6); // Torso right
    path.lineTo(w * 0.7, h * 0.35); // Right arm inner
    path.lineTo(w * 0.75, h * 0.47); // Hand
    path.quadraticBezierTo(
      w * 0.78,
      h * 0.47,
      w * 0.78,
      h * 0.45,
    ); // Right arm outer
    path.lineTo(w * 0.75, h * 0.3); // Shoulder
    path.quadraticBezierTo(w * 0.7, h * 0.25, w * 0.56, h * 0.22); // Neck right

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
