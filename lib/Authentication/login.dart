import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Eita add kora chhilo na

// Class ta StatefulWidget hote hobe, karon ekhane Controllers ache
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // TextEditingController gulo ekhane thakbe
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Sign In Function
  signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(), // trim() dile extra space thakbe na
        password: password.text,
      );
    } catch (e) {
      // Error hole ekhane show korbe
      debugPrint("Login Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Dekhte bhalo lagar jonno padding
        child: Column(
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Email",
              ),
            ),
            const SizedBox(height: 10), // Gap deyar jonno
            TextField(
              controller: password,
              obscureText: true, // Password lukiye rakhar jonno
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signIn, // Sorasori function call kora jay
              child: const Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}