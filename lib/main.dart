import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const GuessGameApp());
}

class GuessGameApp extends StatelessWidget {
  const GuessGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لعبة التخمين التنافسية',
      theme: ThemeData.dark().copyWith(
        primaryColor: GameColors.primary,
        scaffoldBackgroundColor: GameColors.background,
      ),
      home: const HomeScreen(),
    );
  }
}
