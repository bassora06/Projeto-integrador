import 'package:flutter/material.dart';
import 'package:onbus/services/servIoT.dart';
import 'package:onbus/login_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:onbus/providers/locale_provider.dart';
import 'l10n/app_localizations.dart';

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
  String _guicheName = ''; 

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
        _guicheName = 'Guichê Exemplo';
      });
    }
  }

  void _fetchVagas() async {
    final l10n = AppLocalizations.of(context)!;

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
          SnackBar(content: Text(l10n.errorLoadingVacancies(e.toString()))),
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
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.selectLanguage),
          content: DropdownButtonFormField<Locale>(
            value: localeProvider.locale ?? Localizations.localeOf(context),
            items: AppLocalizations.supportedLocales.map((locale) {
              String languageName = '';
              switch (locale.languageCode) {
                case 'pt':
                  languageName = l10n.languageNamePortuguese;
                  break;
                case 'en':
                  languageName = l10n.languageNameEnglish;
                  break;
                case 'es':
                  languageName = l10n.languageNameSpanish;
                  break;
                case 'fr':
                  languageName = l10n.languageNameFrench;
                  break;
                case 'de':
                  languageName = l10n.languageNameGerman;
                  break;
                case 'it':
                  languageName = l10n.languageNameItalian;
                  break;
              }
              return DropdownMenuItem(
                value: locale,
                child: Text(languageName),
              );
            }).toList(),
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                localeProvider.setLocale(newLocale);
                Navigator.of(context).pop();
              }
            },
          ),
        );
      },
    );
  }

  // Novo método para exibir os detalhes da vaga em um pop-up
  void _showVagaDetails(Map<String, dynamic> vaga) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('${l10n.vacancy}${vaga['id'] ?? 'N/A'}', style: const TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${l10n.status}: ${vaga['status']?.toUpperCase() ?? 'N/A'}'),
              const SizedBox(height: 8),
              Text('${l10n.distance}: ${vaga['distance'] ?? 'N/A'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.close),
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
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: ativo
                      ? Border.all(color: Colors.black, width: 2)
                      : null,
                ),
                child: Icon(
                  Icons.circle,
                  color: Colors.transparent, 
                  size: 0,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: ativo ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: screenSize.width * 0.25,
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xff1C00B5),
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
                      Text(
                        l10n.filtering,
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
                            text: l10n.free,
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
                            text: l10n.occupied,
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
                            text: l10n.standBy,
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
                              l10n.removeFilter,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botão de Mudar Idioma
                  TextButton.icon(
                    onPressed: _changeLanguage,
                    icon: const Icon(Icons.language, size: 32), 
                    label: Text(l10n.changeLanguage),        
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, 
                      textStyle: const TextStyle(
                        fontSize: 20, 
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), 
                  // Botão de Sair
                  TextButton.icon(
                    onPressed: _handleLogout,
                    icon: const Icon(Icons.logout, size: 32),
                    label: const Text('Sair da Conta'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 20,
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
              padding: const EdgeInsets.all(32.0),
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
                                            vaga['id']?.replaceFirst('-', l10n.vacancy) ?? 'N/A',
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