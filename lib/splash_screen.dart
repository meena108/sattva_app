// lib/splash_screen.dart
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to home screen after a delay
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white, // Pure white background
      body: Center(
        child: Image.asset(
          'assets/logo.png', // Path to your .png logo
          width: 300.0, // Adjust the width as needed
          height: 300.0, // Adjust the height as needed
        ),
      ),
    );
  }
}


