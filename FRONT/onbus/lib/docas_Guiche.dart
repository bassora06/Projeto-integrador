import 'package:flutter/material.dart';
import 'package:onbus/services/servIoT.dart';
import 'package:onbus/login_screen.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:onbus/providers/locale_provider.dart';
import 'l10n/app_localizations.dart';

// TELA PRINCIPAL (STATEFUL WIDGET)
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

  //variável para controlar o estado da sidebar (expandida ou recolhida)
  bool _isSideBarCollapsed = false;

  @override
  void initState() {
    super.initState();
    _fetchGuicheName();
    // Schedule fetch after first frame to ensure InheritedWidgets (e.g., Localizations) are available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchVagas();
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (!mounted) return;
        _fetchVagas();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // função que ativa a redução/expansão da sidebar
  void _toggleSideBar() {
    setState(() {
      _isSideBarCollapsed = !_isSideBarCollapsed;
    });
  }

  void _fetchGuicheName() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _guicheName = 'Guichê Exemplo';
      });
    }
  }

  void _fetchVagas() async {
    if (!mounted) return;
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
        final l10n = AppLocalizations.of(context)!;
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

  void _handleLogout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void _changeLanguage() {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.selectLanguage),
        content: DropdownButtonFormField<Locale>(
          value: localeProvider.locale ?? Localizations.localeOf(context),
          items: AppLocalizations.supportedLocales.map((locale) {
            String languageName = '';
            switch (locale.languageCode) {
              case 'pt': languageName = l10n.languageNamePortuguese; break;
              case 'en': languageName = l10n.languageNameEnglish; break;
              case 'es': languageName = l10n.languageNameSpanish; break;
              case 'fr': languageName = l10n.languageNameFrench; break;
              case 'de': languageName = l10n.languageNameGerman; break;
              case 'it': languageName = l10n.languageNameItalian; break;
            }
            return DropdownMenuItem(value: locale, child: Text(languageName));
          }).toList(),
          onChanged: (Locale? newLocale) {
            if (newLocale != null) {
              localeProvider.setLocale(newLocale);
              Navigator.of(context).pop();
            }
          },
        ),
      ),
    );
  }

  void _showVagaDetails(Map<String, dynamic> vaga) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          // Trecho com a funcionalidade de redução/expansão da sidebar c/ AnimatedContainer
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            width: _isSideBarCollapsed ? 90 : screenSize.width * 0.25,
            child: SideBarGuiche(
              guicheName: _guicheName,
              filtroAtual: _filtroStatus,
              l10n: l10n,
              isCollapsed: _isSideBarCollapsed,
              onToggle: _toggleSideBar,
              onFiltroChanged: (novoFiltro) {
                setState(() {
                  _filtroStatus = novoFiltro;
                });
              },
              onChangeLanguage: _changeLanguage,
              onLogout: _handleLogout,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        'lib/assets/images/guiche_back.jpg',
                        fit: BoxFit.cover,
                      ),
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
                                            border: Border.all(
                                              color: vaga['excedida'] == true ? const Color(0xfff5ce0c) : Colors.white,
                                              width: 2,
                                            ),
                                          ),
                                          child: Text(
                                            (vaga['id']?.replaceFirst('-', l10n.vacancy) ?? 'N/A') + (vaga['excedida'] == true ? ' ⚠' : ''),
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

// Widget da sidebar separado em um stateless widget
class SideBarGuiche extends StatelessWidget {
  final String guicheName;
  final String filtroAtual;
  final AppLocalizations l10n;
  final bool isCollapsed; 
  final VoidCallback onToggle; 
  final ValueChanged<String> onFiltroChanged;
  final VoidCallback onChangeLanguage;
  final VoidCallback onLogout;

  const SideBarGuiche({
    super.key,
    required this.guicheName,
    required this.filtroAtual,
    required this.l10n,
    required this.isCollapsed,
    required this.onToggle,
    required this.onFiltroChanged,
    required this.onChangeLanguage,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xff1C00B5),
      child: Column(
        crossAxisAlignment: isCollapsed ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
        children: [
          // Botão de expandir/recolher
          IconButton(
            onPressed: onToggle,
            icon: Icon(
              isCollapsed ? Icons.menu : Icons.menu_open,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 30),

          // Conteúdo que muda com base no estado da sidebar
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: isCollapsed
                ? _buildCollapsedContent(context)
                : _buildExpandedContent(context),
          ),

          const Spacer(),

          // Ações do rodapé
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
             transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: isCollapsed
                ? _buildCollapsedActions()
                : _buildExpandedActions(),
          ),
        ],
      ),
    );
  }

  // Conteúdo para a sidebar expandida
  Widget _buildExpandedContent(BuildContext context) {
    return Column(
      key: const ValueKey('expanded'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            'lib/assets/images/onbus-branc.png',
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          guicheName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30),
        
        //_FiltrosOriginais(
        //  l10n: l10n,
        //  filtroAtual: filtroAtual,
        //  onFiltroChanged: onFiltroChanged,
        //),
         _FiltrosDropdown(
           l10n: l10n,
           filtroAtual: filtroAtual,
           onFiltroChanged: onFiltroChanged,
         ),
      ],
    );
  }

  // Conteúdo para a sidebar recolhida (só os ícones)
  Widget _buildCollapsedContent(BuildContext context) {
    return Column(
      key: const ValueKey('collapsed'),
      children: [
        const SizedBox(height: 20),
        const Icon(Icons.directions_bus, color: Colors.white, size: 40),
        const SizedBox(height: 40),
        // Botão da filtragem reduzido
        IconButton(
          icon: const Icon(Icons.filter_list, color: Colors.white, size: 30),
          tooltip: l10n.filtering,
          onPressed: () {
            // Pop-up com dropdown dos filtros
            showDialog(
              context: context,
              builder: (BuildContext dialogContext) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  content: SizedBox(
                    width: 250, 
                    child: _FiltrosDropdown( // Widget responsável pela filtragem em dropdown
                      l10n: l10n,
                      filtroAtual: filtroAtual,
                      onFiltroChanged: (novoFiltro) {
                        onFiltroChanged(novoFiltro);
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
  
  // Ações do rodapé expandidas
  Widget _buildExpandedActions() {
    return Column(
      key: const ValueKey('expanded_actions'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: onChangeLanguage,
          icon: const Icon(Icons.language, size: 32),
          label: Text(l10n.changeLanguage),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: onLogout,
          icon: const Icon(Icons.logout, size: 32),
          label: const Text('Sair da Conta'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }

  // Ações do rodapé reduzidas
  Widget _buildCollapsedActions() {
    return Column(
      key: const ValueKey('collapsed_actions'),
      children: [
        IconButton(
          icon: const Icon(Icons.language, size: 30, color: Colors.white),
          tooltip: l10n.changeLanguage,
          onPressed: onChangeLanguage,
        ),
        const SizedBox(height: 8),
        IconButton(
          icon: const Icon(Icons.logout, size: 30, color: Colors.white),
          tooltip: 'Sair da Conta',
          onPressed: onLogout,
        ),
      ],
    );
  }
}


// Widgets de filtro (incluindo o dropdown com esferas)
class _FiltrosOriginais extends StatelessWidget {
  final AppLocalizations l10n;
  final String filtroAtual;
  final ValueChanged<String> onFiltroChanged;

  const _FiltrosOriginais({
    required this.l10n,
    required this.filtroAtual,
    required this.onFiltroChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xff871CE8), width: 2.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.filtering,
            style: const TextStyle(
              color: Color(0xFF280068),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 10),
          _buildLegendItem(
            color: const Color(0xff41d10d),
            text: l10n.free,
            ativo: filtroAtual == "Livre",
            onTap: () => onFiltroChanged("Livre"),
          ),
          const SizedBox(height: 10),
          _buildLegendItem(
            color: const Color(0xffdb0b23),
            text: l10n.occupied,
            ativo: filtroAtual == "Preenchido",
            onTap: () => onFiltroChanged("Preenchido"),
          ),
          const SizedBox(height: 10),
          _buildLegendItem(
            color: const Color(0xfff5ce0c),
            text: l10n.standBy,
            ativo: filtroAtual == "Stand by",
            onTap: () => onFiltroChanged("Stand by"),
          ),
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: () => onFiltroChanged("Todos"),
              child: Text(
                l10n.removeFilter,
                style: TextStyle(
                  color: const Color(0xFF280068),
                  fontWeight: filtroAtual == "Todos" ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String text,
    required bool ativo,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: ativo ? Border.all(color: Colors.black, width: 2) : null,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF280068),
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

class _FiltrosDropdown extends StatelessWidget {
  final AppLocalizations l10n;
  final String filtroAtual;
  final ValueChanged<String> onFiltroChanged;

  const _FiltrosDropdown({
    required this.l10n,
    required this.filtroAtual,
    required this.onFiltroChanged,
  });

  Widget _buildSphere(Color color) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> filtroOptions = {
      'Todos': l10n.all,
      'Livre': l10n.free,
      'Preenchido': l10n.occupied,
      'Stand by': l10n.standBy,
    };

    final Map<String, Color> filtroColors = {
      'Todos': Colors.grey[600]!,
      'Livre': const Color(0xff41d10d),
      'Preenchido': const Color(0xffdb0b23),
      'Stand by': const Color(0xfff5ce0c),
    };

    return Container(
      margin: const EdgeInsets.only(top: 24.0, bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xff871CE8), width: 2.0),
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: filtroAtual,
        onChanged: (String? newValue) {
          if (newValue != null) {
            onFiltroChanged(newValue);
          }
        },
        items: filtroOptions.keys.map<DropdownMenuItem<String>>((String key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Row(
              children: [
                _buildSphere(filtroColors[key]!),
                Text(filtroOptions[key]!),
              ],
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          labelText: l10n.filtering,
          labelStyle: const TextStyle(
            color: Color(0xFF280068),
            fontWeight: FontWeight.bold,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
