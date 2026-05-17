import 'package:flutter/material.dart';
import 'dart:async';

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
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF121212),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('التخمين التنافسي', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.videogame_asset, size: 100, color: Colors.deepPurpleAccent),
            const SizedBox(height: 40),
            const Text(
              'اختر فئة اللعب:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.branding_watermark),
              label: const Text('ماركات عالمية'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameScreen(category: 'ماركات عالمية')),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
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

class GameScreen extends StatefulWidget {
  final String category;
  const GameScreen({super.key, required this.category});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int score = 0;
  int timeLeft = 15;
  Timer? timer;
  int currentQuestion = 1;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (timeLeft == 0) {
        setState(() {
          t.cancel();
          // منطق انتهاء الوقت
        });
      } else {
        setState(() {
          timeLeft--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void handleAnswer(bool isCorrect) {
    setState(() {
      if (isCorrect) score += 10;
      if (currentQuestion < 5) {
        currentQuestion++;
        timeLeft = 15; // إعادة ضبط الوقت
      } else {
        timer?.cancel();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('انتهت الجولة!'),
            content: Text('نقاطك الإجمالية: \$score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // غلق النافذة
                  Navigator.pop(context); // العودة للقائمة الرئيسية
                },
                child: const Text('العودة للقائمة'),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('السؤال: \$currentQuestion/5', style: const TextStyle(fontSize: 18)),
                Text('النقاط: \$score', style: const TextStyle(fontSize: 18, color: Colors.greenAccent)),
                Text('⏳ \$timeLeft ث', style: const TextStyle(fontSize: 18, color: Colors.orangeAccent)),
              ],
            ),
            const SizedBox(height: 30),
            // مكان عرض الصورة التخيلية
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.deepPurpleAccent, width: 2),
              ),
              child: const Center(
                child: Text('📷 مساحة عرض الصورة', style: TextStyle(color: Colors.white54, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: [
                  ElevatedButton(onPressed: () => handleAnswer(true), child: const Text('إجابة 1')),
                  ElevatedButton(onPressed: () => handleAnswer(false), child: const Text('إجابة 2')),
                  ElevatedButton(onPressed: () => handleAnswer(false), child: const Text('إجابة 3')),
                  ElevatedButton(onPressed: () => handleAnswer(false), child: const Text('إجابة 4')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
