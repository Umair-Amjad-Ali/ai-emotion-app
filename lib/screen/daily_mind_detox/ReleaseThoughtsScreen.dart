import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'ThoughtScanSelectionScreen.dart';

class ReleaseThoughtsScreen extends StatefulWidget {
  const ReleaseThoughtsScreen({super.key});

  @override
  State<ReleaseThoughtsScreen> createState() => _ReleaseThoughtsScreenState();
}

class _ReleaseThoughtsScreenState extends State<ReleaseThoughtsScreen> {
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

          // Background Flares (Subtle glows for depth)
          Positioned(
            top: 150,
            right: -50,
            child: _buildFlare(300, const Color(0xff3299FF).withOpacity(0.05)),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            child: Column(
              children: [
                const AppHeader(),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),

                        // CENTRAL FURNACE CARD AREA
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Floating "Thought" Icons
                            Positioned(
                              top: -20,
                              right: -20,
                              child: _buildFloatingThought(Icons.psychology_outlined),
                            ),
                            Positioned(
                              top: 20,
                              left: -30,
                              child: _buildFloatingThought(Icons.blur_on),
                            ),

                            // Main Furnace Glass Card
                            Container(
                              width: screenWidth * 0.65,
                              height: screenWidth * 0.65,
                              decoration: BoxDecoration(
                                color: const Color(0xff1A1F2E).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.08),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  )
                                ],
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Flame Glow
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xffFF8C66).withOpacity(0.3),
                                            blurRadius: 40,
                                            spreadRadius: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                    // Flame Icon
                                    Icon(
                                      Icons.local_fire_department_rounded,
                                      size: 80,
                                      color: const Color(0xffFF8C66).withOpacity(0.8),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(flex: 3),

                        // TEXT CONTENT
                        const Text(
                          "Release Thoughts",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Drag thoughts into the furnace to clear your mind.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),

                        const Spacer(flex: 2),

                        // RELEASE COMPLETE BUTTON
                        PrimaryButton(text: "RELEASE COMPLETE", onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ThoughtScanSelectionScreen()));

                        }),
                        //_buildCompleteButton(),

                        const SizedBox(height: 120), // Bottom Nav space

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

  Widget _buildFloatingThought(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Icon(icon, color: Colors.white.withOpacity(0.15), size: 20),
    );
  }

  Widget _buildCompleteButton() {
    return Container(
      width: double.infinity,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff2D364D),
            Color(0xff1C2230),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: const Center(
        child: Text(
          "RELEASE COMPLETE",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildFlare(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}