import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';


class GeometricScreen extends StatefulWidget {
  const GeometricScreen({Key? key}) : super(key: key);

  @override
  State<GeometricScreen> createState() => _GeometricScreenState();
}

class ConnectingLine {
  final double angle1;
  final double angle2;
  final double opacity;

  ConnectingLine({
    required this.angle1,
    required this.angle2,
    required this.opacity,
  });
}

class _GeometricScreenState extends State<GeometricScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<ConnectingLine> lines = [];
  final random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    Timer.periodic(const Duration(milliseconds: 150), (_) {
      setState(() {
        final angle1 = random.nextDouble() * 2 * pi;
        final angle2 = random.nextDouble() * 2 * pi;

        lines.add(ConnectingLine(
          angle1: angle1,
          angle2: angle2,
          opacity: 1.0,
        ));

        if (lines.length > 40) {
          lines.removeAt(0);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0d1a3d),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: GeometricPainter(
              lines: lines,
              animation: _controller.value,
            ),
            size: MediaQuery.of(context).size,
          );
        },
      ),
    );
  }
}

class GeometricPainter extends CustomPainter {
  final List<ConnectingLine> lines;
  final double animation;

  GeometricPainter({
    required this.lines,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 60;

    // Draw outer circle
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withOpacity(0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );

    // Draw inner circle
    canvas.drawCircle(
      center,
      radius * 0.8,
      Paint()
        ..color = Colors.white.withOpacity(0.12)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );

    // Draw lines connecting points on circle
    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];
      final progress = i / lines.length;
      final fadeOut = sin((1 - progress) * pi).clamp(0, 1);

      final point1 = Offset(
        center.dx + radius * cos(line.angle1),
        center.dy + radius * sin(line.angle1),
      );

      final point2 = Offset(
        center.dx + radius * cos(line.angle2),
        center.dy + radius * sin(line.angle2),
      );

      // Draw glow layers
      for (int g = 5; g >= 1; g--) {
        final glowOpacity = fadeOut * (1 - g / 6) * 0.5;
        canvas.drawLine(
          point1,
          point2,
          Paint()
            ..color = Colors.white.withOpacity(glowOpacity)
            ..strokeWidth = g * 2.5
            ..strokeCap = StrokeCap.round
            ..maskFilter = MaskFilter.blur(BlurStyle.normal, g * 1.5),
        );
      }

      // Main line
      canvas.drawLine(
        point1,
        point2,
        Paint()
          ..color = Colors.white.withOpacity(fadeOut * 0.95)
          ..strokeWidth = 1.8
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(GeometricPainter oldDelegate) => true;
}