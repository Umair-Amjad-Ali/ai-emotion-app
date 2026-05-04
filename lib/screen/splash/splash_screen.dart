import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'notice_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: Stack(
        children: [
          // 1. Background Gradient (Top-Left Glow & Bottom-Right Glow)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.bgGlowSplash, AppColors.bgDark],
                  stops: [0.0, 0.5], // Only Top-Left glow
                ),
              ),
            ),
          ),

          // 2. Main Content Area
          SafeArea(
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  final screenHeight = constraints.maxHeight;
                  final screenWidth = constraints.maxWidth;

                  final logoSize = screenWidth * 0.28;
                  final baseFontSize = screenWidth * 0.055;
                  final titleLetterSpacing = screenWidth * 0.015;
                  final taglineFontSize = screenWidth * 0.035;
                  final verticalPadding = screenHeight * 0.01;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- The Logo ---
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NoticeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: logoSize,
                          height: logoSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/tny_logo_core.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.psychology,
                                    color: Colors.white70,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: verticalPadding * 1.5),

                      // --- The Title ---
                      // Recreates: THE NOT YOU (with NOT bigger and all red)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'THE ',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: baseFontSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: titleLetterSpacing,
                            ),
                          ),
                          Text(
                            'NOT',
                            style: TextStyle(
                              color: AppColors.accentRed,
                              fontSize: baseFontSize * 1.6,
                              fontWeight: FontWeight.w900,
                              letterSpacing: titleLetterSpacing,
                            ),
                          ),
                          Text(
                            ' YOU',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: baseFontSize,
                              fontWeight: FontWeight.bold,
                              letterSpacing: titleLetterSpacing,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: verticalPadding),

                      // --- The Tagline ---
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                        ),
                        child: Text(
                          'Break free from your thoughts',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: taglineFontSize,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
