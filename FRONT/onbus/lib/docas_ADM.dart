import 'package:flutter/material.dart';
import 'dart:async';

class VagaTela extends StatefulWidget {
  const VagaTela({super.key});

  @override
  State<VagaTela> createState() => _VagaTelaState();
}

class _VagaTelaState extends State<VagaTela> {
  List<Map<String, dynamic>> _vagas = [];
  Timer? _timer;
  bool _isLoading = true;

  final List<String> _mockStatuses = ["livre", "preenchido", "stand by"];
  int _mockStatusIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchVagas();

    // Atualiza os dados a cada 1 minuto
    _timer = Timer.periodic(const Duration(minutes: 1), (_) => _fetchVagas());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchVagas() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 600));
    final mockData = List.generate(
      24,
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
        return Colors.green.shade600;
      case 'preenchido':
        return Colors.red.shade600;
      case 'stand by':
        return Colors.amber.shade700;
      default:
        return Colors.grey.shade500;
    }
  }

  IconData _getIconVaga(String status) {
    switch (status) {
      case 'livre':
        return Icons.check_circle;
      case 'preenchido':
        return Icons.block;
      case 'stand by':
        return Icons.pause_circle_filled;
      default:
        return Icons.help;
    }
  }

  void _showVagaDetails(Map<String, dynamic> vaga) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar')),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String text,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF280068),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _vagaCard(Map<String, dynamic> vaga) {
    final status = (vaga['status'] ?? '') as String;
    final cor = _getCorVaga(status);

    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showVagaDetails(vaga),
        child: Container(
          decoration: BoxDecoration(
            color: cor,
            border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: LayoutBuilder(
            builder: (_, c) {
              final wide = c.maxWidth >= 200;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(_getIconVaga(status), color: Colors.white, size: wide ? 20 : 18),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          vaga['id'] ?? 'N/A',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: wide ? 16 : 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.85), width: 1),
                    ),
                    child: Text(
                      status.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: wide ? 12 : 11,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    vaga['distancia'] ?? '—',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontWeight: FontWeight.w600,
                      fontSize: wide ? 12 : 11,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  double _targetCardWidth(Size s) {
    if (s.width < 360) return s.width - 32;
    if (s.width < 420) return 180;
    if (s.width < 540) return 200;
    if (s.width < 760) return 220;
    if (s.width < 1024) return 240;
    if (s.width < 1400) return 260;
    return 300;
  }

  double _cardAspect(Size s) {
    if (s.width < 360) return 1.40;
    if (s.width < 420) return 1.55;
    if (s.width < 540) return 1.70;
    if (s.width < 760) return 1.9;
    if (s.width < 1024) return 2.1;
    if (s.width < 1400) return 2.25;
    return 2.4;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    final bottomSafe = media.padding.bottom;

    final targetWidth = _targetCardWidth(size);
    final aspect = _cardAspect(size);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/images/fundo_Docas.PNG',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                    child: Column(
                      children: const [
                        Text(
                          'Monitoramento de Vagas',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF280068),
                          ),
                        ),
                        SizedBox(height: 12),
                        Divider(color: Color(0xFF280068), thickness: 1),
                      ],
                    ),
                  ),
                ),
                if (_isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CircularProgressIndicator(color: Colors.white)),
                  )
                else ...[
                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: targetWidth,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: aspect,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => _vagaCard(_vagas[index]),
                        childCount: _vagas.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFF280068), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 8,
                            offset: const Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Column(
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
                          Wrap(
                            spacing: 12,
                            runSpacing: 10,
                            children: [
                              _buildLegendItem(
                                color: Colors.green.shade600,
                                text: "Livre",
                                icon: Icons.check_circle,
                              ),
                              _buildLegendItem(
                                color: Colors.red.shade600,
                                text: "Preenchido",
                                icon: Icons.block,
                              ),
                              _buildLegendItem(
                                color: Colors.amber.shade700,
                                text: "Stand by",
                                icon: Icons.pause_circle_filled,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12 + bottomSafe),
                      child: Center(
                        child: Image.asset(
                          'lib/assets/images/onbusW.png',
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
