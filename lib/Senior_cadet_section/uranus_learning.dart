import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:galaxy_explorer/services/leaderboard_service.dart';

class UranusLearningPage extends StatefulWidget {
  const UranusLearningPage({super.key});

  @override
  State<UranusLearningPage> createState() => _UranusLearningPageState();
}

class _UranusLearningPageState extends State<UranusLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('assets/videos/uranus.mp4')
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
    if (_videoController.value.isPlaying) {
      _videoController.pause();
    } else {
      _videoController.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "🪐 ইউরেনাস (Uranus)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // VIDEO
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
                      : const Center(child: CircularProgressIndicator()),
                ),
              ),

              // CONTENT
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      _card("🪐 ইউরেনাস গ্রহ", "ইউরেনাস সৌরজগতের সপ্তম গ্রহ।"),
                      _card("❄️ আইস জায়ান্ট", "এতে বরফ ও গ্যাস থাকে।"),
                      _card("🔵 রঙ", "মিথেন গ্যাসের কারণে নীল-সবুজ।"),
                      _card("🔄 কাত হয়ে ঘোরে", "এটি পাশ ফিরে ঘোরে।"),
                      _card("🌬️ ঠান্ডা", "খুব ঠান্ডা গ্রহ।"),
                      _card("🌙 চাঁদ", "২৫+ চাঁদ আছে।"),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // QUIZ BUTTON
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UranusQuizPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "🚀 কুইজ শুরু করো",
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
        border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.lightBlueAccent,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            style: const TextStyle(
              color: Color.fromARGB(255, 7, 7, 7),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// QUIZ PAGE
class UranusQuizPage extends StatefulWidget {
  const UranusQuizPage({super.key});

  @override
  State<UranusQuizPage> createState() => _UranusQuizPageState();
}

class _UranusQuizPageState extends State<UranusQuizPage> {
  int current = 0;
  int score = 0;

  List<Question> questions = [
    Question("ইউরেনাস কোন গ্রহ?", ["৫ম", "৬ষ্ঠ", "৭ম", "৮ম"], 2),
    Question("ইউরেনাস কী ধরনের?", ["গ্যাস", "আইস", "পাথর", "ছোট"], 1),
    Question("রঙ কেন?", ["মিথেন", "আগুন", "পানি", "সূর্য"], 0),
    Question("কিভাবে ঘোরে?", ["সোজা", "কাত", "উল্টো", "স্থির"], 1),
    Question("চাঁদ কয়টি?", ["১০", "২০", "২৫+", "৫"], 2),
    Question("ইউরেনাস কী?", ["গরম", "ঠান্ডা", "ছোট", "বড়"], 1),
    Question("গ্যাস?", ["O2", "CH4", "CO2", "H"], 1),
    Question("রঙ?", ["লাল", "নীল", "সবুজ", "হলুদ"], 1),
    Question("টাইপ?", ["আইস", "গ্যাস", "রক", "মিনি"], 0),
    Question("গ্রহ নম্বর?", ["৭", "৮", "৬", "৫"], 0),
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
      backgroundColor: const Color(0xFF001A1F),
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/10"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (current + 1) / 10,
              backgroundColor: Colors.white24,
              color: Colors.lightBlueAccent,
            ),
            const SizedBox(height: 30),
            Text(
              q.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
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
                        backgroundColor: Colors.white10,
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

// RESULT PAGE
class ResultPage extends StatelessWidget {
  final int score;
  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    int wrong = 10 - score;

    return Scaffold(
      backgroundColor: const Color(0xFF001A1F),
      appBar: AppBar(
        title: const Text("ফলাফল"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "আপনার স্কোর: $score / 10",
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
                  moduleId: 'uranus',
                  score: score,
                  total: 10,
                );
                if (!context.mounted) {
                  return;
                }
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
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

// Fixed Question Class
class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question(this.question, this.options, this.correctIndex);
}
