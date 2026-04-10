import 'package:flutter/material.dart';
import 'dart:math';

class MathProblemSolving extends StatefulWidget {
  const MathProblemSolving({super.key});

  @override
  _MathProblemSolvingState createState() => _MathProblemSolvingState();
}

class _MathProblemSolvingState extends State<MathProblemSolving> with TickerProviderStateMixin {
  int num1 = 3;
  int num2 = 2;
  int score = 0;
  bool isAddition = true; // যোগ নাকি বিয়োগ তা ঠিক করবে
  late AnimationController _rocketController;
  late Animation<double> _rocketAnimation;

  @override
  void initState() {
    super.initState();
    _generateNewProblem();

    // রকেট ওড়ার এনিমেশন
    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _rocketAnimation = Tween<double>(begin: 0, end: -300).animate(
      CurvedAnimation(parent: _rocketController, curve: Curves.easeOut),
    );
  }

  void _generateNewProblem() {
    Random random = Random();
    setState(() {
      isAddition = random.nextBool(); // র‍্যান্ডমলি যোগ বা বিয়োগ আসবে
      if (isAddition) {
        num1 = random.nextInt(6) + 1; // ১ থেকে ৬
        num2 = random.nextInt(5) + 1; // ১ থেকে ৫
      } else {
        num1 = random.nextInt(6) + 5; // ৫ থেকে ১০
        num2 = random.nextInt(5) + 1; // ১ থেকে ৫ (যাতে উত্তর মাইনাস না হয়)
      }
    });
  }

  void _checkAnswer(int userAnswer) {
    int correctAnswer = isAddition ? (num1 + num2) : (num1 - num2);

    if (userAnswer == correctAnswer) {
      _rocketController.forward().then((_) {
        _rocketController.reset();
        setState(() {
          score += 10;
        });
        _generateNewProblem();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Superb, Astronaut! 🚀 Rocket Launched!"),
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
        ),
      );
    } else {
      // ভুল হলে হালকা ভাইব্রেশন বা মেসেজ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops! Try again, Alien is watching! 👽"),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _rocketController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int correctAnswer = isAddition ? (num1 + num2) : (num1 - num2);
    
    // অপশন জেনারেট করা (একটি সঠিক, বাকি দুটি ভুল)
    List<int> options = [correctAnswer, correctAnswer + 2, correctAnswer - 1];
    options.shuffle();

    return Scaffold(
      backgroundColor: const Color(0xFF050510),
      appBar: AppBar(
        title: const Text("Space Math Quest"),
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Stars (Static)
          const Positioned.fill(child: Center(child: Text("✨  .  * .  ✨  .  *", style: TextStyle(color: Colors.white24, fontSize: 30)))),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Score
              Text("Score: $score", style: const TextStyle(color: Colors.cyanAccent, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),

              // Problem Area
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildObjectGroup(num1, "🚀"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(isAddition ? "+" : "-", style: const TextStyle(color: Colors.orange, fontSize: 50, fontWeight: FontWeight.bold)),
                  ),
                  _buildObjectGroup(num2, isAddition ? "🚀" : "👽"),
                ],
              ),
              
              const SizedBox(height: 40),
              
              // Animated Rocket
              AnimatedBuilder(
                animation: _rocketAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _rocketAnimation.value),
                    child: const Text("🚀", style: TextStyle(fontSize: 80)),
                  );
                },
              ),

              const SizedBox(height: 40),
              const Text("How many are left?", style: TextStyle(color: Colors.white70, fontSize: 20)),
              const SizedBox(height: 30),

              // Answer Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: options.map((opt) => ElevatedButton(
                  onPressed: () => _checkAnswer(opt),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    side: const BorderSide(color: Colors.cyanAccent, width: 1),
                  ),
                  child: Text("$opt", style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
                )).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ইমোজি দিয়ে সংখ্যা বোঝানোর উইজেট
  Widget _buildObjectGroup(int count, String emoji) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 120),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: List.generate(count, (index) => Text(emoji, style: const TextStyle(fontSize: 25))),
      ),
    );
  }
}