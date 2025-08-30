import 'dart:convert';
import 'package:http/http.dart' as http;

class IotService {
  final String baseUrl = "http://SEU_BACKEND_IOT:8080/api/vaga"; // Insira a URL da sua API

  Future<Map<String, dynamic>> getStatusVaga() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Retorna o corpo da resposta como um mapa.
      // Espera-se que a API retorne algo como:
      // { "status": "livre" }
      // { "status": "preenchido" }
      // { "status": "stand by" }
      return json.decode(response.body);
    } else {
      throw Exception("Erro ao buscar o status da vaga: Status ${response.statusCode}");
    }
  }
}