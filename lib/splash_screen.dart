import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Authentication/wrapper.dart';
import 'package:galaxy_explorer/onboarding_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:lottie/lottie.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showText = false;
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          showText = true;
        });
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Use Get.offAll instead of Navigator
        Get.offAll(() => const Wrapper());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(child: Lottie.asset('assets/animations/Rocket_Lounch.json')),
          if (showText)
            Positioned(
              bottom: 80,
              child: Text(
                "Galaxy Explorer",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),
            ),
        ],
      ),
    );
  }
}