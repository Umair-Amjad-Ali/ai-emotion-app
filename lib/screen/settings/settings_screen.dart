import 'package:flutter/cupertino.dart'; // For the iOS style switches
import 'package:flutter/material.dart';
import '../../widgets/app_header.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Switch states
  bool _dailyFocus = true;
  bool _sessionReminders = false;
  bool _soundscapes = true;
  bool _hapticFeedback = true;

  int _currentIndex = 0; // State variable

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. GLOBAL BACKGROUND (Matching your other screens)
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
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildProfileHeader(),
                        const SizedBox(height: 40),

                        // Sections
                        _buildSectionCard(
                          icon: Icons.person_outline,
                          title: "Account",
                          children: [
                            _buildListTile(
                              title: "Edit Profile",
                              subtitle: "Update your email, name and photo",
                              onTap: () {},
                            ),
                            _buildListTile(
                              title: "Change Password",
                              subtitle: "Secure your sanctuary access",
                              onTap: () {},
                            ),
                          ],
                        ),

                        _buildSectionCard(
                          icon: Icons.notifications_none_rounded,
                          title: "Reminders",
                          children: [
                            _buildSwitchTile(
                              "Daily Focus",
                              _dailyFocus,
                              (v) => setState(() => _dailyFocus = v),
                            ),
                            _buildSwitchTile(
                              "Session Reminders",
                              _sessionReminders,
                              (v) => setState(() => _sessionReminders = v),
                            ),
                          ],
                        ),

                        _buildSectionCard(
                          icon: Icons.tune_rounded,
                          title: "Preferences",
                          children: [
                            _buildSwitchTile(
                              "Soundscapes",
                              _soundscapes,
                              (v) => setState(() => _soundscapes = v),
                            ),
                            _buildSwitchTile(
                              "Haptic Feedback",
                              _hapticFeedback,
                              (v) => setState(() => _hapticFeedback = v),
                            ),
                          ],
                        ),

                        _buildSectionCard(
                          icon: Icons.verified_user_outlined,
                          title: "Privacy & Security",
                          children: [
                            _buildPrivacyTile(
                              Icons.alternate_email_rounded,
                              "Privacy Policy",
                              "UPDATED OCT 2023",
                            ),
                            _buildPrivacyTile(
                              Icons.storage_rounded,
                              "Data Settings",
                              "MANAGE YOUR DATA",
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                        _buildLogoutButton(),
                        const SizedBox(height: 20),
                        _buildVersionInfo(),
                        const SizedBox(height: 120), // Bottom Nav space
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. FIXED CUSTOM BOTTOM NAV BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              selectedIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
                // Add navigation logic here if needed
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: AppHeader(showStatus: false),
    );
  }

  // Widget _titleText(String text, double size, Color color, double height) {
  //   return Text(
  //     text,
  //     style: TextStyle(
  //       fontSize: size,
  //       height: height,
  //       fontWeight: FontWeight.bold,
  //       fontFamily: 'bankgothicmdbt',
  //       color: color,
  //       letterSpacing: 2,
  //     ),
  //   );
  // }

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
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Color(0xffCCECFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.edit_outlined,
                color: Colors.black,
                size: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Alex Rivera",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Premium Member since 2023",
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1A1F2E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue.withOpacity(0.7), size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 15,
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: value,
              activeColor: Colors.blue.withOpacity(0.7),
              trackColor: Colors.white10,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange.withOpacity(0.7), size: 20),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.logout_rounded, color: Colors.white54, size: 18),
          SizedBox(width: 10),
          Text(
            "Logout from Sanctuary",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionInfo() {
    return Text(
      "VERSION 2.4.0 • BUILD 882",
      style: TextStyle(
        color: Colors.white24,
        fontSize: 10,
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
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
