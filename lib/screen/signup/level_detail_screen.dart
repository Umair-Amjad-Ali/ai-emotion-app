import 'package:ai_emotion_app/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';
import '../../widgets/custom_video_player.dart';
import '../../widgets/primary_button.dart';
import '../layout/layout.dart';

class LevelDetailScreen extends StatefulWidget {
  const LevelDetailScreen({super.key});

  @override
  State<LevelDetailScreen> createState() => _LevelDetailScreenState();
}

class _LevelDetailScreenState extends State<LevelDetailScreen> {
  VideoPlayerController? _videoController;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // UPDATED: 3-color linear gradient (Red -> Blue -> Navy)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff451B24), // Red top
              Color(0xff151025), // Blue mid
              Color(0xff080D1C), // Navy bottom
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // TOP SKY BLUE FLARE
            Positioned(
              top: -250,
              right: -280,
              child: Container(
                width: 800,
                height: 800,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    radius: 0.7,
                    colors: [
                      const Color(0xFF3299FF).withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // BOTTOM NAVY BLUE FLARE
            Positioned(
              bottom: -200,
              left: -350,
              child: Container(
                width: 900,
                height: 900,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    radius: 0.8,
                    colors: [
                      const Color(0xff1C28B1).withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  // 1. Header with Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.02),
                      child: IconButton(
                        onPressed: () {
                          print("🎥 Back button pressed - disposing video");
                          _disposeVideoController();
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                      ),
                      child: Column(
                        children: [
                          // 2. MAIN CARD
                          _buildMainLevelCard(screenWidth),

                          const SizedBox(height: 20),

                          // 3. BOTTOM MINI CARDS ROW
                          Row(
                            children: [
                              Expanded(
                                child: _buildMiniCard(
                                  iconPath: 'assets/svg/bulb_ic.svg',
                                  title: "Explore Level 2",
                                  subtitle: "The first shift toward presence.",
                                  iconColor: const Color(0xffA85D5D),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildMiniCard(
                                  iconPath: 'assets/svg/progress_ic.svg',
                                  title: "View Detail",
                                  subtitle: "Deep metrics and trend analysis.",
                                  iconColor: const Color(0xff5D6EA8),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 120,
                          ), // Space for bottom button
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // FIXED BOTTOM BUTTON
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: PrimaryButton(
                  text: 'GO TO HOME',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    print("🎥 GO TO HOME button pressed - disposing video");
                    _disposeVideoController();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppLayout()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildMainLevelCard(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.019),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff522B35).withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 2,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              boxShadow: [
                // Inner intense glow
                BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
                // Outer atmospheric glow (The real "glow" effect)
                BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  blurRadius: 60, // High blur makes it look like light/glow
                  spreadRadius: 10, // Spread pushes the light further out
                ),
              ],
            ),
            child: ClipRRect(
              child: CustomVideoPlayer(
                height: 300,
                width: 400,
                videoPath: 'assets/animations/heart2.mp4',
                isLooping: true,
                onControllerReady: _onVideoControllerReady, // <- CALLBACK HERE
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'LEVEL 1',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          const Text(
            '(Reactive)',
            style: TextStyle(
              color: Color(0xffA88390),
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 25),

          // Status Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xff2C1A24),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xff452B35)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.info_outline, color: Color(0xffA88390), size: 16),
                SizedBox(width: 8),
                Text(
                  'Status: Initial Stage',
                  style: TextStyle(
                    color: Color(0xffA88390),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // QUOTE SECTION
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SvgPicture.asset('assets/svg/quote_ic.svg', height: 14),
                  const SizedBox(height: 5),
                  Container(
                    width: 2,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xffA85D5D),
                          const Color(0xffA85D5D).withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 30),
                    Text(
                      "Thoughts control you.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      "Immediate identification.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      "Impulse > awareness.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniCard({
    required String iconPath,
    required String title,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.019),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconColor.withOpacity(0.15),
            ),
            child: SvgPicture.asset(
              iconPath,
              color: iconColor,
              width: 22,
              height: 22,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
