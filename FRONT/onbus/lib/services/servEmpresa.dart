import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class EnterpriseService {
  final String empresasUrl = "${baseUrl}/empresas";

  /// Busca um único registro de empresa pelo ID.
  Future<Map<String, dynamic>> getEnterpriseById(String id) async {
    final response = await http.get(Uri.parse('$empresasUrl/$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      // Map backend fields (nome,email,cnpj) to UI expectations
      return {
        'id': data['id'],
        'name': data['nome'],
        'cnpj': data['cnpj'],
        'email': data['email'],
        'phone': '',
      };
    } else {
      throw Exception("Erro ao buscar empresa: Status ${response.statusCode}");
    }
  }

  /// Atualiza os dados de um registro de empresa existente.
  Future<bool> updateEnterprise(String id, Map<String, dynamic> data) async {
    // Map UI keys (name) to backend keys (nome)
    final payload = {
      'nome': data['name'],
      'email': data['email'],
      'cnpj': data['cnpj'],
    };

    final response = await http.put(
      Uri.parse('$empresasUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(payload),
    );
    return response.statusCode == 200;
  }
}
