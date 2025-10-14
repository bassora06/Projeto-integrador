import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class GuicheRecordsService {
  final String guichesUrl = "$baseUrl/guiches";

  Future<List<Map<String, dynamic>>> getAllGuiches() async {
    final response = await http.get(Uri.parse(guichesUrl));

    if (response.statusCode == 200) {
      final List<dynamic> recordsData = json.decode(response.body);
      return recordsData.map<Map<String, dynamic>>((e) => {
            'id': e['id'],
            'name': e['nome'] ?? e['email'] ?? 'Guiche',
            'email': e['email'],
          }).toList();
    } else {
      throw Exception("Erro ao buscar registros de guichês: Status ${response.statusCode}");
    }
  }
}