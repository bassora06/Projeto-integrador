import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onbus/api_config.dart';

class IotService {
  final String vagasUrl = "${baseUrl}/api/vagas"; // URL para o endpoint que retorna todas as vagas

  Future<List<Map<String, dynamic>>> getStatusTodasVagas() async {
    try {
      final response = await http.get(Uri.parse(vagasUrl));
      if (response.statusCode == 200) {
        final List<dynamic> vagaData = json.decode(response.body);
        // Map backend structure (vaga,status,excedida) to UI-friendly fields
        return List<Map<String, dynamic>>.generate(vagaData.length, (index) {
          final v = vagaData[index] as Map<String, dynamic>;
          final rawStatus = (v['status'] ?? '').toString().toLowerCase();
          final status = rawStatus == 'ocupada' ? 'preenchido' : 'livre';
        
          return {
            'id': ' - ${index + 1}', // keeps existing UI label logic
            'status': status,
            'excedida': v['excedida'] == true,
            'vagaKey': v['vaga']?.toString(),
            'distance': 'N/A',
          };
        });
      }
    } catch (_) {
      // fall through to mock below
    }
    // Fallback mock if backend not reachable
    await Future.delayed(const Duration(milliseconds: 300));
    return List.generate(12, (index) => {
          'id': ' - ${index + 1}',
          'status': index % 2 == 0 ? 'livre' : 'preenchido',
          'excedida': false,
          'vagaKey': 'vaga${index + 1}',
          'distance': 'N/A',
        });
  }
}
