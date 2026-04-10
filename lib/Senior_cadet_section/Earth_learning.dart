import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';

class EarthLearningPage extends StatefulWidget {
  const EarthLearningPage({super.key});

  @override
  State<EarthLearningPage> createState() => _EarthLearningPageState();
}

class _EarthLearningPageState extends State<EarthLearningPage> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Assets থেকে ভিডিও লোড করা (ভিডিও পাথটি নিশ্চিত করুন)
    _videoController = VideoPlayerController.asset('assets/videos/Earth_video.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoController.setLooping(true);
        // অটোপ্লে বন্ধ রাখা হয়েছে সমস্যা সমাধানের জন্য
      }).catchError((error) {
        debugPrint("Video Error: $error");
      });
  }

  @override
  void dispose() {
    _videoController.dispose(); // পেজ বন্ধ হলে ভিডিও মেমোরি মুক্ত করা
    super.dispose();
  }

  // ভিডিও প্লে/পজ করার ফাংশন
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
      backgroundColor: Colors.transparent, // ব্যাকগ্রাউন্ড ইমেজ দেখানোর জন্য
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🧱 BACKGROUND IMAGE (নিশ্চিত করুন এই ইমেজটি অ্যাসেটসে আছে)
          Image.asset(
            'assets/images/Senior_background.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.broken_image, color: Colors.white10)),
          ),
          
          // 📜 CONTENT Overlay
          Column(
            children: [
              // 🔙 Back Button + Title
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5, bottom: 5),
                color: Colors.white.withOpacity(0.05), 
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back, color: Colors.blueAccent),
                    ),
                     SizedBox(
                        height: 40,
                      ),
                
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // 🎬 VIDEO PLAYER (ক্লিক করলে প্লে/পজ হবে)
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
                            // পজ থাকলে প্লে আইকন দেখাবে
                            if (!_videoController.value.isPlaying)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  size: 80,
                                  color: Colors.white,
                                ),
                              ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator(color: Colors.blueAccent)),
                ),
              ),

              const SizedBox(height: 10),

              // 📜 LEARNING CONTENT (আলাদা আলাদা সেকশন)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        // সেকশন ১: আমাদের বাসস্থান
                        _learningCard(
                          title: "🏠 পৃথিবী আমাদের ঘর",
                          content: "পৃথিবী হলো সেই গ্রহ যেখানে আমরা বাস করি। মহাবিশ্বের অগণিত গ্রহের মধ্যে এটিই একমাত্র গ্রহ যেখানে এখন পর্যন্ত জীবনের অস্তিত্ব পাওয়া গেছে। এটি আমাদের ধারন করে আছে।",
                        ),
                        
                        // সেকশন ২: কেন পৃথিবী বিশেষ?
                        _learningCard(
                          title: "✨ কেন এটি বিশেষ?",
                          content: "জীবন ধারণের জন্য যা যা প্রয়োজন, তার সবই পৃথিবীতে আছে। এখানে আমাদের শ্বাস নেওয়ার জন্য আছে বাতাস (অক্সিজেন), পান করার জন্য সুপেয় পানি এবং বসবাস ও খাদ্য উৎপাদনের জন্য আছে সমতল ভূমি বা স্থলভাগ।",
                        ),

                        // সেকশন ৩: সঠিক দূরত্ব ও তাপমাত্রা
                        _learningCard(
                          title: "🌡️ সঠিক দূরত্ব ও তাপমাত্রা",
                          content: "সূর্য থেকে পৃথিবীর দূরত্ব একদম আদর্শ বা সঠিক অবস্থানে। এই নিখুঁত দূরত্বের কারণেই পৃথিবীর তাপমাত্রা খুব বেশি গরম বা খুব বেশি ঠান্ডা হয় না। এই সহনীয় তাপমাত্রা জীবজগতের টিকে থাকার জন্য অপরিহার্য।",
                        ),

                        // সেকশন ৪: নীল গ্রহ
                        _learningCard(
                          title: "🔵 নীল গ্রহ (The Blue Planet)",
                          content: "মহাকাশ থেকে পৃথিবীকে নীল দেখায়, তাই একে 'নীল গ্রহ' বলা হয়। এর কারণ হলো পৃথিবীর উপরিভাগের প্রায় ৭০ শতাংশই পানি। পানি জীবনের জন্য অপরিহার্য, আর এই বিপুল জলরাশির কারণেই পৃথিবী বসবাসের এত চমৎকার জায়গা।",
                        ),

                        // সেকশন ৫: পৃথিবীর চাঁদ
                        _learningCard(
                          title: "🌙 পৃথিবীর একমাত্র চাঁদ",
                          content: "পৃথিবীর একটি মাত্র প্রাকৃতিক উপগ্রহ বা চাঁদ আছে, যা পৃথিবী থেকে প্রায় ৩,৮৪,৪০০ কিলোমিটার (২,৩৯,০০০ মাইল) দূরে অবস্থিত।",
                        ),

                        // সেকশন ৬: চাঁদের গুরুত্ব
                        _learningCard(
                          title: "🌊 চাঁদের গুরুত্ব",
                          content: "চাঁদ শুধু রাতের আকাশকে আলোকিতই করে না, এটি আমাদের সমুদ্রের জোয়ার-ভাটাকেও ব্যাপকভাবে প্রভাবিত করে। চাঁদের মহাকর্ষ বলের কারণেই সমুদ্রে নিয়মিত জোয়ার-ভাটা হয়।",
                        ),

                        // সেকশন ৭: বায়ুমণ্ডল বা অ্যাটমোস্ফিয়ার
                        _learningCard(
                          title: "🌬️ বায়ুমণ্ডল (Atmosphere)",
                          content: "পৃথিবীর চারপাশে গ্যাসের একটি পাতলা স্তর রয়েছে, যাকে বায়ুমণ্ডল বলা হয়। এটি পৃথিবীর জন্য একটি সুরক্ষা কবচ।",
                        ),

                        // সেকশন ৮: বায়ুমণ্ডলের কাজ
                        _learningCard(
                          title: "🛡️ বায়ুমণ্ডলের কাজ",
                          content: "এই বায়ুমণ্ডল সূর্যের ক্ষতিকর অতিবেগুনি রশ্মি থেকে আমাদের রক্ষা করে। এছাড়া, এটি গ্রিনহাউজ ইফেক্টের মাধ্যমে গ্রহের তাপ ধরে রেখে পৃথিবীকে জীবজগতের বসবাসের জন্য উষ্ণ রাখে।",
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              // 🚀 START QUIZ BUTTON (নিচে ফিক্সড)
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: ElevatedButton(
                  onPressed: () {
                    // কুইজে যাওয়ার আগে ভিডিও পজ করা (সমস্যা সমাধানের জন্য)
                    if (_isVideoInitialized && _videoController.value.isPlaying) {
                      _videoController.pause();
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EarthQuizPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
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
              )
            ],
          ),
        ],
      ),
    );
  }

  // 📦 সেকশন ভিত্তিক লার্নিং কার্ড উইজেট
  Widget _learningCard({required String title, required String content}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.blue.shade50.withOpacity(0.06), 
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.shade100.withOpacity(0.15), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromARGB(232, 13, 13, 13), // ব্যাকগ্রাউন্ড অনুযায়ী কালার অ্যাডজাস্ট করা হয়েছে
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------- QUIZ PAGE (নতুন তথ্য অনুযায়ী প্রশ্ন) ----------------

class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question(this.question, this.options, this.correctIndex);
}

