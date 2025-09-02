import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:onbus/services/iot_service.dart'; // BACK-END (comentado)

class VagaTela extends StatefulWidget {
  const VagaTela({super.key});

  @override
  State<VagaTela> createState() => _VagaTelaState();
}

class _VagaTelaState extends State<VagaTela> {
  // final IotService _iotService = IotService(); // BACK-END (comentado)
  List<Map<String, dynamic>> _vagas = [];
  Timer? _timer;
  bool _isLoading = true;

  // MOCK de dados para simular o back-end
  final List<String> _mockStatuses = ["livre", "preenchido", "stand by"];
  int _mockStatusIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchVagas();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchVagas();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Simula a busca das vagas na API e atualiza a lista
  void _fetchVagas() async {
    setState(() => _isLoading = true);

    // MOCK (substitua por sua chamada de API)
    await Future.delayed(const Duration(seconds: 1));
    final mockData = List.generate(
      24, // Gerando 24 vagas para demonstrar a rolagem
      (index) {
        final status = _mockStatuses[(_mockStatusIndex + index) % _mockStatuses.length];
        return {
          "id": "Vaga ${index + 1}",
          "status": status,
          "distancia": "${(10 + index * 5)} cm",
        };
      },
    );

    setState(() {
      _vagas = mockData;
      _mockStatusIndex = (_mockStatusIndex + 1) % _mockStatuses.length;
      _isLoading = false;
    });

    // BACK-END (comentado)
    /*
    try {
      final vagas = await _iotService.getStatusTodasVagas();
      setState(() {
        _vagas = vagas;
        _isLoading = false;
      });
    } catch (e) {
      print("Erro ao buscar vagas: $e");
      setState(() {
        _isLoading = false;
      });
    }
    */
  }

  // Mapeia o status em texto para a cor correspondente
  Color _getCorVaga(String status) {
    switch (status) {
      case 'livre':
        return Colors.green[400]!;
      case 'preenchido':
        return Colors.red[400]!;
      case 'stand by':
        return Colors.yellow[400]!;
      default:
        return Colors.grey[400]!;
    }
  }

  // Exibe o pop-up com os detalhes da vaga
  void _showVagaDetails(Map<String, dynamic> vaga) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(vaga['id'] ?? 'Detalhes da Vaga', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Status: ${vaga['status']?.toUpperCase() ?? 'N/A'}"),
              const SizedBox(height: 8),
              Text("Distância: ${vaga['distancia'] ?? 'N/A'}"),
              const SizedBox(height: 20),
              // Adicione mais detalhes aqui se a API retornar mais dados
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  // Helper para criar os itens da legenda
  Widget _buildLegendItem({required Color color, required String text, Color textColor = Colors.white}) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: textColor), // Usando o textColor aqui
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'lib/assets/images/fundo_Docas.PNG',
              fit: BoxFit.fill, // Ajuste da imagem para a tela
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Título e logo
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 20.0),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                      'Monitoramento de Vagas',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 40, 0, 104),
                      ),
                      ),
                      const SizedBox(height: 20),
                      const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                        color: Color.fromARGB(255, 40, 0, 104),
                        thickness: 1,
                      ),
                      ),
                    ],
                  ),
                ),
                // Grid de Vagas (Agora rolável)
                Expanded(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: _isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.white))
                    : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // More columns for smaller items
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 2.4, // Rectangular shape (width > height)
                      ),
                      itemCount: _vagas.length,
                      itemBuilder: (context, index) {
                        final vaga = _vagas[index];
                        return GestureDetector(
                        onTap: () => _showVagaDetails(vaga),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                          color: _getCorVaga(vaga['status'] ?? ''),
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.white, width: 1.4),
                          /*boxShadow: [
                            BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                            ),
                          ],
                          */
                          ),
                          child: Text(
                          vaga['id'] ?? 'N/A',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          ),
                        ),
                        );
                      },
                      ),
                  ),
                ),
                // Legenda fixa na parte inferior
                Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF280068),
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status das Vagas:',
                      style: TextStyle(
                        color: Color(0xFF280068),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildLegendItem(color: Colors.green, text: "Livre", textColor: const Color(0xFF280068)),
                    const SizedBox(height: 8),
                    _buildLegendItem(color: Colors.red, text: "Preenchido", textColor: const Color(0xFF280068)),
                    const SizedBox(height: 8),
                    _buildLegendItem(color: Colors.yellow, text: "Stand by", textColor: const Color(0xFF280068)),
                  ],
                ),
                ),

                // Logo fixa na parte inferior
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Image.asset(
                    'lib/assets/images/onbusW.png',
                    height: 50,
                    fit: BoxFit.contain,
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