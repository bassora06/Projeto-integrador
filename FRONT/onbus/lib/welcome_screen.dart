import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'reg_screen_pj.dart';
import 'reg_screen_pf.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipPath(
              clipper: WaveClipper(reverse: true),
              child: Container(
                height: 80,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 55, 39, 166),
                      Color.fromARGB(255, 40, 8, 58),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              ),
              const SizedBox(height: 80),
              
              Image.asset(
                'lib/assets/images/onbus.png',
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              const Text(
                'Bem vindo ao OnBus!',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 40, 0, 104),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),
              
              // ENTRAR Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 30, 0, 161),
                          Color.fromARGB(255, 40, 0, 104),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // REGISTER Buttons Column
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    // PF Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegScreenPF()),
                        );
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 30, 0, 161),
                              Color.fromARGB(255, 40, 0, 104),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'REGISTRAR (PF)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    
                    // PJ Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegScreenPJ()),
                        );
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 30, 0, 161),
                              Color.fromARGB(255, 40, 0, 104),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'REGISTRAR (PJ)',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image.asset(
                  'lib/assets/images/onbusW.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final bool reverse;

  WaveClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    final path = Path();
    
    if (reverse) {
      path.moveTo(0, size.height);
      path.quadraticBezierTo(
        size.width * 0.25, size.height - 30,
        size.width * 0.5, size.height - 20);
      path.quadraticBezierTo(
        size.width * 0.75, size.height - 10,
        size.width, size.height - 30);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.quadraticBezierTo(
        size.width * 0.25, 30,
        size.width * 0.5, 20);
      path.quadraticBezierTo(
        size.width * 0.75, 10,
        size.width, 30);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}