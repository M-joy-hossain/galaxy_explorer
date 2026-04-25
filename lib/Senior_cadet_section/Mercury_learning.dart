import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Earth_learning.dart';
import 'package:video_player/video_player.dart';

class MercuryLearningPage extends StatefulWidget {
  const MercuryLearningPage({super.key});

  @override
  State<MercuryLearningPage> createState() => _MercuryLearningPageState();
}

class _MercuryLearningPageState extends State<MercuryLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Assets থেকে বুধের ভিডিও লোড করা (নিশ্চিত করুন ভিডিওটি আছে)
    _videoController =
        VideoPlayerController.asset('assets/videos/Mercury_video.mp4')
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
      if (_videoController.value.isPlaying) {
        _videoController.pause();
      } else {
        _videoController.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🧱 BACKGROUND IMAGE
          Image.asset(
            'assets/images/Senior_background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white10),
            ),
          ),

          Column(
            children: [
              // 🔙 Back Button + Title
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 5,
                  bottom: 5,
                ),
                color: Colors.white.withOpacity(0.05),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.orangeAccent,
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // 🎬 VIDEO PLAYER
              GestureDetector(
                onTap: _isVideoInitialized ? _togglePlay : null,
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.black.withOpacity(0.3),
                  child: _isVideoInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoController.value.size.width,
                                height: _videoController.value.size.height,
                                child: VideoPlayer(_videoController),
                              ),
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
                            color: Colors.orangeAccent,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 10),

              // 📜 LEARNING CONTENT
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        _learningCard(
                          title: "☀️ সূর্যের সবচেয়ে কাছের গ্রহ",
                          content:
                              "বুধ সৌরজগতের প্রথম এবং সূর্যের সবচেয়ে কাছের গ্রহ। সূর্যের খুব কাছে হওয়ায় এটি দিনের বেলা অত্যন্ত গরম থাকে।",
                        ),
                        _learningCard(
                          title: "📏 ক্ষুদ্রতম গ্রহ",
                          content:
                              "বুধ সৌরজগতের সবচেয়ে ছোট গ্রহ। এটি আকারে আমাদের চাঁদের চেয়ে সামান্য বড়। এর কোনো উপগ্রহ বা চাঁদ নেই।",
                        ),
                        _learningCard(
                          title: "🌑 রুক্ষ পৃষ্ঠ ও গর্ত",
                          content:
                              "বুধের পৃষ্ঠ দেখতে অনেকটা আমাদের চাঁদের মতো। এর উপরিভাগ অসংখ্য গর্তে (Craters) ভরা, যা মহাকাশের উল্কাপাতের ফলে তৈরি হয়েছে।",
                        ),
                        _learningCard(
                          title: "💨 পাতলা বায়ুমণ্ডল",
                          content:
                              "বুধের কোনো শক্তিশালী বায়ুমণ্ডল নেই, শুধু একটি পাতলা স্তর (Exosphere) আছে। এর ফলে এটি মহাকাশের ক্ষতিকর রশ্মি আটকাতে পারে না।",
                        ),
                        _learningCard(
                          title: "🌡️ চরম তাপমাত্রা",
                          content:
                              "দিনের বেলা বুধের তাপমাত্রা ৪৩০° সেলসিয়াস পর্যন্ত পৌঁছায়, কিন্তু রাতে কোনো বায়ুমণ্ডল না থাকায় তাপমাত্রা কমে -১৮০° সেলসিয়াস হয়ে যায়!",
                        ),
                        _learningCard(
                          title: "🏃 দ্রুততম পরিক্রমণ",
                          content:
                              "বুধ অত্যন্ত দ্রুত সূর্যকে প্রদক্ষিণ করে। সূর্যের চারদিকে একবার ঘুরে আসতে এর মাত্র ৮৮ দিন সময় লাগে, যা সৌরজগতের সব গ্রহের মধ্যে দ্রুততম।",
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // 🚀 START QUIZ BUTTON
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_isVideoInitialized &&
                        _videoController.value.isPlaying) {
                      _videoController.pause();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MercuryQuizPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 56, 209),
                    foregroundColor: Colors.black87,
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "🚀 কুইজ শুরু করো",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 252, 250, 250),
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

  Widget _learningCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.orange.shade50.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 78, 37, 226).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 71, 105, 231),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 10, 10, 10),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- QUIZ PAGE ----------------

