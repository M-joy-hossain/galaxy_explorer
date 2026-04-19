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

  // গ্রহের বাংলা নাম
  final Map<String, String> bengaliNames = {
    'Mercury': 'বুধ',
    'Venus': 'শুক্র',
    'Earth': 'পৃথিবী',
    'Mars': 'মঙ্গল',
    'Jupiter': 'বৃহস্পতি',
    'Saturn': 'শনি',
    'Uranus': 'ইউরেনাস',
    'Neptune': 'নেপচুন',
  };

  final Map<String, String> planetImages = {
    'Mercury': 'assets/images/mercury.png',
    'Venus': 'assets/images/venus.png',
    'Earth': 'assets/images/earth.png',
    'Mars': 'assets/images/mars.png',
    'Jupiter': 'assets/images/jupiter.png',
    'Saturn': 'assets/images/saturn.png',
    'Uranus': 'assets/images/uranus.png',
    'Neptune': 'assets/images/neptune.png',
    'Sun': 'assets/images/sun.png',
  };
  List<String?> slots = List.filled(8, null);
  List<bool> slotCorrect = List.filled(8, false);
  
  List<String> planetsToPlace = [];
  int currentPlanetIndex = 0;
  bool gameCompleted = false;
  String? feedbackMessage;
  bool showFeedback = false;
  Color feedbackColor = Colors.green;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() { 
    List<String> shuffledPlanets = List.from(correctOrder);
    shuffledPlanets.shuffle();
    planetsToPlace = shuffledPlanets;
    currentPlanetIndex = 0;
    slots = List.filled(8, null);
    slotCorrect = List.filled(8, false);
    gameCompleted = false;
    feedbackMessage = null;
    showFeedback = false;
  }

  void handleDrop(String data, int index) {
    //চেক করা এই জায়গাটি আগে পূরণ হয়েছে কিনা
    if (slots[index] != null) {
      _showFeedback("❌ এই জায়গাটি ইতিমধ্যে পূরণ হয়েছে!", Colors.orange);
      return;
    }
    
    //চেক করা গ্রহটি সঠিক জায়গায় বসানো হচ্ছে কিনা
    int expectedIndex = correctOrder.indexOf(data);
    
    if (expectedIndex == index) {
      setState(() {
        slots[index] = data;
        slotCorrect[index] = true;
        currentPlanetIndex++;
        
        _showFeedback("✓ সঠিক! ${bengaliNames[data]} গ্রহটি সঠিক জায়গায় বসেছে!", Colors.green);
      });
      
      //সব গ্রহ বসানো শেষ হলে
      if (currentPlanetIndex == correctOrder.length) {
        setState(() {
          gameCompleted = true;
        });
      }
    } else {
      //ভুল জায়গায় বসালে-কোন hint দেওয়া হবে না
      _showFeedback(
        "❌ ভুল জায়গা! আবার চেষ্টা করো।",
        Colors.redAccent
      );
    }
  }
  
  void _showFeedback(String message, Color color) {
    setState(() {
      feedbackMessage = message;
      feedbackColor = color;
      showFeedback = true;
    });
    
    //2 সেকেন্ড পরে ফিডব্যাক লুকানো
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showFeedback = false;
        });
      }
    });
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
              // Lottie অ্যানিমেশন - সঠিক পাথে
              Lottie.asset(
                'assets/animations/congratulations.json',
                width: 300,
                height: 300,
                repeat: true,
                errorBuilder: (context, error, stackTrace) {
                  // যদি Lottie ফাইল লোড না হয়, তাহলে ব্যাকআপ দেখাবে
                  return Column(
                    children: [
                      const Icon(
                        Icons.emoji_events,
                        size: 100,
                        color: Colors.amber,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "🎉অসাধারণ!🎉",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 20),
              
              const Text(
                "🎉অসাধারণ!🎉",
                style: TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 15),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  "তুমি সফলভাবে সৌরজগৎ সাজিয়েছো!",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
              ),
              
              const SizedBox(height: 10),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "গ্রহগুলোর সঠিক ক্রম মনে রেখো! 🪐",
                  style: TextStyle(fontSize: 16, color: Colors.yellow.shade300),
                ),
              ),
              
              const SizedBox(height: 30),
              
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _initializeGame();
                  });
                },
                icon: const Icon(Icons.refresh, color: Colors.white, size: 28),
                label: const Text(
                  "আবার খেলো",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              
              const SizedBox(height: 30),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B0D17),
      appBar: AppBar(
        title: const Text(
          "গ্রহ সাজাও",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "🌞 সূর্য থেকে সিরিয়াল অনুযায়ী গ্রহগুলো বসাও",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
  
          //ফিডব্যাক মেসেজ
          AnimatedOpacity(
            opacity: showFeedback ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: feedbackColor, 
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                feedbackMessage ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          
          //---ড্রপ জোন এরিয়া (Slots)---
          Expanded(
            flex: 2,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange.withOpacity(0.5),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                planetImages['Sun']!,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  // ছবি না থাকলে ব্যাকআপ
                                  return Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(
                                        colors: [Colors.orange, Colors.deepOrange],
                                        stops: [0.5, 1.0],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(Icons.sunny, size: 50, color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "সূর্য",
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 20),
                      
                      //গ্রহের স্লট-কোন hint দেওয়া হবে না
                      Row(
                        children: List.generate(8, (index) {
                          return DragTarget<String>(
                            onWillAccept: (data) => slots[index] == null && !gameCompleted,
                            onAccept: (data) => handleDrop(data, index),
                            builder: (context, candidateData, rejectedData) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 6),
                                width: 85,
                                height: 110,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: slots[index] != null 
                                            ? Colors.grey.shade800 
                                            : Colors.white.withOpacity(0.05),
                                        border: Border.all(
                                          color: slotCorrect[index]
                                              ? Colors.green.shade400
                                              : Colors.white24,
                                          width: slotCorrect[index] ? 4 : 1,
                                        ),
                                      ),
                                      child: slots[index] != null
                                          ? ClipOval(
                                              child: Image.network(
                                                planetImages[slots[index]!]!,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey.shade700,
                                                    child: const Icon(
                                                      Icons.public,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                  );
                                                },
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return Center(
                                                    child: CircularProgressIndicator(
                                                      value: loadingProgress.expectedTotalBytes != null
                                                          ? loadingProgress.cumulatedBytesLoaded / loadingProgress.expectedTotalBytes!
                                                          : null,
                                                      strokeWidth: 2,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                "${index + 1}",
                                                style: const TextStyle(
                                                  color: Colors.white38,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "স্থান ${index + 1}",
                                      style: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 10,
                                      ),
                                    ),
                                    if (slots[index] != null)
                                      Text(
                                        bengaliNames[slots[index]!]!,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                  ],
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
          ),

          // ---ড্র্যাগ করার গ্রহ (Current Planet to Drag)---
          Container(
            height: 240,
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "📦 এই গ্রহটিকে সঠিক পজিশনে টেনে নাও:",
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
                const SizedBox(height: 15),
                
                currentPlanetIndex < planetsToPlace.length
                    ? Draggable<String>(
                        data: planetsToPlace[currentPlanetIndex],
                        feedback: Material(
                          color: Colors.transparent,
                          child: _planetWidget(
                            planetsToPlace[currentPlanetIndex], 
                            true,
                            bengaliNames[planetsToPlace[currentPlanetIndex]]!,
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: _planetWidget(
                            planetsToPlace[currentPlanetIndex], 
                            false,
                            bengaliNames[planetsToPlace[currentPlanetIndex]]!,
                          ),
                        ),
                        child: _planetWidget(
                          planetsToPlace[currentPlanetIndex], 
                          false,
                          bengaliNames[planetsToPlace[currentPlanetIndex]]!,
                        ),
                      )
                    : const SizedBox(),
                    
                if (currentPlanetIndex < planetsToPlace.length) ...[
                  const SizedBox(height: 10),
                  Text(
                    "বাকি আছে: ${correctOrder.length - currentPlanetIndex}টি",
                    style: const TextStyle(color: Colors.white38, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // গ্রহের জন্য স্টাইলিশ উইজেট (ছবি সহ)
  Widget _planetWidget(String name, bool isFeedback, String bengaliName) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isFeedback ? 120 : 100,
      height: isFeedback ? 120 : 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: isFeedback 
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 20,
                  spreadRadius: 5,
                )
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
        border: Border.all(
          color: Colors.white.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              planetImages[name]!,
              width: isFeedback ? 120 : 100,
              height: isFeedback ? 120 : 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.public,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        bengaliName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade800,
                  child: const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              },
            ),

            // নামের জন্য ওভারলে
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  bengaliName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on ImageChunkEvent {
  get cumulatedBytesLoaded => null;
}