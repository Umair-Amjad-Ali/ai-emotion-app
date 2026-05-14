import 'package:ai_emotion_app/screen/anger/anger_recheck_screen.dart';
import 'package:ai_emotion_app/widgets/session_progress_badge.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';

class ResponseChoiceScreen extends StatefulWidget {
  const ResponseChoiceScreen({super.key});

  @override
  State<ResponseChoiceScreen> createState() => _ResponseChoiceScreenState();
}

class _ResponseChoiceScreenState extends State<ResponseChoiceScreen> {
  double _dragPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

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
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.03),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Choose your response',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                'Drag the thumb and release near the\nresponse that best fits your current state.',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                          const SessionProgressBadge(
                            currentSessions: 8,
                            totalSessions: 10,
                            size: 60,
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // --- Interactive Slider Card ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 32,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              'SWIPE TO RESOLVE',
                              style: TextStyle(
                                color: AppColors.accentBlueLite.withOpacity(
                                  0.8,
                                ),
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.5,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.04),

                            LayoutBuilder(
                              builder: (context, constraints) {
                                final trackWidth = constraints.maxWidth;
                                const thumbSize = 64.0;
                                const padding = 4.0;

                                final maxDragDistance =
                                    trackWidth - thumbSize - (padding * 2);

                                return GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    setState(() {
                                      _dragPosition +=
                                          details.delta.dx / maxDragDistance;
                                      _dragPosition = _dragPosition.clamp(
                                        0.0,
                                        1.0,
                                      );
                                    });
                                  },
                                  child: Container(
                                    height: thumbSize + 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.cardLikePillBg
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.02),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        const BoxShadow(
                                          color: Color(0xFF0C1222),
                                          spreadRadius: -4.0,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        // Background Track Text Labels
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                'LATER',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                              Text(
                                                'CALMLY WALK',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.2),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Positioned(
                                          left:
                                              _dragPosition * maxDragDistance +
                                              4,
                                          child: Container(
                                            width: thumbSize,
                                            height: thumbSize,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.textPrimary,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.textPrimary
                                                      .withOpacity(0.4),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                ),
                                                BoxShadow(
                                                  color: AppColors
                                                      .accentBlueLite
                                                      .withOpacity(0.2),
                                                  blurRadius: 2,
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.unfold_more_rounded,
                                              color: Color(0xFF131722),
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: screenHeight * 0.03),

                            // Bottom Labels
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'LOWER INTENSITY',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Text(
                                  'HIGH INTENSITY',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AngerRecheckScreen(),
                            ),
                          );
                        },
                      ),
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
}
