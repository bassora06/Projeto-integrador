import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class ServicoCadastroGuiche {
  final String gestoresUrl = "${baseUrl}/gestores-entrada";

  Future<bool> cadastrarGuiche(Map<String, dynamic> dados) async {
    // Backend expects: nome,email,senha (cpf is ignored by backend)
    final payload = {
      'nome': dados['nome'],
      'email': dados['email'],
      'senha': dados['senha'],
    };
    try {
      final response = await http.post(
        Uri.parse(gestoresUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payload),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      throw Exception('Falha na comunicação com o servidor: $e');
    }
  }
}
