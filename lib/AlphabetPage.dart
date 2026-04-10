import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:animate_do/animate_do.dart';

class AlphabetPage extends StatefulWidget {
  const AlphabetPage({super.key});

  @override
  State<AlphabetPage> createState() => _AlphabetPageState();
}

class _AlphabetPageState extends State<AlphabetPage> {
  final _audioPlayer = AudioPlayer();
  VideoPlayerController? _videoController;
  int unlockedIndex = 0;
  int? currentPlayingIndex;

  bool isShowingTelescopeAnimation = false;
  bool hasTelescope = false;
  bool isMissionComplete = false;
 
  final List<Map<String, String>> alphabetData = List.generate(26, (index) {
    String letter = String.fromCharCode(65 + index); // A, B, C...
    return {
      'image': 'assets/$letter.jpg', //   assets/A.jpg
      'sound': '${letter.toLowerCase()}_sound.mp3', // a_sound.mp3
      'char': letter,
    };
  });

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _audioPlayer.onPlayerComplete.listen((event) {
      _finishAudioAndProceed();
    });
  }

  void _finishAudioAndProceed() {
    if (currentPlayingIndex == unlockedIndex) {
      _handleStepLogic();
    }
    setState(() {
      currentPlayingIndex = null;
    });
  }

  // গেমের লজিক হ্যান্ডেল করা (টিমমেটের কোড থেকে)
  void _handleStepLogic() {
    if (unlockedIndex == 4) { // E এর পর
      _playVideo('assets/videos/robo_intro.mp4', isIntro: true);
    } else if (unlockedIndex == 9) { // J এর পর
      _playVideo('assets/videos/help_robo.mp4', isDanger: true);
    } else if (unlockedIndex == 14) { // O এর পর
      _showQuizPopup();
    } else if (unlockedIndex == 19) { // T তে টেলিস্কোপ
      setState(() {

        isShowingTelescopeAnimation = true;
      });
    } else if (unlockedIndex == 25) { // Z শেষ হলে
      _showSuccessMissionDialog();
    } else {
      _unlockNext();
    }
  }

  Future<void> _playSound(String soundPath, int index) async {
    if (currentPlayingIndex == index) {
      await _audioPlayer.stop();
      _finishAudioAndProceed();
      return;
    }
    await _audioPlayer.stop();
    setState(() => currentPlayingIndex = index);
    // assets থেকে সাউন্ড প্লে
    await _audioPlayer.play(AssetSource(soundPath));
  }

  // --- UI Helpers ---

  Widget _buildAlphabetButton(int index) {
    bool isLocked = index > unlockedIndex;
    bool isPlaying = index == currentPlayingIndex;
    var item = alphabetData[index];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Opacity(
          opacity: isLocked ? 0.5 : 1.0,
          child: GestureDetector(
            onTap: isLocked ? null : () => _playSound(item['sound']!, index),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: isPlaying ? Colors.yellowAccent : Colors.transparent,
                  width: 4,
                ),
                boxShadow: [
                  if (!isLocked)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      item['image']!,
                      fit: BoxFit.contain,
                    ),
                    if (isLocked)
                      Container(
                        color: Colors.black26,
                        child: const Icon(Icons.lock, color: Colors.white, size: 30),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //buildAlphabetRow(ডায়নামিক)
  Widget _buildAlphabetRow(int startIndex, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(count, (i) => _buildAlphabetButton(startIndex + i)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // স্পেস থিম
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: const Text(
          'Alphabet Galaxy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          if (hasTelescope)
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: BounceInDown(child: Image.asset('assets/telescope.png', width: 35)),
            ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  _buildAlphabetRow(0, 3), // A, B, C
                  _buildAlphabetRow(3, 3), // D, E, F
                  _buildAlphabetRow(6, 3), // G, H, I
                  _buildAlphabetRow(9, 3), // J, K, L
                  _buildAlphabetRow(12, 3), // M, N, O
                  _buildAlphabetRow(15, 3), // P, Q, R
                  _buildAlphabetRow(18, 3), // S, T, U
                  _buildAlphabetRow(21, 3), // V, W, X
                  _buildAlphabetRow(24, 2), // Y, Z
                ],
              ),
            ),
          ),
          
          // টিমমেটের এনিমেশন ওভারলে গুলো এখানে যুক্ত
          _buildTelescopeOverlay(),
          if (isShowingTelescopeAnimation) _buildTelescopeCollectionScreen(),
        ],
      ),
    );
  }

  // --- গেম লজিক ফাংশনস (টিমমেটের কোড থেকে সংক্ষেপিত) ---

  void _unlockNext() {
    if (unlockedIndex < alphabetData.length - 1) {
      setState(() => unlockedIndex++);
      _saveProgress(unlockedIndex);
    }
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => unlockedIndex = prefs.getInt('unlocked_level') ?? 0);
  }

  Future<void> _saveProgress(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('unlocked_level', index);
  }

  // ভিডিও প্লেয়ার ডায়ালগ
  void _playVideo(String path, {bool isIntro = false, bool isDanger = false}) {
    _videoController = VideoPlayerController.asset(path)
      ..initialize().then((_) {
        setState(() {});
        _videoController!.play();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Dialog(
            backgroundColor: Colors.black,
            child: AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
          ),
        );
        _videoController!.addListener(() {
          if (_videoController!.value.position >= _videoController!.value.duration) {
            Navigator.pop(context);
            _videoController!.dispose();
            if (isIntro) _unlockNext();
            if (isDanger) _showDangerMissionPopup();
          }
        });
      });
  }

  void _showDangerMissionPopup() {
    _showMissionMessage(
      title: "🚨 মিশন: বন্ধুকে বাঁচাও!",
      content: "জলদি পরের অক্ষরগুলো শিখে রোবো বন্ধুকে সাহায্য করো!",
      buttonText: "মিশন শুরু করো!",
      onNext: _unlockNext,
    );
  }

  void _showMissionMessage({required String title, required String content, required String buttonText, required VoidCallback onNext}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ZoomIn(
        child: AlertDialog(
          backgroundColor: const Color(0xFF1B263B),
          title: Text(title, style: const TextStyle(color: Colors.yellowAccent)),
          content: Text(content, style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(onPressed: () { Navigator.pop(context); onNext(); }, child: Text(buttonText)),
          ],
        ),
      ),
    );
  }

  // কুইজ পপআপ
  void _showQuizPopup() {
    int correctIdx = Random().nextInt(14);
    String correctChar = alphabetData[correctIdx]['char']!;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ZoomIn(
        child: AlertDialog(
          backgroundColor: const Color(0xFF1B263B),
          title: Text("Find the letter '$correctChar'", style: const TextStyle(color: Colors.white)),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [correctIdx, 25, 10].map((idx) => GestureDetector(
              onTap: () {
                if(idx == correctIdx) {
                  Navigator.pop(context);
                  _unlockNext();
                }
              },
              child: Image.asset(alphabetData[idx]['image']!, width: 60),
            )).toList()..shuffle(),
          ),
        ),
      ),
    );
  }

  Widget _buildTelescopeCollectionScreen() {
    return Container(
      color: Colors.black.withOpacity(0.9),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ZoomIn(child: Image.asset('assets/images/telescope.png', width: 200)),
            const SizedBox(height: 20),
            const Text("'T' তে টেলিস্কোপ!", style: TextStyle(color: Colors.white, fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                setState(() { hasTelescope = true; isShowingTelescopeAnimation = false; });
                _unlockNext();
              },
              child: const Text("সংগ্রহ করো 🔭"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelescopeOverlay() {
    if (!hasTelescope || unlockedIndex < 20) return const SizedBox();
    return Positioned(
      bottom: 20, right: 20,
      child: Swing(infinite: true, child: Image.asset('assets/telescope.png', width: 60)),
    );
  }

  void _showSuccessMissionDialog() {
    setState(() => isMissionComplete = true);
    _showMissionMessage(
      title: "🎊 মিশন সফল! 🎉",
      content: "তুমি সবগুলো অক্ষর শিখে ফেলেছো!",
      buttonText: "আবার খেলি!",
      onNext: () => setState(() { unlockedIndex = 0; isMissionComplete = false; }),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _videoController?.dispose();
    super.dispose();
  }
}