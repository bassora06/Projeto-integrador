import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class ServicoOnibus {
  final String onibusUrl = "${baseUrl}/api/onibus";

  // MOCK de dados para simular as placas cadastradas
  static List<String> _placasMockadas = ["ABC-1234", "DEF-5678"];

  Future<List<String>> getPlacasOnibus() async {
    final response = await http.get(Uri.parse(onibusUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // Map list of objects to list of placas
      final placas = data
          .map<String>((e) => (e['placa'] ?? '').toString())
          .where((p) => p.isNotEmpty)
          .toList();
      if (placas.isEmpty) {
        // Fallback to mock if API returns empty list (dev convenience)
        return _placasMockadas;
      }
      return placas;
    } else {
      // Fallback to mock data if backend not reachable
      await Future.delayed(const Duration(milliseconds: 300));
      return _placasMockadas;
    }
  }

  Future<bool> cadastrarOnibus(String placa, int usuarioId) async {
    final response = await http.post(
      Uri.parse(onibusUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'placa': placa, 'usuarioId': usuarioId}),
    );
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getOnibusLista() async {
    final response = await http.get(Uri.parse(onibusUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      return [
        {'id': 1, 'placa': 'ABC-1234', 'usuarioId': 24},
        {'id': 2, 'placa': 'DEF-5678', 'usuarioId': 25},
      ];
    }
  }
}
