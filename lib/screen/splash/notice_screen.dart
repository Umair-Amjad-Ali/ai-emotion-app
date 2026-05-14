
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../Signup/signup_screen.dart';
import '../signup/select_language_screen.dart';


class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: MainBackground(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 24, right: 24,bottom: 10),
                        width: screenWidth * 0.25,
                        height: screenWidth * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.warningCircleBg,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.warningCircleBg.withOpacity(0.5),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset('assets/svg/warning.svg',)
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      const Text(
                        'Important Notice',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Text(
                        'This app is not intended to treat any illness.\nIf you are experiencing mental health challenges, please seek professional medical advice. This tool is designed for mindfulness and self-awareness practices only.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 15,
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),

                // Primary Button (Pill shape)
                PrimaryButton(
                  text: 'I UNDERSTAND & ACCEPT',
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
