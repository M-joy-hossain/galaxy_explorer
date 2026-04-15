import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_explorer/onboarding_screen.dart';
import 'package:galaxy_explorer/Authentication/login.dart';
// Apnar home page ebong login page-er import gulo niche add koren
// import 'package:galaxy_explorer/home_page.dart'; 
// import 'package:galaxy_explorer/login_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Firebase authentication er state check korbe
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Connection check korar jonno (optional kintu bhalo)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // User jodi login kora thake (data thakle)
          if (snapshot.hasData) {
            return onboarding_screen();
            //const Center(child: Text("Home Page (Replace with your HomePage class)")); 
            // return const HomePage(); // Ekhane apnar HomePage call koren
          } 
          // User login na thakle
          else {
            return Login(); // Ekhane apnar LoginPage call koren
            //const Center(child: Text("Login Page (Replace with your LoginPage class)"));
            // return const LoginPage(); // Ekhane apnar LoginPage call koren
          }
        },
      ),
    );
  }
}