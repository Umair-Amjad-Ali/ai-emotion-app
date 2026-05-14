import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import 'DailyMindDetoxSelectionScreen.dart';

class ScheduleSetScreen extends StatefulWidget {
  const ScheduleSetScreen({super.key});

  @override
  State<ScheduleSetScreen> createState() => _ScheduleSetScreenState();
}

class _ScheduleSetScreenState extends State<ScheduleSetScreen> {
  int _currentIndex = 0;
  bool _notificationsEnabled = true;

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
                colors: [Color(0xff101A2C), Color(0xff070B16)],
              ),
            ),
          ),

          // Global Background Flare (Top Right of screen)
          Positioned(
            top: -100,
            right: -screenWidth * 0.2,
            child: _buildFlare(700, const Color(0xFF3299FF).withOpacity(0.12)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "YOUR SAVED SCHEDULE",
                          style: TextStyle(
                            color: Color(0xff7FD6FF).withOpacity(0.9),
                            fontSize: 12,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Your schedule is\nset",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Your rituals are ready. A 20-minute\ncommitment to mental clarity.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.55),
                            fontSize: 16,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // --- ACTIVE SESSION CARD (Morning) with prominent Blue Flare ---
                        _buildSessionCard(
                          isNext: true,
                          title: "MORNING",
                          time: "08:00",
                          period: "AM SESSION",
                          icon: Icons.wb_sunny_outlined,
                          buttonText: "START MORNING SESSION",
                          flareColor: const Color(0xff7FD6FF).withOpacity(0.6),
                          iconColor: const Color(0xff7FD6FF),
                        ),

                        const SizedBox(height: 20),

                        // --- SECONDARY SESSION CARD (Evening) with subtle Red/Purple Flare ---
                        _buildSessionCard(
                          isNext: false,
                          title: "EVENING",
                          time: "09:30",
                          period: "PM SESSION",
                          icon: Icons.nightlight_outlined,
                          buttonText: "START EVENING SESSION",
                          flareColor: const Color(0xffFF3299).withOpacity(0.08),
                          iconColor: const Color(0xffFFB4A8),
                        ),

                        const SizedBox(height: 20),

                        // --- SETTINGS CARD ---
                        _buildSettingsCard(),

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

  Widget _buildSessionCard({
    required bool isNext,
    required String title,
    required String time,
    required String period,
    required IconData icon,
    required String buttonText,
    required Color flareColor,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        border: Border.all(
          color: isNext ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.06),
          width: 1.2,
        ),
      ),
      child: Stack(
        children: [
          // BACKGROUND GRADIENT OF THE CARD
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isNext ? const Color(0xff1C2A4D) : const Color(0xff161B29).withOpacity(0.5),
                    const Color(0xff0D1321),
                  ],
                ),
              ),
            ),
          ),

          // THE PROMINENT TOP-RIGHT INNER FLARE
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(1.3, -1.3), // Far Top Right
                  radius: 1.5,
                  colors: [
                    flareColor,
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.6],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: iconColor, size: 22),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (isNext)
                          Row(
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: Color(0xff7FD6FF),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "NEXT SESSION",
                                style: TextStyle(
                                  color: Color(0xff7FD6FF),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: TextStyle(
                            color: Color(0xff7FD6FF).withOpacity(0.7),
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                //const SizedBox(height: 24),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 20),

                // Button
                GestureDetector(
                  onTap: (){
                    if(isNext) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DailyMindDetoxSelectionScreen()));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      gradient: isNext
                          ? const LinearGradient(
                        colors: [Color(0xff2D364D), Color(0xff1C2230)],
                      )
                          : null,
                      color: !isNext ? Colors.black.withOpacity(0.3) : null,
                      border: !isNext ? Border.all(color: Colors.white.withOpacity(0.05)) : null,
                    ),
                    child: Center(
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          color: Colors.white.withOpacity(isNext ? 1.0 : 0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
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

  Widget _buildSettingsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: const Color(0xff161B29).withOpacity(0.4),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.timer_outlined, color: Colors.white.withOpacity(0.5), size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "20 Minutes",
                      style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Session Duration",
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 13),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "NOTIFICATIONS",
                    style: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                  ),
                  Transform.scale(
                    scale: 0.75,
                    alignment: Alignment.centerRight,
                    child: CupertinoSwitch(
                      value: _notificationsEnabled,
                      activeColor: const Color(0xff7FD6FF),
                      onChanged: (v) => setState(() => _notificationsEnabled = v),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
          Divider(color: Colors.white.withOpacity(0.05), height: 1),
          const SizedBox(height: 25),
          Row(
            children: [
              Icon(Icons.edit_outlined, color: Colors.white.withOpacity(0.4), size: 20),
              const SizedBox(width: 12),
              Text(
                "Edit Schedule",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFlare(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent])
      ),
    );
  }

}