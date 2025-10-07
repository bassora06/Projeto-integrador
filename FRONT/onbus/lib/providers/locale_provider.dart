import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart'; 

class LocaleProvider with ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    if (!AppLocalizations.supportedLocales.contains(newLocale)) return;

    _locale = newLocale;
    notifyListeners();
  }
}