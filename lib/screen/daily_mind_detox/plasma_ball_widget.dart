import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;

class PlasmaBallWidget extends StatefulWidget {
  final double size;
  final Duration animationDuration;
  final Color plasmaColor;

  const PlasmaBallWidget({
    Key? key,
    this.size = 300,
    this.animationDuration = const Duration(milliseconds: 8000),
    this.plasmaColor = const Color(0xFF7BD3E9),
  }) : super(key: key);

  @override
  State<PlasmaBallWidget> createState() => _PlasmaBallWidgetState();
}

class _PlasmaBallWidgetState extends State<PlasmaBallWidget>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    _animationController.repeat();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      if (_isMounted && _animationController.isAnimating) {
        _animationController.stop();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (_isMounted && !_animationController.isAnimating) {
        _animationController.repeat();
      }
    }
  }

  @override
  void dispose() {
    _isMounted = false;
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: PlasmaBallPainter(
            animationValue: _animation.value,
            plasmaColor: widget.plasmaColor,
          ),
          size: Size(widget.size, widget.size),
        );
      },
    );
  }
}

class PlasmaBallPainter extends CustomPainter {
  final double animationValue;
  final Color plasmaColor;

  PlasmaBallPainter({
    required this.animationValue,
    required this.plasmaColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Single phase: 0 to 2π - this is the ONLY time parameter
    final phase = animationValue * 2 * math.pi;

    // Draw background
    final bgPaint = Paint()
      ..shader = ui.Gradient.radial(
        center,
        radius,
        [
          const Color(0xFF1a3a4a).withOpacity(0.8),
          const Color(0xFF0f1f2a).withOpacity(0.95),
        ],
        [0.0, 1.0],
      )
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, bgPaint);

    // Draw continuously flowing plasma lines - NO GENERATIONS, just pure sine waves
    for (int layer = 0; layer < 3; layer++) {
      _drawPlasmaLayer(canvas, center, radius, phase, layer);
    }

    // Draw core
    _drawCore(canvas, center, radius, phase);

    // Draw rim
    final rimPaint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..color = plasmaColor.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 5);

    canvas.drawCircle(center, radius * 0.98, rimPaint);
  }

  void _drawPlasmaLayer(
      Canvas canvas,
      Offset center,
      double radius,
      double phase,
      int layer,
      ) {
    final lineCount = 16;
    final layerPhaseOffset = (layer * math.pi * 2) / 3; // 0°, 120°, 240°

    for (int i = 0; i < lineCount; i++) {
      final baseAngle = (i / lineCount) * math.pi * 2;

      // Line opacity oscillates continuously - NO GENERATION, pure sine wave
      final opacity = 0.3 + 0.4 * math.sin(phase + i + layerPhaseOffset);

      // Skip completely transparent lines
      if (opacity < 0.05) continue;

      // Line length oscillates
      final length = 0.5 + 0.5 * math.sin(phase * 0.5 + i * 0.3 + layerPhaseOffset);

      _drawLine(
        canvas,
        center,
        radius,
        baseAngle,
        phase,
        length,
        opacity,
        i,
        layer,
      );
    }
  }

  void _drawLine(
      Canvas canvas,
      Offset center,
      double radius,
      double baseAngle,
      double phase,
      double lengthFactor,
      double opacity,
      int lineIndex,
      int layer,
      ) {
    final maxLength = radius * 0.85;
    final lineLength = maxLength * lengthFactor;

    // Create jagged path using simple sine waves
    final path = Path();
    path.moveTo(center.dx, center.dy);

    final segmentCount = 25;
    final random = math.Random(lineIndex * 1000 + layer * 100);

    for (int j = 1; j <= segmentCount; j++) {
      final t = j / segmentCount;
      final currentLength = lineLength * t;

      // Base position along the line
      final baseX = center.dx + math.cos(baseAngle) * currentLength;
      final baseY = center.dy + math.sin(baseAngle) * currentLength;

      // Add perpendicular jitter using sine waves - CONTINUOUSLY LOOPING
      final perpAngle = baseAngle + math.pi / 2;
      final jitterAmount = math.sin(phase * 1.5 + j * 0.5 + lineIndex) *
          radius * 0.06 * (1 - t);
      final randomJitter = (random.nextDouble() - 0.5) * radius * 0.04 * (1 - t);

      final x = baseX + math.cos(perpAngle) * (jitterAmount + randomJitter);
      final y = baseY + math.sin(perpAngle) * (jitterAmount + randomJitter);

      path.lineTo(x, y);
    }

    // Outer glow layer
    final glowPaint = Paint()
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = plasmaColor.withOpacity(opacity * 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawPath(path, glowPaint);

    // Mid glow layer
    final midPaint = Paint()
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = plasmaColor.withOpacity(opacity * 0.65)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.drawPath(path, midPaint);

    // Bright core
    final corePaint = Paint()
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..color = Colors.white.withOpacity(opacity * 0.9)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.3);

    canvas.drawPath(path, corePaint);
  }

  void _drawCore(Canvas canvas, Offset center, double radius, double phase) {
    // Continuous pulsing using sine - ALWAYS LOOPS PERFECTLY
    final pulse = 0.6 + 0.4 * math.sin(phase);
    final coreRadius = radius * 0.12 * pulse;

    // Outer glow
    final outerGlow = Paint()
      ..color = plasmaColor.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, coreRadius * 0.9);

    canvas.drawCircle(center, coreRadius * 1.4, outerGlow);

    // Main glow
    final mainGlow = Paint()
      ..color = plasmaColor.withOpacity(0.75)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, coreRadius * 0.5);

    canvas.drawCircle(center, coreRadius, mainGlow);

    // Bright center
    final brightPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.3);

    canvas.drawCircle(center, coreRadius * 0.4, brightPaint);
  }

  @override
  bool shouldRepaint(PlasmaBallPainter oldDelegate) {
    return true; // Always repaint for smooth animation
  }
}