import 'package:ai_emotion_app/screen/daily_mind_detox/MindActivityScreen.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class DailyMindDetoxSelectionScreen extends StatefulWidget {
  const DailyMindDetoxSelectionScreen({super.key});

  @override
  State<DailyMindDetoxSelectionScreen> createState() =>
      _DailyMindDetoxSelectionScreenState();
}

class _DailyMindDetoxSelectionScreenState
    extends State<DailyMindDetoxSelectionScreen> {
  int _currentIndex = 0;

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
                colors: [Color(0xff111F45), Color(0xff141625)],
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
                    padding:
                    EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          "Daily Mind Detox",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Choose your path to mental clarity. Soft\nguidance for a quiet mind.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Selection Cards
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MindActivityScreen()));
                          },
                          child: _buildSelectionCard(
                            icon: Icons.bolt_rounded,
                            title: "3 Minute Quick Detox",
                            subtitle: "Rapid presence for busy moments",
                            glowColor: const Color(0xff7FD6FF).withOpacity(0.15),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildSelectionCard(
                          icon: Icons.refresh_rounded,
                          title: "5 Minute Reset",
                          subtitle: "Recenter your focus and breath",
                          glowColor: const Color(0xff7FD6FF).withOpacity(0.1),
                        ),
                        const SizedBox(height: 16),
                        _buildSelectionCard(
                          icon: Icons.self_improvement_rounded,
                          title: "10 Minute Deep Detox",
                          subtitle: "Profound immersion into stillness",
                          glowColor: const Color(0xff7FD6FF).withOpacity(0.08),
                        ),

                        const SizedBox(height: 24),

                        // Focus Theme Card
                        _buildFocusThemeCard(),

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

  Widget _buildSelectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color glowColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.0),
      ),
      child: Row(
        children: [
          // Icon Badge with Glow Effect
          Container(
            height: 54,
            width: 54,
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
            child: Icon(icon, color: const Color(0xff7FD6FF), size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusThemeCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xff1A1F2E).withOpacity(0.5),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // 1. ADDED BACKGROUND IMAGE (Right Aligned)
            Positioned.fill(
              child: Image.asset(
                'assets/pngs/bgs/crystalline_clarity_bg.png', // Ensure your asset path matches
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              ),
            ),

            // 2. UPDATED GRADIENT OVERLAY (Fades image out to the left for text readability)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: const [0.4, 1.0],
                    colors: [
                      const Color(0xff0D1321).withOpacity(0.95), // Dark solid on text side
                      Colors.transparent, // Reveal image on graphic side
                    ],
                  ),
                ),
              ),
            ),

            // 3. CONTENT
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xff3D2E2E).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "FOCUS THEME",
                      style: TextStyle(
                        color: Color(0xffFFB4A8),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Crystalline Clarity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Today's environment is\noptimized for high-frequency\nfocus. Let the light guide your\nintent.",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        "View Reflection Journal",
                        style: TextStyle(
                          color: Color(0xff7FD6FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.arrow_right_alt,
                          color: const Color(0xff7FD6FF).withOpacity(0.7),
                          size: 18),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}