import 'package:ai_emotion_app/screen/addiction/session_complete_screen.dart';
import 'package:ai_emotion_app/screen/restfullmind/night_reset.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/breathe_with_the_circle.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/choose_a_safe_place.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/confirm_present_safety.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/reconnect_to_what_is_real.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/release_physical_tension.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/release_physical_tension2.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/separate_past_from_present.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/stabilize_nervous_system.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/what_do_you_feel_right_now.dart';
import 'package:ai_emotion_app/screen/trauma_trigger_stabilizer/what_triggered_you.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
        fontFamily: 'Outfit',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.bgGlow,
          brightness: Brightness.dark,
          primary: AppColors.textPrimary,
          secondary: AppColors.accentRed,
        ),
      ),
      home: const StabilizeNervousSystem(),
    );
  }
}