class EarthQuizPage extends StatefulWidget {
  const EarthQuizPage({super.key});

  @override
  State<EarthQuizPage> createState() => _EarthQuizPageState();
}

class _EarthQuizPageState extends State<EarthQuizPage> {
  int current = 0;
  int score = 0;
  late List<Question> quizQuestions;

  // আপনার দেওয়া নতুন তথ্যের ওপর ভিত্তি করে কুইজ প্রশ্ন
  List<Question> allQuestions = [
    Question("এখন পর্যন্ত জানা তথ্যমতে, কোন গ্রহে জীবনের অস্তিত্ব আছে?", ["মঙ্গল", "বুধ", "পৃথিবী", "শুক্র"], 2),
    Question("জীবন ধারণের জন্য পৃথিবী বিশেষ কেন?", ["বাতাস, পানি ও জমি আছে", "এটি খুব বড়", "এটি লাল রঙের", "এর অনেক চাঁদ আছে"], 0),
    Question("সূর্য থেকে সঠিক দূরত্বের কারণে পৃথিবীর কী সুবিধা হয়?", ["পানি শুকিয়ে যায়", "তাপমাত্রা বসবাসের উপযোগী থাকে", "সবসময় রাত থাকে", "অনেক বাতাস হয়"], 1),
    Question("পৃথিবীকে 'নীল গ্রহ' বলা হয় কেন?", ["এটি নীল রঙের গ্যাসে ঢাকা", "এর উপরিভাগে প্রচুর পানি আছে", "এটি বরফে ঢাকা", "এটি সূর্যের খুব কাছে"], 1),
    Question("পৃথিবীর উপরিভাগের প্রায় কত অংশ পানি?", ["৫০%", "৬০%", "৭০%", "৮০%"], 2),
    Question("পৃথিবীর চাঁদ কত দূরে অবস্থিত?", ["১,০০,০০০ কিমি", "৩,৮৪,৪০০ কিমি", "৫,০০,০০০ কিমি", "১০,০০,০০০ কিমি"], 1),
    Question("চাঁদ আমাদের সমুদ্রের কোন বিষয়টিকে প্রভাবিত করে?", ["পানির রঙ", "জোয়ার-ভাটা", "মাছের সংখ্যা", "পানির তাপমাত্রা"], 1),
    Question("পৃথিবীর চারপাশের গ্যাসের স্তরকে কী বলা হয়?", ["ভূত্বক", "গুরুমণ্ডল", "কেন্দ্রমণ্ডল", "বায়ুমণ্ডল"], 3),
    Question("বায়ুমণ্ডল আমাদের কী থেকে রক্ষা করে?", ["বৃষ্টি", "সূর্যের ক্ষতিকর রশ্মি", "বাতাস", "চাঁদের আলো"], 1),
    Question("গ্রহকে উষ্ণ রাখতে এবং ক্ষতিকর রশ্মি আটকাতে কোনটি কাজ করে?", ["পানি", "জমি", "বায়ুমণ্ডল", "চাঁদ"], 2),
  ];

