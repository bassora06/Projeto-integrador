import 'package:flutter/material.dart';
import 'package:onbus/services/servAgendamento.dart';
import 'package:onbus/services/servOnibus.dart';
import 'l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key});

  @override
  State<TelaAgendamento> createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final ServicoAgendamento _service = ServicoAgendamento();
  final ServicoOnibus _onibusService = ServicoOnibus(); 
  final TextEditingController _dadosAdicionaisController = TextEditingController();
  DateTime? _horaChegada;
  DateTime? _DataChegada;
  bool _isLoading = false;
  List<String> _placas = [];
  String? _placaSelecionada;
  // New: doca/vaga selectors
  String _docaSelecionada = 'A';
  String _vagaSelecionada = '1';

  @override
  void initState() {
    super.initState();
    // Defer until after first frame so Localizations and context dependencies are ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _fetchPlacas();
    });
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
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorLoadingData(e.toString()))),
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
    final l10n = AppLocalizations.of(context)!; 
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (_placaSelecionada == null || _horaChegada == null || _DataChegada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.fillAllFields)),
      );
      return;
    }
    if (_horaChegada!.isAfter(_DataChegada!) || _horaChegada!.isAtSameMomentAs(_DataChegada!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Horário de chegada deve ser antes do horário de saída.')),
      );
      return;
    }
    if (auth.userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sessão inválida. Faça login novamente.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _service.agendarDoca(
        doca: _docaSelecionada,
        vaga: _vagaSelecionada,
        placaOnibus: _placaSelecionada!,
        horaChegada: _horaChegada!,
        horaSaida: _DataChegada!,
        idUsuario: auth.userId!,
        dadosAdicionais: _dadosAdicionaisController.text,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.schedulingSuccess)), //l10n.schedulingSuccess
        );
        Navigator.of(context).pop();
      } else {
        throw Exception(l10n.errorSchedulingFailed); //l10n.errorSchedulingFailed
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorLoadingData(e.toString()))),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!; 

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.scheduleVacancy), //l10n.scheduleVacancy
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(l10n.busPlate), //l10n.busPlate
                  DropdownButton<String>(
                    value: _placaSelecionada,
                    hint: Text(l10n.selectPlate), //l10n.selectPlate
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
                  const SizedBox(height: 16),
                  // Doca selector
                  const Text('Doca'),
                  DropdownButton<String>(
                    value: _docaSelecionada,
                    isExpanded: true,
                    items: const ['A','B','C']
                        .map((d) => DropdownMenuItem<String>(value: d, child: Text(d)))
                        .toList(),
                    onChanged: (v) => setState(() => _docaSelecionada = v ?? 'A'),
                  ),
                  const SizedBox(height: 16),
                  // Vaga selector (1..3 para compatibilidade)
                  const Text('Vaga'),
                  DropdownButton<String>(
                    value: _vagaSelecionada,
                    isExpanded: true,
                    items: const ['1','2','3']
                        .map((v) => DropdownMenuItem<String>(value: v, child: Text(v)))
                        .toList(),
                    onChanged: (v) => setState(() => _vagaSelecionada = v ?? '1'),
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.arrivalTime), //l10n.arrivalTime
                  ElevatedButton(
                    onPressed: () => _selecionarHorario(context, isData: true),
                    child: Text(_horaChegada != null ? _horaChegada!.toString() : l10n.selectTime), //l10n.selectTime  
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.arrivalDate), //l10n.arrivalDate
                  ElevatedButton(
                    onPressed: () => _selecionarData(context, isData: false),
                    child: Text(_DataChegada != null ? _DataChegada!.toString() : l10n.selectDate), //l10n.selectDate
                  ),
                  const SizedBox(height: 20),
                  Text(l10n.additionalData ), //l10n.additionalData 
                  TextField(controller: _dadosAdicionaisController),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _enviarAgendamento,
                    child: Text(l10n.schedule), //l10n.schedule 
                  ),
                ],
              ),
            ),
    );
  }
}
