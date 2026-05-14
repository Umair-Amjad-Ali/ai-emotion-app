import 'package:ai_emotion_app/screen/dailyantitode/daily_antidote_dissolve_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/circular_timer.dart'; // Reusable timer widget
import '../../widgets/primary_button.dart';

class DailyAntidoteReconnectScreen extends StatefulWidget {
  const DailyAntidoteReconnectScreen({super.key});

  @override
  State<DailyAntidoteReconnectScreen> createState() =>
      _DailyAntidoteReconnectScreenState();
}

class _DailyAntidoteReconnectScreenState
    extends State<DailyAntidoteReconnectScreen> {
  final Set<String> _completedTasks = {};

  void _toggleTask(String taskId) {
    setState(() {
      if (_completedTasks.contains(taskId)) {
        _completedTasks.remove(taskId);
      } else {
        _completedTasks.add(taskId);
      }
    });
  }

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

                      // --- Session Time Header ---
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
                          // Reusable Timer Widget
                          const CircularTimer(borderColor: Colors.red),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Section Headers ---
                      Text(
                        'THE NOT YOU',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Daily Antidote',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Present Anchor Badge ---
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accentBlueLite.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.accentBlueLite.withOpacity(0.3),
                            width: 1.0,
                          ),
                        ),
                        child: Text(
                          'Present Anchor',
                          style: TextStyle(
                            color: AppColors.accentBlueLite,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // --- Main Titles ---
                      Text(
                        'Reconnect to the\npresent',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap each box as you complete the grounding\ntask.',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.6),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Grounding Task Grid ---
                      Row(
                        children: [
                          Expanded(
                            child: _buildTaskBox(
                              id: 'sound1',
                              label: 'SOUND 1',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTaskBox(
                              id: 'sound2',
                              label: 'SOUND 2',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTaskBox(
                              id: 'object1',
                              label: 'OBJECT 1',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTaskBox(
                              id: 'object2',
                              label: 'OBJECT 2',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTaskBox(
                              id: 'sensation',
                              label: 'SENSATION',
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(child: SizedBox()),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.05),

                      // --- Continue Button ---
                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DailyAntidoteDissolveScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.12), // Bottom padding
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

  // --- Individual Interactive Task Box ---
  Widget _buildTaskBox({required String id, required String label}) {
    final isSelected = _completedTasks.contains(id);

    return GestureDetector(
      onTap: () => _toggleTask(id),
      child: SizedBox(
        height: 100, // Fixed height to make them perfectly proportioned
        child: Stack(
          children: [
            // Main Box Background
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentBlueLite.withOpacity(0.1)
                    : AppColors.cardLikePillBg.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentBlueLite.withOpacity(0.6)
                      : Colors.white.withOpacity(0.1),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.accentBlueLite.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 1,
                        ),
                      ]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
            ),

            // --- The 4 delicate corner dots seen in the design ---
            Positioned(top: 8, left: 8, child: _buildCornerDot(isSelected)),
            Positioned(top: 8, right: 8, child: _buildCornerDot(isSelected)),
            Positioned(bottom: 8, left: 8, child: _buildCornerDot(isSelected)),
            Positioned(bottom: 8, right: 8, child: _buildCornerDot(isSelected)),
          ],
        ),
      ),
    );
  }

  // --- Tiny Corner Dot Widget ---
  Widget _buildCornerDot(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 2.5,
      height: 2.5,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.accentBlueLite
            : AppColors.accentBlueLite.withOpacity(0.4),
        shape: BoxShape.circle,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.accentBlueLite,
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
    );
  }
}
