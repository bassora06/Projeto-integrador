import 'package:flutter/material.dart';
import 'package:onbus/home_page.dart';
import 'package:onbus/login_screen.dart';
import 'package:onbus/termos.dart';
import 'package:onbus/services/servCadEmpresa.dart';

class RegScreenPJ extends StatefulWidget {
  const RegScreenPJ({super.key});

  @override
  State<RegScreenPJ> createState() => _RegScreenPJState();
}

class _RegScreenPJState extends State<RegScreenPJ> {
  final ServicoCadastroEmpresa _service = ServicoCadastroEmpresa();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  bool _isLoading = false;
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

  void _cadastrar() async {
    if (!_isFormValid) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      _showPasswordMismatchDialog(context);
      return;
    }

    setState(() => _isLoading = true);

    final dados = {
      'nome': _nameController.text,
      'cnpj': _cnpjController.text,
      'email': _emailController.text,
      'senha': _passwordController.text,
    };

    try {
      final sucesso = await _service.cadastrarEmpresa(dados);
      if (sucesso) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Sucesso'),
            content: const Text('Empresa cadastrada com sucesso!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        throw Exception("O cadastro falhou. Tente novamente.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro no cadastro: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 40, 0, 104),
      body: Stack(
        children: [
          // Background Image
          SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Image.asset(
              'lib/assets/images/fundo_Padrao.PNG',
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Botão de voltar
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color:  Color.fromARGB(255, 40, 0, 104),
                          size: 30,
                        ),
                        onPressed: () => Navigator.pop(context),
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
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Razão Social'),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 40, 0, 104),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color.fromARGB(255, 40, 0, 104)),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _cnpjController,
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('CNPJ'),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 40, 0, 104),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color.fromARGB(255, 40, 0, 104)),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Email'),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 40, 0, 104),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Color.fromARGB(255, 40, 0, 104)),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:  Color.fromARGB(255, 40, 0, 104),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            label: const Text('Senha'),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 40, 0, 104),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color:  Color.fromARGB(255, 40, 0, 104)),
                            ),
                          ),
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color:  Color.fromARGB(255, 40, 0, 104),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            label: const Text('Confirmar Senha'),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color:  Color.fromARGB(255, 40, 0, 104),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color:  Color.fromARGB(255, 40, 0, 104)),
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
                              activeColor:  Color.fromARGB(255, 40, 0, 104),
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
                                      color:  Color.fromARGB(255, 40, 0, 104),
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
                                  _isFormValid ? Color.fromARGB(255, 30, 0, 161) : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: _isLoading || !_isFormValid
                                ? null
                                : _cadastrar,
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color:  Color.fromARGB(255, 40, 0, 104),
                                  )
                                : const Text(
                                    'CADASTRAR',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:  Color.fromARGB(255, 40, 0, 104),
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
          ),
        ],
      ),
    );
  }
}

// O WaveClipper é mantido comentado como solicitado
/*
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
*/