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
      32, // Gerando 24 vagas para demonstrar a rolagem
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
        return Color(0xff41d10d)!;
      case 'preenchido':
        return Color(0xffdb0b23)!;
      case 'stand by':
        return Color(0xfff5ce0c)!;
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
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: textColor),
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
              fit: BoxFit.fill,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Título e logo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, size: 37, color: Color(0xff4c12de)),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        'Monitoramento',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3a0382),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(
                          color: Color(0xff4c12de),
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
                        : LayoutBuilder(
                            builder: (context, constraints) {
                              int crossAxisCount = (constraints.maxWidth ~/ 110).clamp(2, 6);
                              double childAspectRatio = 2.5;

                              return GridView.builder(
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: childAspectRatio,
                                ),
                                itemCount: _vagas.length,
                                itemBuilder: (context, index) {
                                  final vaga = _vagas[index];
                                  final statusCor = _getCorVaga(vaga['status'] ?? '');
                                  final hsl = HSLColor.fromColor(statusCor);
                                  final bordaCor = hsl
                                        .withLightness((hsl.lightness * 0.8).clamp(0.0, 1.0))
                                        .toColor();
                                  return GestureDetector(
                                    onTap: () => _showVagaDetails(vaga),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _getCorVaga(vaga['status'] ?? ''),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: bordaCor,
                                          width: 0.7,
                                        ),                                                     //Border.all(color: Colors.white, width: 1.5),
                                        /*boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          ),
                                         
                                        ], */
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
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
                              );
                            },
                          ),
                  ),
                ),
                // Legenda fixa na parte inferior (corrigida)
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(top: 24.0, bottom: 16.0), // ✅ Espaçamento em relação ao grid
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xFF280068),
                        width: 2.0,
                      ),
                    /*boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10,
                        offset: Offset(0, -5),
                      ),
                    ], 
                    */
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
                   // 🔄 Alteramos de Column para Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegendItem(
                        color: Colors.green,
                        text: "Livre",
                        textColor: const Color(0xFF280068)),
                      _buildLegendItem(
                        color: Colors.red,
                        text: "Preenchido",
                        textColor: const Color(0xFF280068)),
                      _buildLegendItem(
                        color: Colors.yellow,
                        text: "Stand by",
                        textColor: const Color(0xFF280068)),
                      ],
                    ),
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