import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'DetoxCompleteScreen2.dart';

class DetoxCompleteScreen extends StatefulWidget {
  const DetoxCompleteScreen({super.key});

  @override
  State<DetoxCompleteScreen> createState() => _DetoxCompleteScreenState();
}

class _DetoxCompleteScreenState extends State<DetoxCompleteScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Using a scale factor for the Transform widget
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.2, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Column(
                      children: [

                        // ANIMATED SUCCESS INDICATOR
                        // Fixed size SizedBox prevents the layout from jumping/resizing
                        SizedBox(
                          height: 150,
                          width: 150,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Glowing Outer Ring (Animated via Transform.scale)
                                  Transform.scale(
                                    scale: _scaleAnimation.value,
                                    child: Container(
                                      width: 110,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xffFF8C66)
                                              .withOpacity(_opacityAnimation.value),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Main Static Circle
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.05),
                                      border: Border.all(
                                        color: const Color(0xffFF8C66)
                                            .withOpacity(0.4),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.check_rounded,
                                      color: Color(0xffFF8C66),
                                      size: 40,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        // TITLE
                        const Text(
                          "Detox Complete",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // STATS TILES
                        _buildStatTile("Thoughts Observed:", "0"),
                        const SizedBox(height: 16),
                        _buildStatTile("Thoughts Released:", "0"),
                        const SizedBox(height: 16),
                        _buildStatTile("Mind Clarity Rank:", "64"),

                        const SizedBox(height: 40),

                        // SUBTITLE
                        Text(
                          "Your mind is now quiet.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // START AGAIN BUTTON
                        PrimaryButton(
                          text: "Continue to Full Mind Detox",
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetoxCompleteScreen2()));

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

  Widget _buildStatTile(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}