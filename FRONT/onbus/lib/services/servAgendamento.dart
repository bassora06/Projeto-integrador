import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';
import 'package:onbus/services/servOnibus.dart';

class ServicoAgendamento {
  final String reservasUrl = "${baseUrl}/reservas";
  final _onibusService = ServicoOnibus();

  Future<bool> agendarDoca({
    required String doca,
    required String vaga,
    required String placaOnibus,
    required DateTime horaChegada,
    required DateTime horaSaida,
    required int idUsuario,
    String? dadosAdicionais,
  }) async {
    // Find bus id by placa
    final lista = await _onibusService.getOnibusLista();
    final match = lista.firstWhere(
      (e) => (e['placa']?.toString() ?? '').toUpperCase() == placaOnibus.toUpperCase(),
      orElse: () => {},
    );
    if (match.isEmpty || match['id'] == null) {
      throw Exception('Ônibus não encontrado para a placa $placaOnibus');
    }
    final int idOnibus = (match['id'] is num) ? (match['id'] as num).toInt() : int.parse(match['id'].toString());

    final resp = await http.post(
      Uri.parse(reservasUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'idOnibus': idOnibus,
        'idUsuario': idUsuario,
        'horaChegada': horaChegada.toIso8601String(),
        'horaSaida': horaSaida.toIso8601String(),
        'doca': doca,
        'vaga': vaga,
      }),
    );

    if (resp.statusCode == 200 || resp.statusCode == 201) return true;
    try {
      final decoded = json.decode(resp.body);
      final msg = decoded is Map && decoded['message'] != null ? decoded['message'].toString() : 'Erro ao agendar';
      throw Exception(msg);
    } catch (_) {
      throw Exception('Erro ao agendar: HTTP ${resp.statusCode}');
    }
  }
}
