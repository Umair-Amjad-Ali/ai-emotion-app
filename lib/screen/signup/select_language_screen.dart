import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';
import '../Signup/signup_screen.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  int _selectedLanguageIndex = 0; // Default to English

  final List<Map<String, String>> _languages = [
    {"name": "English", "flag": "🇺🇸"},
    {"name": "中文", "flag": "🇨🇳"},
    {"name": "Русский", "flag": "🇷🇺"},
    {"name": "Español", "flag": "🇪🇸"},
    {"name": "Deutsch", "flag": "🇩🇪"},
    {"name": "Français", "flag": "🇫🇷"},
    {"name": "العربية", "flag": "🇸🇦"},
    {"name": "עברית", "flag": "🇮🇱"},
    {"name": "Italiano", "flag": "🇮🇹"},
    {"name": "日本語", "flag": "🇯🇵"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // EXACT BACKGROUND: Using the same logic as your other screens
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff101A2C),
              Color(0xff070B16),
            ],
          ),
        ),
        child: Stack(
          children: [
            // TOP SKY BLUE FLARE
            Positioned(
              top: -250,
              right: -280,
              child: _buildFlare(800, const Color(0xFF3299FF).withOpacity(0.15)),
            ),
            // BOTTOM NAVY FLARE
            Positioned(
              bottom: -200,
              left: -350,
              child: _buildFlare(900, const Color(0xff1C28B1).withOpacity(0.2)),
            ),

            SafeArea(
              child: Column(
                children: [
                  // 1. Header
                  _buildHeader(context),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          // 2. Title & Subtitle
                          const Text(
                            "Choose your language",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Choose your preferred language for the app",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 35),

                          // 3. Language List
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _languages.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              return _buildLanguageCard(index);
                            },
                          ),
                          const SizedBox(height: 120), // Padding for button
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 4. Fixed Bottom Next Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.06),
                child: PrimaryButton(
                  text: 'NEXT',
                  icon: Icons.arrow_forward,
                  onPressed: () {
                    // Action to save language and proceed
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 8),
          const Text(
            "Select Language",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageCard(int index) {
    bool isSelected = _selectedLanguageIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedLanguageIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ?  Colors.white.withOpacity(0.25)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Circular Flag Placeholder
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child: Text(
                _languages[index]['flag']!,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(width: 16),
            // Language Name
            Expanded(
              child: Text(
                _languages[index]['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Custom Radio Indicator
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xff8D99AE)
                      : Colors.white.withOpacity(0.3),
                  width: 2,
                ),
                color: isSelected ? const Color(0xff8D99AE).withOpacity(0.4) : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                child: Icon(Icons.circle, color: Colors.white, size: 8),
              )
                  : null,
            ),
          ],
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
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }

}