// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get askRegisterBusBeforeScheduling =>
      'Möchten Sie vor der Terminplanung einen neuen Bus registrieren?';

  @override
  String get changeLanguage => 'Sprache ändern';

  @override
  String get changeRecord => 'Eintrag ändern';

  @override
  String get close => 'Schließen';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get companyName => 'Firmenname';

  @override
  String get companyRegisteredSuccess => 'Firma erfolgreich registriert!';

  @override
  String get companyUpdatedSuccess => 'Firma erfolgreich aktualisiert!';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get corporateName => 'Offizieller Firmenname';

  @override
  String get counterExample => 'Beispiel-Schalter';

  @override
  String get counterRegisteredSuccess => 'Schalter erfolgreich registriert!';

  @override
  String get cpf => 'CPF';

  @override
  String get createAccountCompany => 'Konto erstellen - Firma';

  @override
  String get createAccountCounter => 'Konto erstellen - Schalter';

  @override
  String get distance => 'Entfernung';

  @override
  String get docks => 'Laderampen';

  @override
  String get docksOrganization => 'Laderampen-Organisation';

  @override
  String get editCompany => 'Firma bearbeiten';

  @override
  String get email => 'E-Mail';

  @override
  String get error => 'Fehler';

  @override
  String get exit => 'BEENDEN';

  @override
  String get featureInProgress => 'Funktion in Entwicklung.';

  @override
  String get fillAllFields => 'Bitte füllen Sie alle Pflichtfelder aus.';

  @override
  String get filtering => 'Filterung';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get free => 'Frei';

  @override
  String get includeRegistration => 'Eintrag hinzufügen';

  @override
  String get language => 'Sprache';

  @override
  String get login => 'ANMELDEN';

  @override
  String get logOut => 'Abmelden';

  @override
  String get monitoring => 'Überwachung';

  @override
  String get name => 'Name';

  @override
  String get noContinueScheduling => 'Nein, mit der Planung fortfahren';

  @override
  String get noVacanciesAvailable => 'Derzeit keine Plätze verfügbar.';

  @override
  String get occupied => 'Besetzt';

  @override
  String get ok => 'OK';

  @override
  String get password => 'Passwort';

  @override
  String get passwordError => 'Passwortfehler';

  @override
  String get passwordsDoNotMatch =>
      'Die eingegebenen Passwörter stimmen nicht überein. Bitte überprüfen und erneut versuchen.';

  @override
  String get phone => 'Telefon';

  @override
  String get register => 'REGISTRIEREN';

  @override
  String get registerCompany => 'Firma registrieren';

  @override
  String get registerCounter => 'Schalter registrieren';

  @override
  String get registrationFailed =>
      'Registrierung fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get removeFilter => 'Filter entfernen';

  @override
  String get saveChanges => 'ÄNDERUNGEN SPEICHERN';

  @override
  String get scheduleArrival => 'Ankunft planen';

  @override
  String get scheduleArrivalButton => 'ANKUNFT PLANEN';

  @override
  String get settings => 'Einstellungen';

  @override
  String get standBy => 'Stand-by';

  @override
  String get status => 'Status';

  @override
  String get success => 'Erfolg';

  @override
  String get termsAndConditions =>
      'Ich erkläre, dass ich die Nutzungsbedingungen gelesen habe und ihnen zustimme';

  @override
  String get unknownUserType => 'Unbekannter Benutzertyp.';

  @override
  String get vacanciesStatus => 'Status der Plätze:';

  @override
  String get vacancyDetails => 'Details zum Platz';

  @override
  String get yesRegisterBus => 'Ja, Bus registrieren';

  @override
  String errorLoadingData(String error) {
    return 'Fehler beim Laden der Daten: $error';
  }

  @override
  String errorLoadingVacancies(String error) {
    return 'Fehler beim Laden der Plätze: $error';
  }

  @override
  String errorSavingCompany(String error) {
    return 'Fehler beim Speichern der Firma: $error';
  }

  @override
  String registrationError(String error) {
    return 'Registrierungsfehler: $error';
  }

  @override
  String get busPlate => 'Bus-Kennzeichen';

  @override
  String get selectPlate => 'Kennzeichen auswählen';

  @override
  String get arrivalTime => 'Ankunftszeit';

  @override
  String get selectTime => 'Zeit auswählen';

  @override
  String get arrivalDate => 'Ankunftsdatum';

  @override
  String get selectDate => 'Datum auswählen';

  @override
  String get additionalData => 'Zusätzliche Daten';

  @override
  String get schedule => 'PLANEN';

  @override
  String get plateCannotBeEmpty => 'Das Kennzeichen darf nicht leer sein.';

  @override
  String get plateRegisteredSuccess => 'Kennzeichen erfolgreich registriert!';

  @override
  String get plateRegistrationError =>
      'Fehler: Kennzeichen bereits registriert oder Dienstfehler.';

  @override
  String get registerBus => 'Bus registrieren';

  @override
  String get attention => 'Achtung';

  @override
  String get selectVacancyToSchedule =>
      'Wählen Sie einen Platz aus, um die Ankunft zu planen.';

  @override
  String get confirmSaveChanges => 'Möchten Sie die Änderungen speichern?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get recordUpdatedSuccess => 'Eintrag erfolgreich aktualisiert.';

  @override
  String get recordUpdateFailed =>
      'Aktualisierung des Eintrags fehlgeschlagen.';

  @override
  String get registrationHistory => 'Registrierungsverlauf';

  @override
  String get failedToSendSchedule => 'Senden des Plans fehlgeschlagen';

  @override
  String get serverCommunicationFailed => 'Serverkommunikation fehlgeschlagen';

  @override
  String get failedToFetchCompany => 'Abrufen der Firma fehlgeschlagen';

  @override
  String get failedToUpdateCompany => 'Aktualisierung der Firma fehlgeschlagen';

  @override
  String get failedToFetchVacancies => 'Abrufen der Plätze fehlgeschlagen';

  @override
  String get failedToFetchCounterName =>
      'Abrufen des Schalternamens fehlgeschlagen';

  @override
  String get unauthenticatedUser =>
      'Nicht authentifizierter Benutzer oder ungültiges Token.';

  @override
  String get failedToFetchCounterNameStatusCode =>
      'Abrufen des Schalternamens fehlgeschlagen: Statuscode ';

  @override
  String get invalidCredentials => 'Ungültige Anmeldeinformationen';

  @override
  String get failedToFetchBusPlates =>
      'Abrufen der Buskennzeichen fehlgeschlagen';

  @override
  String get failedToRegisterBus => 'Registrierung des Busses fehlgeschlagen';

  @override
  String get failedToFetchRecords => 'Abrufen der Einträge fehlgeschlagen';

  @override
  String get schedulingSuccess => 'Terminplanung erfolgreich!';

  @override
  String get errorSchedulingFailed =>
      'Terminplanung fehlgeschlagen. Bitte versuchen Sie es erneut.';

  @override
  String get scheduleVacancy => 'Platz planen';

  @override
  String get termsAndConditionsTitle => 'Allgemeine Geschäftsbedingungen';

  @override
  String get termsAndConditionsBody =>
      'Hier sind die Allgemeinen Geschäftsbedingungen von OnBus. Durch die Nutzung der App stimmen Sie diesen Bedingungen zu.';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get languageNamePortuguese => 'Portugiesisch (Brasilien)';

  @override
  String get languageNameEnglish => 'Englisch (USA)';

  @override
  String get languageNameSpanish => 'Spanisch';

  @override
  String get languageNameFrench => 'Französisch';

  @override
  String get languageNameGerman => 'Deutsch';

  @override
  String get languageNameItalian => 'Italienisch';

  @override
  String get totalRecords => 'Gesamtzahl der Einträge: ';

  @override
  String get records => 'Einträge';

  @override
  String get plate => 'Kennzeichen';

  @override
  String unexpectedError(String error) {
    return 'Unerwarteter Fehler: $error';
  }

  @override
  String loginError(String error) {
    return 'Fehler beim Anmelden: $error';
  }

  @override
  String get vacancy => 'Platz';

  @override
  String get all => 'Alle';
}
