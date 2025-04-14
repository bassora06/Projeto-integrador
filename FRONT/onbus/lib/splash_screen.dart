import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart'; // Make sure the path is correct

class OnBusSplashScreen extends StatefulWidget {
  const OnBusSplashScreen({super.key});

  @override
  State<OnBusSplashScreen> createState() => _OnBusSplashScreenState();
}

class _OnBusSplashScreenState extends State<OnBusSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C1E88), // Top purple
              Colors.white,
              Color(0xFF2C1E88), // Bottom purple
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/assets/images/onbus.png',
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
