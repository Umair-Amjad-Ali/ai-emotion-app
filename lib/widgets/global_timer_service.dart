import 'dart:async';
import 'package:flutter/material.dart';

class GlobalTimerService extends ChangeNotifier {
  // Singleton pattern so the exact same timer is shared across the whole app
  static final GlobalTimerService _instance = GlobalTimerService._internal();
  factory GlobalTimerService() => _instance;
  GlobalTimerService._internal();

  Timer? _timer;
  int _remainingSeconds = 30 * 60; // Default 30 minutes

  int get remainingSeconds => _remainingSeconds;

  // Formats the seconds into "MM:SS"
  String get timeString {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Call this when entering the first screen to start or restart the timer
  void startOrResetTimer({int minutes = 30}) {
    _timer?.cancel(); // Stop any existing timer
    _remainingSeconds = minutes * 60;
    notifyListeners(); // Update the UI immediately

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        notifyListeners(); // Tell all connected widgets to rebuild
      } else {
        timer.cancel(); // Stop when it hits 00:00
      }
    });
  }

  // Optional: Call this if you want to completely destroy the timer
  void stopTimer() {
    _timer?.cancel();
  }
}
