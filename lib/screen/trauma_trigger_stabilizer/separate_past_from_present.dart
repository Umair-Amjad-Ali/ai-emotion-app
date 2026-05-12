import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class SeparatePastFromPresentScreen extends StatefulWidget {
  const SeparatePastFromPresentScreen({super.key});

  @override
  State<SeparatePastFromPresentScreen> createState() =>
      _SeparatePastFromPresentScreenState();
}

class _SeparatePastFromPresentScreenState
    extends State<SeparatePastFromPresentScreen>
    with SingleTickerProviderStateMixin {
  bool _isMovingAway = false;
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 600), () {
          if (mounted) {
            _animController.reverse();
            setState(() {
              _isMovingAway = false;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onMoveMemoryAway() {
    if (_isMovingAway) return;
    setState(() {
      _isMovingAway = true;
    });
    _animController.forward(from: 0.0);
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
                      label: 'MEMORY SEPARATION',
                      title: 'Separate past from\npresent',
                      subtitle:
                          'Press the button and watch the\nmemory move away from the present\nmoment.',
                    ),
                    const SizedBox(height: 20),
                    _buildMemoryCard(),
                    const SizedBox(height: 40),
                    PrimaryButton(
                      text: 'MOVE MEMORY AWAY',
                      height: 60,
                      onPressed: _onMoveMemoryAway,
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

  Widget _buildMemoryCard() {
    return SizedBox(
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Top-right decorative dot
          Positioned(
            top: 8,
            right: 40,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.peachAccent.withOpacity(0.6),
              ),
            ),
          ),
          // Bottom-left decorative dot
          Positioned(
            bottom: 8,
            left: 40,
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.textPrimary.withOpacity(0.3),
              ),
            ),
          ),
          // Main card
          AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(opacity: _opacityAnimation.value, child: child),
              );
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors.cardLikePillBg.withOpacity(0.2),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.glassCardBorder,
                  width: 1.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Brain icon in circle
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      color: AppColors.peachAccent.withOpacity(0.1),
                      border: Border.all(
                        color: AppColors.peachAccent.withOpacity(0.25),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.psychology_rounded,
                      color: AppColors.peachAccent,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Card text
                  const Text(
                    'Past trigger not\npresent danger',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
