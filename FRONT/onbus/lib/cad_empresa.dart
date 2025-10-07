import 'package:flutter/material.dart';
import 'package:onbus/termos.dart';
import 'package:onbus/services/servCadEmpresa.dart';
import 'l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.passwordError),
        content: Text(l10n.passwordsDoNotMatch),
        actions: <Widget>[
          TextButton(
            child: Text(l10n.ok),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  void _cadastrar() async {
    final l10n = AppLocalizations.of(context)!;
    if (_passwordController.text != _confirmPasswordController.text) {
      _showPasswordMismatchDialog(context);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dadosCadastro = {
        "name": _nameController.text,
        "cnpj": _cnpjController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      };
      await _service.cadastrarEmpresa(dadosCadastro);

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.success),
          content: Text(l10n.companyRegisteredSuccess),
          actions: <Widget>[
            TextButton(
              child: Text(l10n.ok),
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.registrationError(e.toString()))),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.of(context).size;

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
                      // CORREÇÃO: Cor da seta de retorno ajustada para ser visível
                      child: BackButton(color: const Color.fromARGB(255, 40, 0, 104)),
                    ),
                  ),
                  // CORREÇÃO: Logo da OnBus re-adicionado
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0), // Ajuste o padding conforme necessário
                    child: Image.asset(
                      'lib/assets/images/onbus.png',
                      height: 150, // Ajuste a altura conforme necessário
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.createAccountCompany,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color.fromARGB(255, 40, 0, 104), // Cor ajustada para visibilidade
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(l10n.corporateName),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _cnpjController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: Text(l10n.cnpj),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            suffixIcon:
                                const Icon(Icons.check, color: Colors.grey),
                            label: Text(l10n.email),
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
                              onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                            ),
                            label: Text(l10n.password),
                          ),
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
                              onPressed: () => setState(() =>
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword),
                            ),
                            label: Text(l10n.confirmPassword),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (value) =>
                                  setState(() => _termsAccepted = value!),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Termos(),
                                  ),
                                ),
                                child: Text(
                                  l10n.termsAndConditions,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 40, 0, 104),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFormValid
                                  ? const Color.fromARGB(255, 30, 0, 161)
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: _isLoading || !_isFormValid
                                ? null
                                : _cadastrar,
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    l10n.register,
                                    style: const TextStyle(
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
          ),
        ],
      ),
    );
  }
}