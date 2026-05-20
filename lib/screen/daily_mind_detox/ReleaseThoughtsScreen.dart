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

  // Track which thoughts have been "burned"
  final Set<int> _releasedThoughtIds = {};

  // Define organic positions for the thoughts - naturally scattered around the fire
  // Define organic positions for the thoughts - naturally scattered around the fire
  final List<Map<String, dynamic>> _thoughtData = [
    {"id": 0, "icon": Icons.psychology_outlined, "offsetTop": 20.0, "offsetLeft": -30.0},
    {"id": 1, "icon": Icons.cloud_outlined, "offsetTop": -20.0, "offsetLeft": 220.0},
  ];

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

          // Background Flare
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

                        // CENTRAL FURNACE AREA
                        Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // 1. FURNACE RENDERED FIRST (Underneath)
                            DragTarget<int>(
                              onAccept: (id) {
                                setState(() {
                                  _releasedThoughtIds.add(id);
                                });
                              },
                              builder: (context, candidateData, rejectedData) {
                                bool isHovering = candidateData.isNotEmpty;
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: screenWidth * 0.65,
                                  height: screenWidth * 0.65,
                                  decoration: BoxDecoration(
                                    color: isHovering
                                        ? const Color(0xffFF8C66).withOpacity(0.15)
                                        : const Color(0xff1A1F2E).withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                      color: isHovering
                                          ? const Color(0xffFF8C66).withOpacity(0.7)
                                          : Colors.white.withOpacity(0.08),
                                      width: isHovering ? 2.5 : 1.5,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: isHovering ? const Color(0xffFF8C66).withOpacity(0.2) : Colors.black.withOpacity(0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xffFF8C66).withOpacity(isHovering ? 0.8 : 0.3),
                                                blurRadius: 40,
                                                spreadRadius: 10,
                                              )
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.local_fire_department_rounded,
                                          size: 80,
                                          color: const Color(0xffFF8C66).withOpacity(isHovering ? 1.0 : 0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),

                            // 2. THOUGHT BUBBLES RENDERED ON TOP
                            ..._thoughtData.where((t) => !_releasedThoughtIds.contains(t['id'])).map((thought) {
                              return Positioned(
                                top: thought['offsetTop'] as double?,
                                left: thought['offsetLeft'] as double?,
                                width: 60,
                                height: 60,
                                child: _buildDraggableThought(thought['id'], thought['icon']),
                              );
                            }),
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
                          _releasedThoughtIds.length == _thoughtData.length
                              ? "Your mind is clear and light."
                              : "Drag thoughts into the furnace to clear your mind.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),

                        const Spacer(flex: 2),

                        // RELEASE COMPLETE BUTTON
                        Opacity(
                          opacity: _releasedThoughtIds.length == _thoughtData.length ? 1.0 : 0.5,
                          child: PrimaryButton(
                              text: "RELEASE COMPLETE",
                              onPressed: () {
                                if (_releasedThoughtIds.length == _thoughtData.length) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ThoughtScanSelectionScreen()));
                                }
                              }
                          ),
                        ),

                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

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

  Widget _buildDraggableThought(int id, IconData icon) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Draggable<int>(
        data: id,
        hitTestBehavior: HitTestBehavior.opaque,
        feedback: Material(
          color: Colors.transparent,
          child: Container(
            width: 70, // Explicit size for feedback
            height: 70,
            decoration: BoxDecoration(
                color: const Color(0xffFF8C66).withOpacity(0.5),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xffFF8C66), width: 2),
                boxShadow: [
                  BoxShadow(color: const Color(0xffFF8C66).withOpacity(0.4), blurRadius: 25)
                ]
            ),
            child: Center(child: Icon(icon, color: Colors.white, size: 30)),
          ),
        ),
        childWhenDragging: const SizedBox.shrink(),
        child: Center(
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
                color: const Color(0xff1A1F2E).withOpacity(0.8),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.15)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)
                ]
            ),
            child: Opacity(
              opacity: 0.7,
              child: Icon(icon, color: Colors.white, size: 24),
            ),
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