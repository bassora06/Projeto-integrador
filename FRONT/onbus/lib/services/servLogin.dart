import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class LoginService {
  final String authUrl = "$baseUrl/api/v1/auth";

  Future<Map<String, dynamic>> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Email ou senha não podem ser vazios.");
    }

    final response = await http.post(
      Uri.parse('$authUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'email': email,
        'senha': password, // backend expects 'senha'
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      // Normalize userType for existing UI routing
      final rawType = (data['userType'] ?? '').toString().toLowerCase();
      String normalized;
      if (rawType.contains('admin')) {
        normalized = 'adm';
      } else if (rawType.contains('empresa')) {
        normalized = 'empresa';
      } else if (rawType.contains('gestor')) {
        normalized = 'guiche';
      } else {
        normalized = rawType;
      }
      data['userType'] = normalized;
      return data;
    } else if (response.statusCode == 400) {
      throw Exception("Credenciais inválidas.");
    } else {
      throw Exception("Erro ao fazer login: Status ${response.statusCode}");
    }
  }
}
