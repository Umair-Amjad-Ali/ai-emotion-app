import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class MainBackground extends StatelessWidget {
  final Widget child;
  final bool showBottomGlow;

  const MainBackground({
    super.key,
    required this.child,
    this.showBottomGlow = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [AppColors.bgGlow, AppColors.bgDark],
                  stops: [0.05, 0.6],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class TopGlowBackground extends StatelessWidget {
  final Widget child;

  const TopGlowBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.bgGlowBlue, AppColors.bgDark],
                  stops: [0.6, 0.9],
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}