class MercuryQuizPage extends StatefulWidget {
  const MercuryQuizPage({super.key});

  @override
  State<MercuryQuizPage> createState() => _MercuryQuizPageState();
}

class _MercuryQuizPageState extends State<MercuryQuizPage> {
  int current = 0;
  int score = 0;
  late List<Question> quizQuestions;

  List<Question> allQuestions = [
    Question("সৌরজগতের ক্ষুদ্রতম গ্রহ কোনটি?", [
      "শুক্র",
      "মঙ্গল",
      "বুধ",
      "নেপচুন",
    ], 2),
    Question("বুধের কয়টি প্রাকৃতিক উপগ্রহ বা চাঁদ আছে?", [
      "১টি",
      "২টি",
      "৩টি",
      "একটিও নেই",
    ], 3),
    Question("সূর্যকে একবার প্রদক্ষিণ করতে বুধের কত দিন সময় লাগে?", [
      "৮৮ দিন",
      "৩৬৫ দিন",
      "২০০ দিন",
      "৫০ দিন",
    ], 0),
    Question("বুধের পৃষ্ঠ দেখতে অনেকটা কার মতো?", [
      "পৃথিবী",
      "চাঁদ",
      "সূর্য",
      "শনির রিং",
    ], 1),
    Question("দিনের বেলা বুধের তাপমাত্রা কত পর্যন্ত পৌঁছাতে পারে?", [
      "১০০°C",
      "৪৩০°C",
      "৮০০°C",
      "০°C",
    ], 1),
    Question("বুধ সূর্য থেকে দূরত্বের দিক দিয়ে কততম গ্রহ?", [
      "প্রথম",
      "দ্বিতীয়",
      "তৃতীয়",
      "চতুর্থ",
    ], 0),
    Question("রাতে বুধের তাপমাত্রা কেন অত্যন্ত কমে যায়?", [
      "সূর্য দূরে বলে",
      "বায়ুমণ্ডল নেই বলে",
      "বরফ আছে বলে",
      "এটি খুব ছোট বলে",
    ], 1),
    Question("বুধের উপরিভাগের গর্তগুলোকে কী বলা হয়?", [
      "আগ্নেয়গিরি",
      "গহ্বর (Craters)",
      "পাহাড়",
      "সমুদ্র",
    ], 1),
    Question("বুধের বায়ুমণ্ডলকে কী বলা হয়?", [
      "অক্সিজেন স্তর",
      "এক্সোস্ফিয়ার",
      "ওজোন স্তর",
      "নাইট্রোজেন স্তর",
    ], 1),
    Question("সৌরজগতের দ্রুততম পরিক্রমণকারী গ্রহ কোনটি?", [
      "বৃহস্পতি",
      "পৃথিবী",
      "বুধ",
      "ইউরেনাস",
    ], 2),
  ];

  @override
  void initState() {
    super.initState();
    allQuestions.shuffle();
    quizQuestions = allQuestions.take(10).toList();
  }

  void answer(int index) {
    if (quizQuestions[current].correctIndex == index) score++;
    if (current < quizQuestions.length - 1) {
      setState(() => current++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            score: score,
            total: quizQuestions.length,
            moduleId: 'mercury',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = quizQuestions[current];
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/10"),
        backgroundColor: Colors.orange[800],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (current + 1) / 10,
              backgroundColor: Colors.white12,
              color: Colors.orangeAccent,
            ),
            const SizedBox(height: 30),
            Text(
              q.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(q.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () => answer(i),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade900,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    q.options[i],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ---------------- ফলাফল এবং কুইজ ডেটা মডেল ----------------
class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  Question(this.question, this.options, this.correctIndex);
}
