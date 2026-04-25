import 'package:flutter/material.dart';
import 'dart:math' as math;
// আপনার প্রজেক্টের সঠিক পাথ অনুযায়ী নিচের ইম্পোর্টগুলো চেক করে নিন
import 'package:galaxy_explorer/AlphabetPage.dart';
import 'package:galaxy_explorer/Moon_Mission_Learning.dart';
import 'package:galaxy_explorer/SolarSystemLearning.dart';
import 'package:galaxy_explorer/Space_journey_by_rocket.dart';
import 'package:galaxy_explorer/black_hole_learning.dart'; 
import 'package:galaxy_explorer/mars_mission_learning.dart';

// --- 1. LEVEL DATA MODEL ---
class LevelData {
  final String title;
  final String interiorEmoji;
  final String leftDoorDecoration;
  final String rightDoorDecoration;
  final List<Color> interiorColors;
  final Widget gamePage; 

  LevelData({
    required this.title,
    required this.interiorEmoji,
    required this.leftDoorDecoration,
    required this.rightDoorDecoration,
    required this.interiorColors,
    required this.gamePage,
  });
}

// --- 2. SAMPLE TARGET PAGE (For Demo) ---
class MarsMissionPage extends StatelessWidget {
  const MarsMissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[900],
      appBar: AppBar(title: const Text("Mars Mission"), backgroundColor: Colors.red),
      body: const Center(
        child: Text("Welcome to Mars! 🚀", style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
    );
  }
}

// --- 3. MAIN SCREEN GRID ---
class SpaceMuseumGrid extends StatelessWidget {
  const SpaceMuseumGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<LevelData> levels = [
      LevelData(
        title: "সৌরজগত",
        interiorEmoji: "☀️",
        leftDoorDecoration: "🪐",
        rightDoorDecoration: "🌑",
        interiorColors: [const Color(0xFF240b36), const Color(0xFF000000)],
        gamePage:  SolarSystemLearning(), 
      ),
      LevelData(
        title: "মঙ্গল অভিযান",
        interiorEmoji: "🚀",
        leftDoorDecoration: "🔴",
        rightDoorDecoration: "🤖",
        interiorColors: [const Color(0xFF8B0000), Colors.black],
        gamePage: const MarsMissionLearning(),  
      ),
      LevelData(
        title: "নিল আর্মস্ট্রং ও অ্যাপোলো ১১",
        interiorEmoji: "🕳️",
        leftDoorDecoration: "✨",
        rightDoorDecoration: "🌌",
        interiorColors: [const Color(0xFF000000), const Color(0xFF434343)],
        gamePage: const  MoonMissionLearning(), 
      ),
      LevelData(
        title: "বন্ধুদের মহাকাশ অভিযান",
        interiorEmoji: "👽",
        leftDoorDecoration: "🛸",
        rightDoorDecoration: "👾",
        interiorColors: [const Color(0xFF0F9D58), Colors.black],
        gamePage: const SpaceJourneyByRocket(),
      ),
     
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFf0f4f8),
      appBar: AppBar(
        title: const Text("মহাকাশ জাদুঘর"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: levels.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
            crossAxisSpacing: 15,
            mainAxisSpacing: 25,
          ),
          itemBuilder: (context, index) {
            return SpaceMuseumDoor(data: levels[index]);
          },
        ),
      ),
    );
  }
}

// --- 4. ANIMATED DOOR WIDGET ---
class SpaceMuseumDoor extends StatefulWidget {
  final LevelData data;
  const SpaceMuseumDoor({super.key, required this.data});

  @override
  State<SpaceMuseumDoor> createState() => _SpaceMuseumDoorState();
}

