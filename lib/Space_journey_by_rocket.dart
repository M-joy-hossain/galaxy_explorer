import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SpaceJourneyByRocket extends StatefulWidget {
  const SpaceJourneyByRocket({super.key});

  @override
  _SpaceJourneyByRocketState createState() => _SpaceJourneyByRocketState();
}

class _SpaceJourneyByRocketState extends State<SpaceJourneyByRocket> with TickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isVideoInitialized = false;
  late AnimationController _floatingController;

  final List<Map<String, dynamic>> spaceLifeSteps = [
    {
      "name": "Sleeping",
      "bn": "মহাকাশে ঘুম",
      "emoji": "😴",
      "color": Colors.deepPurpleAccent,
      "fact": "মহাকাশে বিছানা নেই, মহাকাশচারীরা দেয়ালের সাথে আটকে ঘুমায়!",
      "extra": "সেখানে কোনো ওপর-নিচ নেই, তাই তারা একটি স্লিপিং ব্যাগের ভেতরে ঢুকে নিজেদের দেয়ালের সাথে বেঁধে রাখে যাতে ঘুমের ঘোরে ভেসে না যায়।"
    },
    {
      "name": "Eating",
      "bn": "খাবার দাবার",
      "emoji": "🍔",
      "color": Colors.orangeAccent,
      "fact": "খাবারগুলো প্যাকেট করা থাকে এবং চামচ দিয়ে খেতে হয় যেন উড়ে না যায়।",
      "extra": "সেখানে লবন বা গোলমরিচ তরল আকারে থাকে। কারণ গুড়ো মশলা মহাকাশচারীদের নাকে ঢুকে যেতে পারে!"
    },
    {
      "name": "Water Magic",
      "bn": "পানির জাদু",
      "emoji": "💧",
      "color": Colors.lightBlueAccent,
      "fact": "পানি ফেললে মহাকাশে তা গোল মার্বেলের মতো ভাসতে থাকে!",
      "extra": "সেখানে গ্লাসে করে পানি খাওয়া যায় না। স্ট্র দিয়ে সরাসরি প্যাকেট থেকে পানি খেতে হয়। ফোঁটা ফোঁটা পানিগুলো বাতাসে বলের মতো ভেসে বেড়ায়।"
    },
    {
      "name": "Exercise",
      "bn": "ব্যায়াম করা",
      "emoji": "🏃‍♂️",
      "color": Colors.greenAccent,
      "fact": "শরীরের হাড় শক্ত রাখতে প্রতিদিন ২ ঘণ্টা ব্যায়াম করতে হয়।",
      "extra": "মহাকাশে শরীর খুব হালকা হয়ে যায়, তাই পেশী সচল রাখতে বিশেষ মেশিনে দৌড়াতে হয়।"
    },
    {
      "name": "Space Toilet",
      "bn": "মহাকাশের টয়লেট",
      "emoji": "🚽",
      "color": Colors.grey,
      "fact": "টয়লেটে ভ্যাকুয়াম ক্লিনারের মতো বাতাস দিয়ে সব টেনে নেওয়া হয়!",
      "extra": "যেহেতু সেখানে পানি বা কোনো কিছু নিচে পড়ে না, তাই বিশেষ ফ্যান ও বাতাসের সাহায্যে সব পরিষ্কার করা হয়।"
    },
    {
      "name": "Brush Teeth",
      "bn": "দাঁত মাজা",
      "emoji": "🪥",
      "color": Colors.pinkAccent,
      "fact": "দাঁত মাজার পর তারা ফেনা কুলি না করে গিলে ফেলে!",
      "extra": "মহাকাশে বেসিন নেই যেখানে পানি ফেলা যাবে, তাই মহাকাশচারীরা বিশেষ ধরণের টুথপেস্ট ব্যবহার করেন যা গিলে ফেললে কোনো ক্ষতি হয় না।"
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
    _videoController = VideoPlayerController.asset('assets/videos/Space_vromon.mp4')
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
      backgroundColor: const Color(0xFF020215),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("Space Life 👨‍🚀", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              background: _isVideoInitialized 
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        VideoPlayer(_videoController!),
                        Center(
                          child: Icon(Icons.blur_on, color: Colors.white.withOpacity(0.3), size: 100),
                        ),
                      ],
                    )
                  : Container(color: Colors.indigo[900], child: const Center(child: CircularProgressIndicator())),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Life in Zero Gravity! 🌌", 
                    style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("মহাকাশচারীরা কীভাবে সেখানে থাকে? চলো জেনে নিই!", 
                    style: TextStyle(color: Colors.grey[400], fontSize: 16)),
                ],
              ),
            ),
          ),

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
                (context, index) => _buildLifeCard(spaceLifeSteps[index]),
                childCount: spaceLifeSteps.length,
              ),
            ),
          ),
          
          const SliverToBoxAdapter(child: SizedBox(height: 50)),
        ],
      ),
    );
  }

  Widget _buildLifeCard(Map<String, dynamic> item) {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => _showLifeDetail(item),
          child: Transform.translate(
            offset: Offset(0, 10 * _floatingController.value),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A35),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: item['color'].withOpacity(0.5), width: 2),
                boxShadow: [BoxShadow(color: item['color'].withOpacity(0.1), blurRadius: 10)],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item['emoji'], style: const TextStyle(fontSize: 50)),
                  const SizedBox(height: 10),
                  Text(item['bn'], 
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

  void _showLifeDetail(Map<String, dynamic> item) {
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
                    Text(item['emoji'], style: const TextStyle(fontSize: 80)),
                    const SizedBox(height: 10),
                    Text(item['bn'], 
                      style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                    const Divider(color: Colors.white12, height: 30),
                    
                    Text(item['fact'], 
                      textAlign: TextAlign.center, 
                      style: TextStyle(color: item['color'], fontSize: 20, fontWeight: FontWeight.bold)),
                    
                    const SizedBox(height: 15),
                    
                    Text(item['extra'], 
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
                backgroundColor: item['color'],
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("বাহ! কী মজা!", 
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}