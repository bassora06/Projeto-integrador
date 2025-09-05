import 'dart:convert';
//import 'package:http/http.dart' as http;

class EnterpriseService {
  final String baseUrl = "http://SEU_BACKEND:8080/api/enterprises"; // URL base para todos os endpoints

  /// Busca todos os registros de empresas na API.
  /// Retorna uma lista de mapas com os dados de cada empresa.
  Future<List<Map<String, dynamic>>> getAllEnterprises() async {
    // BACK-END (comentado)
    /*
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> recordsData = json.decode(response.body);
      return recordsData.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Erro ao buscar registros: Status ${response.statusCode}");
    }
    */

    // MOCK (para testar o front-end sem o back)
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      15, // Gera 15 registros de exemplo
      (index) => {
        "id": "EMP-${index + 1}",
        "name": "Empresa de Exemplo ${index + 1}",
        "cnpj": "12.345.678/000${index + 1}-90",
        "email": "empresa${index + 1}@email.com",
        "phone": "(11) 9${1234 + index}-5678",
      },
    );
  }

  /* Busca um único registro de empresa pelo ID.
  Future<Map<String, dynamic>> getEnterpriseById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao buscar empresa: Status ${response.statusCode}");
    }
  }

  /// Cria um novo registro de empresa.
  /// Recebe um mapa de dados e retorna true se o cadastro foi bem-sucedido.
  Future<bool> createEnterprise(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return response.statusCode == 201; // 201 Created é o código de sucesso para criação
  }

  /// Atualiza os dados de um registro de empresa existente.
  /// Recebe o ID e um mapa de dados para atualização.
  Future<bool> updateEnterprise(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return response.statusCode == 200;
  }

  /// Deleta um registro de empresa pelo ID.
  Future<bool> deleteEnterprise(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    return response.statusCode == 200;
  }
*/
}