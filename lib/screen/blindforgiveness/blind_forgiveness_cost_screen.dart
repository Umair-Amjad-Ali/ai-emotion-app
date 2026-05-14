import 'package:ai_emotion_app/screen/blindforgiveness/decision_gate_screen.dart';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/custom_video_player.dart';

enum MediaType { image, video }

class BlindForgivenessCostScreen extends StatefulWidget {
  final MediaType mediaType;
  final String mediaPath;

  const BlindForgivenessCostScreen({
    super.key,
    this.mediaType = MediaType.video,
    this.mediaPath = 'assets/animations/galaxy.mp4',
  });

  @override
  State<BlindForgivenessCostScreen> createState() =>
      _BlindForgivenessCostScreenState();
}

class _BlindForgivenessCostScreenState
    extends State<BlindForgivenessCostScreen> {
  final Set<int> _selectedIndices = {};

  final List<Map<String, dynamic>> _costs = [
    {
      'title': 'Mental Energy',
      'icon': Icons.bolt_rounded,
      'color': AppColors.accentBlueLite,
    },
    {
      'title': 'Emotional Peace',
      'icon': Icons.self_improvement_rounded,
      'color': AppColors.peachAccent,
    },
    {
      'title': 'Time Lost',
      'icon': Icons.access_time_rounded,
      'color': Colors.orangeAccent,
    },
  ];

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
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
                    children: [
                      SizedBox(height: screenHeight * 0.01),

                      Text(
                        'THE NOT YOU',
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 3.0,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        'Blind Forgiveness',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      Container(
                        width: double.infinity,
                        height: screenWidth * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (widget.mediaType == MediaType.video) ...[
                                CustomVideoPlayer(
                                  height: screenWidth * 0.85,
                                  width: double.infinity,
                                  videoPath: widget.mediaPath,
                                  isLooping: true,
                                ),
                                Container(
                                  color: AppColors.accentBlueLite.withOpacity(
                                    0.08,
                                  ),
                                ),
                              ] else ...[
                                Image.asset(
                                  widget.mediaPath,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.accentBlueLite.withOpacity(
                                          0.18,
                                        ),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 24,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cardLikePillBg.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(
                            color: AppColors.textPrimary.withOpacity(0.05),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'What is this costing you?',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Text(
                              "Forgiving without boundaries isn't\npeace—it's a quiet debt you're\npaying with your own vitality. Notice\nwhere the energy is leaking.",
                              style: TextStyle(
                                color: AppColors.textPrimary.withOpacity(0.6),
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: screenHeight * 0.04),
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _costs.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: screenHeight * 0.015),
                              itemBuilder: (context, index) {
                                return _buildCostOption(
                                  index: index,
                                  title: _costs[index]['title'],
                                  icon: _costs[index]['icon'],
                                  color: _costs[index]['color'],
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      PrimaryButton(
                        text: 'CONTINUE',
                        onPressed: _selectedIndices.isNotEmpty
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DecisionGateScreen(),
                                  ),
                                );
                              }
                            : () {},
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

  Widget _buildCostOption({
    required int index,
    required String title,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedIndices.contains(index);

    return GestureDetector(
      onTap: () => _toggleSelection(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.1)
              : AppColors.textPrimary.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? color.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Left Icon
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.15),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Text(
              isSelected ? 'SELECTED' : 'TAP',
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
