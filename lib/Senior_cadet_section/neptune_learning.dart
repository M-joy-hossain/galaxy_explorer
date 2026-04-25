import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';

class NeptuneLearningPage extends StatefulWidget {
  const NeptuneLearningPage({super.key});

  @override
  State<NeptuneLearningPage> createState() => _NeptuneLearningPageState();
}

class _NeptuneLearningPageState extends State<NeptuneLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/neptune.mp4')
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
          // 🌌 ব্যাকগ্রাউন্ড ইমেজ
          Positioned.fill(
            child: Image.asset(
              "assets/images/Senior_background.png",
              fit: BoxFit.cover,
            ),
          ),

          // হালকা ব্লু ওভারলে (অন্ধকার ভাব দূর করার জন্য)
          Container(color: Colors.blue.withOpacity(0.1)),

          Column(
            children: [
              // HEADER (ব্যালেন্স করার জন্য টপ প্যাডিং)
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.cyanAccent),
                    ),
                    const Expanded(
                      child: Text(
                        "🪐 নেপচুন (Neptune)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                            shadows: [Shadow(blurRadius: 15, color: Colors.black54)]),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // 🎬 ভিডিও প্লেয়ার
              GestureDetector(
                onTap: _isVideoInitialized ? _togglePlay : null,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(color: Colors.cyanAccent.withOpacity(0.2), blurRadius: 20)
                    ],
                    border: Border.all(color: Colors.white24),
                    color: Colors.black45,
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
                                const Icon(Icons.play_circle_fill,
                                    size: 70, color: Colors.white),
                            ],
                          )
                        : const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
                  ),
                ),
              ),

              // 📜 লার্নিং কার্ডস
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _card("🪐 নেপচুন গ্রহ", "নেপচুন সৌরজগতের অষ্টম ও সবচেয়ে দূরের গ্রহ।"),
                    _card("🌊 নীল গ্রহ", "মিথেন গ্যাসের কারণে নেপচুন গাঢ় নীল রঙের দেখায়।"),
                    _card("🌪️ প্রবল ঝড়", "নেপচুনে সৌরজগতের সবচেয়ে শক্তিশালী বাতাস ও ঝড় হয়।"),
                    _card("❄️ অত্যন্ত ঠান্ডা", "সূর্য থেকে অনেক দূরে হওয়ায় এটি খুব ঠান্ডা গ্রহ।"),
                    _card("🌙 চাঁদ", "নেপচুনের ১৪টি চাঁদ আছে, যার মধ্যে ট্রাইটন সবচেয়ে বড়।"),
                    _card("🌀 গ্রেট ডার্ক স্পট", "নেপচুনে বিশাল ঝড় দেখা যায় যাকে গ্রেট ডার্ক স্পট বলা হয়।"),
                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // 🚀 কুইজ বাটন
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xff00d2ff), Color(0xff3a7bd5)],
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const NeptuneQuizPage()),
                      );
                    },
                    child: const Text("🚀 কুইজ শুরু করো",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
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
        color: const Color.fromARGB(255, 101, 95, 95).withOpacity(0.2), // কার্ড অনেক বেশি উজ্জ্বল করা হয়েছে
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color.fromARGB(77, 10, 10, 10)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 15, 15, 15))),
          const SizedBox(height: 6),
          Text(content,
              style: const TextStyle(
                  color: Color.fromARGB(255, 11, 11, 11), 
                  fontSize: 16, 
                  fontWeight: FontWeight.w500,
                  height: 1.4)),
        ],
      ),
    );
  }
}

// ---------------- QUIZ PAGE ----------------
class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  Question(this.question, this.options, this.correctIndex);
}

class NeptuneQuizPage extends StatefulWidget {
  const NeptuneQuizPage({super.key});

  @override
  State<NeptuneQuizPage> createState() => _NeptuneQuizPageState();
}

class _NeptuneQuizPageState extends State<NeptuneQuizPage> {
  int current = 0;
  int score = 0;

  final List<Question> questions = [
    Question("সৌরজগতের অষ্টম গ্রহ কোনটি?", ["ইউরেনাস", "নেপচুন", "শনি", "মঙ্গল"], 1),
    Question("নেপচুন গ্রহের রঙ গাঢ় নীল কেন?", ["পানির জন্য", "মিথেন গ্যাসের জন্য", "আগুনের জন্য", "বরফের জন্য"], 1),
    Question("নেপচুনের সবচেয়ে বড় চাঁদের নাম কী?", ["টাইটান", "ইউরোপা", "ট্রাইটন", "আইও"], 2),
    Question("নেপচুনের বাতাসে কীসের পরিমাণ বেশি?", ["অক্সিজেন", "হাইড্রোজেন ও হিলিয়াম", "কার্বন", "নাইট্রোজেন"], 1),
    Question("নেপচুনে যে বিশাল ঝড় দেখা যায় তাকে কী বলে?", ["রেড স্পট", "গ্রেট ডার্ক স্পট", "ব্লু আই", "হোয়াইট ক্লাউড"], 1),
    Question("নেপচুন সূর্য থেকে কত দূরে অবস্থিত?", ["সবচেয়ে কাছে", "৩য় স্থানে", "৫ম স্থানে", "সবচেয়ে দূরে"], 3),
    Question("নেপচুনের মোট কয়টি চাঁদ আছে?", ["৫টি", "১০টি", "১৪টি", "২০টি"], 2),
    Question("নেপচুন কী ধরনের গ্রহ?", ["পাথুরে গ্রহ", "আইস জায়ান্ট", "জ্বলন্ত গ্রহ", "ছোট গ্রহ"], 1),
    Question("নেপচুনের তাপমাত্রা কেমন?", ["অত্যন্ত গরম", "মাঝারি", "অত্যন্ত ঠান্ডা", "খুব আরামদায়ক"], 2),
    Question("নেপচুন সূর্যকে একবার প্রদক্ষিণ করতে কত সময় নেয়?", ["১৬৫ বছর", "৫০ বছর", "১০ বছর", "১ বছর"], 0),
  ];

  void answer(int i) {
    if (questions[current].correctIndex == i) score++;
    if (current < questions.length - 1) {
      setState(() => current++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultPage(score: score, total: questions.length)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[current];
    return Scaffold(
      backgroundColor: const Color(0xFF000B18),
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/10"), 
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(value: (current + 1) / 10, color: Colors.cyanAccent, backgroundColor: Colors.white10),
            const SizedBox(height: 40),
            Text(q.question, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), 
                        side: const BorderSide(color: Colors.white24))),
                    child: Text(q.options[i], style: const TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- RESULT PAGE ----------------
class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  const ResultPage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000B18),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.stars, color: Colors.cyanAccent, size: 80),
            const SizedBox(height: 20),
            const Text("কুইজ সম্পন্ন হয়েছে!", style: TextStyle(color: Colors.cyanAccent, fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("আপনার স্কোর: $score / $total", style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            SizedBox(
              height: 250,
              child: PieChart(PieChartData(sections: [
                PieChartSectionData(value: score.toDouble(), color: Colors.greenAccent, title: 'সঠিক', radius: 65, 
                titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                PieChartSectionData(value: (total - score).toDouble(), color: Colors.redAccent, title: 'ভুল', radius: 65,
                 titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ])),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent, 
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
              ),
              child: const Text("ফিরে যাও", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}