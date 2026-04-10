import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MarsMissionLearning extends StatefulWidget {
  const MarsMissionLearning({super.key});

  @override
  _MarsMissionLearningState createState() => _MarsMissionLearningState();
}

class _MarsMissionLearningState extends State<MarsMissionLearning> with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  late AnimationController _floatingController;

  // সরাসরি অনলাইন লিঙ্ক (NASA & Wikimedia verified)
  final List<Map<String, dynamic>> marsSteps = [
    {
      "name": "The Red Planet",
      "bn": "লাল গ্রহ",
      "emoji": "🔴",
      "image": "https://upload.wikimedia.org/wikipedia/commons/thumb/0/02/OSIRIS_Mars_true_color.jpg/800px-OSIRIS_Mars_true_color.jpg",
      "color": Colors.redAccent,
      "fact": "মঙ্গলের মাটি লাল কারণ এর মাটিতে প্রচুর লোহা বা জং আছে!",
      "extra": "মহাকাশ থেকে একে একটি লাল বলের মতো দেখায়।"
    },
    {
      "name": "Mars Rover",
      "bn": "মঙ্গল গাড়ি",
      "emoji": "🤖",
      "image": "https://mars.nasa.gov/system/resources/detail_files/25043_PIA23962-web.jpg",
      "color": Colors.cyan,
      "fact": "রোবট গাড়িগুলো মঙ্গলের মাটিতে ঘুরে বেড়ায় এবং ছবি তোলে।",
      "extra": "এরা মানুষের পাঠানো ছোট রোবট বিজ্ঞানী!"
    },
    {
      "name": "Blue Sunset",
      "bn": "নীল সূর্যাস্ত",
      "emoji": "🌇",
      "image": "https://www.nasa.gov/wp-content/uploads/2015/05/pia19401-full2.jpg",
      "color": Colors.blueAccent,
      "fact": "মঙ্গলের আকাশে সূর্যাস্ত নীল রঙের হয়!",
      "extra": "পৃথিবীর ঠিক উল্টো, ভাবতেই অবাক লাগে তাই না?"
    },
    {
      "name": "Olympus Mons",
      "bn": "বিশাল পাহাড়",
      "emoji": "🌋",
      "image": "https://upload.wikimedia.org/wikipedia/commons/0/00/Olympus_Mons_alt.jpg",
      "color": Colors.deepOrange,
      "fact": "এটি সৌরজগতের সবচেয়ে বড় আগ্নেয়গিরি।",
      "extra": "এটি এভারেস্টের চেয়ে ৩ গুণ বেশি উঁচু!"
    },
    {
      "name": "Ice on Mars",
      "bn": "মঙ্গলে বরফ",
      "emoji": "❄️",
      "image": "https://www.esa.int/var/esa/storage/images/esa_multimedia/images/2018/12/korolev_crater/19154497-2-eng-GB/Korolev_Crater_pillars.jpg",
      "color": Colors.white70,
      "fact": "মঙ্গলের উত্তর দিকে প্রচুর জমে থাকা বরফ পাওয়া গেছে!",
      "extra": "তার মানে সেখানে এক সময় অনেক পানি ছিল।"
    },
    {
      "name": "First Helicopter",
      "bn": "মঙ্গলের ড্রোন",
      "emoji": "🚁",
      "image": "https://mars.nasa.gov/system/resources/detail_files/25640_PIA24467-web.jpg",
      "color": Colors.greenAccent,
      "fact": "এটি হলো প্রথম ড্রোন যা অন্য গ্রহে উড়েছে।",
      "extra": "এর নাম হলো ইনজেনুইটি (Ingenuity)।"
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
  // .networkUrl এর পরিবর্তে .asset ব্যবহার করুন
  _videoController = VideoPlayerController.asset(
    'assets/videos/mars_mission.mp4',
  )..initialize().then((_) {
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
        // ভিডিওটি লোড হওয়ার পর অটোমেটিক প্লে করার জন্য নিচের লাইনটি দিন
        _videoController!.play();
        // ভিডিওটি বারবার চালানোর জন্য লুপ সেট করতে পারেন
       // _videoController!.setLooping(true);
      }
    }).catchError((error) {
      // যদি ভিডিও লোড হতে কোনো সমস্যা হয় তবে এখানে এরর দেখাবে
      debugPrint("Video Error: $error");
    });
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
      backgroundColor: const Color(0xFF1A0A05),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: Colors.deepOrange[900],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Mars Mission 🚀", style: TextStyle(fontWeight: FontWeight.bold)),
              background: _isVideoInitialized 
                  ? VideoPlayer(_videoController!) 
                  : Container(color: Colors.black),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Explore Mars in Real Life! ✨", 
                    style: TextStyle(fontSize: 24, color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("NASA-র পাঠানো আসল ছবিগুলো নিচে দেখো:", 
                    style: TextStyle(color: Colors.orange[100], fontSize: 16)),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 210,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildMarsCard(marsSteps[index]),
                childCount: marsSteps.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildMarsCard(Map<String, dynamic> step) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => _showMarsDetail(step),
          child: Transform.translate(
            offset: Offset(0, 8 * _floatingController.value),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: const Color(0xFF2D140C),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: step['color'].withOpacity(0.5), width: 2),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // --- ইমেজ নেটওয়ার্ক লোডিং সহ ---
                  Image.network(
                    step['image'],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator(color: Colors.white24));
                    },
                    errorBuilder: (context, error, stackTrace) => 
                      const Center(child: Icon(Icons.broken_image, color: Colors.white24, size: 40)),
                  ),
                  Container(color: Colors.black45), 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(step['emoji'], style: const TextStyle(fontSize: 40)),
                      const SizedBox(height: 10),
                      Text(step['name'], textAlign: TextAlign.center, 
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(step['bn'], style: TextStyle(color: step['color'], fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showMarsDetail(Map<String, dynamic> step) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF1A0A05),
          borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
        ),
        child: Column(
          children: [
            Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 20), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        step['image'],
                        height: 220, width: double.infinity, fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(height: 220, child: Center(child: CircularProgressIndicator()));
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(step['name'], style: const TextStyle(color: Colors.orangeAccent, fontSize: 26, fontWeight: FontWeight.bold)),
                    const Divider(color: Colors.white10, height: 30),
                    Text(step['fact'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Text(step['extra'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.orange, fontSize: 16, height: 1.5)),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: step['color'], minimumSize: const Size(double.infinity, 55), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              child: const Text("সব বুঝেছি! 🚀", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }
}