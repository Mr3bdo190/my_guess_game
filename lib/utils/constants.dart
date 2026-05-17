import 'package:flutter/material.dart';

class GameColors {
  static const Color background = Color(0xFF121212);
  static const Color primary = Colors.deepPurple;
  static const Color accent = Colors.deepPurpleAccent;
  static const Color text = Colors.white;
  static const Color correct = Colors.greenAccent;
  static const Color timer = Colors.orangeAccent;
}

class GameStyles {
  static final ButtonStyle mainButton = ElevatedButton.styleFrom(
    backgroundColor: GameColors.accent,
    foregroundColor: GameColors.text,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(vertical: 16),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );
}
