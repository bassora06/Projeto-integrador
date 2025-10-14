import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class GuicheService {
  final String guichesUrl = "$baseUrl/guiches";

  /// Busca um único registro de guiche pelo ID.
  Future<Map<String, dynamic>> getCounterById(String id) async {
    final response = await http.get(Uri.parse('$guichesUrl/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return {
        'id': data['id'],
        'name': data['nome'],
        'email': data['email'],
      };
    } else {
      throw Exception("Erro ao buscar guiche: Status ${response.statusCode}");
    }
  }

  Future<bool> updateGuiche(String id, Map<String, dynamic> data) async {
    final payload = {
      'nome': data['name'],
      'email': data['email'],
    };

    final response = await http.put(
      Uri.parse('$guichesUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(payload),
    );
    return response.statusCode == 200;
  }
}