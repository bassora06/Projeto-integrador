import 'dart:convert';
//import 'package:http/http.dart' as http;

class ServicoOnibus {
  final String baseUrl = "http://SEU_BACKEND:8080/api/onibus";

  // MOCK de dados para simular as placas cadastradas
  static List<String> _placasMockadas = ["ABC-1234", "DEF-5678"];

  Future<List<String>> getPlacasOnibus() async {
    // BACK-END (comentado)
    /*
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<String>();
    } else {
      throw Exception("Erro ao buscar placas de ônibus.");
    }
    */
    await Future.delayed(const Duration(milliseconds: 500));
    return _placasMockadas;
  }

  Future<bool> cadastrarOnibus(String placa) async {
    // BACK-END (comentado)
    /*
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'placa': placa}),
    );
    return response.statusCode == 201;
    */
    await Future.delayed(const Duration(milliseconds: 500));
    if (_placasMockadas.contains(placa)) {
      return false; // Simula placa já cadastrada
    }
    _placasMockadas.add(placa);
    return true;
  }
}