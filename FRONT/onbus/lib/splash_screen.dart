import 'package:flutter/material.dart';
import 'dart:async';
import 'login_screen.dart'; 

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
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      },
      child: Stack(
        children: [
          // Imagem de fundo redimensionada dinamicamente
          SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Image.asset(
              'lib/assets/images/Fundo_Splash.PNG',
              fit: BoxFit.fill, // Ajuste da imagem para a tela
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'lib/assets/images/onbus.png',
                  height: 200, // Adjusted size for better fit
                  fit: BoxFit.contain, // Ensures the logo fits properly
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
