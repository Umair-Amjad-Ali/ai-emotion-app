import 'package:flutter/material.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';

class SessionProgressBadge extends StatelessWidget {
  final int currentSessions;
  final int totalSessions;
  final double size;

  const SessionProgressBadge({
    super.key,
    required this.currentSessions,
    required this.totalSessions,
    this.size = 70,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = totalSessions > 0
        ? currentSessions / totalSessions
        : 0.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlue.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 4.5,
              color: Colors.white.withOpacity(0.1),
            ),
          ),

          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 4.5,
              color: AppColors.accentBlue,
              strokeCap: StrokeCap.round,
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$currentSessions/$totalSessions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size * 0.21,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'SESSIONS',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: size * 0.11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
