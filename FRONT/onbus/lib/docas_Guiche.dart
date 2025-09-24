import 'package:flutter/material.dart';
import 'package:onbus/services/servIoT.dart';
import 'package:onbus/login_screen.dart';
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
  String _guicheName = ''; // Adicionado para armazenar o nome do guichê

  @override
  void initState() {
    super.initState();
    // 1. Busca os dados iniciais quando a tela é carregada
    _fetchGuicheName();
    _fetchVagas();

    // 2. Configura um Timer para atualizar os dados a cada 5 segundos
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchVagas();
    });
  }

  @override
  void dispose() {
    // 3. Cancela o Timer quando o widget é descartado para evitar memory leaks
    _timer?.cancel();
    super.dispose();
  }

  // Simula a busca do nome do guichê
  void _fetchGuicheName() async {
    // Simula uma requisição de rede
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _guicheName = 'Guichê Exemplo'; // Nome mockado
      });
    }
  }

  void _fetchVagas() async {
    // Mantém o estado de loading apenas na primeira carga
    if (_isLoading) {
      setState(() => _isLoading = true);
    }
    
    try {
      final fetchedVagas = await _iotService.getStatusTodasVagas();
      if (mounted) {
        setState(() {
          _vagas = fetchedVagas;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao carregar vagas: $e")),
        );
      }
    } finally {
      if (mounted && _isLoading) {
        setState(() => _isLoading = false);
      }
    }
  }

  List<Map<String, dynamic>> get _vagasFiltradas {
    if (_filtroStatus == 'Todos' || _filtroStatus == 'todos') {
      return _vagas;
    }
    // Convertendo o filtro para minúsculas para garantir a correspondência
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
  
  // Método para o botão de sair
  void _handleLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Método para a internacionalização (simulado)
  void _changeLanguage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Funcionalidade de internacionalização em desenvolvimento.")),
    );
  }

  // Novo método para exibir os detalhes da vaga em um pop-up
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
                const SizedBox(height: 10),
                // 4. Utilizando a variável _guicheName para exibir o nome
                Text(
                  _guicheName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                /*const Text(
                  "Filtros",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),*/
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color(0xff871CE8),
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Filtragem:',
                        style: TextStyle(
                          color: Color(0xFF280068),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
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
                    ],
                  ),
                ),
                const Spacer(),
                Column(
                // crossAxisAlignment.start alinha os filhos (os botões) à esquerda
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botão de Mudar Idioma
                  TextButton.icon(
                    onPressed: _changeLanguage,
                    icon: const Icon(Icons.language, size: 30), // Ícone
                    label: const Text('Mudar Idioma'),        // Texto ao lado do ícone
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // Define a cor do ícone e do texto
                      textStyle: const TextStyle(
                        fontSize: 16, // Tamanho da fonte
                      ),
                    ),
                  ),

                  // Espaçamento entre os botões
                  const SizedBox(height: 8), 

                  // Botão de Sair
                  TextButton.icon(
                    onPressed: _handleLogout,
                    icon: const Icon(Icons.logout, size: 30),
                    label: const Text('Sair da Conta'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'lib/assets/images/guiche_back.jpg',
                      fit: BoxFit.cover,
                    ),
                    Padding(
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
                                      return GestureDetector(
                                        onTap: () => _showVagaDetails(vaga),
                                        child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: _getCorVaga(vaga['status'] ?? ''),
                                            borderRadius: BorderRadius.circular(8),
                                            border: Border.all(color: Colors.white, width: 2),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}