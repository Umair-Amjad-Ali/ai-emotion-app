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
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const ScreenHeader(
                        title: 'Mind Clutter\nCrematorium',
                        subtitle: 'STEP 4: CREMATORIUM CHAMBER',
                      ),
                      const SizedBox(height: 24),
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
                      const SizedBox(height: 40),

                      // Draggable Thought Card
                      _buildDraggableCard(),

                      const SizedBox(height: 60),

                      // Furnace Drop Target
                      _buildFurnace(),

                      const SizedBox(height: 40),

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

                      const SizedBox(height: 40),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          // Handle continue
                        },
                      ),

                      const SizedBox(height: 120),
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

  Widget _buildDraggableCard() {
    if (_isDropped) {
      return const SizedBox(height: 220); // Maintain spacing
    }

    return Draggable<String>(
      data: 'thought',
      feedback: Material(
        color: Colors.transparent,
        child: _buildThoughtCard(isFeedback: true),
      ),
      childWhenDragging: Opacity(opacity: 0.3, child: _buildThoughtCard()),
      child: _buildThoughtCard(),
    );
  }

  Widget _buildThoughtCard({bool isFeedback = false}) {
    return Container(
      width: 180,
      height: 220,
      decoration: BoxDecoration(
        color: AppColors.bgDark.withOpacity(0.8),
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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accentBlueLite.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.layers_outlined,
              color: AppColors.accentBlueLite,
              size: 32,
            ),
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

  Widget _buildFurnace() {
    return DragTarget<String>(
      onWillAccept: (data) => data == 'thought',
      onAccept: (data) {
        setState(() {
          _isDropped = true;
        });
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;

        return Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                isHovering
                    ? const Color(0xFFE06080).withOpacity(0.3)
                    : const Color(0xFF131B2B).withOpacity(0.4),
                const Color(0xFF131B2B).withOpacity(0.8),
              ],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(160),
              topRight: Radius.circular(160),
            ),
            border: Border.all(
              color: isHovering
                  ? const Color(0xFFE06080).withOpacity(0.5)
                  : Colors.white.withOpacity(0.05),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'DROP THOUGHT HERE',
                style: TextStyle(
                  color:
                      (isHovering
                              ? const Color(0xFFE06080)
                              : const Color(0xFFE8C6B0))
                          .withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: isHovering
                        ? const Color(0xFFE06080)
                        : const Color(0xFFE8C6B0).withOpacity(0.5),
                    size: 24,
                  ),
                  Container(
                    width: 60,
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    color:
                        (isHovering
                                ? const Color(0xFFE06080)
                                : const Color(0xFFE8C6B0))
                            .withOpacity(0.2),
                  ),
                  Icon(
                    Icons.local_fire_department_rounded,
                    color: isHovering
                        ? const Color(0xFFE06080)
                        : const Color(0xFFE8C6B0).withOpacity(0.5),
                    size: 24,
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
