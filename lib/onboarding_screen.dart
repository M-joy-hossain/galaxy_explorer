import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Earth_learning.dart';
import 'package:galaxy_explorer/Senior_cadet_section/Senior_dashboard.dart';
import 'package:galaxy_explorer/junior_cadet_item.dart';

class onboarding_screen extends StatefulWidget {
  const onboarding_screen({super.key});

  @override
  State<onboarding_screen> createState() => _onboarding_screenState();
}

class _onboarding_screenState extends State<onboarding_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // পুরো স্ক্রিন জুড়ে ব্যাকগ্রাউন্ড ইমেজ
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Senior_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Choose your class :",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 12, 12, 12),
                ),
              ),
              const SizedBox(height: 40),
            
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // ১ম বাটন
                    SizedBox(
                      width: double.maxFinite,  
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: const Color.fromARGB(255, 150, 131, 237),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const junior_cadet_item()),
                          );
                        },
                        child: const Text(
                          "Play – Class 5",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20), // দুই বাটনের মাঝখানের গ্যাপ

                    // ২য় বাটন
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          backgroundColor: const Color.fromARGB(255, 148, 130, 225),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const SeniorDashboard()),
                          );
                        },
                        child: const Text(
                          "Class 6 – 10",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}