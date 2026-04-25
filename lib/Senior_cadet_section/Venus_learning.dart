import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Earth_learning.dart';
import 'package:video_player/video_player.dart';

class VenusLearningPage extends StatefulWidget {
  const VenusLearningPage({super.key});

  @override
  State<VenusLearningPage> createState() => _VenusLearningPageState();
}

class _VenusLearningPageState extends State<VenusLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Assets থেকে শুক্রের ভিডিও লোড করা (ভিডিও পাথ নিশ্চিত করুন)
    _videoController =
        VideoPlayerController.asset('assets/videos/Venus_video.mp4')
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
                color: const Color.fromARGB(255, 11, 11, 11).withOpacity(0.05),
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
                          title: "🌡️ সৌরজগতের উষ্ণতম গ্রহ",
                          content:
                              "সূর্যের নিকটতম গ্রহ না হওয়া সত্ত্বেও শুক্র সৌরজগতের সবচেয়ে গরম গ্রহ। এর গড় তাপমাত্রা প্রায় ৪৬৪° সেলসিয়াস, যা সীসা গলানোর জন্য যথেষ্ট!",
                        ),
                        _learningCard(
                          title: "☁️ বিষাক্ত বায়ুমণ্ডল",
                          content:
                              "শুক্রের বায়ুমণ্ডল অত্যন্ত ঘন এবং এটি মূলত কার্বন ডাই-অক্সাইডে পূর্ণ। এখানে সালফিউরিক অ্যাসিডের ঘন মেঘ রয়েছে যা গ্রহটিকে সবসময় ঢেকে রাখে।",
                        ),
                        _learningCard(
                          title: "🌍 পৃথিবীর যমজ গ্রহ",
                          content:
                              "শুক্রকে প্রায়ই পৃথিবীর 'যমজ' বলা হয় কারণ এর আকার, ভর এবং ঘনত্ব অনেকটা আমাদের পৃথিবীর মতো। তবে এর পরিবেশ পৃথিবীর সম্পূর্ণ বিপরীত।",
                        ),
                        _learningCard(
                          title: "🔄 উল্টো ঘূর্ণন",
                          content:
                              "বেশিরভাগ গ্রহ ঘড়ির কাঁটার বিপরীতে ঘুরলেও শুক্র ঘড়ির কাঁটার দিকে ঘোরে। এর মানে শুক্র গ্রহে সূর্য পশ্চিমে ওঠে এবং পূর্বে অস্ত যায়!",
                        ),
                        _learningCard(
                          title: "⏳ বড় দিন, ছোট বছর",
                          content:
                              "শুক্র নিজের অক্ষে অত্যন্ত ধীরগতিতে ঘোরে। এর এক দিন পৃথিবীর ২৪৩ দিনের সমান, যা এর এক বছরের (২২৫ দিন) চেয়েও বড়!",
                        ),
                        _learningCard(
                          title: "✨ ভোরের তারা ও সন্ধ্যার তারা",
                          content:
                              "পৃথিবী থেকে শুক্রকে খুব উজ্জ্বল দেখায়। সূর্যোদয়ের আগে একে 'ভোরের তারা' এবং সূর্যাস্তের পর 'সন্ধ্যার তারা' হিসেবে দেখা যায়।",
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
                      MaterialPageRoute(builder: (_) => const VenusQuizPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 55, 44, 223),
                    foregroundColor: Colors.white,
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
                      color: Colors.white,
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
          color: Colors.orangeAccent.withOpacity(0.2),
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
              color: Color.fromARGB(255, 47, 64, 222),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 13, 13, 13),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- QUIZ PAGE ----------------

class VenusQuizPage extends StatefulWidget {
  const VenusQuizPage({super.key});

  @override
  State<VenusQuizPage> createState() => _VenusQuizPageState();
}

class _VenusQuizPageState extends State<VenusQuizPage> {
  int current = 0;
  int score = 0;
  late List<Question> quizQuestions;

  List<Question> allQuestions = [
    Question("সৌরজগতের উষ্ণতম গ্রহ কোনটি?", [
      "বুধ",
      "মঙ্গল",
      "শুক্র",
      "বৃহস্পতি",
    ], 2),
    Question("শুক্রের বায়ুমণ্ডল মূলত কোন গ্যাসে পূর্ণ?", [
      "অক্সিজেন",
      "নাইট্রোজেন",
      "কার্বন ডাই-অক্সাইড",
      "মিথেন",
    ], 2),
    Question("কোন গ্রহকে পৃথিবীর 'যমজ' বলা হয়?", [
      "মঙ্গল",
      "শুক্র",
      "ইউরেনাস",
      "নেপচুন",
    ], 1),
    Question("শুক্র গ্রহে সূর্য কোন দিকে উদিত হয়?", [
      "পূর্ব",
      "পশ্চিম",
      "উত্তর",
      "দক্ষিণ",
    ], 1),
    Question("শুক্রের এক দিন পৃথিবীর কত দিনের সমান?", [
      "২৪৩ দিন",
      "৩৬৫ দিন",
      "১০০ দিন",
      "১০ দিন",
    ], 0),
    Question("শুক্রের আকাশে কিসের ঘন মেঘ রয়েছে?", [
      "পানির কণা",
      "সালফিউরিক অ্যাসিড",
      "ধুলাবালি",
      "বরফ",
    ], 1),
    Question("শুক্রকে ভোরের আকাশে দেখলে কী বলা হয়?", [
      "লাল তারা",
      "ভোরের তারা",
      "ধুমকেতু",
      "উল্কা",
    ], 1),
    Question("শুক্র সূর্য থেকে দূরত্বের দিক দিয়ে কততম গ্রহ?", [
      "প্রথম",
      "দ্বিতীয়",
      "তৃতীয়",
      "চতুর্থ",
    ], 1),
    Question("শুক্রের কয়টি চাঁদ বা প্রাকৃতিক উপগ্রহ আছে?", [
      "১টি",
      "২টি",
      "৫টি",
      "একটিও নেই",
    ], 3),
    Question("কেন শুক্র বুধের চেয়েও বেশি গরম?", [
      "সূর্যের কাছে বলে",
      "ঘন বায়ুমণ্ডলে গ্রিনহাউস প্রভাবের জন্য",
      "অনেক আগ্নেয়গিরি আছে বলে",
      "এর আকার বড় বলে",
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
      // ResultPage আপনার প্রোজেক্টে আগে থেকেই তৈরি করা আছে বলে ধরে নিচ্ছি
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            score: score,
            total: quizQuestions.length,
            moduleId: 'venus',
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
        backgroundColor: Colors.orange[900],
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
