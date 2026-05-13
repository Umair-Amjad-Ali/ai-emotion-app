import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/release_physical_tension2.dart';
import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ReleasePhysicalTensionScreen extends StatefulWidget {
  const ReleasePhysicalTensionScreen({super.key});

  @override
  State<ReleasePhysicalTensionScreen> createState() =>
      _ReleasePhysicalTensionScreenState();
}

class _ReleasePhysicalTensionScreenState
    extends State<ReleasePhysicalTensionScreen> {
  final Set<int> _completedActions = {};

  final List<_TensionAction> _actions = const [
    _TensionAction(
      label: 'Unclench jaw',
      icon: Icons.sentiment_neutral_rounded,
    ),
    _TensionAction(
      label: 'Drop shoulders',
      icon: Icons.accessibility_new_rounded,
    ),
    _TensionAction(label: 'Relax hands', icon: Icons.pan_tool_outlined),
    _TensionAction(label: 'Slow breathing', icon: Icons.air_rounded),
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
                      label: 'BODY RELEASE',
                      title: 'Release physical\ntension',
                      subtitle: 'Tap each action as you do it.',
                    ),
                    const SizedBox(height: 8),
                    ..._buildActionTiles(),
                    const SizedBox(height: 28),
                    PrimaryButton(
                      text: 'CONTINUE',
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ReleasePhysicalTension2Screen(),
                          ),
                        );
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

  List<Widget> _buildActionTiles() {
    final List<Widget> tiles = [];
    for (int i = 0; i < _actions.length; i++) {
      tiles.add(_buildActionTile(i));
      if (i < _actions.length - 1) {
        tiles.add(const SizedBox(height: 14));
      }
    }
    return tiles;
  }

  Widget _buildActionTile(int index) {
    final action = _actions[index];
    final bool isCompleted = _completedActions.contains(index);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_completedActions.contains(index)) {
            _completedActions.remove(index);
          } else {
            _completedActions.add(index);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: isCompleted
              ? AppColors.accentBlueLite.withOpacity(0.06)
              : AppColors.cardLikePillBg.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isCompleted
                ? AppColors.accentBlueLite.withOpacity(0.4)
                : AppColors.glassCardBorder,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Icon badge
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: isCompleted
                    ? AppColors.accentBlueLite.withOpacity(0.15)
                    : AppColors.accentBlueLite.withOpacity(0.08),
                border: Border.all(
                  color: isCompleted
                      ? AppColors.accentBlueLite.withOpacity(0.3)
                      : AppColors.accentBlueLite.withOpacity(0.12),
                  width: 1.0,
                ),
              ),
              child: Icon(
                action.icon,
                color: AppColors.accentBlueLite,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Label
            Expanded(
              child: Text(
                action.label,
                style: TextStyle(
                  color: isCompleted
                      ? AppColors.textPrimary
                      : AppColors.textPrimary.withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Circle checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.accentBlueLite.withOpacity(0.15)
                    : Colors.transparent,
                border: Border.all(
                  color: isCompleted
                      ? AppColors.accentBlueLite
                      : AppColors.textPrimary.withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: isCompleted
                  ? const Icon(
                      Icons.check_rounded,
                      color: AppColors.accentBlueLite,
                      size: 12,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

/// Data model for a tension release action.
class _TensionAction {
  final String label;
  final IconData icon;

  const _TensionAction({required this.label, required this.icon});
}
