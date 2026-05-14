import 'dart:ui';
import 'package:ai_emotion_app/screen/anger/perspective_shift_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class RageDumpScreen extends StatefulWidget {
  const RageDumpScreen({super.key});

  @override
  State<RageDumpScreen> createState() => _RageDumpScreenState();
}

class _RageDumpScreenState extends State<RageDumpScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  // Center Pulse Animations
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  // Text Destruction Animations
  late AnimationController _destroyController;
  late Animation<double> _textFadeAnim;
  late Animation<Offset> _textSlideAnim;
  late Animation<double> _textBlurAnim;
  late Animation<double> _textScaleAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _destroyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textFadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _destroyController, curve: Curves.easeOutCubic),
    );

    _textSlideAnim =
        Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0.05, -0.1),
        ).animate(
          CurvedAnimation(
            parent: _destroyController,
            curve: Curves.easeOutCubic,
          ),
        );

    _textBlurAnim = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(parent: _destroyController, curve: Curves.easeIn),
    );

    _textScaleAnim = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _destroyController, curve: Curves.easeOutCubic),
    );

    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_textController.text.isNotEmpty) {
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      _pulseController.stop();
      _pulseController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _pulseController.dispose();
    _destroyController.dispose();
    super.dispose();
  }

  void _onDestroyMessage() {
    if (_textController.text.trim().isEmpty) return;
    if (_destroyController.isAnimating) return;

    FocusScope.of(context).unfocus();

    _pulseController.stop();
    _pulseController.animateTo(0.0);

    _destroyController.forward().then((_) {
      _textController.clear();
      _destroyController.reset();

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PerspectiveShiftScreen()),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Message Destroyed. Moving to next step...'),
          backgroundColor: AppColors.cardBackgroundColor.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      Text(
                        'ANGER TAMER',
                        style: TextStyle(
                          color: AppColors.lightPink.withOpacity(0.7),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      const Text(
                        'Rage Dump Mode',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Text(
                        'Dump it exactly as it appears in your mind.\nThis message will not be sent. It will be\ndestroyed.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary.withOpacity(0.6),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      SizedBox(
                        height: screenHeight * 0.22,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Faint Outer Ring
                            Container(
                              width: screenWidth * 0.35,
                              height: screenWidth * 0.35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.lightPink.withOpacity(0.1),
                                  width: 1.0,
                                ),
                              ),
                            ),

                            // Animated Core
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Container(
                                    width: screenWidth * 0.18,
                                    height: screenWidth * 0.18,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.lightPink,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.lightPink
                                              .withOpacity(
                                                _glowAnimation.value,
                                              ),
                                          blurRadius: 40,
                                          spreadRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.bolt_rounded,
                                      color: AppColors.lightTextColor,
                                      size: 32,
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Small floating dust particles
                            Positioned(
                              top: 20,
                              right: 20,
                              child: _buildDustParticle(4),
                            ),
                            Positioned(
                              bottom: 30,
                              left: 20,
                              child: _buildDustParticle(6),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Write the angry message',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'DRAFTING CHAOS',
                            style: TextStyle(
                              color: AppColors.lightTextColor,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // --- The Text Box ---
                      Container(
                        height: screenHeight * 0.28,
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                              animation: _destroyController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _textScaleAnim.value,
                                  child: SlideTransition(
                                    position: _textSlideAnim,
                                    child: Opacity(
                                      opacity: _textFadeAnim.value,
                                      child: ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                          sigmaX: _textBlurAnim.value,
                                          sigmaY: _textBlurAnim.value,
                                        ),
                                        child: child,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: TextField(
                                controller: _textController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(20),
                                  hintText:
                                      'Type what you really want to say...',
                                  hintStyle: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.3,
                                    ),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),

                            // Bottom Right "Wind" Icon
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Icon(
                                Icons.air_rounded,
                                color: AppColors.textPrimary.withOpacity(0.2),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      PrimaryButton(
                        text: 'DESTROY MESSAGE',
                        onPressed: _onDestroyMessage,
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
      // bottomNavigationBar: const CustomBottomNavBar(),
      // extendBody: true,
    );
  }

  Widget _buildDustParticle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFFFFB4A8).withOpacity(0.4),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFB4A8).withOpacity(0.6),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}
