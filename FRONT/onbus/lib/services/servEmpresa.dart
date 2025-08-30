import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceEmpresa {
  final String baseUrl = "http://SEU_BACKEND:8080/api/enterprise"; // adicionar a url backend real

  Future<Map<String, dynamic>> getEnterpriseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao buscar empresa: ${response.statusCode}");
    }
  }

  Future<bool> updateEnterprise(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );

    return response.statusCode == 200;
  }
}

//Busca dados com base no id e atualiza com o PUT

