import 'package:ai_emotion_app/screen/daily_mind_detox/BreathingStabilizationScreen.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class ThoughtScanSelectionScreen extends StatefulWidget {
  const ThoughtScanSelectionScreen({super.key});

  @override
  State<ThoughtScanSelectionScreen> createState() => _ThoughtScanSelectionScreenState();
}

class _ThoughtScanSelectionScreenState extends State<ThoughtScanSelectionScreen> {
  int _currentIndex = 0;

  // Track selected thoughts
  final Set<String> _selectedThoughts = {};

  void _toggleSelection(String thought) {
    setState(() {
      if (_selectedThoughts.contains(thought)) {
        _selectedThoughts.remove(thought);
      } else {
        _selectedThoughts.add(thought);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff111F45), Color(0xff070B16)],
              ),
            ),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                const AppHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),

                        // Progress/Indicator bar (Subtle white line)
                        Container(
                          width: 30,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        const SizedBox(height: 24),
                        Text(
                          "Tap thoughts appearing in your\nconsciousness right now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 18,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Selection Cards
                        _buildThoughtTile(
                          id: "past_replay",
                          icon: Icons.history_rounded,
                          title: "Past Replay",
                          glowColor: const Color(0xff7FD6FF).withOpacity(0.12),
                        ),
                        const SizedBox(height: 16),
                        _buildThoughtTile(
                          id: "future_worry",
                          icon: Icons.update_rounded,
                          title: "Future Worry",
                          glowColor: const Color(0xffFFB4A8).withOpacity(0.08),
                        ),
                        const SizedBox(height: 16),
                        _buildThoughtTile(
                          id: "self_criticism",
                          icon: Icons.psychology_alt_outlined,
                          title: "Self Criticism",
                          glowColor: const Color(0xffFFB4A8).withOpacity(0.06),
                        ),

                        const SizedBox(height: 40),

                        // CONTINUE BUTTON
                        PrimaryButton(text: "CONTINUE", onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BreathingStabilizationScreen()));
                        }),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. BOTTOM NAV
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              selectedIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThoughtTile({
    required String id,
    required IconData icon,
    required String title,
    required Color glowColor,
  }) {
    bool isSelected = _selectedThoughts.contains(id);

    return GestureDetector(
      onTap: () => _toggleSelection(id),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(isSelected ? 0.12 : 0.07),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.05),
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            // Icon with Glow
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.2),
                boxShadow: [
                  BoxShadow(
                    color: glowColor,
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(icon, color: isSelected ? Colors.white : Colors.white.withOpacity(0.6), size: 24),
            ),
            const SizedBox(width: 20),

            // Text
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(isSelected ? 1.0 : 0.8),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Custom Radio Circle
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xff7FD6FF) : Colors.white.withOpacity(0.15),
                  width: 2,
                ),
                color: isSelected ? const Color(0xff7FD6FF).withOpacity(0.2) : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(child: Icon(Icons.check, size: 14, color: Color(0xff7FD6FF)))
                  : null,
            ),
          ],
        ),
      ),
    );
  }

}
