import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_explorer/onboarding_screen.dart';
import 'package:galaxy_explorer/Authentication/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Data load hobar somoy loading screen
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User login kora thakle onboarding_screen-e jabe
        if (snapshot.hasData) {
          return const onboarding_screen(); 
        } 
        // User login na thakle Login page-e jabe
        else {
          return const Login();
        }
      },
    );
  }
}