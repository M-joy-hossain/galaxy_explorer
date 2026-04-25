import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:galaxy_explorer/services/leaderboard_service.dart';

class JupiterLearningPage extends StatefulWidget {
  const JupiterLearningPage({super.key});

  @override
  State<JupiterLearningPage> createState() => _JupiterLearningPageState();
}

class _JupiterLearningPageState extends State<JupiterLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/jupiter.mp4')
      ..initialize().then((_) {
        setState(() => _isVideoInitialized = true);
        _videoController.setLooping(true);
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _videoController.value.isPlaying
          ? _videoController.pause()
          : _videoController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Senior_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "🪐 বৃহস্পতি (Jupiter)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 10, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _isVideoInitialized ? _togglePlay : null,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 20,
                      ),
                    ],
                    color: Colors.black26,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: _isVideoInitialized
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              AspectRatio(
                                aspectRatio: _videoController.value.aspectRatio,
                                child: VideoPlayer(_videoController),
                              ),
                              if (!_videoController.value.isPlaying)
                                const Icon(
                                  Icons.play_circle_fill,
                                  size: 70,
                                  color: Colors.white,
                                ),
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                            ),
                          ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _card(
                      "🪐 বৃহস্পতি গ্রহ",
                      "বৃহস্পতি সৌরজগতের সবচেয়ে বড় গ্রহ। এটি একটি গ্যাস জায়ান্ট।",
                    ),
                    _card(
                      "🌪️ গ্যাস জায়ান্ট",
                      "এটি মূলত হাইড্রোজেন ও হিলিয়াম গ্যাস দিয়ে তৈরি। এর কোন শক্ত পৃষ্ঠ নেই।",
                    ),
                    _card(
                      "🔴 গ্রেট রেড স্পট",
                      "বৃহস্পতির বিখ্যাত ঝড় ‘গ্রেট রেড স্পট’ শত শত বছর ধরে চলছে।",
                    ),
                    _card(
                      "🌙 অনেক চাঁদ",
                      "বৃহস্পতির ৯০টিরও বেশি চাঁদ আছে। গ্যানিমেড এর সবচেয়ে বড় চাঁদ।",
                    ),
                    _card(
                      "⚡ শক্তিশালী মাধ্যাকর্ষণ",
                      "এর মাধ্যাকর্ষণ এত শক্তিশালী যে এটি পৃথিবীকে ধুমকেতুর হাত থেকে রক্ষা করে।",
                    ),
                    _card(
                      "🌀 দ্রুত ঘূর্ণন",
                      "এটি সৌরজগতের সবচেয়ে দ্রুত ঘূর্ণনশীল গ্রহ।",
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const JupiterQuizPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "🚀 কুইজ শুরু করো",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card(String title, String content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            style: const TextStyle(
              color: Color.fromARGB(255, 10, 10, 10),
              fontSize: 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  Question(this.question, this.options, this.correctIndex);
}

class JupiterQuizPage extends StatefulWidget {
  const JupiterQuizPage({super.key});

  @override
  State<JupiterQuizPage> createState() => _JupiterQuizPageState();
}

class _JupiterQuizPageState extends State<JupiterQuizPage> {
  int current = 0;
  int score = 0;

  final List<Question> questions = [
    Question("সৌরজগতের সবচেয়ে বড় গ্রহ কোনটি?", [
      "পৃথিবী",
      "মঙ্গল",
      "বৃহস্পতি",
      "শনি",
    ], 2),
    Question("বৃহস্পতি কী ধরনের গ্রহ?", [
      "পাথুরে",
      "গ্যাস জায়ান্ট",
      "বরফ গ্রহ",
      "ছোট গ্রহ",
    ], 1),
    Question("গ্রেট রেড স্পট আসলে কী?", [
      "চাঁদ",
      "বিশাল ঝড়",
      "পর্বত",
      "সমুদ্র",
    ], 1),
    Question("বৃহস্পতিতে প্রধানত কোন গ্যাস থাকে?", [
      "অক্সিজেন",
      "হাইড্রোজেন",
      "কার্বন",
      "নাইট্রোজেন",
    ], 1),
    Question("বৃহস্পতির কতগুলো চাঁদ আছে?", ["২", "১০", "৫০", "৯০+"], 3),
    Question("সৌরজগতের সবচেয়ে দ্রুত ঘূর্ণনশীল গ্রহ কোনটি?", [
      "বুধ",
      "বৃহস্পতি",
      "শুক্র",
      "মঙ্গল",
    ], 1),
    Question("বৃহস্পতির সবচেয়ে বড় চাঁদের নাম কী?", [
      "গ্যানিমেড",
      "টাইটান",
      "ইউরোপা",
      "চাঁদ",
    ], 0),
    Question("বৃহস্পতির মাধ্যাকর্ষণ শক্তি কেমন?", [
      "খুব দুর্বল",
      "মাঝারি",
      "খুব শক্তিশালী",
      "নেই",
    ], 2),
    Question("বৃহস্পতির বিখ্যাত ঝড়ের রঙ কী?", [
      "নীল",
      "সবুজ",
      "লাল",
      "হলুদ",
    ], 2),
    Question("বৃহস্পতির কি কোন শক্ত মাটি আছে?", [
      "হ্যাঁ",
      "না",
      "অল্প",
      "শুধু মেরু অঞ্চলে",
    ], 1),
  ];

  void answer(int i) {
    if (questions[current].correctIndex == i) score++;
    if (current < questions.length - 1) {
      setState(() => current++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[current];
    return Scaffold(
      backgroundColor: const Color(0xFF1B1200),
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/10"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (current + 1) / 10,
              color: Colors.orangeAccent,
              backgroundColor: Colors.white10,
            ),
            const SizedBox(height: 40),
            Text(
              q.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    onPressed: () => answer(i),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.1),
                      padding: const EdgeInsets.all(18),
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      q.options[i],
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  const ResultPage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1200),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.stars, color: Colors.orangeAccent, size: 80),
            const SizedBox(height: 20),
            const Text(
              "কুইজ সম্পন্ন হয়েছে!",
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "আপনার স্কোর: $score / $total",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: score.toDouble(),
                      color: Colors.greenAccent,
                      title: 'সঠিক',
                      radius: 65,
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    PieChartSectionData(
                      value: (total - score).toDouble(),
                      color: Colors.redAccent,
                      title: 'ভুল',
                      radius: 65,
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                await LeaderboardService.instance.saveSeniorQuizAttempt(
                  moduleId: 'jupiter',
                  score: score,
                  total: total,
                );
                if (!context.mounted) {
                  return;
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "ফিরে যাও",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
