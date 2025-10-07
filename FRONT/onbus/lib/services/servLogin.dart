import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl = "http://localhost:8080/api/v1/auth/login";

  Future<Map<String, dynamic>> login(String email, String password, String tipo) async {
    // BACK-END (comentado)
    
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'email': email,
        'password': password,
        'tipo': tipo,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao fazer login: Status ${response.statusCode}");
    }
    
    // MOCK (para testar o front-end sem o back)
    // await Future.delayed(const Duration(seconds: 2));
    
    // // Simula falha de login para credenciais inválidas
    // if (email.isEmpty || password.isEmpty) {
    //   throw Exception("Email ou senha não podem ser vazios.");
    // }
    // if (email == "erro@login.com") {
    //   throw Exception("Credenciais inválidas. Verifique seu email e senha.");
    // }

    // // Simula o retorno do back-end para diferentes tipos de usuário
    // if (email == "adm@onbus.com") {
    //   return {"message": "Login bem-sucedido!", "token": "mock-token-adm", "userType": "adm"};
    // } else if (email == "empresa@onbus.com") {
    //   return {"message": "Login bem-sucedido!", "token": "mock-token-empresa", "userType": "empresa"};
    // } else if (email == "guiche@onbus.com") {
    //   return {"message": "Login bem-sucedido!", "token": "mock-token-guiche", "userType": "guiche"};
    // } else {
    //   throw Exception("Credenciais inválidas. Verifique seu email e senha.");
    // }
  }
}