  @override
  void initState() {
    super.initState();
    allQuestions.shuffle(); // প্রশ্ন এলোমেলো করা
    quizQuestions = allQuestions.take(10).toList(); // ১০টি প্রশ্ন নেওয়া
  }

  void answer(int index) {
    if (quizQuestions[current].correctIndex == index) {
      score++;
    }

    if (current < quizQuestions.length - 1) {
      setState(() {
        current++;
      });
    } else {
      // কুইজ শেষ হলে ফলাফল পেজে যাওয়া
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ResultPage(score: score)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = quizQuestions[current];

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A05), // স্পেস থিম ব্যাকগ্রাউন্ড
      appBar: AppBar(
        title: Text("প্রশ্ন ${current + 1}/10"),
        backgroundColor: Colors.deepOrange[900],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // প্রগ্রেস বার
            LinearProgressIndicator(
              value: (current + 1) / 10,
              backgroundColor: Colors.white12,
              color: Colors.deepOrangeAccent,
            ),
            const SizedBox(height: 30),
            // প্রশ্ন
            Text(
              q.question,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
            ),
            const SizedBox(height: 30),
            // অপশন বাটন
            ...List.generate(q.options.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () => answer(i),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade900,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: Text(
                    q.options[i],
                    style: const TextStyle(fontSize: 18, color: Colors.deepOrangeAccent),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

// ---------------- RESULT PAGE (আগের মতোই) ----------------

class ResultPage extends StatelessWidget {
  final int score;
  const ResultPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    int wrong = 10 - score;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A05),
      appBar: AppBar(title: const Text("তোমার ফলাফল"), centerTitle: true, backgroundColor: Colors.deepOrange[900], foregroundColor: Colors.white),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              score >= 7 ? "🎉 চমৎকার!" : "👍 ভালো চেষ্টা!",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
            ),
            const SizedBox(height: 30),
            // পাই চার্ট
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: score.toDouble(),
                      title: "$score সঠিক",
                      color: Colors.green,
                      radius: 60,
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: wrong.toDouble(),
                      title: "$wrong ভুল",
                      color: Colors.redAccent,
                      radius: 50,
                      titleStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "মোট স্কোর: $score / 10",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orangeAccent),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // ড্যাশবোর্ডে ফিরে যাওয়া
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange[900],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("ড্যাশবোর্ডে ফিরে যাও", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}