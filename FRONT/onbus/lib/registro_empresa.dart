import 'package:flutter/material.dart';
import 'package:onbus/termos.dart';

class EmpresaReg extends StatefulWidget {
  const EmpresaReg({super.key});

  @override
  State<EmpresaReg> createState() => _EmpresaRegState();
}

class _EmpresaRegState extends State<EmpresaReg> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
        _cnpjController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _termsAccepted &&
        _passwordController.text == _confirmPasswordController.text;
  }

  void _showPasswordMismatchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Erro de Senha'),
            content: const Text(
              'As senhas digitadas não coincidem. Por favor, verifique e tente novamente.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              child: Column(
                children: [
                  // Top Wave
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
                      child: Stack(
                        children: [
                          Positioned(
                            left: 15,
                            bottom: 15,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Logo
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      'lib/assets/images/onbus.png',
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),

                  // Registration Form
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, 
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Criar Conta - Empresa',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 40, 0, 104),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(
                              'Razão Social',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 0, 104),
                              ),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _cnpjController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(
                              'CNPJ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 0, 104),
                              ),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(
                              'Email',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 0, 104),
                              ),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
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
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            label: const Text(
                              'Confirmar Senha',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 40, 0, 104),
                              ),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (bool? value) {
                                setState(() {
                                  _termsAccepted = value ?? false;
                                });
                              },
                              activeColor: const Color.fromARGB(
                                255,
                                40,
                                0,
                                104,
                              ),
                            ),
                            Expanded(
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Termos(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Declaro que li e concordo com os termos de uso',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _isFormValid
                                      ? const Color.fromARGB(255, 40, 0, 104)
                                      : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed:
                                _isFormValid
                                    ? () {
                                      if (_passwordController.text !=
                                          _confirmPasswordController.text) {
                                        _showPasswordMismatchDialog(context);
                                      } else {
                                        final name = _nameController.text;
                                        final email = _emailController.text;
                                        final password =_passwordController.text;
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                          title: const Text('Sucesso'),
                                          content: Text(
                                            'Empresa $name cadastrada com sucesso!\nEmail: $email\nSenha: $password',
                                          ),
                                          actions: [
                                            TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('OK'),
                                            ),
                                          ],
                                          ),
                                        );
                                      }
                                    }
                                    : null,
                            child: const Text(
                              'CADASTRAR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
}
*/
