import 'package:ai_emotion_app/screen/dailyantitode/intention_selection_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart';
import '../../widgets/primary_button.dart';

class DailyAntidoteDissolveScreen extends StatefulWidget {
  const DailyAntidoteDissolveScreen({super.key});

  @override
  State<DailyAntidoteDissolveScreen> createState() =>
      _DailyAntidoteDissolveScreenState();
}

class _DailyAntidoteDissolveScreenState
    extends State<DailyAntidoteDissolveScreen> {
  double _dragPercent = 0.0;

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
                      SizedBox(height: screenHeight * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Session Time',
                                  style: TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'BUILD MENTAL IMMUNITY',
                                  style: TextStyle(
                                    color: AppColors.textPrimary.withOpacity(
                                      0.6,
                                    ),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const CircularTimer(borderColor: Colors.red),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Badge ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlueLite.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.2),
                          ),
                        ),
                        child: const Text(
                          'THOUGHT DISSOLVER',
                          style: TextStyle(
                            color: AppColors.accentBlueLite,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Dissolve the remaining\ntoxins',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Swipe all the way to pull the selected toxins into the antidote field.',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.7),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // --- Visualizer: Rounded Image ---
                      Center(
                        child: Opacity(
                          opacity: (1.0 - _dragPercent).clamp(0.0, 1.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              'assets/pngs/toxins.png',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      _buildSliderCard(),

                      SizedBox(height: screenHeight * 0.04),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => IntentionSelectionScreen(),
                            ),
                          );
                        },
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
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  Widget _buildSliderCard() {
    int percentage = (_dragPercent * 100).toInt();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final double trackWidth = constraints.maxWidth;
              const double thumbSize = 64.0;
              // Precise math for full range movement
              final double maxDrag = trackWidth - thumbSize;
              final double leftPosition = _dragPercent * maxDrag;

              return Container(
                height: 72,
                width: trackWidth,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.bgDark.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: AppColors.textPrimary.withOpacity(0.05),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'SLIDE TO RELEASE',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.2),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: leftPosition,
                      top: 3, // Centering thumb vertically in a 72 height track
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _dragPercent =
                                (_dragPercent + details.delta.dx / maxDrag)
                                    .clamp(0.0, 1.0);
                          });
                        },
                        onPanEnd: (details) {
                          setState(() {
                            if (_dragPercent > 0.85) {
                              _dragPercent = 1.0;
                            } else {
                              _dragPercent = 0.0;
                            }
                          });
                        },
                        child: _buildGlowingThumb(thumbSize),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'DISSOLVING: ',
                style: TextStyle(
                  color: AppColors.textPrimary.withOpacity(0.5),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$percentage%',
                style: const TextStyle(
                  color: AppColors.accentBlueLite,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlowingThumb(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [Colors.white, AppColors.accentBlueLite.withOpacity(0.6)],
          stops: [0.1, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentBlueLite.withOpacity(0.6),
            blurRadius: 15,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'DISSOLVE',
          style: TextStyle(
            color: AppColors.bgDark,
            fontSize: 8,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
