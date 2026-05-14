import 'package:ai_emotion_app/widgets/global_timer_service.dart';
import 'package:flutter/material.dart';

class CircularTimer extends StatelessWidget {
  final Color borderColor;
  final double size;

  const CircularTimer({
    super.key,
    this.borderColor = Colors.red,
    this.size = 64.0,
  });

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder listens to the service and rebuilds ONLY this widget every second
    return AnimatedBuilder(
      animation: GlobalTimerService(),
      builder: (context, child) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: borderColor.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              GlobalTimerService().timeString, // Fetches the live time
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      },
    );
  }
}
