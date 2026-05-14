import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'PressureReleaseScreen.dart';

class ThoughtItem {
  final String id;
  final String text;
  final String category;
  final IconData icon;
  final Color iconColor;

  ThoughtItem({
    required this.id,
    required this.text,
    required this.category,
    required this.icon,
    required this.iconColor,
  });
}

class ThoughtDiffusionScreen extends StatefulWidget {
  const ThoughtDiffusionScreen({super.key});

  @override
  State<ThoughtDiffusionScreen> createState() => _ThoughtDiffusionScreenState();
}

class _ThoughtDiffusionScreenState extends State<ThoughtDiffusionScreen> {
  int _currentIndex = 0;
  bool _isHovering = false;

  final List<ThoughtItem> _thoughts = [
    ThoughtItem(
      id: "1",
      text: '"I\'m not doing enough today"',
      category: "SELF-JUDGEMENT",
      icon: Icons.cloud_queue,
      iconColor: const Color(0xff7FD6FF),
    ),
    ThoughtItem(
      id: "2",
      text: '"What if I fail the presentation?"',
      category: "ANTICIPATORY ANXIETY",
      icon: Icons.flash_on_rounded,
      iconColor: const Color(0xffFFB4A8),
    ),
    ThoughtItem(
      id: "3",
      text: '"Everything feels overwhelming"',
      category: "EMOTIONAL BURNOUT",
      icon: Icons.waves_rounded,
      iconColor: const Color(0xff7FD6FF),
    ),
  ];

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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Thought Defusion",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Visualize your intrusive thoughts as physical objects. Drag them to the sanctuary zone to release their weight.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // --- DRAGGABLE THOUGHTS LIST ---
                        ..._thoughts.map((thought) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildDraggableThought(thought, screenWidth),
                        )),

                        const SizedBox(height: 20),

                        // --- RELEASE ZONE (DRAG TARGET) ---
                        _buildReleaseZone(screenWidth),

                        const SizedBox(height: 32),

                        // --- CONTINUE BUTTON ---
                        PrimaryButton(text: "CONTINUE", onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>PressureReleaseScreen()));
                        }),

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

  Widget _buildDraggableThought(ThoughtItem thought, double width) {
    Widget cardContent = Container(
      width: width * 0.88,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: thought.iconColor.withOpacity(0.1),
            ),
            child: Icon(thought.icon, color: thought.iconColor.withOpacity(0.8), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  thought.text,
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  thought.category,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.3),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.drag_indicator, color: Colors.white.withOpacity(0.15)),
        ],
      ),
    );

    return Draggable<ThoughtItem>(
      data: thought,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.7, child: cardContent),
      ),
      childWhenDragging: Opacity(opacity: 0.2, child: cardContent),
      child: cardContent,
    );
  }

  Widget _buildReleaseZone(double width) {
    return DragTarget<ThoughtItem>(
      onWillAccept: (data) {
        setState(() => _isHovering = true);
        return true;
      },
      onLeave: (data) => setState(() => _isHovering = false),
      onAccept: (thought) {
        setState(() {
          _thoughts.removeWhere((t) => t.id == thought.id);
          _isHovering = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Thought released"), duration: Duration(milliseconds: 500)),
        );
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: width * 0.88,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: _isHovering ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.1),
              width: 1.5,
              style: BorderStyle.solid, // Note: For dashed effect, use path_drawing package
            ),
            color: _isHovering ? Colors.white.withOpacity(0.05) : Colors.transparent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff1A1F2E).withOpacity(0.8),
                ),
                child: Icon(Icons.cloud_outlined, color: const Color(0xff7FD6FF).withOpacity(0.8), size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                "RELEASE HERE",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: const Color(0xff2D364D).withOpacity(0.8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: const Center(
        child: Text(
          "CONTINUE",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
    );
  }
}