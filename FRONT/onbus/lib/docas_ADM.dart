import 'package:flutter/material.dart';
import 'dart:async';
import 'package:onbus/services/servIot.dart';

class VagaTela extends StatefulWidget {
  const VagaTela({super.key});

  @override
  State<VagaTela> createState() => _VagaTelaState();
}

class _VagaTelaState extends State<VagaTela> {
  final IotService _iotService = IotService();
  String _status = "stand by"; // Status inicial
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Inicia a busca pelo status da vaga quando a tela é carregada
    _fetchStatus();
    // Configura um timer para buscar o status a cada 5 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchStatus();
    });
  }

  @override
  void dispose() {
    // Cancela o timer quando a tela é descartada
    _timer?.cancel();
    super.dispose();
  }

  // Busca o status da vaga na API
  void _fetchStatus() async {
    try {
      final data = await _iotService.getStatusVaga();
      setState(() {
        _status = data['status'] ?? 'stand by';
      });
    } catch (e) {
      // Em caso de erro, a vaga pode ser mantida em 'stand by' ou você
      // pode adicionar uma lógica de erro, como um ícone.
      print("Erro ao buscar status da vaga: $e");
    }
  }

  // Mapeia o status em texto para a cor correspondente
  Color _getCorVaga() {
    switch (_status) {
      case 'livre':
        return Colors.green;
      case 'preenchido':
        return Colors.red;
      case 'stand by':
        return Colors.yellow;
      default:
        return Colors.grey; // Cor padrão para status desconhecido
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/fundo_Docas.PNG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título da tela
                const Text(
                  "Status da Vaga",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Representação visual da vaga
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: _getCorVaga(),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Exibe o status em texto
                Text(
                  _status.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.black,
                        offset: Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}