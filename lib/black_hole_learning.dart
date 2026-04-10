import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BlackHoleLearning extends StatefulWidget {
  const BlackHoleLearning({super.key});

  @override
  _BlackHoleLearningState createState() => _BlackHoleLearningState();
}

class _BlackHoleLearningState extends State<BlackHoleLearning> with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  late AnimationController _floatingController;

  final List<Map<String, dynamic>> planets = [
    {
      "name": "Mercury",
      "bn": "বুধ",
      "emoji": "☄️",
      "color": Colors.orange,
      "fact": "বুধ সূর্যের খুব কাছে হলেও এটি সবচেয়ে গরম গ্রহ নয়!",
      "extra": "এখানে এক বছর কাটে মাত্র ৮৮ দিনে। অর্থাৎ এটি খুব দ্রুত সূর্যকে ঘুরে আসে।"
    },
    {
      "name": "Venus",
      "bn": "শুক্র",
      "emoji": "🌟",
      "color": Colors.yellow,
      "fact": "এটি সৌরজগতের সবচেয়ে উজ্জ্বল এবং সবচেয়ে গরম গ্রহ!",
      "extra": "শুক্র গ্রহ উল্টো দিকে ঘোরে। এখানে সূর্য পশ্চিমে ওঠে আর পূর্বে ডোবে!"
    },
    {
      "name": "Earth",
      "bn": "পৃথিবী",
      "emoji": "🌍",
      "color": Colors.blue,
      "fact": "আমাদের পৃথিবী একমাত্র গ্রহ যেখানে প্রাণ আছে।",
      "extra": "মহাকাশ থেকে পৃথিবীকে একটি নীল মার্বেলের মতো দেখায়।"
    },
    {
      "name": "Mars",
      "bn": "মঙ্গল",
      "emoji": "🔴",
      "color": Colors.redAccent,
      "fact": "মঙ্গলে সৌরজগতের সবচেয়ে বড় আগ্নেয়গিরি আছে।",
      "extra": "এর মাটি লাল কারণ এতে প্রচুর লোহা বা আয়রন আছে।"
    },
    {
      "name": "Jupiter",
      "bn": "বৃহস্পতি",
      "emoji": "🌀",
      "color": Colors.brown,
      "fact": "এটি এত বড় যে এর ভেতর ১৩০০টি পৃথিবী ধরে যাবে!",
      "extra": "বৃহস্পতির গায়ে একটি বিশাল লাল দাগ আছে যা আসলে একটি পুরনো ঝড়।"
    },
    {
      "name": "Saturn",
      "bn": "শনি",
      "emoji": "🪐",
      "color": Colors.amber,
      "fact": "শনির আংটিগুলো ধুলোবালি আর বরফের টুকরো দিয়ে তৈরি।",
      "extra": "শনির ঘনত্ব পানির চেয়েও কম, তাই এটি পানির ওপর ভাসতে পারে!"
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
    // ভিডিওর লিঙ্ক কাজ না করলে অ্যাপ ক্রাশ করবে না
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
    )..initialize().then((_) {
        if (mounted) setState(() => _isVideoInitialized = true);
      }).catchError((e) => debugPrint("Video Init Error: $e"));
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
      backgroundColor: const Color(0xFF020210), // Deep space background
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. App Bar with Video
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Solar Journey", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
                  : Container(color: Colors.indigo[900], child: const Center(child: CircularProgressIndicator())),
            ),
          ),

          // 2. Title Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Explore the Galaxy ✨", 
                    style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("গ্রহগুলোতে ক্লিক করো এবং মজার তথ্য শেখো!", 
                    style: TextStyle(color: Colors.grey[400], fontSize: 15)),
                ],
              ),
            ),
          ),

          // 3. Planet Grid (Fixed Error)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.95, // Ratio fix kora holo overflow rokhte
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildPlanetCard(planets[index]),
                childCount: planets.length,
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildPlanetCard(Map<String, dynamic> planet) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => _showPlanetInfo(planet),
          child: Transform.translate(
            offset: Offset(0, 8 * _floatingController.value),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF101025),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: planet['color'].withOpacity(0.5), width: 2),
                boxShadow: [BoxShadow(color: planet['color'].withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(planet['emoji'], style: const TextStyle(fontSize: 50)),
                  const SizedBox(height: 10),
                  Text(planet['name'], 
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(planet['bn'], 
                    style: TextStyle(color: planet['color'], fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void _showPlanetInfo(Map<String, dynamic> planet) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // এটি অনেক জরুরি যাতে কীবোর্ড বা বড় কন্টেন্টে সমস্যা না হয়
      builder: (context) => Container(
        // স্ক্রিনের ৮০% পর্যন্ত হাইট নিতে পারবে যদি প্রয়োজন হয়
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xFF0F0F25),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // কন্টেন্ট অনুযায়ী হাইট নিবে
          children: [
            // ওপরের ছোট বার (Handle)
            Container(
              width: 45, 
              height: 4, 
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))
            ),
            
            // স্ক্রলযোগ্য অংশ শুরু
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Text(planet['emoji'], style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 10),
                    Text(
                      planet['name'], 
                      style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)
                    ),
                    const Divider(color: Colors.white12, height: 30),
                    
                    // মেইন ফ্যাক্ট
                    Text(
                      planet['fact'], 
                      textAlign: TextAlign.center, 
                      style: const TextStyle(color: Colors.cyanAccent, fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // এক্সট্রা ডিটেইলস
                    Text(
                      planet['extra'], 
                      textAlign: TextAlign.center, 
                      style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.5)
                    ),
                    
                    const SizedBox(height: 30), // বাটনের আগে একটু গ্যাপ
                  ],
                ),
              ),
            ),
            
            // বাটনটি নিচে ফিক্সড থাকবে
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: planet['color'],
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 5,
                ),
                child: const Text(
                  "সব বুঝেছি!", 
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}