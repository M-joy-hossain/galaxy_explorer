import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart'; // Pie Chart এর জন্য এটি প্রয়োজন

class MathProblemSolving extends StatefulWidget {
  const MathProblemSolving({super.key});

  @override
  _MathProblemSolvingState createState() => _MathProblemSolvingState();
}

class _MathProblemSolvingState extends State<MathProblemSolving>
    with TickerProviderStateMixin {
  int num1 = 3;
  int num2 = 2;
  int score = 0;
  int questionCount = 0; // প্রশ্নের সংখ্যা গণনার জন্য
  int correctAnswers = 0; // কয়টি সঠিক হয়েছে তার জন্য
  bool isAddition = true;
  late AnimationController _rocketController;
  late Animation<double> _rocketAnimation;

  @override
  void initState() {
    super.initState();
    _generateNewProblem();

    _rocketController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _rocketAnimation = Tween<double>(begin: 0, end: -300).animate(
      CurvedAnimation(parent: _rocketController, curve: Curves.easeOut),
    );
  }

  void _generateNewProblem() {
    if (questionCount >= 10) {
      // ১০টি প্রশ্ন শেষ হলে রেজাল্ট পেজে নিয়ে যাবে
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SpaceMathResult(
              score: score,
              correct: correctAnswers,
              total: 10,
            ),
          ),
        );
      });
      return;
    }

    Random random = Random();
    setState(() {
      questionCount++;
      isAddition = random.nextBool();
      if (isAddition) {
        num1 = random.nextInt(6) + 1;
        num2 = random.nextInt(5) + 1;
      } else {
        num1 = random.nextInt(6) + 5;
        num2 = random.nextInt(5) + 1;
      }
    });
  }

  void _checkAnswer(int userAnswer) {
    int correctAnswer = isAddition ? (num1 + num2) : (num1 - num2);

    if (userAnswer == correctAnswer) {
      correctAnswers++;
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops! Try again, Alien is watching! 👽"),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 500),
        ),
      );
      _generateNewProblem(); // ভুল হলেও পরের প্রশ্নে নিয়ে যাবে
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
    List<int> options = [correctAnswer, correctAnswer + 2, correctAnswer - 1];
    options.shuffle();

    return Scaffold(
      backgroundColor: const Color(0xFF050510),
      appBar: AppBar(
        title: Text("Quest: $questionCount / 10"), // প্রগ্রেস দেখাবে
        backgroundColor: Colors.indigo[900],
        elevation: 0,
      ),
      body: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: Text(
                "✨ . * . ✨ . *",
                style: TextStyle(color: Colors.white24, fontSize: 30),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Score: $score",
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildObjectGroup(num1, "🚀"),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      isAddition ? "+" : "-",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildObjectGroup(num2, isAddition ? "🚀" : "👽"),
                ],
              ),
              const SizedBox(height: 40),
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
              const Text(
                "What is the result?",
                style: TextStyle(color: Colors.white70, fontSize: 20),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: options
                    .map(
                      (opt) => ElevatedButton(
                        onPressed: () => _checkAnswer(opt),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35,
                            vertical: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          side: const BorderSide(
                            color: Colors.cyanAccent,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "$opt",
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
        children: List.generate(
          count,
          (index) => Text(emoji, style: const TextStyle(fontSize: 25)),
        ),
      ),
    );
  }
}

// ---------------- রেজাল্ট পেজ উইজেট ----------------
class SpaceMathResult extends StatelessWidget {
  final int score;
  final int correct;
  final int total;

  const SpaceMathResult({
    super.key,
    required this.score,
    required this.correct,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    int wrong = total - correct;

    return Scaffold(
      backgroundColor: const Color(0xFF050510),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🎊 CONGRATULATIONS! 🎊",
                style: TextStyle(
                  color: Colors.yellowAccent,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "You are a Space Math Hero! 👨‍🚀",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 40),

              // Pie Chart
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: correct.toDouble(),
                        color: Colors.greenAccent,
                        title: 'Correct',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      PieChartSectionData(
                        value: wrong.toDouble(),
                        color: Colors.redAccent,
                        title: 'Wrong',
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                    centerSpaceRadius: 40,
                    sectionsSpace: 5,
                  ),
                ),
              ),

              const SizedBox(height: 40),
              Text(
                "Final Score: $score",
                style: const TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MathProblemSolving(),
                    ),
                  );
                },
                icon: const Icon(Icons.refresh, color: Colors.white),
                label: const Text(
                  "Play Again",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
