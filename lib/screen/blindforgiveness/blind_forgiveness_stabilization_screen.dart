import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/app_header.dart';
import '../../widgets/primary_button.dart';
import 'blind_forgiveness_screen.dart';

class BlindForgivenessStabilizationScreen extends StatefulWidget {
  const BlindForgivenessStabilizationScreen({super.key});

  @override
  State<BlindForgivenessStabilizationScreen> createState() =>
      _BlindForgivenessStabilizationScreenState();
}

class _BlindForgivenessStabilizationScreenState
    extends State<BlindForgivenessStabilizationScreen> {
  int? _selectedStateIndex;

  final List<Map<String, dynamic>> _states = [
    {'title': 'Peace', 'icon': Icons.cloud_outlined},
    {'title': 'Neutrality', 'icon': Icons.tune_rounded},
    {'title': 'Closure', 'icon': Icons.lock_outline_rounded},
    {'title': 'Letting go', 'icon': Icons.air_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final horizontalPadding = screenWidth * 0.06;

    return Scaffold(
      body: TopGlowBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const AppHeader(level: 'LEVEL 1'),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.02),

                      // --- Main Titles ---
                      const Center(
                        child: Text(
                          'What state feels\nclosest now?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Center(
                        child: Text(
                          'Take a moment to check in with your\nemotional resonance before we finalize\nyour session.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textPrimary.withOpacity(0.7),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- State Grid ---
                      GridView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.25,
                            ),
                        itemCount: _states.length,
                        itemBuilder: (context, index) {
                          return _buildStateCard(
                            index: index,
                            title: _states[index]['title'],
                            icon: _states[index]['icon'],
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // --- Tracking Header ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Resentment Tracking',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.peachAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.peachAccent.withOpacity(0.3),
                                width: 1.0,
                              ),
                            ),
                            child: const Text(
                              'LIVE UPDATES',
                              style: TextStyle(
                                color: AppColors.peachAccent,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // --- Stats Grid ---
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              label: 'SESSIONS\nCOMPLETED',
                              value: '1',
                              valueColor: AppColors.accentBlueLite,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              label: 'RELEASES\nCOMPLETED',
                              value: '1',
                              valueColor: AppColors.accentBlueLite,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              label: 'HELD RESENTMENT',
                              value: '0',
                              valueColor: AppColors.peachAccent,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              label: 'TOTAL WEIGHT\nRELEASED',
                              value: '5',
                              suffix: 'lbs',
                              valueColor: AppColors.accentBlueLite,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      _buildQuoteCard(screenHeight),

                      SizedBox(height: screenHeight * 0.03),
                      PrimaryButton(
                        text: 'START AGAIN',
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const BlindForgivenessScreen(),
                            ),
                            (route) => false,
                          );
                        },
                      ),

                      SizedBox(height: screenHeight * 0.12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNavBar(selectedIndex: 0),
      // extendBody: true,
    );
  }

  Widget _buildStateCard({
    required int index,
    required String title,
    required IconData icon,
  }) {
    final isSelected = _selectedStateIndex == index;
    final color = AppColors.accentBlueLite;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStateIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.1)
              : AppColors.cardLikePillBg.withOpacity(0.2),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? color.withOpacity(0.5)
                : AppColors.textPrimary.withOpacity(0.05),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? color.withOpacity(0.2)
                    : AppColors.textPrimary.withOpacity(0.05),
              ),
              child: Icon(
                icon,
                color: isSelected ? color : AppColors.accentBlueLite,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textPrimary.withOpacity(0.9),
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required Color valueColor,
    String? suffix,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardLikePillBg.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary.withOpacity(0.5),
              fontSize: 8,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.0,
                ),
              ),
              if (suffix != null) ...[
                const SizedBox(width: 4),
                Text(
                  suffix,
                  style: TextStyle(
                    color: AppColors.textPrimary.withOpacity(0.5),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(double screenHeight) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.textPrimary.withOpacity(0.08)),
        // Background Image Configuration
        image: DecorationImage(
          image: const AssetImage('assets/pngs/mars.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.bgDark.withOpacity(0.85),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote_rounded,
            color: AppColors.accentBlueLite.withOpacity(0.7),
            size: 20,
          ),
          SizedBox(height: screenHeight * 0.018),
          const Text(
            '"Forgiveness is not an\noccasional act, it is a\nconstant attitude."',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          SizedBox(height: screenHeight * 0.018),
          Row(
            children: [
              Container(
                width: 24,
                height: 1,
                color: AppColors.accentBlueLite.withOpacity(0.5),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'MARTIN LUTHER KING JR.',
                style: TextStyle(
                  color: AppColors.accentBlueLite,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
