import 'dart:ui';

import 'package:ai_emotion_app/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/app_background.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/primary_button.dart';
import '../signup/signup_screen.dart';
import 'assessment_screen.dart';


class RegistrationSuccessfulScreen extends StatelessWidget {
  const RegistrationSuccessfulScreen({super.key});

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
                          padding: EdgeInsets.only(left: 24, right: 24),
                          width: screenWidth * 0.25,
                          height: screenWidth * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //color: AppColors.warningCircleBg,
                            gradient: const LinearGradient(
                              colors: [AppColors.buttonStart, AppColors.buttonEnd],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            boxShadow: [
                              /*BoxShadow(
                                color: AppColors.warningCircleBg.withOpacity(0.5),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),*/
                            ],
                          ),
                          child: SvgPicture.asset('assets/svg/tick_ic.svg',)
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      const Text(
                        'Registration Successful',
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
                        'Your account is awaiting admin \napproval. You will receive a notification \nonce your settings is activated.',
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
                  text: 'CONTINUE',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AssessmentScreen()));
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
