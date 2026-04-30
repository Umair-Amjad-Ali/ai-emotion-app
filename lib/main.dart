import 'package:ai_emotion_app/screen/addiction/trigger_analysis_screen.dart';
import 'package:ai_emotion_app/screen/addiction/urge_intensity_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_colors.dart';

void main() {
  // Set system UI to be light on a dark background
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark, // iOS
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
      home: const TriggerAnalysisScreen(),
    );
  }
}
