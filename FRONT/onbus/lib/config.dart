import 'package:flutter/material.dart';
import 'package:onbus/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:onbus/providers/locale_provider.dart';
import 'l10n/app_localizations.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    // 1. Buscando o provider para poder usá-lo no widget
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClipper(reverse: true),
              child: Container(
                height: 120,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 55, 39, 166),
                      Color.fromARGB(255, 40, 8, 58),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Center(child: Icon(Icons.settings, size: 40, color: Color.fromARGB(255, 40, 0, 104))),
                    const SizedBox(height: 8),
                    Center(
                      // 2. Usando a chave de tradução para o título
                      child: Text(
                        AppLocalizations.of(context)!.settings,
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 40, 0, 104),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // 3. Usando a chave de tradução para o label
                    Text(
                      AppLocalizations.of(context)!.language,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // 4. Dropdown corrigido
                    DropdownButtonFormField<Locale>(
                      value: localeProvider.locale ?? Localizations.localeOf(context),
                      items: AppLocalizations.supportedLocales.map((locale) {
                        String languageName = '';
                        switch (locale.languageCode) {
                          case 'pt':
                            languageName = 'Português (Brasil)';
                            break;
                          case 'en':
                            languageName = 'English (US)';
                            break;
                          case 'es':
                            languageName = 'Español';
                            break;
                          case 'fr':
                            languageName = 'Français';
                            break;
                          case 'de':
                            languageName = 'Deutsch';
                            break;
                          case 'it':
                            languageName = 'Italiano';
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
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      isExpanded: true,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 40, 0, 104),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false, 
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.exit,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class WaveClipper extends CustomClipper<Path> {
  final bool reverse;
  WaveClipper({this.reverse = false});
  @override
  Path getClip(Size size) {
    final path = Path();
    if (reverse) {
      path.moveTo(0, size.height);
      path.quadraticBezierTo(size.width * 0.25, size.height - 30, size.width * 0.5, size.height - 20);
      path.quadraticBezierTo(size.width * 0.75, size.height - 10, size.width, size.height - 30);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else {
      path.moveTo(0, 0);
      path.quadraticBezierTo(size.width * 0.25, 30, size.width * 0.5, 20);
      path.quadraticBezierTo(size.width * 0.75, 10, size.width, 30);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    }
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}