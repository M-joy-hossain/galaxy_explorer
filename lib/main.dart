import 'package:flutter/material.dart';
import 'package:galaxy_explorer/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Eita oboshoyei thakte hobe

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Web-e run korar jonno nichei options deya thaktei hobe
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, 
    );
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Firebase Initialization Error: $e");
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
      home: const splash_screen(), 
    );
  }
}