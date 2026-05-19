import 'dart:ui';
import 'package:ai_emotion_app/screen/profile/subscription_screen.dart';
import 'package:flutter/material.dart';
import '../../Utils.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. BACKGROUND
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff101A2C), Color(0xff070B16)],
              ),
            ),
          ),

          // Background Flares
          Positioned(
            top: -250,
            right: -200,
            child: _buildFlare(800, const Color(0xFF3299FF).withOpacity(0.15)),
          ),
          Positioned(
            bottom: -200,
            left: -250,
            child: _buildFlare(900, const Color(0xff1C28B1).withOpacity(0.2)),
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.055),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        _buildProfileHeader(),
                        const SizedBox(height: 32),

                        _buildEmotionalLevelCard(),
                        const SizedBox(height: 16),

                        Row(
                          children: [
                            Expanded(child: _buildStatCard(Icons.calendar_today_outlined, "CURRENT STREAK", "12 Days")),
                            const SizedBox(width: 12),
                            Expanded(child: _buildStatCard(Icons.airplanemode_active_rounded, "TOTAL SESSIONS", "48")),
                          ],
                        ),
                        const SizedBox(height: 16),

                        //_buildEquilibriumCard(),
                        //const SizedBox(height: 16),

                        _buildActionTile(Icons.edit_outlined, "Edit Profile", "Update identity and preferences"),
                        const SizedBox(height: 12),
                        _buildActionTile(Icons.notifications_none_rounded, "Alert Preferences", "Manage focus & wellness reminders"),
                        const SizedBox(height: 16),
                        _buildPlanCard(),
                        const SizedBox(height: 130),
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: AppHeader(showStatus: false,),
    );
  }

  Widget _titleText(String text, double size, Color color, double height) {
    return Text(text, style: TextStyle(fontSize: size, height: height, fontWeight: FontWeight.bold, fontFamily: 'bankgothicmdbt', color: color, letterSpacing: 1.0));
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xffCCECFF), width: 4),
              ),
              child: const CircleAvatar(radius: 48, backgroundImage: NetworkImage('https://i.pravatar.cc/300')),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(color: Color(0xffCCECFF), shape: BoxShape.circle),
              child: const Icon(Icons.edit_outlined, color: Colors.black, size: 18),
            )
          ],
        ),
        const SizedBox(height: 16),
        const Text("Alex Rivera", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text("Premium Member since 2023", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
      ],
    );
  }

  Widget _buildEmotionalLevelCard() {
    return _buildGlassCard(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          const Color(0xff161B29).withOpacity(0.8),
          const Color(0xff161B29).withOpacity(0.8),
          const Color(0xff161B29).withOpacity(0.8),
          const Color(0xff232D43).withOpacity(0.8),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EMOTIONAL LEVEL", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.8)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text("8.4", style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
                  Text(" / 10", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 18)),
                ],
              ),
              const SizedBox(height: 4),
              Text("Sustained high tranquility", style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
            ],
          ),
          Icon(Icons.eco_rounded, color: Colors.white.withOpacity(0.15), size: 54),
        ],
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value) {
    return _buildGlassCard(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xffFF9F92).withOpacity(0.9), size: 20),
          const SizedBox(height: 14),
          Text(label, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildEquilibriumCard() {
    return _buildGlassCard(
      padding: EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Weekly Equilibrium", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text("Consistent improvement in focus\nstates", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12, height: 1.4)),
                ],
              ),
              Icon(Icons.insights_rounded, color: Colors.white.withOpacity(0.6), size: 22),
            ],
          ),
          const SizedBox(height: 28),
          // Bars aligned perfectly with the card content width
          SizedBox(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildGradientBar(28),
                _buildGradientBar(38),
                _buildGradientBar(32),
                _buildGradientBar(55),
                _buildGradientBar(70, isHighlighted: true),
                _buildGradientBar(48),
                _buildGradientBar(32),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.06), borderRadius: BorderRadius.circular(14)),
            alignment: Alignment.center,
            child: Text("VIEW FULL PROGRESS", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
          )
        ],
      ),
    );
  }

  Widget _buildGradientBar(double height, {bool isHighlighted = false}) {
    return Container(
      width: 32, // Increased width for better alignment across the card
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: isHighlighted ? [BoxShadow(color: const Color(0xffA8C7FA).withOpacity(0.3), blurRadius: 10, spreadRadius: 1)] : null,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.3, 0.6],
          colors: isHighlighted
              ? [const Color(0xffDAE7FF), const Color(0xffA8C7FA), const Color(0xff86BFFF)]
              : [
            Colors.white.withOpacity(0.3), // Brighter Top
            Colors.white.withOpacity(0.15), // Dimmer Middle
            Colors.white.withOpacity(0.1),  // Solid Bottom half
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle) {
    return _buildGlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.04), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: Colors.white.withOpacity(0.7), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: Colors.white.withOpacity(0.15), size: 20),
        ],
      ),
    );
  }

  Widget _buildPlanCard() {
    return _buildGlassCard(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xff2A3145).withOpacity(0.8), // Bright
          const Color(0xff121624), // Dark
          const Color(0xff2A3145).withOpacity(0.8), // Bright
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("CURRENT PLAN", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1)),
              const SizedBox(height: 6),
              const Text("Lumina Premium", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text("Next billing: Oct 24, 2023", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11)),
            ],
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionScreen()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
                //color: Colors.black.withOpacity(0.2),
              ),
              child: const Text("MANAGE", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGlassCard({required Widget child, EdgeInsets padding = const EdgeInsets.all(20), Gradient? gradient}) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: gradient == null ? const Color(0xff1A1F2E).withOpacity(0.45) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: child,
    );
  }

  Widget _buildFlare(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [color, Colors.transparent])),
    );
  }

}