import 'package:flutter/material.dart';
import 'package:onbus/services/servOnibus.dart';
import 'l10n/app_localizations.dart';

class TelaCadastroOnibus extends StatefulWidget {
  const TelaCadastroOnibus({super.key});

  @override
  State<TelaCadastroOnibus> createState() => _TelaCadastroOnibusState();
}

class _TelaCadastroOnibusState extends State<TelaCadastroOnibus> {
  final ServicoOnibus _service = ServicoOnibus();
  final TextEditingController _placaController = TextEditingController();
  bool _isLoading = false;

  void _cadastrarPlaca() async {
    final l10n = AppLocalizations.of(context)!;

    if (_placaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.plateCannotBeEmpty)),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final success = await _service.cadastrarOnibus(_placaController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.plateRegisteredSuccess)),
        );
        Navigator.of(context).pop(); 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.plateRegistrationError)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Material(
      color: Colors.transparent,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.registerBus, 
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.busPlate),
                  TextField(controller: _placaController),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _cadastrarPlaca,
                    child: Text(l10n.register),
                  ),
                ],
              ),
            ),
    );
  }
}