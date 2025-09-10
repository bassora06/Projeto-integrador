import 'dart:convert';
//import 'package:http/http.dart' as http;

class ServicoAgendamento {
  final String baseUrl = "http://SEU_BACKEND:8080/api/agendamentos";

  Future<bool> agendarDoca({
    required String vagaId,
    required String placaOnibus,
    required DateTime horaChegada,
    required DateTime horaSaida,
    String? dadosAdicionais,
  }) async {
    // BACK-END (comentado)
    /*
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'vagaId': vagaId,
        'placaOnibus': placaOnibus,
        'horaChegada': horaChegada.toIso8601String(),
        'horaSaida': horaSaida.toIso8601String(),
        'dadosAdicionais': dadosAdicionais,
      }),
    );
    return response.statusCode == 201; // 201 Created é o código de sucesso para agendamento
    */

    // MOCK (para testar o front-end sem o back)
    await Future.delayed(const Duration(seconds: 1));
    print("Agendamento para Vaga $vagaId realizado com sucesso:");
    print("  Placa do Ônibus: $placaOnibus");
    print("  Chegada: $horaChegada");
    print("  Saída: $horaSaida");
    print("  Dados Adicionais: $dadosAdicionais");
    return true; // Simula um agendamento bem-sucedido
  }
}