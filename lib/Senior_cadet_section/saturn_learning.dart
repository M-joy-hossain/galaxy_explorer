import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:galaxy_explorer/services/leaderboard_service.dart';

class SaturnLearningPage extends StatefulWidget {
  const SaturnLearningPage({super.key});

  @override
  State<SaturnLearningPage> createState() => _SaturnLearningPageState();
}

class _SaturnLearningPageState extends State<SaturnLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('assets/videos/saturn.mp4')
      ..initialize()
          .then((_) {
            setState(() {
              _isVideoInitialized = true;
            });
            _videoController.setLooping(true);
          })
          .catchError((error) {
            debugPrint("Video Error: $error");
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
        fit: StackFit.expand,
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Senior_background.png',
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // HEADER
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 5,
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
                        "🪐 শনি (Saturn)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // 🎬 VIDEO
              GestureDetector(
                onTap: _isVideoInitialized ? _togglePlay : null,
                child: Container(
                  height: 250,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Colors.black26,
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
                                size: 80,
                                color: Colors.white70,
                              ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange,
                          ),
                        ),
                ),
              ),

              // 📜 CONTENT
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _card(
                        "🪐 শনি গ্রহ",
                        "শনি সৌরজগতের দ্বিতীয় বৃহত্তম গ্রহ এবং এটি তার সুন্দর বলয়ের জন্য বিখ্যাত।",
                      ),

                      _card(
                        "💍 বলয় (Rings)",
                        "শনির চারপাশে অসংখ্য বরফ ও পাথরের কণা দিয়ে তৈরি বিশাল বলয় রয়েছে।",
                      ),

                      _card(
                        "🌫️ গ্যাস জায়ান্ট",
                        "শনি একটি গ্যাস জায়ান্ট, যা প্রধানত হাইড্রোজেন ও হিলিয়াম দিয়ে তৈরি।",
                      ),

                      _card(
                        "🌬️ খুব হালকা গ্রহ",
                        "শনি এত হালকা যে এটি যদি পানিতে রাখা যেত, তাহলে ভেসে থাকত!",
                      ),

                      _card(
                        "🌙 অনেক চাঁদ",
                        "শনির ৮০+ চাঁদ আছে। টাইটান (Titan) এর সবচেয়ে বড় চাঁদ।",
                      ),

                      _card(
                        "🧊 ঠান্ডা গ্রহ",
                        "শনির তাপমাত্রা খুব কম এবং এটি সূর্য থেকে অনেক দূরে অবস্থিত।",
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // 🚀 QUIZ BUTTON
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SaturnQuizPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
              color: Color.fromARGB(255, 10, 10, 10),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- QUIZ ----------------

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question(this.question, this.options, this.correctIndex);
}

class SaturnQuizPage extends StatefulWidget {
  const SaturnQuizPage({super.key});

  @override
  State<SaturnQuizPage> createState() => _SaturnQuizPageState();
}

class _SaturnQuizPageState extends State<SaturnQuizPage> {
  int current = 0;
  int score = 0;

  List<Question> questions = [
    Question("শনি গ্রহ কী জন্য বিখ্যাত?", ["রং", "বলয়", "তাপ", "পাহাড়"], 1),
    Question("শনি কোন ধরনের গ্রহ?", [
      "পাথুরে",
      "গ্যাস জায়ান্ট",
      "বরফ গ্রহ",
      "ছোট গ্রহ",
    ], 1),
    Question("শনির বলয় কী দিয়ে তৈরি?", [
      "আগুন",
      "বরফ ও পাথর",
      "গ্যাস",
      "মাটি",
    ], 1),
    Question("শনির সবচেয়ে বড় চাঁদ কোনটি?", [
      "চাঁদ",
      "টাইটান",
      "ইউরোপা",
      "আইও",
    ], 1),
    Question("শনি গ্রহের তাপমাত্রা কেমন?", [
      "খুব গরম",
      "মাঝারি",
      "খুব ঠান্ডা",
      "পরিবর্তনশীল",
    ], 2),
  ];

  void answer(int i) {
    if (questions[current].correctIndex == i) score++;

    if (current < questions.length - 1) {
      setState(() => current++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultPage(score: score)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[current];

    return Scaffold(
      backgroundColor: const Color(0xFF1A0F00), // Dark Orange/Brown theme
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/5"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (current + 1) / 5,
              backgroundColor: Colors.white24,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 30),
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
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      onPressed: () => answer(i),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        q.options[i],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- RESULT ----------------

class ResultPage extends StatelessWidget {
  final int score;
  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    int total = 5;
    int wrong = total - score;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0F00),
      appBar: AppBar(
        title: const Text("ফলাফল"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "আপনার স্কোর: $score / $total",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 5,
                  centerSpaceRadius: 50,
                  sections: [
                    PieChartSectionData(
                      value: score.toDouble(),
                      color: Colors.green,
                      title: 'সঠিক',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      value: wrong.toDouble(),
                      color: Colors.red,
                      title: 'ভুল',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
                  moduleId: 'saturn',
                  score: score,
                  total: total,
                );
                if (!context.mounted) {
                  return;
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "ফিরে যান",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
