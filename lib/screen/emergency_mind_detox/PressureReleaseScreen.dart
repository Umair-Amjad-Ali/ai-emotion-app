import 'package:ai_emotion_app/screen/emergency_mind_detox/StabilizationCompleteScreen.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_video_player.dart';

class PressureReleaseScreen extends StatefulWidget {
  const PressureReleaseScreen({super.key});

  @override
  State<PressureReleaseScreen> createState() => _PressureReleaseScreenState();
}

class _PressureReleaseScreenState extends State<PressureReleaseScreen> {
  int _currentIndex = 0;
  double _sliderValue = 0.0; // 0.0 to 1.0
  final double _sliderHeight = 72.0;
  final double _handleSize = 62.0;
  VideoPlayerController? _videoController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculate the total width of the slider track
    final double trackWidth = screenWidth * 0.88;
    // Calculate maximum drag distance (Track width - handle size - padding)
    final double maxDragDistance = trackWidth - _handleSize - 10;

    print("PressureReleaseScreen");
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          // --- CENTRAL CRYSTAL OBJECT ---
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Circular backdrop with soft light effect
                              Container(
                                width: screenWidth * 0.8,
                                height: screenWidth * 0.8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white.withOpacity(0.03)),
                                  gradient: RadialGradient(
                                    colors: [
                                      const Color(0xff7FD6FF).withOpacity(0.08 * (1 - _sliderValue)),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                              // The Fading Image Asset
                              Opacity(
                                opacity: (1.0 - _sliderValue).clamp(0.0, 1.0),
                                child:   Container(
                                  width: 250, // Explicitly match dimensions
                                  height: 250,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xff7FD6FF).withOpacity(0.1),
                                        blurRadius: 40,
                                        spreadRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Center( // <--- Added Center here to align the video
                                      child: CustomVideoPlayer(
                                        zoom: 1.2,               // Change this to zoom in/out
                                        offset: Offset(1.0, -10.0),
                                        height: 300,
                                        width: 300,
                                        backgroundColor: Color(0xff253351), // Matches your app theme
                                        videoPath: 'assets/animations/water.mp4',
                                        isLooping: true,
                                        enableFade: true,
                                        onControllerReady: _onVideoControllerReady,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 40),
                          const Text(
                            "Pressure Release",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Take a deep breath. Visualize the tension\nleaving your body as you move the slider.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 60),

                          // --- PIXEL PERFECT CUSTOM SLIDER ---
                          _buildPressureSlider(trackWidth, maxDragDistance),

                          const SizedBox(height: 60),

                          // --- STATUS INDICATORS (State, Mid, Goal) ---
                          _buildStatusRow(),

                          const SizedBox(height: 50),

                          // --- CONTINUE BUTTON ---
                          PrimaryButton(text: "CONTINUE", onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>StabilizationCompleteScreen()));
                          }),

                          const SizedBox(height: 120),
                        ],
                      ),
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

  Widget _buildPressureSlider(double trackWidth, double maxDragDistance) {
    return Container(
      width: trackWidth,
      height: _sliderHeight,
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.3),
        borderRadius: BorderRadius.circular(_sliderHeight / 2),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Background Label
          Center(
            child: Opacity(
              opacity: (1.0 - _sliderValue).clamp(0.2, 1.0),
              child: const Text(
                "RELEASE TO CALM",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),

          // The Draggable Glowing Orb Handle
          Positioned(
            left: 5 + (_sliderValue * maxDragDistance),
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _sliderValue += details.primaryDelta! / maxDragDistance;
                  _sliderValue = _sliderValue.clamp(0.0, 1.0);
                });
              },
              onHorizontalDragEnd: (details) {
                if (_sliderValue < 0.95) {
                  setState(() => _sliderValue = 0.0); // Reset if not fully slid
                } else {
                  setState(() => _sliderValue = 1.0); // Snap to end
                }
              },
              child: Container(
                width: _handleSize,
                height: _handleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffBDEBFF), // Brighter center for the orb
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff7FD6FF).withOpacity(0.6),
                      blurRadius: 25,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: const Icon(Icons.chevron_right_rounded, color: Color(0xff070B16), size: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _disposeVideoController() {
    if (_videoController != null) {
      print("🎥 Manually disposing video controller");
      try {
        _videoController!.pause();
        print("🎥 Video paused");
        _videoController!.dispose();
        print("🎥 Video controller disposed successfully");
        _videoController = null;
      } catch (e) {
        print("🎥 Error disposing controller: $e");
      }
    } else {
      print("🎥 No video controller to dispose");
    }
  }

  // Callback to capture video controller from CustomVideoPlayer
  void _onVideoControllerReady(VideoPlayerController controller) {
    print("🎥 Video controller received from CustomVideoPlayer");
    setState(() {
      _videoController = controller;
    });
  }

  @override
  void dispose() {
    print("🎥 LevelDetailScreen disposing");
    _disposeVideoController();
    super.dispose();
  }


  Widget _buildStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _statusItem("STATE", "Tension", Colors.white),
        _statusItem("MID", "Flow", Colors.white.withOpacity(0.3)),
        _statusItem("GOAL", "Serenity", const Color(0xffFFB4A8)),
      ],
    );
  }

  Widget _statusItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: label == "GOAL" ? const Color(0xffFFB4A8).withOpacity(0.5) : Colors.white.withOpacity(0.3),
            fontSize: 10,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    bool isEnabled = _sliderValue >= 1.0;
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.5,
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xff2D364D).withOpacity(0.8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
          child: Text(
            "CONTINUE",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
