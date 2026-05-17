import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
      // دعم اللغة العربية
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ar', 'EG'), 
      ],
      locale: Locale('ar', 'EG'),
      home: HomeScreen(),
    );
  }
}
