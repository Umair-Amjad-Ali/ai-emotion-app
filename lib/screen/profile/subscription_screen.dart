import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _currentIndex = 0;
  String _selectedPlan = 'yearly';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff070B16),
      body: Stack(
        children: [
          // 1. BACKGROUND GRADIENT & FLARES
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff101A2C), Color(0xff070B16)],
                ),
              ),
            ),
          ),
          Positioned(
            top: -150,
            right: -100,
            child: _buildFlare(600, const Color(0xFF3299FF).withOpacity(0.12)),
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
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Unlock Full Access",
                          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Access all emotional healing flows and\nguided experiences",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 16, height: 1.4),
                        ),
                        const SizedBox(height: 32),

                        // Features List Card
                        _buildGlassCard(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              _buildFeatureRow(Icons.diamond_outlined, "Unlimited access to all flows"),
                              const SizedBox(height: 20),
                              _buildFeatureRow(Icons.psychology_outlined, "Advanced emotional tools"),
                              const SizedBox(height: 20),
                              _buildFeatureRow(Icons.auto_awesome_outlined, "Guided healing sessions"),
                              const SizedBox(height: 20),
                              _buildFeatureRow(Icons.analytics_outlined, "Progress tracking"),
                              const SizedBox(height: 20),
                              _buildFeatureRow(Icons.history_outlined, "Future content updates"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Plans
                        _buildPlanTile(
                          id: 'monthly',
                          title: "Monthly Plan",
                          subtitle: "Billed every 30 days",
                          price: "\$12.99",
                          period: "/month",
                        ),
                        const SizedBox(height: 16),
                        _buildPlanTile(
                          id: 'yearly',
                          title: "Yearly Plan",
                          subtitle: "Billed annually",
                          price: "\$99.99",
                          period: "/year",
                          isBestValue: true,
                        ),

                        const SizedBox(height: 32),

                        // CTA Button
                        _buildPremiumButton(),

                        const SizedBox(height: 24),
                        Text("Restore Purchase", style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15)),

                        const SizedBox(height: 40),
                        _buildFooterLinks(),
                        const SizedBox(height: 30),
                        _buildSignOutButton(),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _titleText("THE", 16, Colors.white, 0),
              const SizedBox(width: 2),
              _titleText("NOT", 24, Colors.red, 1),
              const SizedBox(width: 2),
              _titleText("YOU", 16, Colors.white, 0),
            ],
          ),
          Column(
            children: [
              Image.asset('assets/pngs/brain.png', height: 40),
              const Text("LEVEL 1", style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold, height: -0.5)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _titleText(String text, double size, Color color, double height) {
    return Text(text, style: TextStyle(fontSize: size, height: height, fontWeight: FontWeight.bold, fontFamily: 'bankgothicmdbt', color: color, letterSpacing: 1.0));
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.blue.withOpacity(0.8), size: 18),
        ),
        const SizedBox(width: 16),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildPlanTile({required String id, required String title, required String subtitle, required String price, required String period, bool isBestValue = false}) {
    bool isSelected = _selectedPlan == id;
    return GestureDetector(
      onTap: () => setState(() => _selectedPlan = id),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.05) : const Color(0xff161B29).withOpacity(0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue.withOpacity(0.5) : Colors.white.withOpacity(0.05),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected ? [BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 15, spreadRadius: 2)] : null,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(price, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(period, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
                  ],
                ),
              ],
            ),
            if (isBestValue)
              Positioned(
                top: -32,
                right: -10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xff86BFFF), borderRadius: BorderRadius.circular(8)),
                  child: const Text("BEST VALUE", style: TextStyle(color: Color(0xff070B16), fontSize: 10, fontWeight: FontWeight.w900)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [const Color(0xff445678), const Color(0xff2A354D)],
        ),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: const Center(
        child: Text("START PREMIUM", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
      ),
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 14, color: Colors.white.withOpacity(0.3)),
            const SizedBox(width: 4),
            Text("Secure payment", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
            const SizedBox(width: 12),
            Container(width: 4, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle)),
            const SizedBox(width: 12),
            Text("Cancel anytime", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 12)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Terms of Service", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
            const SizedBox(width: 20),
            Text("Privacy Policy", style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 11)),
          ],
        ),
      ],
    );
  }

  Widget _buildSignOutButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.logout, size: 16, color: Colors.white.withOpacity(0.4)),
        const SizedBox(width: 8),
        Text("SIGN OUT FROM SANCTUARY", style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.1)),
      ],
    );
  }

  Widget _buildGlassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xff161B29).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
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