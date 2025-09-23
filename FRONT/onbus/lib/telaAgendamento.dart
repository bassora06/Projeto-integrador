import 'package:flutter/material.dart';
import 'package:onbus/services/servAgendamento.dart';
import 'package:onbus/services/servOnibus.dart'; // Importando o serviço de ônibus

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key});

  @override
  State<TelaAgendamento> createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final ServicoAgendamento _service = ServicoAgendamento();
  final ServicoOnibus _onibusService = ServicoOnibus(); // Instância do serviço de ônibus
  final TextEditingController _dadosAdicionaisController = TextEditingController();
  DateTime? _horaChegada;
  DateTime? _DataChegada;
  bool _isLoading = false;
  List<String> _placas = [];
  String? _placaSelecionada;

  @override
  void initState() {
    super.initState();
    _fetchPlacas();
  }

  // Novo método para buscar as placas de ônibus
  void _fetchPlacas() async {
    setState(() => _isLoading = true);
    try {
      final fetchedPlacas = await _onibusService.getPlacasOnibus();
      setState(() {
        _placas = fetchedPlacas;
        _placaSelecionada = _placas.isNotEmpty ? _placas.first : null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao carregar placas: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selecionarHorario(BuildContext context, {required bool isData}) async {
    final now = DateTime.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(now),
    );
    if (pickedTime != null) {
      final newTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      setState(() {
        if (isData) {
          _horaChegada = newTime;
        } else {
          _DataChegada = newTime;
        }
      });
    }
  }

  Future<void> _selecionarData(BuildContext context, {required bool isData}) async {
    final now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (pickedDate != null) {
      setState(() {
        if (isData) {
          _horaChegada = pickedDate;
        } else {
          _DataChegada = pickedDate;
        }
      });
    }
  }

  void _enviarAgendamento() async {
    if (_placaSelecionada == null || _horaChegada == null || _DataChegada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, preencha todos os campos obrigatórios.")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _service.agendarDoca(
        vagaId: "id_da_vaga_atribuida_pelo_backend",
        placaOnibus: _placaSelecionada!,
        horaChegada: _horaChegada!,
        horaSaida: _DataChegada!,
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
        title: const Text("Agendar Vaga"),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Placa do Ônibus"),
                  DropdownButton<String>(
                    value: _placaSelecionada,
                    hint: const Text("Selecione a placa"),
                    isExpanded: true,
                    items: _placas.map((String placa) {
                      return DropdownMenuItem<String>(
                        value: placa,
                        child: Text(placa),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _placaSelecionada = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text("Horário de Chegada"),
                  ElevatedButton(
                    onPressed: () => _selecionarHorario(context, isData: true),
                    child: Text(_horaChegada != null ? _horaChegada!.toString() : "Selecionar Horário"),
                  ),
                  const SizedBox(height: 20),
                  const Text("Data de Chegada"),
                  ElevatedButton(
                    onPressed: () => _selecionarData(context, isData: false),
                    child: Text(_DataChegada != null ? _DataChegada!.toString() : "Selecionar Data"),
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