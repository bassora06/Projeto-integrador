import 'dart:convert';
//import 'package:http/http.dart' as http;

class IotService {
  final String baseUrl = "http://SEU_BACKEND_IOT:8080/api/vagas"; // URL para o endpoint que retorna todas as vagas

  Future<List<Map<String, dynamic>>> getStatusTodasVagas() async {
    // BACK-END (comentado)
    /*
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> vagaData = json.decode(response.body);
      return vagaData.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Erro ao buscar o status das vagas: Status ${response.statusCode}");
    }
    */

    // MOCK (para testar o front-end sem o back)
    await Future.delayed(const Duration(seconds: 1));
    final mockData = List.generate(
      32,
      (index) {
        final List<String> mockStatuses = ["livre", "preenchido", "stand by"];
        final status = mockStatuses[index % mockStatuses.length];
        return {
          "id": "Vaga ${index + 1}",
          "status": status,
          "distancia": "${(10 + index * 5)} cm",
        };
      },
    );
    return mockData;
  }
}