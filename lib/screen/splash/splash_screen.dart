import 'dart:async';
import 'package:ai_emotion_app/screen/splash/notice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Precise 1-second delay as requested
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const NoticeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // Radial gradient to match the deep navy depth of the design
          gradient: LinearGradient(
            begin: Alignment(-1, -0.99),  // Less vertical offset
            end: Alignment(1, 0.80),
            colors: [
              Color(0xff1F3245),
              Color(0xff111E2E),
              Color(0xff0B1222),
              Color(0xff0B1222),
              Color(0xff0B1222),
              Color(0xff070B1A),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container
            Image.asset('assets/pngs/logo.png', height: 100, width: 100,),
            //Container(color: Colors.red, child: SvgPicture.asset('assets/logo.svg')), // Replace with your asset
            const SizedBox(height: 10),

            // Main Title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "THE",
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 20,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bankgothicmdbt',
                    // Suggested font for this tech look
                    color: Colors.white,
                  ),
                ),
                Text(
                  "NOT",
                  style: TextStyle(
                    height: 1,
                    fontSize: 34,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bankgothicmdbt',
                    // Suggested font for this tech look
                    color: Colors.red,
                  ),
                ),
                Text(
                  "YOU",
                  style: TextStyle(
                    height: 1.3,
                    fontSize: 20,
                    letterSpacing: 4.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'bankgothicmdbt',
                    // Suggested font for this tech look
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Tagline
            const Text(
              'Break free from your thoughts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w300,
                fontFamily: 'Montserrat', // Clean sans-serif
              ),
            ),
          ],
        ),
      ),
    );
  }
}
