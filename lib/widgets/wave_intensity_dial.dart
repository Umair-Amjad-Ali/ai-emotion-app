import 'dart:math';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class WaveIntensityDial extends StatelessWidget {
  final double intensity;
  final double size;

  const WaveIntensityDial({
    super.key,
    required this.intensity,
    this.size = 220.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size * 0.9,
            height: size * 0.9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB5C8E2).withOpacity(0.12),
                  blurRadius: 50,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),

          // The Custom Painter drawing the gradient arc
          CustomPaint(
            size: Size(size, size),
            painter: _DialPainter(intensity: intensity),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                intensity.toInt().toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              Text(
                'INTENSITY',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  final double intensity;

  _DialPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    // Tightened the radius to make the track and border seamless
    final baseRadius = (size.width / 2) - 16;
    const strokeWidth = 26.0;

    const startAngle = -pi / 2;
    const sweepAngle = 2 * pi;

    final shadowPaint = Paint()
      ..color = AppColors.cardBackgroundColor.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12.0);
    canvas.drawCircle(center, baseRadius + strokeWidth / 2 + 8, shadowPaint);

    final frameColor = const Color(0xFF0C1222).withOpacity(0.5);
    final outerRadius = baseRadius + strokeWidth / 2;

    final framePaint = Paint()
      ..color = frameColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    canvas.drawCircle(center, outerRadius + 5, framePaint);

    // Subtle outer highlight
    final outerHighlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, outerRadius + 10, outerHighlightPaint);

    // 3. Draw the full background track
    final bgPaint = Paint()
      ..color = AppColors.glassCardBg
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, baseRadius, bgPaint);

    // 3. Draw the active gradient progress track
    final progressSweepAngle = (intensity / 10.0) * sweepAngle;

    final gradient = const LinearGradient(
      colors: [Color(0xFF4E6076), Color(0xFFB5C8E2)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromCircle(center: center, radius: baseRadius));

    final activePaint = Paint()
      ..shader = gradient
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (intensity > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: baseRadius),
        startAngle,
        progressSweepAngle,
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) {
    return oldDelegate.intensity != intensity;
  }
}
