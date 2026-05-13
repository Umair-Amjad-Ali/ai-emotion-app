import 'package:ai_emotion_app/core/theme/app_colors.dart';
import 'package:ai_emotion_app/widgets/app_background.dart';
import 'package:ai_emotion_app/widgets/app_header.dart';
import 'package:ai_emotion_app/widgets/custom_bottom_nav_bar.dart';
import 'package:ai_emotion_app/widgets/glass_card.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:ai_emotion_app/widgets/screen_header.dart';
import 'package:flutter/material.dart';

class ThoughtCaptureScreen extends StatefulWidget {
  const ThoughtCaptureScreen({super.key});

  @override
  State<ThoughtCaptureScreen> createState() => _ThoughtCaptureScreenState();
}

class _ThoughtCaptureScreenState extends State<ThoughtCaptureScreen> {
  final TextEditingController _thoughtController = TextEditingController();
  String? _selectedCategory;

  final List<String> _categories = [
    'Regret',
    'Anger',
    'Worry',
    'Self-criticism',
    'Fear',
    'Overthinking',
  ];

  @override
  void dispose() {
    _thoughtController.dispose();
    super.dispose();
  }

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ScreenHeader(
                        title: 'What thought is\nbothering you right\nnow?',
                        subtitle: "Don't overthink it...",
                      ),
                      const SizedBox(height: 24),
                      
                      // Thought Input Card
                      GlassCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextField(
                              controller: _thoughtController,
                              maxLines: 8,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Example: I keep replaying what I should have said...',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.2),
                                  fontSize: 18,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Enter to Breathe Pill
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.textPrimary.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.subdirectory_arrow_left_rounded,
                                    size: 14,
                                    color: AppColors.textPrimary.withOpacity(0.5),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'PRESS ENTER TO BREATHE',
                                    style: TextStyle(
                                      color: AppColors.textPrimary.withOpacity(0.6),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Categorization Section
                      Text(
                        'CATEGORIZE THIS THOUGHT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary.withOpacity(0.5),
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Category Chips
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: _categories.map((category) => _buildCategoryChip(category)).toList(),
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

  Widget _buildCategoryChip(String category) {
    final bool isSelected = _selectedCategory == category;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.accentBlueLite.withOpacity(0.1) 
              : AppColors.cardLikePillBg.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? AppColors.accentBlueLite.withOpacity(0.5) 
                : AppColors.textPrimary.withOpacity(0.05),
          ),
        ),
        child: Text(
          category,
          style: TextStyle(
            color: isSelected ? AppColors.textPrimary : AppColors.textPrimary.withOpacity(0.6),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
