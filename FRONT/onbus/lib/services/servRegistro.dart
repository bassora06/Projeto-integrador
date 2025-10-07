import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class RecordsService {
  final String empresasUrl = "${baseUrl}/empresas"; // Lista de empresas

  Future<List<Map<String, dynamic>>> getAllEnterprises() async {
    final response = await http.get(Uri.parse(empresasUrl));
    if (response.statusCode == 200) {
      final List<dynamic> recordsData = json.decode(response.body);
      // Map backend fields (id,nome) -> UI expected keys (id,name)
      return recordsData.map<Map<String, dynamic>>((e) => {
            'id': e['id'],
            'name': e['nome'] ?? e['email'] ?? 'Empresa',
            'cnpj': e['cnpj'],
            'email': e['email'],
          }).toList();
    } else {
      throw Exception("Erro ao buscar registros: Status ${response.statusCode}");
    }
  }
}
