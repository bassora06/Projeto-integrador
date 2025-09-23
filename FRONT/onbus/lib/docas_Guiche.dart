import 'package:flutter/material.dart';
import 'package:onbus/services/servIoT.dart';
import 'dart:async';

class VagaTelaGuicheDesktop extends StatefulWidget {
  const VagaTelaGuicheDesktop({super.key});

  @override
  State<VagaTelaGuicheDesktop> createState() => _VagaTelaGuicheDesktopState();
}

class _VagaTelaGuicheDesktopState extends State<VagaTelaGuicheDesktop> {
  final IotService _iotService = IotService();
  List<Map<String, dynamic>> _vagas = [];
  String _filtroStatus = 'Todos';
  Timer? _timer;
  bool _isLoading = true;

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
    try {
      final fetchedVagas = await _iotService.getStatusTodasVagas();
      setState(() {
        _vagas = fetchedVagas;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao carregar vagas: $e")),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  List<Map<String, dynamic>> get _vagasFiltradas {
    if (_filtroStatus == 'Todos') {
      return _vagas;
    }
    return _vagas.where((vaga) => vaga['status'] == _filtroStatus.toLowerCase()).toList();
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

  Widget _buildLegendItem({
    required Color color,
    required String text,
    required Color textColor,
    required bool ativo,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: ativo
                  ? Border.all(color: Colors.black, width: 2)
                  : null,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: ativo ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          // Área de Navegação (Sidebar)
          Container(
            width: screenSize.width * 0.25,
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xff871CE8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Image.asset(
                    'lib/assets/images/onbus-branc.png',
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Filtros",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
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
                    // Change Row to Column for vertical layout
                    Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLegendItem(
                      color: const Color(0xff41d10d),
                      text: "Livre",
                      textColor: const Color(0xFF280068),
                      ativo: _filtroStatus == "Livre",
                      onTap: () {
                        setState(() {
                        _filtroStatus = "Livre";
                        });
                      },
                      ),
                      const SizedBox(height: 10),
                      _buildLegendItem(
                      color: const Color(0xffdb0b23),
                      text: "Preenchido",
                      textColor: const Color(0xFF280068),
                      ativo: _filtroStatus == "Preenchido",
                      onTap: () {
                        setState(() {
                        _filtroStatus = "Preenchido";
                        });
                      },
                      ),
                      const SizedBox(height: 10),
                      _buildLegendItem(
                      color: const Color(0xfff5ce0c),
                      text: "Stand by",
                      textColor: const Color(0xFF280068),
                      ativo: _filtroStatus == "Stand by",
                      onTap: () {
                        setState(() {
                        _filtroStatus = "Stand by";
                        });
                      },
                      ),
                    ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                    onPressed: () {
                      setState(() {
                      _filtroStatus = "Todos";
                      });
                    },
                    child: Text(
                      "Remover Filtro",
                      style: TextStyle(
                      color: const Color(0xFF280068),
                      fontWeight: _filtroStatus == "Todos" ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    ),
                  ],
                  ),
                ),
              ],
            ),
          ),

          // Grid de Vagas (Conteúdo principal)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/assets/images/onbusW.png',
                        height: 120,
                      ),
                      const SizedBox(height: 50),
                      Expanded(
                        child: _isLoading
                            ? const Center(child: CircularProgressIndicator(color: Color(0xff4c12de)))
                            : GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 2.4,
                                ),
                                itemCount: _vagasFiltradas.length,
                                itemBuilder: (context, index) {
                                  final vaga = _vagasFiltradas[index];
                                  return Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: _getCorVaga(vaga['status'] ?? ''),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      vaga['id'] ?? 'N/A',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}