import 'dart:convert';
import 'package:http/http.dart' as http;

class IotService {
  final String baseUrl = "http://SEU_BACKEND_IOT:8080/api/vagas"; // URL para o endpoint que retorna todas as vagas

  Future<List<Map<String, dynamic>>> getStatusTodasVagas() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Espera-se que a API retorne uma lista de objetos, como:
      // [ { "id": "1", "status": "livre" }, { "id": "2", "status": "preenchido" } ]
      final List<dynamic> vagaData = json.decode(response.body);
      return vagaData.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Erro ao buscar o status das vagas: Status ${response.statusCode}");
    }
  }
}