import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التخمين التنافسي', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: GameColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.videogame_asset, size: 100, color: GameColors.accent),
            const SizedBox(height: 40),
            const Text(
              'اختر فئة اللعب:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: GameColors.text),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: GameStyles.mainButton,
              icon: const Icon(Icons.branding_watermark),
              label: const Text('ماركات عالمية'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameScreen(category: 'ماركات عالمية')),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: GameStyles.mainButton,
              icon: const Icon(Icons.sports_soccer),
              label: const Text('شخصيات رياضية'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameScreen(category: 'شخصيات رياضية')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
