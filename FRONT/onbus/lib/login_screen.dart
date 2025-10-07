import 'package:flutter/material.dart';
import 'package:onbus/home_page.dart';
import 'package:onbus/cad_guiche.dart';
import 'package:onbus/cad_empresa.dart';
import 'package:onbus/services/servLogin.dart';
import 'package:onbus/docas_Empresa.dart';
import 'package:onbus/docas_ADM.dart';
import 'package:onbus/docas_Guiche.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Import para detectar plataforma
import 'dart:io' show Platform; // Import para detectar desktop
import 'l10n/app_localizations.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginService _loginService = LoginService();
  bool _obscurePassword = true;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _tipoController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() => _isLoading = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      final authData = await _loginService.login(
        _emailController.text,
        _passwordController.text,
        _tipoController.text,
      );

      final userType = authData['userType'];

      Widget destinationPage;
      switch (userType) {
        case 'ROLE_ADMIN':
          destinationPage = const HomePage();
          break;
        case 'ROLE_EMPRESA':
          destinationPage = const VagaTelaEmpresa();
          break;
        case 'ROLE_GESTORENTRADA':
          // Lógica para verificar se é desktop/web
          if (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
            destinationPage = const VagaTelaGuicheDesktop();
          } else {
            destinationPage = const VagaTela();
          }
          break;
        default:
          throw Exception(l10n.unknownUserType);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => destinationPage),
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.unexpectedError(e.toString()))),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
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
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Image.asset(
                      'lib/assets/images/onbus.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),

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
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.check, color: Colors.grey),
                            label: Text(
                              l10n.email,
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
                            label: Text(
                              l10n.password,
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
                             
                            },
                            child: Text(
                              l10n.forgotPassword,
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
                            onPressed: _isLoading ? null : _handleLogin,
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
                                child: _isLoading
                                    ? const CircularProgressIndicator(color: Colors.white)
                                    : Text(
                                        l10n.login,
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