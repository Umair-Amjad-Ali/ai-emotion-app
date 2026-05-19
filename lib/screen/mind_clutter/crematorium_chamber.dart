import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class CrematoriumChamberScreen extends StatefulWidget {
  const CrematoriumChamberScreen({super.key});

  @override
  State<CrematoriumChamberScreen> createState() =>
      _CrematoriumChamberScreenState();
}

class _CrematoriumChamberScreenState extends State<CrematoriumChamberScreen> {
  bool _isDropped = false;

  @override
  Widget build(BuildContext context) {
    // Fetch screen dimensions for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    final cardWidth = screenWidth * 0.5;
    final cardHeight = screenWidth * 0.6;
    final furnaceHeight = screenHeight * 0.18;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  // Responsive horizontal padding
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        title: 'Mind Clutter\nCrematorium',
                        subtitle: 'STEP 4: CREMATORIUM CHAMBER',
                      ),

                      Text(
                        'Drag the thought container into the furnace to\nbegin the purification ritual.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      // Draggable Thought Card
                      _buildDraggableCard(cardWidth, cardHeight),

                      SizedBox(height: screenHeight * 0.07),
                      _buildFurnace(furnaceHeight),

                      SizedBox(
                        height: screenHeight * 0.05,
                      ), // Responsive spacing

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '"Release the past. Each thought consumed strengthens your presence in the now."',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.5),
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: screenHeight * 0.05,
                      ), // Responsive spacing

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          // Handle continue
                        },
                      ),

                      const SizedBox(
                        height: 120,
                      ), // Standard bottom nav padding
                    ],
                  ),
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

  Widget _buildDraggableCard(double width, double height) {
    if (_isDropped) {
      return SizedBox(height: height); // Maintain exact spacing when dropped
    }

    return Draggable<String>(
      data: 'thought',
      feedback: Material(
        color: Colors.transparent,
        child: _buildThoughtCard(width, height, isFeedback: true),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: _buildThoughtCard(width, height),
      ),
      child: _buildThoughtCard(width, height),
    );
  }

  Widget _buildThoughtCard(
    double width,
    double height, {
    bool isFeedback = false,
  }) {
    return Container(
      width: width, // Responsive width
      height: height, // Responsive height
      decoration: BoxDecoration(
        color: AppColors.bgDark.withOpacity(0.2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColors.bgDark.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accentBlueLite.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Image.asset('assets/pngs/regret.png', width: 20, height: 20),
          ),
          const SizedBox(height: 20),
          const Text(
            'Regret',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '"Heavy burden"',
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.6),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentBlueLite.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFurnace(double height) {
    return DragTarget<String>(
      onWillAccept: (data) => data == 'thought',
      onAccept: (data) {
        setState(() {
          _isDropped = true;
        });
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;

        // Synced color for everything
        final primaryColor = isHovering
            ? const Color(0xFFE06080)
            : AppColors.lightPink.withOpacity(0.8);

        return Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: AppColors.cardLikePillBg.withOpacity(0.6),

            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(120),
              topRight: Radius.circular(120),
            ),

            // 2. MUCH SOFTER OUTER GLOW
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(isHovering ? 0.15 : 0.15),
                blurRadius: 60,
                spreadRadius: 2,
                offset: const Offset(0, -20),
              ),
            ],

            // Top and sides only border
            border: Border(
              top: BorderSide(
                color: primaryColor.withOpacity(isHovering ? 0.6 : 0.3),
                width: 1.5,
              ),
              left: BorderSide(
                color: primaryColor.withOpacity(isHovering ? 0.6 : 0.3),
                width: 1.5,
              ),
              right: BorderSide(
                color: primaryColor.withOpacity(isHovering ? 0.6 : 0.3),
                width: 1.5,
              ),
              bottom: BorderSide.none,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Text(
                'DROP THOUGHT HERE',
                style: TextStyle(
                  color: primaryColor.withOpacity(isHovering ? 0.9 : 0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5.0,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: primaryColor.withOpacity(isHovering ? 0.9 : 0.7),
                    size: 28,
                  ),

                  // Fading gradient center line
                  Container(
                    width: 100,
                    height: 1.5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          primaryColor.withOpacity(isHovering ? 0.8 : 0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  Icon(
                    Icons.local_fire_department_rounded,
                    color: primaryColor.withOpacity(isHovering ? 0.9 : 0.7),
                    size: 28,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
