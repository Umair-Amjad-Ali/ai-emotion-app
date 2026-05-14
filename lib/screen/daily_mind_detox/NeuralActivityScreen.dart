import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import './plasma_ball_widget.dart';
import 'ReleaseThoughtsScreen.dart'; // Using your existing plasma ball

class NeuralActivityScreen extends StatefulWidget {
  const NeuralActivityScreen({super.key});

  @override
  State<NeuralActivityScreen> createState() => _NeuralActivityScreenState();
}

class _NeuralActivityScreenState extends State<NeuralActivityScreen> {
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
                colors: [Color(0xff111F45), Color(0xff070B16)],
              ),
            ),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                const AppHeader(),

                const SizedBox(height: 20),
                

                // Heading
                const Text(
                  "Neural Activity",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                  child: Text(
                    "Observe mental activity without reacting.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.45),
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),

                const Spacer(),

                // 3. CENTRAL PLASMA BALL WIDGET
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer soft glow/shadow
                      Container(
                        width: screenWidth * 0.78,
                        height: screenWidth * 0.78,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff7BD3E9).withOpacity(0.08),
                              blurRadius: 60,
                              spreadRadius: 10,
                            ),
                          ],
                          // Darker rim container
                          color: const Color(0xff111F45).withOpacity(0.3),
                        ),
                      ),
                      // The Animated Plasma Ball
                      PlasmaBallWidget(
                        size: screenWidth * 0.72,
                        plasmaColor: const Color(0xff7BD3E9),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // 4. CONTINUE BUTTON
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: PrimaryButton(text: "CONTINUE", onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ReleaseThoughtsScreen()));
                  }),
                ),

                const SizedBox(height: 120), // Bottom Nav space
              ],
            ),
          ),

          // 5. BOTTOM NAV
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


}