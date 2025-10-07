import 'dart:convert';
//import 'package:http/http.dart' as http;

class ServicoCadastroEmpresa {
  final String baseUrl = "http://SEU_BACKEND:8080/api/cadastro-empresa";

  Future<bool> cadastrarEmpresa(Map<String, dynamic> dados) async {
    // BACK-END (comentado)
    /*
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(dados),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Falha na comunicação com o servidor: $e');
    }
    */
    
    // MOCK (para testar o front-end sem o back)
    await Future.delayed(const Duration(seconds: 1));
    print("Dados de empresa enviados para o servidor: $dados");
    
    // Simula uma resposta de sucesso do servidor
    return true;
  }
}