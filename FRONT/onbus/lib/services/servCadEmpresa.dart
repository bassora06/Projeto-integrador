import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class ServicoCadastroEmpresa {
  final String empresasUrl = "${baseUrl}/empresas";

  Future<bool> cadastrarEmpresa(Map<String, dynamic> dados) async {
    // Map front keys (name,password) to backend (nome,senha)
    final payload = {
      'nome': dados['name'],
      'email': dados['email'],
      'senha': dados['password'],
      'cnpj': dados['cnpj'],
    };

    try {
      final response = await http.post(
        Uri.parse(empresasUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Falha na comunicação com o servidor: $e');
    }
  }
}
