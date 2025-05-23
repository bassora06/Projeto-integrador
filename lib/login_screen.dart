import 'package:flutter/material.dart';
import 'package:onbus/home_page.dart';
import 'package:onbus/reg_screen_pf.dart';
import 'package:onbus/reg_screen_pj.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo redimensionada dinamicamente
          SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Image.asset(
              'lib/assets/images/fundo_Padrao.PNG',
              fit: BoxFit.fill, // Ajuste da imagem para a tela
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Botão voltar
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Image.asset(
                      'lib/assets/images/onbus.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Login Form
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 40,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 0, 104),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            label: const Text(
                              'Senha',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 0, 104),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // Add forgot password functionality
                            },
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xff281537),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              // Add login functionality
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              print('Email: $email, Password: $password');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 30, 0, 161),
                                    Color.fromARGB(255, 40, 0, 104),
                                  ],
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'ENTRAR',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "Ainda não tem uma conta?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Pessoa Física option
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegScreenPF(),
                              ),
                            );
                          },
                          child: const Text(
                            "Cadastre-se como Pessoa Física",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Pessoa Jurídica option
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegScreenPJ(),
                              ),
                            );
                          },
                          child: const Text(
                            "Cadastre-se como Pessoa Jurídica",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*class WaveClipper extends CustomClipper<Path> {
  final bool reverse;

  WaveClipper({this.reverse = false});

  @override
  Path getClip(Size size) {
    final path = Path();

    if (reverse) {
      path.moveTo(0, size.height);
      path.quadraticBezierTo(
        size.width * 0.25,
        size.height - 30,
        size.width * 0.5,
        size.height - 20,
      );
      path.quadraticBezierTo(
        size.width * 0.75,
        size.height - 10,
        size.width,
        size.height - 30,
      );
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.25, 30, size.width * 0.5, 20);
      path.quadraticBezierTo(size.width * 0.75, 10, size.width, 30);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}*/
}
