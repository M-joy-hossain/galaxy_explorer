import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_explorer/Authentication/forgot.dart';
import 'package:galaxy_explorer/Authentication/signup.dart';
import 'package:galaxy_explorer/Authentication/wrapper.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Input Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Focus Nodes to handle keyboard flow
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool isLoading = false;
  bool obscurePassword = true;

  // Sign In Logic
  Future<void> signIn() async {
    FocusScope.of(context).unfocus();

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Successful login - Go to Wrapper
      if (mounted) {
        Get.offAll(() => const Wrapper());
      }
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      }

      Get.snackbar(
        "Error",
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: SafeArea(
        // ৩য় অপশন: GestureDetector পুরোপুরি রিমুভ করা হয়েছে টার্চ কনফ্লিক্ট এড়াতে
        child: ListView(
          // স্ক্রিন ধরে নিচে টান দিলেই কীবোর্ড হাইড হয়ে যাবে (GestureDetector এর বিকল্প)
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            const SizedBox(height: 60),

            // Logo or App Title
            const Icon(Icons.rocket_launch, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 10),
            const Text(
              "Galaxy Explorer",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 50),

            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Login to continue your space journey",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 35),

            /// EMAIL FIELD
            TextField(
              controller: emailController,
              focusNode: emailFocus,
              autofocus: false, // এটি false থাকবে
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// PASSWORD FIELD
            TextField(
              controller: passwordController,
              focusNode: passwordFocus,
              autofocus: false,
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => signIn(),
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            // Forgot Password link
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.to(() => const Forgot()),
                child: const Text("Forgot password?"),
              ),
            ),

            const SizedBox(height: 20),

            /// LOGIN BUTTON
            SizedBox(
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3)
                )
                    : const Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 30),

            /// REGISTER LINK
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? ", style: TextStyle(color: Colors.black54)),
                GestureDetector(
                  onTap: () => Get.to(() => const Signup()),
                  child: const Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}