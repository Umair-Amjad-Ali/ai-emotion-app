import 'dart:ui';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/screen/restfullmind/forgiveness_reset.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class BubbleData {
  final String id;
  final String text;
  final double size;
  final Alignment alignment;

  BubbleData(this.id, this.text, this.size, this.alignment);
}

class EmotionalReleaseChamberScreen extends StatefulWidget {
  const EmotionalReleaseChamberScreen({super.key});

  @override
  State<EmotionalReleaseChamberScreen> createState() =>
      _EmotionalReleaseChamberScreenState();
}

class _EmotionalReleaseChamberScreenState
    extends State<EmotionalReleaseChamberScreen> {
  List<BubbleData> activeBubbles = [
    BubbleData('worry', 'WORRY', 100, const Alignment(-0.5, -0.9)),
    BubbleData('hurt', 'HURT', 90, const Alignment(0.5, -0.6)),
    BubbleData('tasks', 'UNFINISHED\nTASKS', 120, const Alignment(-0.8, 0.4)),
    BubbleData(
      'convo',
      'REPLAYED\nCONVERSATION',
      130,
      const Alignment(0.6, 0.3),
    ),
  ];

  int totalBubbles = 4;
  int get releasedCount => totalBubbles - activeBubbles.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const AppHeader(level: 'LEVEL 1'),

                const SizedBox(height: 16),

                // Progress text
                Text(
                  'PROGRESS 2 / 10',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 8),

                const ScreenHeader(
                  title: 'Release the day\ndownward',
                  subtitle:
                      'Drag each selected bubble into the\nchamber below.',
                ),

                // Bubble Area
                SizedBox(
                  height: 380,
                  child: Stack(
                    children: [
                      ...activeBubbles.map((bubble) {
                        return Align(
                          alignment: bubble.alignment,
                          child: Draggable<String>(
                            data: bubble.id,
                            feedback: Material(
                              color: Colors.transparent,
                              child: _buildBubbleWidget(bubble),
                            ),
                            childWhenDragging: const SizedBox.shrink(),
                            child: _buildBubbleWidget(bubble),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                // Released Count
                Text(
                  'RELEASED: $releasedCount / $totalBubbles',
                  style: const TextStyle(
                    color: Color(0xFF5BC0EB),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 16),

                // Drop Zone Chamber
                DragTarget<String>(
                  onAccept: (data) {
                    setState(() {
                      activeBubbles.removeWhere((b) => b.id == data);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    bool isHovered = candidateData.isNotEmpty;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: double.infinity,
                      height: 180,
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      decoration: BoxDecoration(
                        color: isHovered
                            ? const Color(0xff1B1F2E).withOpacity(0.8)
                            : const Color(0xff1B1F2E).withOpacity(0.4),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                        border: Border.all(
                          color: isHovered
                              ? const Color(0xFF5BC0EB).withOpacity(0.5)
                              : Colors.white.withOpacity(0.05),
                          width: 1.5,
                        ),
                        boxShadow: [
                          if (isHovered)
                            BoxShadow(
                              color: const Color(0xFF5BC0EB).withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 5,
                            )
                          else
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0xFF161A29),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Color(0xFF5BC0EB),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'DROP HERE TO LET IT GO',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: PrimaryButton(
                    text: 'CONTINUE',
                    height: 60,
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgivenessResetScreen())),
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
      extendBody: true,
    );
  }

  Widget _buildBubbleWidget(BubbleData bubble) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(bubble.size / 2),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: bubble.size,
          height: bubble.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF161A29).withOpacity(0.6),
            border: Border.all(
              color: Colors.white.withOpacity(0.05),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Text(
              bubble.text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
