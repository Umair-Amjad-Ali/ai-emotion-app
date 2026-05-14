import 'package:ai_emotion_app/screen/emergency_mind_detox/EmergencyBreathingResetScreen.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../../widgets/custom_video_player.dart';
import 'GeometricAnimatedWidget.dart';


//MAIN POINT
class PanicStabilizerScreen extends StatefulWidget {
  const PanicStabilizerScreen({super.key});

  @override
  State<PanicStabilizerScreen> createState() => _PanicStabilizerScreenState();
}

class _PanicStabilizerScreenState extends State<PanicStabilizerScreen>{
  int _currentIndex = 0;
  VideoPlayerController? _videoController;


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
                        const SizedBox(height: 10),

                        // --- ANIMATED CRYSTALLINE ORB ---
                        // --- ANIMATED CRYSTALLINE ORB ---
                        // --- ANIMATED CRYSTALLINE ORB ---
                        Container(
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
                                offset: Offset(5.0, 10.0),
                                height: 300,
                                width: 300,
                                videoPath: 'assets/animations/geometric_lines.mp4',
                                isLooping: true,
                                onControllerReady: _onVideoControllerReady,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // --- MAIN URGENT CARD ---
                        _buildUrgentCard(),

                        const SizedBox(height: 24),

                        // --- SUB OPTIONS (Grid-like row) ---
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EmergencyBreathingResetScreen()));
                                },
                                child: _buildMiniCard(
                                  icon: Icons.air,
                                  title: "4-7-8 Breath",
                                  subtitle: "Regulate Oxygen",
                                  iconColor: const Color(0xff7FD6FF),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _buildMiniCard(
                                icon: Icons.visibility_outlined,
                                title: "5-4-3-2-1",
                                subtitle: "Grounding Ritual",
                                iconColor: const Color(0xffFFB4A8),
                              ),
                            ),
                          ],
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

  // Function to dispose video controller
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

  Widget _buildUrgentCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xff3D2E2E).withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "URGENT ASSIST",
              style: TextStyle(
                color: Color(0xffFFB4A8),
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Panic Stabilizer",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "A guided sensory anchor designed to lower your heart rate and ground your awareness in 60 seconds.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Emergency Button
          Container(
            width: double.infinity,
            height: 62,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xff2D364D), Color(0xff1C2230)],
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
              ],
            ),
            child: const Center(
              child: Text(
                "EMERGENCY STABILIZE",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Voice Guidance Button
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
              color: Colors.white.withOpacity(0.02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.volume_up_outlined, color: Colors.white.withOpacity(0.7), size: 20),
                const SizedBox(width: 10),
                Text(
                  "Voice Guidance Only",
                  style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard({required IconData icon, required String title, required String subtitle, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.1),
            ),
            child: Icon(icon, color: iconColor.withOpacity(0.8), size: 24),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
        ],
      ),
    );
  }
}