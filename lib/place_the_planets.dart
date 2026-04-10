import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PlaceThePlanets extends StatefulWidget {
  const PlaceThePlanets({super.key});
  @override
  State<PlaceThePlanets> createState() => _PlaceThePlanetsState();
}

class _PlaceThePlanetsState extends State<PlaceThePlanets> {
  // সূর্য থেকে সঠিক ক্রম
  final List<String> correctOrder = [
    'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune'
  ];
 
  List<String?> slots = List.filled(8, null);
   
  int currentTargetIndex = 0;
  bool gameCompleted = false;

  void handleDrop(String data, int index) {
    if (index == currentTargetIndex && data == correctOrder[currentTargetIndex]) {
      setState(() {
        slots[index] = data; // গ্রহটি পজিশনে বসিয়ে দাও
        currentTargetIndex++; // এখন পরবর্তী গ্রহের জন্য টার্গেট আপডেট করো
      });

      // সব গ্রহ বসানো শেষ হলে
      if (currentTargetIndex == correctOrder.length) {
        setState(() {
          gameCompleted = true;
        });
      }
    } else {
      // ভুল জায়গায় বসালে ফিডব্যাক
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("❌ ভুল পজিশন! সূর্য থেকে দূরত্ব অনুযায়ী বসাও।"),
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (gameCompleted) {
      return Scaffold(
        backgroundColor: const Color(0xFF0B0D17),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/congratulations.json', width: 250),
              const Text("🎉 অসামান্য!", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              const Text("তুমি সফলভাবে সৌরজগৎ সাজিয়েছো!", style: TextStyle(fontSize: 18, color: Colors.white70)),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: () {
                  setState(() {
                    slots = List.filled(8, null);
                    currentTargetIndex = 0;
                    gameCompleted = false;
                  });
                },
                child: const Text("আবার খেলো", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      appBar: AppBar(title: const Text("Place The Planets"), centerTitle: true, backgroundColor: Colors.transparent, elevation: 0),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("🌞 সূর্য থেকে সিরিয়াল অনুযায়ী গ্রহগুলো বসাও", 
            style: TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 20),
          
          // --- ড্রপ জোন এরিয়া (Slots) ---
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Icon(Icons.sunny, size: 100, color: Colors.orange), ////// সূর্য
                    const SizedBox(width: 20),
                    Row(
                      children: List.generate(8, (index) {
                        return DragTarget<String>(
                          onWillAccept: (data) => slots[index] == null,
                          onAccept: (data) => handleDrop(data, index),
                          builder: (context, candidateData, rejectedData) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: slots[index] != null ? Colors.blueAccent : Colors.white.withOpacity(0.05),
                                border: Border.all(
                                  color: index == currentTargetIndex ? Colors.yellowAccent : Colors.white24,
                                  width: index == currentTargetIndex ? 3 : 1
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  slots[index] ?? "${index + 1}",
                                  style: TextStyle(
                                    color: slots[index] != null ? Colors.white : Colors.white38,
                                    fontSize: slots[index] != null ? 12 : 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- ড্র্যাগ করার গ্রহ (Current Planet to Drag) ---
          Container(
            height: 200,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))
            ),
            child: Center(
              child: currentTargetIndex < correctOrder.length
                  ? Column(
                      children: [
                        const Text("এই গ্রহটিকে সঠিক পজিশনে টেনে নাও:", style: TextStyle(color: Colors.white60)),
                        const SizedBox(height: 20),
                        Draggable<String>(
                          data: correctOrder[currentTargetIndex],
                          feedback: Material(
                            color: Colors.transparent,
                            child: _planetWidget(correctOrder[currentTargetIndex], true),
                          ),
                          childWhenDragging: Opacity(
                            opacity: 0.3,
                            child: _planetWidget(correctOrder[currentTargetIndex], false),
                          ),
                          child: _planetWidget(correctOrder[currentTargetIndex], false),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  // গ্রহের জন্য স্টাইলিশ উইজেট
  Widget _planetWidget(String name, bool isFeedback) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blueAccent,
        boxShadow: isFeedback ? [] : [
          BoxShadow(color: Colors.blue.withOpacity(0.4), blurRadius: 15, spreadRadius: 2)
        ],
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }
}