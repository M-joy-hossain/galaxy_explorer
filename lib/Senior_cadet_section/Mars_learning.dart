import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Earth_learning.dart';
import 'package:video_player/video_player.dart';

class MarsLearningPage extends StatefulWidget {
  const MarsLearningPage({super.key});

  @override
  State<MarsLearningPage> createState() => _MarsLearningPageState();
}

class _MarsLearningPageState extends State<MarsLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Assets থেকে মঙ্গলের ভিডিও লোড করা (নিশ্চিত করুন ভিডিওটি আছে)rf
    _videoController =
        VideoPlayerController.asset('assets/videos/Mars_video.mp4')
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
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        "🔴 মঙ্গল (Mars)",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent,
                          letterSpacing: 1.2,
                        ),
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
                            color: Colors.deepOrangeAccent,
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
                          title: "🔴 লাল গ্রহের রহস্য",
                          content:
                              "মঙ্গলকে 'লাল গ্রহ' বলা হয় কারণ এর পৃষ্ঠ আয়রন অক্সাইড বা মরিচায় ঢাকা। এটি সৌরজগতের চতুর্থ গ্রহ।",
                        ),
                        _learningCard(
                          title: "🏔️ বিশাল পর্বত ও আগ্নেয়গিরি",
                          content:
                              "মঙ্গলে রয়েছে সৌরজগতের বৃহত্তম আগ্নেয়গিরি 'অলিম্পাস মন্স', যা মাউন্ট এভারেস্টের চেয়ে প্রায় তিন গুণ বড়!",
                        ),
                        _learningCard(
                          title: "❄️ মঙ্গলে পানি ও বরফ",
                          content:
                              "মঙ্গলের মেরু অঞ্চলে বরফের অস্তিত্ব পাওয়া গেছে। বিজ্ঞানীরা মনে করেন প্রাচীনকালে মঙ্গলে নদী ও সমুদ্র ছিল।",
                        ),
                        _learningCard(
                          title: "🌑 মঙ্গলের দুটি চাঁদ",
                          content:
                              "পৃথিবীর একটি চাঁদ থাকলেও মঙ্গলের ছোট ছোট দুটি চাঁদ আছে। এদের নাম হলো 'ফোবোস' (Phobos) ও 'ডেইমোস' (Deimos)।",
                        ),
                        _learningCard(
                          title: "🌬️ পাতলা বায়ুমণ্ডল",
                          content:
                              "মঙ্গলের বায়ুমণ্ডল অত্যন্ত পাতলা এবং এতে মূলত কার্বন ডাই-অক্সাইড রয়েছে। এখানে প্রায়ই বিশাল ধূলিঝড় সৃষ্টি হয়।",
                        ),
                        _learningCard(
                          title: "🚀 ভবিষ্যতের মানুষের ঘর",
                          content:
                              "বিজ্ঞানীরা মঙ্গলে মানুষের বসবাসের সম্ভাবনা নিয়ে গবেষণা করছেন। মঙ্গলের একদিন পৃথিবীর দিনের চেয়ে মাত্র ৪০ মিনিট বড়।",
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
                      MaterialPageRoute(builder: (_) => const MarsQuizPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 191, 54, 12),
                    // foregroundDecoration: null,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 60),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "🚀 কুইজ শুরু করো",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        color: Colors.deepOrange.shade50.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.deepOrangeAccent.withOpacity(0.2),
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
              color: Colors.deepOrangeAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- QUIZ PAGE ----------------

class MarsQuizPage extends StatefulWidget {
  const MarsQuizPage({super.key});

  @override
  State<MarsQuizPage> createState() => _MarsQuizPageState();
}

class _MarsQuizPageState extends State<MarsQuizPage> {
  int current = 0;
  int score = 0;
  late List<Question> quizQuestions;

  List<Question> allQuestions = [
    Question("মঙ্গল গ্রহকে কী বলা হয়?", [
      "নীল গ্রহ",
      "লাল গ্রহ",
      "সবুজ গ্রহ",
      "হলুদ গ্রহ",
    ], 1),
    Question("মঙ্গলের কয়টি প্রাকৃতিক উপগ্রহ বা চাঁদ আছে?", [
      "১টি",
      "২টি",
      "৩টি",
      "৪টি",
    ], 1),
    Question("সৌরজগতের বৃহত্তম আগ্নেয়গিরি কোনটি?", [
      "মাউন্ট এভারেস্ট",
      "অলিম্পাস মন্স",
      "মনা কেয়া",
      "ফুজি",
    ], 1),
    Question("মঙ্গলের বায়ুমণ্ডলে কোন গ্যাস সবচেয়ে বেশি?", [
      "অক্সিজেন",
      "নাইট্রোজেন",
      "কার্বন ডাই-অক্সাইড",
      "হিলিয়াম",
    ], 2),
    Question("মঙ্গলের মেরু অঞ্চলে কিসের অস্তিত্ব পাওয়া গেছে?", [
      "আগুন",
      "হীরা",
      "বরফ ও পানি",
      "সোনা",
    ], 2),
    Question("মঙ্গলের একদিন পৃথিবীর দিনের চেয়ে কত সময় বড়?", [
      "১০ মিনিট",
      "৪০ মিনিট",
      "২ ঘণ্টা",
      "৫ ঘণ্টা",
    ], 1),
    Question("মঙ্গল সূর্য থেকে দূরত্বের দিক দিয়ে কততম গ্রহ?", [
      "দ্বিতীয়",
      "তৃতীয়",
      "চতুর্থ",
      "পঞ্চম",
    ], 2),
    Question("মঙ্গলের লাল রঙের মূল কারণ কী?", [
      "আগ্নেয়গিরি",
      "আয়রন অক্সাইড বা মরিচা",
      "সূর্যের আলো",
      "গ্যাস",
    ], 1),
    Question("মঙ্গলের চাঁদ দুটির নাম কী?", [
      "টাইটান ও লুনা",
      "ফোবোস ও ডেইমোস",
      "আইও ও ক্যালিস্টো",
      "ইউরোপা",
    ], 1),
    Question("মঙ্গলের আকাশ সাধারণত কোন রঙের দেখায়?", [
      "গাঢ় নীল",
      "গোলাপী বা লালচে",
      "কালো",
      "সবুজ",
    ], 1),
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
      // আপনার প্রোজেক্টের ResultPage এ ন্যাভিগেট করুন
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            score: score,
            total: quizQuestions.length,
            moduleId: 'mars',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = quizQuestions[current];
    return Scaffold(
      backgroundColor: const Color(0xFF120500),
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/10"),
        backgroundColor: Colors.deepOrange[800],
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
              color: Colors.deepOrangeAccent,
            ),
            const SizedBox(height: 30),
            Text(
              q.question,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
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
                      color: Colors.deepOrangeAccent,
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

// ডেটা মডেল
class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  Question(this.question, this.options, this.correctIndex);
}
