import 'package:ai_emotion_app/screen/daily_mind_detox/NeuralActivityScreen.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class MindActivityScreen extends StatefulWidget {
  const MindActivityScreen({super.key});

  @override
  State<MindActivityScreen> createState() => _MindActivityScreenState();
}

class _MindActivityScreenState extends State<MindActivityScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Matching your theme)
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
                        const SizedBox(height: 40),
                        Text(
                          "How active is your mind?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 60),

                        // Activity Cards
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>NeuralActivityScreen()));
                          },
                          child: _buildActivityCard(
                            icon: Icons.local_florist_outlined, // Lotus-like icon
                            title: "Calm",
                            subtitle: "Feeling centered and present",
                            glowColor: const Color(0xff7FD6FF).withOpacity(0.15),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildActivityCard(
                          icon: Icons.bolt_rounded,
                          title: "Busy",
                          subtitle: "Many thoughts, but manageable",
                          glowColor: const Color(0xff7FD6FF).withOpacity(0.12),
                        ),
                        const SizedBox(height: 20),
                        _buildActivityCard(
                          icon: Icons.cyclone_rounded, // Spiral/Cyclone icon
                          title: "Overthinking",
                          subtitle: "Thoughts are loud and spinning",
                          glowColor: const Color(0xff7FD6FF).withOpacity(0.1),
                        ),

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

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color glowColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        // Dark translucent card color matching your Detox Selection screen
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.0),
      ),
      child: Row(
        children: [
          // Icon Badge with Glow Effect
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                  color: glowColor,
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: const Color(0xff7FD6FF), size: 28),
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
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
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
          Icon(
            Icons.chevron_right_rounded,
            color: Colors.white.withOpacity(0.15),
            size: 24,
          ),
        ],
      ),
    );
  }
}