import 'package:ai_emotion_app/screen/daily_mind_detox/ScheduleSetScreen.dart';
import 'package:ai_emotion_app/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';


//MAIN POINT
class DailyMindDetoxScreen extends StatefulWidget {
  const DailyMindDetoxScreen({super.key});

  @override
  State<DailyMindDetoxScreen> createState() => _DailyMindDetoxScreenState();
}

class _DailyMindDetoxScreenState extends State<DailyMindDetoxScreen> {
  bool _isReminderEnabled = true;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT & FLARES
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff101A2C), Color(0xff070B16)],
              ),
            ),
          ),
          Positioned(
            top: -100,
            right: -screenWidth * 0.2,
            child: _buildFlare(700, const Color(0xFF3299FF).withOpacity(0.12)),
          ),

          // 2. MAIN SCROLLABLE CONTENT
          SafeArea(
            child: Column(
              children: [
                const AppHeader(), // Uses your app_header.dart
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),

                        // --- OUTER MAIN CARD ---
                        _buildOuterMainCard(screenWidth),

                        const SizedBox(height: 30),

                        // Footer Quote
                        const SizedBox(height: 130),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. BOTTOM NAVIGATION
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

  // LEVEL 1: OUTER CARD (Contains Header + Inner Card)
  Widget _buildOuterMainCard(double screenWidth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        //color: Colors.white.withOpacity(0.05),

        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffCCECFF).withOpacity(0.2), // Light Blue
            Color(0xff007FFF).withOpacity(0.1), // Brighter Blue
            Color(0xff007FFF).withOpacity(0.1), // Brighter Blue
          ],
        ),
        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: Colors.white.withOpacity(0.06), width: 1.2),
      ),
      child: Column(
        children: [
          // Header inside Outer Card
          const Text(
            "Daily Mind\nDetox",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
              height: 1.05,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Set your preferred time to begin",
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 40),

          // LEVEL 2: INNER CARD (Morning Session -> Next Button)
          _buildInnerContentCard(),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "“The soul always knows what to do to heal itself. \nThe challenge is to silence the mind.”",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.15),
                fontSize: 13,
                //fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // LEVEL 2: INNER CARD
  Widget _buildInnerContentCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25), // Darker than outer
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffCCECFF).withOpacity(0.3), // Light Blue
            Color(0xff1A2139).withOpacity(0.2), // Brighter Blue
            Color(0xff007FFF).withOpacity(0.1), // Brighter Blue
          ],
        ),

        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSessionLabel("MORNING SESSION"),
          const SizedBox(height: 12),
          // LEVEL 3: TIME INPUT
          _buildTimeDisplay("--:-- --", Icons.wb_sunny_outlined),

          const SizedBox(height: 28),

          _buildSessionLabel("EVENING SESSION"),
          const SizedBox(height: 12),
          // LEVEL 3: TIME INPUT
          _buildTimeDisplay("--:-- --", Icons.nightlight_outlined),

          const SizedBox(height: 30),

          // Reminder Toggle
          _buildReminderToggle(),

          const SizedBox(height: 20),

          // Tip Box
          _buildTipBox(),

          const SizedBox(height: 20),

          // Next Button (Now inside the inner card)
          _buildNextButton(),
          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay(String time, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5), // Darkest
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              color: Colors.white.withOpacity(0.2),
              fontSize: 26,
              letterSpacing: 2,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Spacer(),
          Icon(icon, color: Colors.blue.withOpacity(0.3), size: 24),
        ],
      ),
    );
  }

  Widget _buildSessionLabel(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        )
      ],
    );
  }

  Widget _buildReminderToggle() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enable daily reminder",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                "Receive gentle prompts to detox",
                style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
              ),
            ],
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: CupertinoSwitch(
            value: _isReminderEnabled,
            activeColor: Colors.white,
            trackColor: Colors.white10,
            onChanged: (v) => setState(() => _isReminderEnabled = v),
          ),
        ),
      ],
    );
  }

  Widget _buildTipBox() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14, height: 1.1),
          children: const [
            TextSpan(
              text: "Tip: ",
              style: TextStyle(color: Color(0xffE58C8C), fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: "Starting with 10-15 \nminutes \nhelps build a sustainable \nhabit \nbefore moving to longer \nsessions.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xff2D364D), Color(0xff1C2230)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Center(
        child: PrimaryButton(text: "NEXT", onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleSetScreen()));

        })
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
