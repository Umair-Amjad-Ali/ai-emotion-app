import 'dart:async';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

enum _BreathPhase { inhale, hold, exhale }

class BreatheWithTheCircleScreen extends StatefulWidget {
  const BreatheWithTheCircleScreen({super.key});

  @override
  State<BreatheWithTheCircleScreen> createState() =>
      _BreatheWithTheCircleScreenState();
}

class _BreatheWithTheCircleScreenState extends State<BreatheWithTheCircleScreen>
    with SingleTickerProviderStateMixin {
  // Durations for each phase in seconds
  static const int _inhaleDuration = 4;
  static const int _holdDuration = 4;
  static const int _exhaleDuration = 4;

  _BreathPhase _currentPhase = _BreathPhase.inhale;
  int _countdown = _inhaleDuration;
  Timer? _timer;

  // Animation controller for the breathing circle scale
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: _inhaleDuration),
    );

    _scaleAnimation = Tween<double>(begin: 0.65, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    // Start the breathing cycle
    _startPhase(_BreathPhase.inhale);
  }

  void _startPhase(_BreathPhase phase) {
    _timer?.cancel();

    setState(() {
      _currentPhase = phase;
    });

    int phaseDuration;
    switch (phase) {
      case _BreathPhase.inhale:
        phaseDuration = _inhaleDuration;
        _animController.duration = Duration(seconds: phaseDuration);
        _animController.forward(from: 0.0);
        break;
      case _BreathPhase.hold:
        phaseDuration = _holdDuration;
        // Keep circle expanded during hold
        _animController.stop();
        break;
      case _BreathPhase.exhale:
        phaseDuration = _exhaleDuration;
        _animController.duration = Duration(seconds: phaseDuration);
        _animController.reverse(from: 1.0);
        break;
    }

    setState(() {
      _countdown = phaseDuration;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 1) {
        timer.cancel();
        // Move to next phase
        _BreathPhase next;
        switch (_currentPhase) {
          case _BreathPhase.inhale:
            next = _BreathPhase.hold;
            break;
          case _BreathPhase.hold:
            next = _BreathPhase.exhale;
            break;
          case _BreathPhase.exhale:
            next = _BreathPhase.inhale;
            break;
        }
        _startPhase(next);
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  String get _phaseLabel {
    switch (_currentPhase) {
      case _BreathPhase.inhale:
        return 'INHALE';
      case _BreathPhase.hold:
        return 'HOLD';
      case _BreathPhase.exhale:
        return 'EXHALE';
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  children: [
                    const ScreenHeader(
                      title: 'Breathe with the\ncircle',
                      subtitle:
                          'Follow the circle. Stay with the\nbreath rather than the memory.',
                    ),
                    const SizedBox(height: 20),
                    _buildBreathingCircle(),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: 'CONTINUE',
                      height: 60,
                      onPressed: () {
                        // Handle navigation to next screen
                      },
                    ),
                    const SizedBox(height: 120),
                  ],
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

  Widget _buildBreathingCircle() {
    final double maxSize = MediaQuery.of(context).size.width * 0.6;

    return SizedBox(
      height: maxSize + 40,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            final double size = maxSize * _scaleAnimation.value;
            return _BreathCirclePainterWidget(
              size: size,
              phaseLabel: _phaseLabel,
              countdown: _countdown,
              phase: _currentPhase,
            );
          },
        ),
      ),
    );
  }
}

class _BreathCirclePainterWidget extends StatelessWidget {
  final double size;
  final String phaseLabel;
  final int countdown;
  final _BreathPhase phase;

  const _BreathCirclePainterWidget({
    required this.size,
    required this.phaseLabel,
    required this.countdown,
    required this.phase,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(0.1, -0.2),
          radius: 0.75,
          colors: [
            AppColors.accentBlueLite, // bright cyan center
            AppColors.midBlue, // mid blue
            AppColors.deeperBlue, // deeper blue
            AppColors.darkBlueEdge, // dark blue edge
          ],
          stops: [0.0, 0.35, 0.65, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.midBlue.withOpacity(0.45),
            blurRadius: 40,
            spreadRadius: 8,
          ),
          BoxShadow(
            color: AppColors.darkBlueEdge.withOpacity(0.3),
            blurRadius: 60,
            spreadRadius: 16,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Phase label
          Text(
            phaseLabel,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: size * 0.09,
              fontWeight: FontWeight.w600,
              letterSpacing: 4,
            ),
          ),
          SizedBox(height: size * 0.02),
          // Countdown number
          Text(
            '$countdown',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: size * 0.28,
              fontWeight: FontWeight.w600,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
