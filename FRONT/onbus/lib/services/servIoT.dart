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
        // Map backend structure to UI-friendly fields
        return List<Map<String, dynamic>>.generate(vagaData.length, (index) {
          final v = vagaData[index] as Map<String, dynamic>;
          // 1. Pega o status do MongoDB e coloca em minúsculo (o default é 'livre')
          final rawStatus = (v['status'] ?? 'livre').toString().toLowerCase(); 
          
          // 2. Mapeia para o nome usado no front ('preenchido'), senão, usa o rawStatus (incluindo 'expirada')
          final statusParaUI = rawStatus == 'ocupada' ? 'preenchido' : rawStatus; 

          // RETORNO CORRETO DO MAPA DA VAGA (DADOS REAIS)
          return {
            'id': ' - ${index + 1}', // Se o Mongo ID for 'vaga1', você pode usar 'v['_id']' aqui
            'status': statusParaUI, // Agora pode ser 'livre', 'preenchido', 'expirada', etc.
            'distance': 'N/A',
          };
        });
      }
    } catch (_) {
      // Cai no mock se o backend não estiver acessível (por erro de comunicação ou status != 200)
      // fall through to mock below
    }
    
    // Fallback mock if backend not reachable - Corrigido para 3 status
    await Future.delayed(const Duration(milliseconds: 300));
    return List.generate(12, (index) => {
          'id': ' - ${index + 1}',
          // CORREÇÃO: Usa index % 3 para ciclar entre 'livre', 'preenchido' e 'expirada' no mock.
          'status': ['livre', 'preenchido', 'expirada'][index % 3], 
          'distance': 'N/A',
        });
  }
}