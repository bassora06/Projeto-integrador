import 'package:flutter/material.dart';
import 'package:onbus/services/servAgendamento.dart';

class TelaAgendamento extends StatefulWidget {
  final String vagaId;

  const TelaAgendamento({super.key, required this.vagaId});

  @override
  State<TelaAgendamento> createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final ServicoAgendamento _service = ServicoAgendamento();
  final TextEditingController _placaOnibusController = TextEditingController();
  final TextEditingController _dadosAdicionaisController = TextEditingController();
  DateTime? _horaChegada;
  DateTime? _horaSaida;
  bool _isLoading = false;

  Future<void> _selecionarHorario(BuildContext context, {required bool isChegada}) async {
    final now = DateTime.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (pickedTime != null) {
      final newTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      setState(() {
        if (isChegada) {
          _horaChegada = newTime;
        } else {
          _horaSaida = newTime;
        }
      });
    }
  }

  void _enviarAgendamento() async {
    if (_placaOnibusController.text.isEmpty || _horaChegada == null || _horaSaida == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos obrigatórios.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _service.agendarDoca(
        vagaId: widget.vagaId,
        placaOnibus: _placaOnibusController.text,
        horaChegada: _horaChegada!,
        horaSaida: _horaSaida!,
        dadosAdicionais: _dadosAdicionaisController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Agendamento realizado com sucesso!")),
        );
        Navigator.of(context).pop();
      } else {
        throw Exception("O agendamento falhou. Tente novamente.");
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Agendar Vaga ${widget.vagaId}"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Placa do Ônibus"),
                  TextField(controller: _placaOnibusController),
                  const SizedBox(height: 20),
                  const Text("Horário de Chegada"),
                  ElevatedButton(
                    onPressed: () => _selecionarHorario(context, isChegada: true),
                    child: Text(_horaChegada != null ? _horaChegada!.toString() : "Selecionar Horário"),
                  ),
                  const SizedBox(height: 20),
                  const Text("Horário de Saída"),
                  ElevatedButton(
                    onPressed: () => _selecionarHorario(context, isChegada: false),
                    child: Text(_horaSaida != null ? _horaSaida!.toString() : "Selecionar Horário"),
                  ),
                  const SizedBox(height: 20),
                  const Text("Dados Adicionais"),
                  TextField(controller: _dadosAdicionaisController),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _enviarAgendamento,
                    child: const Text("AGENDAR"),
                  ),
                ],
              ),
            ),
    );
  }
}