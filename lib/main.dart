import 'package:ai_emotion_app/screen/addiction/session_complete_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set status bar overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AiEmotionApp());
}

class AiEmotionApp extends StatelessWidget {
  const AiEmotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Not You',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgDark,
        fontFamily: 'Outfit', // Using a premium font placeholder
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.bgGlow,
          brightness: Brightness.dark,
          primary: AppColors.textPrimary,
          secondary: AppColors.accentRed,
        ),
      ),
      home: const SessionCompleteScreen(),
    );
  }
}
