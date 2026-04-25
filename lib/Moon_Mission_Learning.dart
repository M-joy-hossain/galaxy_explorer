import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MoonMissionLearning extends StatefulWidget {
  const MoonMissionLearning({super.key});

  @override
  _MoonMissionLearningState createState() => _MoonMissionLearningState();
}

class _MoonMissionLearningState extends State<MoonMissionLearning> with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  late AnimationController _floatingController;

  // মুন মিশনের ধাপগুলো
  final List<Map<String, dynamic>> missionSteps = [
    {
      "name": "The Rocket",
      "bn": "বিশাল রকেট",
      "emoji": "🚀",
      "color": Colors.orangeAccent,
      "fact": "চাঁদে যাওয়ার জন্য আমাদের চাই একটি বিশাল রকেট!",
      "extra": "অ্যাপোলো ১১ মিশনের জন্য ব্যবহার করা হয়েছিল শনি-৫ (Saturn V) রকেট। এটি একটি ৩২ তলা বাড়ির সমান লম্বা ছিল!"
    },
    {
      "name": "Blast Off",
      "bn": "মহাকাশে যাত্রা",
      "emoji": "🔥",
      "color": Colors.redAccent,
      "fact": "রকেট যখন ওড়ে, তখন নিচ দিয়ে প্রচুর আগুন বের হয়।",
      "extra": "রকেটটি খুব দ্রুত গতিতে বাতাসের বাধা পেরিয়ে মহাকাশে চলে যায়। একে বলা হয় 'লিফট অফ'।"
    },
    {
      "name": "Floating in Space",
      "bn": "মহাকাশে ভাসা",
      "emoji": "👨‍🚀",
      "color": Colors.blueAccent,
      "fact": "মহাকাশে কোনো বাতাস নেই এবং সব কিছু ভেসে থাকে!",
      "extra": "মহাকাশচারীরা সেখানে ওজনহীন হয়ে পড়েন। তারা চাইলেই পাখির মতো ঘরের মধ্যে ভেসে বেড়াতে পারেন।"
    },
    {
      "name": "Moon Landing",
      "bn": "চাঁদে নামা",
      "emoji": "🌑",
      "color": Colors.grey,
      "fact": "রকেট থেকে একটি ছোট অংশ আলাদা হয়ে চাঁদে নামে।",
      "extra": "নিল আর্মস্ট্রং এবং বাজ অলড্রিন 'ঈগল' নামক একটি ছোট যানে করে চাঁদের বুকে প্রথম পা রাখেন।"
    },
    {
      "name": "First Footprint",
      "bn": "প্রথম পদচিহ্ন",
      "emoji": "👣",
      "color": Colors.cyanAccent,
      "fact": "চাঁদে মানুষের পায়ের ছাপ কোনোদিন মুছে যায় না!",
      "extra": "যেহেতু চাঁদে কোনো বাতাস বা বৃষ্টি নেই, তাই সেখানে প্রথম মানুষের পায়ের ছাপ এখনো আগের মতোই আছে।"
    },
    {
      "name": "Return Home",
      "bn": "পৃথিবীতে ফেরা",
      "emoji": "🌊",
      "color": Colors.greenAccent,
      "fact": "মিশন শেষে মহাকাশচারীরা সমুদ্রে এসে নামেন।",
      "extra": "চাঁদ থেকে ফিরে তারা একটি প্যারাসুটের সাহায্যে প্রশান্ত মহাসাগরের পানিতে নিরাপদে অবতরণ করেন।"
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupVideo();
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  void _setupVideo() {
    _videoController = VideoPlayerController.asset('assets/videos/moon_mission.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() => _isVideoInitialized = true);
          _videoController!.play();
          _videoController!.setLooping(true);
        }
      }).catchError((e) => debugPrint("Video Error: $e"));
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF020210),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ১. ভিডিও হেডার
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Moon Journey 🌙", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              background: _isVideoInitialized 
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        VideoPlayer(_videoController!),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              _videoController!.value.isPlaying ? Icons.pause_circle : Icons.play_circle, 
                              color: Colors.white70, size: 60
                            ),
                            onPressed: () => setState(() => _videoController!.value.isPlaying ? _videoController!.pause() : _videoController!.play()),
                          ),
                        ),
                      ],
                    )
                  : Container(color: Colors.blueGrey[900], child: const Center(child: CircularProgressIndicator())),
            ),
          ),

          // ২. টাইটেল সেকশন
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("How we went to Moon! ✨", 
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("ধাপে ধাপে শেখো রকেট কীভাবে চাঁদে যায়!", 
                    style: TextStyle(color: Colors.grey[400], fontSize: 16)),
                ],
              ),
            ),
          ),

          // ৩. মিশনের ধাপগুলো (Grid)
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildStepCard(missionSteps[index]),
                childCount: missionSteps.length,
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildStepCard(Map<String, dynamic> step) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => _showStepInfo(step),
          child: Transform.translate(
            offset: Offset(0, 8 * _floatingController.value),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151530),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: step['color'].withOpacity(0.5), width: 2),
                boxShadow: [BoxShadow(color: step['color'].withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(step['emoji'], style: const TextStyle(fontSize: 50)),
                  const SizedBox(height: 10),
                  Text(step['bn'], 
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showStepInfo(Map<String, dynamic> step) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xFF0F0F25),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 45, height: 4, margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
            
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(step['emoji'], style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 10),
                    Text(step['bn'], 
                      style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const Divider(color: Colors.white12, height: 30),
                    
                    Text(step['fact'], 
                      textAlign: TextAlign.center, 
                      style: TextStyle(color: step['color'], fontSize: 20, fontWeight: FontWeight.bold)),
                    
                    const SizedBox(height: 15),
                    
                    Text(step['extra'], 
                      textAlign: TextAlign.center, 
                      style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: step['color'],
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("পরের ধাপে যাই!", 
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}