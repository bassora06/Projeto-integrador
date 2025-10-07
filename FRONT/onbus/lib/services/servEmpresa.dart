import 'dart:convert';
//import 'package:http/http.dart' as http;

class EnterpriseService {
  final String baseUrl = "http://SEU_BACKEND:8080/api/enterprises";

  /// Busca um único registro de empresa pelo ID.
  Future<Map<String, dynamic>> getEnterpriseById(String id) async {
    // BACK-END (comentado)
    /*
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao buscar empresa: Status ${response.statusCode}");
    }
    */
    
    // MOCK (para testar o front-end sem o back)
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      "id": id,
      "name": "Empresa Mockada",
      "cnpj": "12.345.678/0001-90",
      "email": "mock@email.com",
      "phone": "(11) 91234-5678",
    };
  }

  /// Atualiza os dados de um registro de empresa existente.
  Future<bool> updateEnterprise(String id, Map<String, dynamic> data) async {
    // BACK-END (comentado)
    /*
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(data),
    );
    return response.statusCode == 200;
    */
    
    // MOCK (para testar o front-end sem o back)
    await Future.delayed(const Duration(milliseconds: 500));
    print("Atualizando empresa $id com os dados: $data");
    return true; // Simula uma atualização bem-sucedida
  }
}