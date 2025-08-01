import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Start a timer for 3 seconds
    Timer(const Duration(seconds: 3), () {
      // Check if the widget is still mounted before navigating
      // This prevents errors if the user pops the screen before the timer finishes
      if (!mounted) return;

      // Get the current authenticated user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        // No user is logged in, navigate to Login Screen
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // User is logged in, navigate to Dashboard Screen
        Navigator.pushReplacementNamed(context, '/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
          // Optional dark overlay
          Container(color: Colors.black.withOpacity(0.4)),
          // Logo + Title
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/img.png', // Ensure this image path is correct
                  height: 120,
                ),
                const SizedBox(height: 20),
                const Text(
                  'RAJASTHAN HUB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}