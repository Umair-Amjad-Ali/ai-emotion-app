import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ReconnectToWhatIsRealScreen extends StatefulWidget {
  const ReconnectToWhatIsRealScreen({super.key});

  @override
  State<ReconnectToWhatIsRealScreen> createState() =>
      _ReconnectToWhatIsRealScreenState();
}

class _ReconnectToWhatIsRealScreenState
    extends State<ReconnectToWhatIsRealScreen> {
  final Set<int> _completedTasks = {};

  final List<_GroundingTask> _tasks = [
    _GroundingTask(
      label: 'SEE 1',
      icon: Icons.visibility_outlined,
      accentColor: AppColors.accentBlueLite,
    ),
    _GroundingTask(
      label: 'SEE 2',
      icon: Icons.visibility_outlined,
      accentColor: AppColors.accentBlueLite,
    ),
    _GroundingTask(
      label: 'SEE 3',
      icon: Icons.visibility_outlined,
      accentColor: AppColors.accentBlueLite,
    ),
    _GroundingTask(
      label: 'TOUCH 1',
      icon: Icons.pan_tool_outlined,
      accentColor: AppColors.peachAccent,
    ),
    _GroundingTask(
      label: 'TOUCH 2',
      icon: Icons.pan_tool_outlined,
      accentColor: AppColors.peachAccent,
    ),
    _GroundingTask(
      label: 'HEAR 1',
      icon: Icons.hearing_outlined,
      accentColor: AppColors.peachAccent,
    ),
  ];

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
                      title: 'Reconnect to what\nis real',
                      subtitle:
                          'Tap each box as you complete the\ngrounding task.',
                    ),
                    _buildTasksGrid(),
                    _buildProgressCircle(),
                    const SizedBox(height: 28),
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

  Widget _buildTasksGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24.0,
        mainAxisSpacing: 20.0,
        childAspectRatio: 1.1,
      ),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return _buildTaskItem(index);
      },
    );
  }

  Widget _buildTaskItem(int index) {
    final task = _tasks[index];
    final bool isCompleted = _completedTasks.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_completedTasks.contains(index)) {
            _completedTasks.remove(index);
          } else {
            _completedTasks.add(index);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isCompleted
              ? task.accentColor.withOpacity(0.08)
              : AppColors.cardLikePillBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: isCompleted
                ? task.accentColor.withOpacity(0.5)
                : AppColors.glassCardBorder,
            width: isCompleted ? 1.5 : 1.0,
          ),
          boxShadow: isCompleted
              ? [
                  BoxShadow(
                    color: task.accentColor.withOpacity(0.12),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular icon container
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? task.accentColor.withOpacity(0.15)
                    : AppColors.glassCardBg.withOpacity(0.2),
                border: Border.all(
                  color: isCompleted
                      ? task.accentColor.withOpacity(0.5)
                      : AppColors.textPrimary.withOpacity(0.05),
                  width: 1.5,
                ),
                boxShadow: isCompleted
                    ? [
                        BoxShadow(
                          color: task.accentColor.withOpacity(0.2),
                          blurRadius: 16,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: isCompleted
                  ? Icon(Icons.check_rounded, color: task.accentColor, size: 30)
                  : Icon(task.icon, color: task.accentColor, size: 28),
            ),
            const SizedBox(height: 10),
            // Label
            Text(
              task.label,
              style: TextStyle(
                color: AppColors.textPrimary.withOpacity(0.7),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCircle() {
    final int completed = _completedTasks.length;
    final int total = _tasks.length;
    final double progress = total > 0 ? completed / total : 0;

    return Center(
      child: SizedBox(
        width: 120,
        height: 120,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background ring
            SizedBox(
              width: 120,
              height: 120,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 3,
                color: AppColors.textPrimary.withOpacity(0.06),
              ),
            ),
            // Progress ring
            SizedBox(
              width: 120,
              height: 120,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: progress),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOut,
                builder: (context, value, _) {
                  return CircularProgressIndicator(
                    value: value,
                    strokeWidth: 3,
                    color: AppColors.accentBlueLite,
                    strokeCap: StrokeCap.round,
                  );
                },
              ),
            ),
            // Counter text
            Text(
              '$completed/$total',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 32,
                fontWeight: FontWeight.w300,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Data model for a grounding task item.
class _GroundingTask {
  final String label;
  final IconData icon;
  final Color accentColor;

  const _GroundingTask({
    required this.label,
    required this.icon,
    required this.accentColor,
  });
}
