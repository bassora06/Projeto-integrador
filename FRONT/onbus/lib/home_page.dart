import 'package:flutter/material.dart';
import 'package:onbus/config.dart';
import 'package:onbus/cad_empresa.dart';
import 'package:onbus/records.dart';
import 'package:onbus/cad_guiche.dart';
import 'package:onbus/docas_ADM.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Applying scrollable view
          child: Column(
            children: [
              // Abstract curved header
              ClipPath(
                clipper: WaveClipper(reverse: true),
                child: Container(
                  height: 120,
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
                  child: Stack(
                    children: [
                      Positioned(
                        right: 15,
                        bottom: 50,
                        child: IconButton(
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfigPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Main content
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Organização de Docas',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 40, 0, 104),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                        color: Color.fromARGB(255, 40, 0, 104),
                        thickness: 1,
                      ),
                    ),

                    const SizedBox(height: 30),
                    // First row with Docas and Conversar
                    // Single "Docas" button expanded to fill the row as a big rectangular button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                      icon: const Icon(Icons.directions_bus, size: 40),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Text(
                        'Docas',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VagaTela(),
                          ),
                        );
                      },
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Second row with Incluir and Alterar Cadastro
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                          icon: const Icon(Icons.directions_bus, size: 40), //trocar imagem
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                            'Incluir Cadastro',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                            ),
                            elevation: 4,
                          ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Center(
                                      child: Text('Incluir Cadastro'),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const RegScreenPJ(),
                                            ),
                                          );
                                          // Add your first button action here
                                        },
                                        child: const Center(
                                          child: Text(
                                            'Cadastrar Empresa',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 40, 0, 104),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      const RegScreenPF(),
                                            ),
                                          );
                                          // Add your second button action here
                                        },
                                        child: const Center(
                                          child: Text(
                                            'Cadastrar Guichê',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                40,
                                                0,
                                                104,
                                              ),
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: ElevatedButton.icon(
                          icon: const Icon(Icons.directions_bus, size: 40), //trocar imagem
                          label: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Text(
                            'Alterar Registro',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)
                            ),
                            elevation: 4,
                          ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegistrosPag(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Logo at the bottom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Image.asset(
                        'lib/assets/images/onbus.png', // Make sure you have this asset in your project
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),

              // Abstract curved footer
              ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 40, 8, 58),
                        Color.fromARGB(255, 55, 39, 166),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color.fromARGB(255, 40, 0, 104),
                width: 1,
              ),
            ),
            child: Icon(icon, size: 80),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
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
}
