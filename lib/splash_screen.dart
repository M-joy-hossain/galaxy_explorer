// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:galaxy_explorer/onboarding_screen.dart';
import 'package:lottie/lottie.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splash_screen> {
  bool showText = false;

  @override
  void initState() {
    super.initState();

    // Show text after rocket launches (2 seconds)
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showText = true;
      });
    });

    // Navigate to onboarding after full splash (3 seconds)
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const onboarding_screen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Rocket animation
          Center(child: Lottie.asset('assets/animations/Rocket_Lounch.json')),

          // Show text when showText = true
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
     // backgroundColor: Colors.black,
    );
  }
}
