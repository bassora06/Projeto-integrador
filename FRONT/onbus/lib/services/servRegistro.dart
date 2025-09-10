import 'dart:convert';
//import 'package:http/http.dart' as http;

class RecordsService {
  //final String baseUrl = "http://SEU_BACKEND:8080/api/enterprises"; // URL para o endpoint que retorna a lista de empresas

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
}