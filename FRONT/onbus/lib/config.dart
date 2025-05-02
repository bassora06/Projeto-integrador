import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  String? _selectedLanguage = 'Português (Brasil)';
  final List<String> _languages = [
    'Português (Brasil)',
    'English (US)',
    'Espanhol',
    'Francês',
    'Alemão',
    'Italiano',
    
  ];

  void _logout() {
    // Add your logout logic here
    print('User logged out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
            // Header with back button and title
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white,),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  
                  
                ],
              ),
              ),
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Center(child: Icon(Icons.settings, size: 40, color: Color.fromARGB(255, 40, 0, 104))),
                    const SizedBox(height: 8),
                    const Center(child: Text(
                      'Configurações',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 40, 0, 104),
                      ),
                    ),
                    ),
                    const SizedBox(height: 40,),
                    const Text(
                      'Idioma',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    material.DropdownButtonFormField<String>(
                      value: _selectedLanguage,
                      items: _languages.map((String value) {
                        return material.DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLanguage = newValue;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      isExpanded: true,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 40, 0, 104),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _logout,
                        child: const Text(
                          'SAIR',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
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