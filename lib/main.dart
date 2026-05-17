import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DoubleGuessGameApp());
}

class DoubleGuessGameApp extends StatelessWidget {
  const DoubleGuessGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لعبة التخمين المزدوج',
      home: HomeScreen(),
    );
  }
}
