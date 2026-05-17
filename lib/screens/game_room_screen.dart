import 'package:flutter/material.dart';
import '../utils/constants.dart';

class GameRoomScreen extends StatefulWidget {
  final String category;
  const GameRoomScreen({super.key, required this.category});

  @override
  State<GameRoomScreen> createState() => _GameRoomScreenState();
}

class _GameRoomScreenState extends State<GameRoomScreen> {
  int myWins = 0;
  int opponentWins = 0;
  final TextEditingController _chatController = TextEditingController();
  List<String> chatMessages = ["النظام: بدأت الجولة الأولى!"];

  void _sendMessage() {
    if (_chatController.text.isNotEmpty) {
      setState(() {
        chatMessages.add("أنت: \${_chatController.text}");
        // محاكاة لرد الخصم
        if (_chatController.text.contains("؟")) {
           chatMessages.add("الخصم: لا أعتقد ذلك.");
        }
        _chatController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.background,
      appBar: AppBar(
        title: Text('غرفة: \${widget.category}'),
        backgroundColor: GameColors.primary,
        actions: [
           IconButton(icon: const Icon(Icons.mic), onPressed: () {}), // زر الصوت
        ],
      ),
      body: Column(
        children: [
          // شريط النتائج (Best of 3)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('أنت: \$myWins/2', style: const TextStyle(color: Colors.greenAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                const Text('الجولة 1', style: TextStyle(color: Colors.white70, fontSize: 18)),
                Text('الخصم: \$opponentWins/2', style: const TextStyle(color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          
          // منطقة عرض صورة الخصم (التي يجب أن تخمنها أنت)
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: GameColors.panel,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: GameColors.secondary, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('هذه هي صورة الخصم', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  SizedBox(height: 10),
                  Icon(Icons.image, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('ساعده في تخمينها!', style: TextStyle(color: GameColors.secondary, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // مساحة الشات
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(chatMessages[index], style: const TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ),
          
          // حقل إدخال الشات والرد
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'اسأل سؤالاً (مثال: هل هو حيوان أليف؟)',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: GameColors.panel,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: GameColors.primary,
                  radius: 25,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
          
          // زر التخمين النهائي
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('عرفت صورتي! (تخمين نهائي)', style: TextStyle(fontSize: 18, color: Colors.black87, fontWeight: FontWeight.bold)),
                onPressed: () {
                  // فتح نافذة لكتابة التخمين النهائي
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
