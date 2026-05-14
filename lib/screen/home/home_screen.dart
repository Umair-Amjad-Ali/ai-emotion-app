
import 'package:ai_emotion_app/screen/addiction/addiction_breaker_screen.dart';
import 'package:ai_emotion_app/screen/blindforgiveness/blind_forgiveness_screen.dart';
import 'package:ai_emotion_app/screen/dailyantitode/daily_antidote_screen.dart';
import 'package:ai_emotion_app/screen/emergency_mind_detox/PanicStabilizerScreen.dart';
import 'package:ai_emotion_app/screen/restfullmind/night_reset.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/stabilize_nervous_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../Utils.dart';
import '../../widgets/app_header.dart';
import '../../widgets/grid_Item_with_lock.dart';
import '../../widgets/primary_button.dart';
import '../anger/anger_tamer_screen.dart';
import '../daily_mind_detox/DailyMindDetoxSelectionScreen.dart';
import '../daily_mind_detox/daily_mind_detox_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. EXACT BACKGROUND: Updated colors and orientation
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.6, -1.0), // Specific slant from design
                end: Alignment(0.6, 1.0),
                colors: [
                  Color(0xff100D2C), // Richer navy top
                  Color(0xff080914), // Deep center
                  Color(0xff0D1A38), // Dark bottom
                ],
              ),
            ),
          ),

          // Refined Global Flares
          Positioned(
            top: -150,
            right: -100,
            child: _buildFlare(700, const Color(0xFF3299FF).withOpacity(0.18)),
          ),
          Positioned(
            bottom: 100,
            left: -150,
            child: _buildFlare(800, const Color(0xff1C28B1).withOpacity(0.2)),
          ),

          // 2. MAIN CONTENT
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        _buildWelcomeSection(),
                        const SizedBox(height: 25),
                        _buildDailyDetoxCard(context),
                        const SizedBox(height: 35),
                        _buildGridSection(),
                        const SizedBox(height: 30),
                        GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PanicStabilizerScreen()));
                            },
                            
                            child: _buildEmergencyCard()),
                        const SizedBox(height: 140), // More space for nav bar
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: AppHeader(showStatus: false,),
    );
  }

  Widget _titleText(String text, double size, Color color, double height) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        height: height,
        fontWeight: FontWeight.bold,
        fontFamily: 'bankgothicmdbt',
        color: color,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Welcome back Brutt",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w300,
          ),
        ),
        Column(
          children: [
            Image.asset('assets/pngs/brain.png', height: 45),
            const Text(
              "LEVEL 1",
              style: TextStyle(
                height: -0.5,
                color: Color(0xffFF3B3B),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDailyDetoxCard(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias, // Ensures internal flare doesn't bleed
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.3),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Stack(
        children: [
          // PROMINENT INTERNAL FLARE (Top Right)
          // PROMINENT INTERNAL FLARE (Top Right)
          Positioned(
            top: -95, // Slightly more offset for better spread
            right: -95,
            child: Container(
              width: 270, // Increased size for softer falloff
              height: 270,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xffFFFFFF).withOpacity(0.1), // Brightest center
                    const Color(0xff4196D7).withOpacity(0.16), // Soft Blue bleed to match global theme
                    const Color(0xff1A1F2E).withOpacity(0.0),  // Blend into card color
                  ],
                  stops: const [0.0, 0.4, 1.0], // Controls the sharpness of the glow
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        //Icon(Icons.timer_outlined, color: Colors.white.withOpacity(0.7), size: 18),
                        SvgPicture.asset('assets/svg/stopwatch_ic.svg', height: 18),
                        const SizedBox(width: 8),
                        Text(
                          "DAILY MIND DETOX",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 10,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                    //Icon(Icons.event_note_outlined, color: Colors.white.withOpacity(0.5), size: 18),
                    SvgPicture.asset('assets/svg/calender_ic.svg', height: 18),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  "Daily Mind Detox",
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  "Next session at 8:00 AM",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
                PrimaryButton(
                  text: "START SESSION",
                  height: 56,
                  borderRadius: 18,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DailyMindDetoxSelectionScreen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildGridSection() {


    List<Map<String, String>> items = [
      {"t": "Daily mind detox", "s": "Subscribed", "i": "daily_mind_detox.png", "locked": "false"},
      {"t": "Addiction breaker", "s": "Walk through urges daily", "i": "addiction_breaker.png", "locked": "true"},
      {"t": "Guilt Cleanser", "s": "Process guilt gently", "i": "guilt_cleanser.png", "locked": "true"},
      {"t": "Anger tamer", "s": "Navigate anger with clarity", "i": "anger_tammer.png", "locked": "true"},
      {"t": "Daily Antidote", "s": "Built mental resilience", "i": "daily_antidote.png", "locked": "true"},
      {"t": "Restful Mind", "s": "Prepare for sleep", "i": "restfull_mind.png", "locked": "true"},
      {"t": "Mind clutter crematorium", "s": "", "i": "mind_clutter.png", "locked": "true"},
      {"t": "Blind forgiveness", "s": "Release deep resentment", "i": "blind_forgiveness.png", "locked": "true"},
      {"t": "Trauma Trigger", "s": "Ground yourself", "i": "trauma_trigger.png","locked": "true"},
    ];

    /*final List<Map<String, String>> items = [
      {"t": "Daily mind detox", "s": "Subscribed", "i": "logo.png", "locked": "false"},
      {"t": "Addiction breaker", "s": "Walk through urges daily", "i": "logo.png", "locked": "true"},
      {"t": "Guilt Cleanser", "s": "Process guilt gently", "i": "logo.png", "locked": "true"},
      {"t": "Anger tamer", "s": "Navigate anger with clarity", "i": "logo.png", "locked": "true"},
      {"t": "Daily Antidote", "s": "Built mental resilience", "i": "logo.png", "locked": "false"},
      {"t": "Restful Mind", "s": "Prepare for sleep", "i": "logo.png", "locked": "false"},
      {"t": "Mind clutter crematorium", "s": "", "i": "logo.png", "locked": "true"},
      {"t": "Blind forgiveness", "s": "Release deep resentment", "i": "logo.png", "locked": "true"},
      {"t": "Trauma Trigger", "s": "Ground yourself", "i": "logo.png", "locked": "true"},
    ];*/

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GridItemWithLock(item: items[index]);
      },
    );
  }





  Widget _buildEmergencyCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              width: 80,
              height: 80,
              color: const Color(0xff3D1515).withOpacity(0.4), // Replace with Image
              child: Image.asset('assets/pngs/menu/emergency_detox.png')
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "EMERGENCY MIND\nDETOX",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Quick 45-second calm - tap\nwhen overwhelmed",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildFlare(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}

