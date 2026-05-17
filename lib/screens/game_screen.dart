import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/constants.dart';

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
          handleAnswer(false); // انتقال تلقائي عند انتهاء الوقت
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
        timeLeft = 15;
        // إعادة تشغيل المؤقت إذا كان متوقفاً
        if (!(timer?.isActive ?? false)) startTimer();
      } else {
        timer?.cancel();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: GameColors.background,
            title: const Text('انتهت الجولة!', style: TextStyle(color: GameColors.text)),
            content: Text('نقاطك الإجمالية: $score', style: const TextStyle(color: GameColors.correct)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('العودة للقائمة', style: TextStyle(color: GameColors.accent)),
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
        backgroundColor: GameColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('السؤال: $currentQuestion/5', style: const TextStyle(fontSize: 18, color: GameColors.text)),
                Text('النقاط: $score', style: const TextStyle(fontSize: 18, color: GameColors.correct)),
                Text('⏳ $timeLeft ث', style: const TextStyle(fontSize: 18, color: GameColors.timer)),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: GameColors.accent, width: 2),
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
                  ElevatedButton(style: GameStyles.mainButton, onPressed: () => handleAnswer(true), child: const Text('إجابة 1')),
                  ElevatedButton(style: GameStyles.mainButton, onPressed: () => handleAnswer(false), child: const Text('إجابة 2')),
                  ElevatedButton(style: GameStyles.mainButton, onPressed: () => handleAnswer(false), child: const Text('إجابة 3')),
                  ElevatedButton(style: GameStyles.mainButton, onPressed: () => handleAnswer(false), child: const Text('إجابة 4')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
