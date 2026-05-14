import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../splash/splash_screen.dart';
import 'PanicStabilizerScreen.dart';

class StabilizationCompleteScreen extends StatefulWidget {
  const StabilizationCompleteScreen({super.key});

  @override
  State<StabilizationCompleteScreen> createState() => _StabilizationCompleteScreenState();
}

class _StabilizationCompleteScreenState extends State<StabilizationCompleteScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),

                        // --- GEOMETRIC HEART SECTION ---
                        _buildGeometricHeart(screenWidth),

                        const SizedBox(height: 40),

                        // --- COMPLETION CARD ---
                        _buildCompletionCard(screenWidth),

                        const SizedBox(height: 120), // Bottom nav space
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

  Widget _buildGeometricHeart(double width) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer Glow
        Container(
          width: width * 0.6,
          height: width * 0.6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff7FD6FF).withOpacity(0.15),
                blurRadius: 100,
                spreadRadius: 20,
              ),
            ],
          ),
        ),
        // The Heart Shape (Assuming an SVG or Image asset for the geometric lines)
        // Using an Icon/Image placeholder with the specific gradient
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffBDEBFF), Color(0xffFFD1D1)],
            ).createShader(bounds);
          },
          child: Icon(
            Icons.favorite,
            size: width * 0.55,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionCard(double width) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(44),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Text(
            "PHASE 04 COMPLETE",
            style: TextStyle(
              color: const Color(0xff7FD6FF).withOpacity(0.6),
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 2.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Stabilization\nComplete",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Your neural pathways have reached a state of balanced resonance. The detox session is successfully integrated.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),

          // --- STATS ROW ---
          Row(
            children: [
              Expanded(child: _buildStatItem("FOCUS LEVEL", "94%", Icons.trending_up)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatItem("STABILITY RANK", "A+", Icons.verified_user_outlined)),
            ],
          ),

          const SizedBox(height: 32),

          // Divider Line
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              color: Colors.white.withOpacity(0.05),
            ),
          ),

          const SizedBox(height: 32),

          // --- START AGAIN BUTTON ---
          GestureDetector(
            onTap: (){


             /*Navigator.popUntil(
                context,
                    (route) {
                  return route.settings is MaterialPageRoute &&
                      (route.settings as MaterialPageRoute).builder(context) is PanicStabilizerScreen;
                },
              );*/


              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PanicStabilizerScreen(),
                ),
                    (route) => false,
              );

            },
            child: Container(
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xff2D364D).withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Center(
                child: Text(
                  "START AGAIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 9,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              Icon(icon, size: 14, color: const Color(0xffFFB4A8).withOpacity(0.7)),
            ],
          ),
        ],
      ),
    );
  }
}