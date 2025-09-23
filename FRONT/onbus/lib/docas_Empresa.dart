import 'package:flutter/material.dart';
import 'dart:async';
import 'package:onbus/services/servIoT.dart';
import 'package:onbus/telaAgendamento.dart';
import 'package:onbus/telaCadastroOnibus.dart';

class VagaTelaEmpresa extends StatefulWidget {
  const VagaTelaEmpresa({super.key});

  @override
  State<VagaTelaEmpresa> createState() => _VagaTelaEmpresaState();
}

class _VagaTelaEmpresaState extends State<VagaTelaEmpresa> {
  final IotService _iotService = IotService();
  List<Map<String, dynamic>> _vagas = [];
  Timer? _timer;
  bool _isLoading = true;

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

  void _fetchVagas() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 1));
    final mockData = List.generate(
      32,
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
  }

  Color _getCorVaga(String status) {
    switch (status) {
      case 'livre':
        return const Color(0xff41d10d);
      case 'preenchido':
        return const Color(0xffdb0b23);
      case 'stand by':
        return const Color(0xfff5ce0c);
      default:
        return Colors.grey[400]!;
    }
  }

  void _showSchedulingPopup() {
    if (_vagas.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Agendar Chegada"),
            content: const Text("Deseja cadastrar uma nova placa de ônibus antes de agendar?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const TelaAgendamento(),
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      );
                    },
                  );
                },
                child: const Text("Não, continuar agendando"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o pop-up atual
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const TelaCadastroOnibus(),
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      );
                    },
                  );
                },
                child: const Text("Sim, cadastrar ônibus"),
              ),
            ],
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Não há vagas disponíveis no momento.")),
      );
    }
  }

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
                                  return GestureDetector(
                                    onTap: () => _showVagaDetails(vaga),
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _getCorVaga(vaga['status'] ?? ''),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.white, width: 1.5),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.symmetric(vertical: 24.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 30, 0, 161),
                        Color.fromARGB(255, 40, 0, 104),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                    onPressed: _showSchedulingPopup,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'AGENDAR CHEGADA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xFF280068),
                      width: 2.0,
                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildLegendItem(
                            color: const Color(0xff41d10d),
                            text: "Livre",
                            textColor: const Color(0xFF280068),
                          ),
                          _buildLegendItem(
                            color: const Color(0xffdb0b23),
                            text: "Preenchido",
                            textColor: const Color(0xFF280068),
                          ),
                          _buildLegendItem(
                            color: const Color(0xfff5ce0c),
                            text: "Stand by",
                            textColor: const Color(0xFF280068),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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