class _SpaceMuseumDoorState extends State<SpaceMuseumDoor>
    with TickerProviderStateMixin {
  late AnimationController _doorController;
  late Animation<double> _leftDoorAnim;
  late Animation<double> _rightDoorAnim;

  bool _isOpen = false;
  final List<int> _astronauts = [];

  @override
  void initState() {
    super.initState();
    _doorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _leftDoorAnim = Tween<double>(begin: 0, end: -110 * (math.pi / 180)).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOutBack),
    );

    _rightDoorAnim = Tween<double>(begin: 0, end: 110 * (math.pi / 180)).animate(
      CurvedAnimation(parent: _doorController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _doorController.dispose();
    super.dispose();
  }

  void _handleTap() async {
    if (_isOpen) return;

    setState(() {
      _isOpen = true;
    });
    _doorController.forward();

    // Astronaut animation
    for (int i = 0; i < 3; i++) {
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        setState(() {
          _astronauts.add(i);
        });
      }
    }

    // দরজার অ্যানিমেশন এবং অ্যাস্ট্রোনট ওড়ার জন্য অপেক্ষা
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    // সরাসরি টার্গেট গেমে নেভিগেট করা হচ্ছে (ইন্টারমিডিয়েট পেজ ছাড়াই)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget.data.gamePage, 
      ),
    ).then((_) {
      // ফিরে আসার পর দরজা আবার বন্ধ হয়ে যাবে
      if (mounted) {
        setState(() {
          _isOpen = false;
          _astronauts.clear();
        });
        _doorController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 240,
          height: 380,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 20,
                child: Container(
                  width: 230,
                  height: 360,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3E2723),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                ),
              ),
              _buildInteriorScreen(),
              ..._astronauts.map((id) => _FloatingAstronaut(key: ValueKey(id))),
              // Left Door
              Positioned(
                left: 7,
                bottom: 0,
                child: AnimatedBuilder(
                  animation: _leftDoorAnim,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(_leftDoorAnim.value),
                      alignment: Alignment.centerLeft,
                      child: _buildDoorLeaf(
                          isLeft: true, decoration: widget.data.leftDoorDecoration),
                    );
                  },
                ),
              ),
              // Right Door
              Positioned(
                right: 7,
                bottom: 0,
                child: AnimatedBuilder(
                  animation: _rightDoorAnim,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(_rightDoorAnim.value),
                      alignment: Alignment.centerRight,
                      child: _buildDoorLeaf(
                          isLeft: false, decoration: widget.data.rightDoorDecoration),
                    );
                  },
                ),
              ),
              Positioned(
                top: 5,
                child: _buildSignboard(),
              ),
              if (!_isOpen)
                Positioned(
                  bottom: -15,
                  child: _BouncingHand(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInteriorScreen() {
    return Positioned(
      top: 40,
      bottom: 20,
      child: Container(
        width: 210,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFFF6D00), width: 3),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: widget.data.interiorColors,
                  center: Alignment.center,
                  radius: 0.8,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.data.interiorEmoji, style: const TextStyle(fontSize: 70)),
                  const SizedBox(height: 10),
                  Text(
                    widget.data.title.replaceAll(" ", "\n"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFFAB40),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoorLeaf({required bool isLeft, required String decoration}) {
    return Container(
      width: 113,
      height: 360,
      decoration: BoxDecoration(
        color: const Color(0xFF4E342E),
        borderRadius: isLeft
            ? const BorderRadius.only(topLeft: Radius.circular(20))
            : const BorderRadius.only(topRight: Radius.circular(20)),
        border: Border.all(color: const Color(0xFF3E2723), width: 2),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: GridPainter())),
          Positioned(
            top: 120,
            left: isLeft ? 25 : null,
            right: isLeft ? null : 25,
            child: Text(decoration, style: const TextStyle(fontSize: 32)),
          ),
        ],
      ),
    );
  }

  Widget _buildSignboard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE65100),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Text(
        widget.data.title,
        style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// --- 5. HELPERS (GridPainter, FloatingAstronaut, BouncingHand) ---
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0x40000000)..style = PaintingStyle.stroke..strokeWidth = 1.0;
    for (double x = 0; x <= size.width; x += 30) { canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint); }
    for (double y = 0; y <= size.height; y += 30) { canvas.drawLine(Offset(0, y), Offset(size.width, y), paint); }
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FloatingAstronaut extends StatefulWidget {
  const _FloatingAstronaut({super.key});
  @override State<_FloatingAstronaut> createState() => _FloatingAstronautState();
}

class _FloatingAstronautState extends State<_FloatingAstronaut> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnim;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _offsetAnim = Tween<Offset>(begin: const Offset(0, 60), end: const Offset(0, -100)).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Positioned(
        bottom: 50,
        child: Transform.translate(offset: _offsetAnim.value, child: const Text("👨‍🚀", style: TextStyle(fontSize: 40))),
      ),
    );
  }
}

class _BouncingHand extends StatefulWidget {
  @override State<_BouncingHand> createState() => _BouncingHandState();
}

class _BouncingHandState extends State<_BouncingHand> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, -5 * _controller.value),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: const Text("👆 TAP", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}