import 'package:flutter/material.dart';
import 'package:onbus/services/servOnibus.dart';

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
    if (_placaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("A placa não pode estar vazia.")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final success = await _service.cadastrarOnibus(_placaController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Placa cadastrada com sucesso!")),
        );
        Navigator.of(context).pop(); // Fecha o pop-up
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Erro: Placa já cadastrada ou falha no serviço.")),
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
    return Material(
      color: Colors.transparent, // Adicionado Material com cor transparente
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Cadastrar Ônibus",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text("Placa do Ônibus"),
                  TextField(controller: _placaController),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _cadastrarPlaca,
                    child: const Text("CADASTRAR"),
                  ),
                ],
              ),
            ),
    );
  }
}