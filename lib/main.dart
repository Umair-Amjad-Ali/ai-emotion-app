import 'package:ai_emotion_app/screen/addiction/wave_intensity_screen.dart';
import 'package:ai_emotion_app/screen/restfullmind/star_release.dart';
import 'package:ai_emotion_app/screen/restfullmind/body_relaxation_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_colors.dart';
import 'screen/addiction/wave_intensity_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const AiEmotionApp());
}

class AiEmotionApp extends StatelessWidget {
  const AiEmotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Emotion App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.bgDark,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const BodyRelaxationScanScreen(),
      // home: const WaveIntensityScreen(),
    );
  }
}
