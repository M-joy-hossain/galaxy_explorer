import 'package:flutter/material.dart';
import 'package:galaxy_explorer/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try { 
    await Firebase.initializeApp(
     // options: DefaultFirebaseOptions.currentPlatform,  
    );
  } catch (e) {
    print("Firebase Error: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Kept exactly as your original class name
      home: const splash_screen(), 
    );
  }
}