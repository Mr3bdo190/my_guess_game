import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'game_room_screen.dart';
import 'bluetooth_lobby_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.background,
      appBar: AppBar(
        title: const Text('لعبة التخمين المزدوج 🎭', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: GameColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🧠', style: TextStyle(fontSize: 100)),
            const SizedBox(height: 30),
            const Text(
              'اختر فئة وابحث عن منافس!',
              style: TextStyle(color: GameColors.text, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 15,
              runSpacing: 15,
              alignment: WrapAlignment.center,
              children: [
                _buildCategoryButton(context, 'حيوانات 🦁', Icons.pets),
                _buildCategoryButton(context, 'سيارات 🏎️', Icons.directions_car),
                _buildCategoryButton(context, 'رياضة ⚽', Icons.sports_soccer),
                _buildCategoryButton(context, 'ماركات 👟', Icons.storefront),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              icon: const Text('📶', style: TextStyle(fontSize: 18)),
              label: const Text('اللعب مع صديق بجانبك', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BluetoothLobbyScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String title, IconData icon) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: GameColors.panel,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      icon: Icon(icon, color: GameColors.secondary),
      label: Text(title, style: const TextStyle(color: GameColors.text, fontSize: 18)),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => GameRoomScreen(category: title)));
      },
    );
  }
}
