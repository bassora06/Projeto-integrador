import 'package:flutter/material.dart';
import 'package:onbus/home_page.dart';
import 'package:onbus/login_screen.dart';
import 'package:onbus/termos.dart';
import 'package:onbus/services/servCadGuiche.dart'; 
import 'l10n/app_localizations.dart';

class RegScreenPF extends StatefulWidget {
  const RegScreenPF({super.key});

  @override
  State<RegScreenPF> createState() => _RegScreenPFState();
}

class _RegScreenPFState extends State<RegScreenPF> {
  final ServicoCadastroGuiche _service = ServicoCadastroGuiche();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;
  bool _isLoading = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
        _cpfController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _termsAccepted &&
        _passwordController.text == _confirmPasswordController.text;
  }

  void _showPasswordMismatchDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(l10n.passwordError),
            content: Text(
              l10n.passwordsDoNotMatch,
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
    final l10n = AppLocalizations.of(context)!;
    if (!_isFormValid) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      _showPasswordMismatchDialog(context);
      return;
    }

    setState(() => _isLoading = true);

    final dados = {
      'nome': _nameController.text,
      'cpf': _cpfController.text,
      'email': _emailController.text,
      'senha': _passwordController.text,
    };

    try {
      final sucesso = await _service.cadastrarGuiche(dados);
      if (sucesso) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.success),
            content: Text(l10n.counterRegisteredSuccess),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        throw Exception(l10n.registrationFailed);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.registrationError(e.toString()))),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 40, 0, 104),
      body: Stack(
        children: [
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
                          size: 37,
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
                        Text(
                          l10n.createAccountCounter,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color:  Color.fromARGB(255, 40, 0, 104),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _nameController,
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(l10n.name),
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
                          controller: _cpfController,
                          style: const TextStyle(color:  Color.fromARGB(255, 40, 0, 104)),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(l10n.cpf),
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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text(l10n.email),
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
                            label: Text(l10n.password),
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
                            label: Text(l10n.confirmPassword),
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
                                  child: Text(
                                    l10n.termsAndConditions,
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
                                : Text(
                                    l10n.register,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color:  Colors.white,
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