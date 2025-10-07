// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get askRegisterBusBeforeScheduling =>
      'Vuoi registrare un nuovo autobus prima di programmare?';

  @override
  String get changeLanguage => 'Cambia lingua';

  @override
  String get changeRecord => 'Modifica record';

  @override
  String get close => 'Chiudi';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get companyName => 'Nome dell\'azienda';

  @override
  String get companyRegisteredSuccess => 'Azienda registrata con successo!';

  @override
  String get companyUpdatedSuccess => 'Azienda aggiornata con successo!';

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get corporateName => 'Ragione sociale';

  @override
  String get counterExample => 'Sportello di esempio';

  @override
  String get counterRegisteredSuccess => 'Sportello registrato con successo!';

  @override
  String get cpf => 'CPF';

  @override
  String get createAccountCompany => 'Crea account - Azienda';

  @override
  String get createAccountCounter => 'Crea account - Sportello';

  @override
  String get distance => 'Distanza';

  @override
  String get docks => 'Banchine';

  @override
  String get docksOrganization => 'Organizzazione banchine';

  @override
  String get editCompany => 'Modifica azienda';

  @override
  String get email => 'Email';

  @override
  String get error => 'Errore';

  @override
  String get exit => 'ESCI';

  @override
  String get featureInProgress => 'Funzionalità in fase di sviluppo.';

  @override
  String get fillAllFields =>
      'Si prega di compilare tutti i campi obbligatori.';

  @override
  String get filtering => 'Filtraggio';

  @override
  String get forgotPassword => 'Hai dimenticato la password?';

  @override
  String get free => 'Libero';

  @override
  String get includeRegistration => 'Aggiungi registrazione';

  @override
  String get language => 'Lingua';

  @override
  String get login => 'ACCEDI';

  @override
  String get logOut => 'Esci';

  @override
  String get monitoring => 'Monitoraggio';

  @override
  String get name => 'Nome';

  @override
  String get noContinueScheduling => 'No, continua a programmare';

  @override
  String get noVacanciesAvailable => 'Nessun posto disponibile al momento.';

  @override
  String get occupied => 'Occupato';

  @override
  String get ok => 'OK';

  @override
  String get password => 'Password';

  @override
  String get passwordError => 'Errore password';

  @override
  String get passwordsDoNotMatch =>
      'Le password inserite non corrispondono. Si prega di controllare e riprovare.';

  @override
  String get phone => 'Telefono';

  @override
  String get register => 'REGISTRATI';

  @override
  String get registerCompany => 'Registra azienda';

  @override
  String get registerCounter => 'Registra sportello';

  @override
  String get registrationFailed =>
      'Registrazione fallita. Si prega di riprovare.';

  @override
  String get removeFilter => 'Rimuovi filtro';

  @override
  String get saveChanges => 'SALVA MODIFICHE';

  @override
  String get scheduleArrival => 'Programma arrivo';

  @override
  String get scheduleArrivalButton => 'PROGRAMMA ARRIVO';

  @override
  String get settings => 'Impostazioni';

  @override
  String get standBy => 'In attesa';

  @override
  String get status => 'Stato';

  @override
  String get success => 'Successo';

  @override
  String get termsAndConditions =>
      'Dichiaro di aver letto e di accettare i termini di utilizzo';

  @override
  String get unknownUserType => 'Tipo di utente sconosciuto.';

  @override
  String get vacanciesStatus => 'Stato posti:';

  @override
  String get vacancyDetails => 'Dettagli posto';

  @override
  String get yesRegisterBus => 'Sì, registra autobus';

  @override
  String errorLoadingData(String error) {
    return 'Errore durante il caricamento dei dati: $error';
  }

  @override
  String errorLoadingVacancies(String error) {
    return 'Errore during il caricamento dei posti: $error';
  }

  @override
  String errorSavingCompany(String error) {
    return 'Errore durante il salvataggio dell\'azienda: $error';
  }

  @override
  String registrationError(String error) {
    return 'Errore di registrazione: $error';
  }

  @override
  String get busPlate => 'Targa Autobus';

  @override
  String get selectPlate => 'Seleziona Targa';

  @override
  String get arrivalTime => 'Orario di Arrivo';

  @override
  String get selectTime => 'Seleziona Orario';

  @override
  String get arrivalDate => 'Data di Arrivo';

  @override
  String get selectDate => 'Seleziona Data';

  @override
  String get additionalData => 'Dati Aggiuntivi';

  @override
  String get schedule => 'PROGRAMMA';

  @override
  String get plateCannotBeEmpty => 'La targa non può essere vuota.';

  @override
  String get plateRegisteredSuccess => 'Targa registrata con successo!';

  @override
  String get plateRegistrationError =>
      'Errore: Targa già registrata o errore del servizio.';

  @override
  String get registerBus => 'Registra Autobus';

  @override
  String get attention => 'Attenzione';

  @override
  String get selectVacancyToSchedule =>
      'Seleziona un posto per programmare l\'arrivo.';

  @override
  String get confirmSaveChanges => 'Vuoi salvare le modifiche?';

  @override
  String get cancel => 'Annulla';

  @override
  String get save => 'Salva';

  @override
  String get recordUpdatedSuccess => 'Record aggiornato con successo.';

  @override
  String get recordUpdateFailed => 'Aggiornamento del record fallito.';

  @override
  String get registrationHistory => 'Cronologia Registrazioni';

  @override
  String get failedToSendSchedule => 'Invio della programmazione fallito';

  @override
  String get serverCommunicationFailed => 'Comunicazione con il server fallita';

  @override
  String get failedToFetchCompany => 'Recupero azienda fallito';

  @override
  String get failedToUpdateCompany => 'Aggiornamento azienda fallito';

  @override
  String get failedToFetchVacancies => 'Recupero posti fallito';

  @override
  String get failedToFetchCounterName => 'Recupero nome sportello fallito';

  @override
  String get unauthenticatedUser =>
      'Utente non autenticato o token non valido.';

  @override
  String get failedToFetchCounterNameStatusCode =>
      'Recupero nome sportello fallito: Codice di stato ';

  @override
  String get invalidCredentials => 'Credenziali non valide';

  @override
  String get failedToFetchBusPlates => 'Recupero targhe autobus fallito';

  @override
  String get failedToRegisterBus => 'Registrazione autobus fallita';

  @override
  String get failedToFetchRecords => 'Recupero record fallito';

  @override
  String get schedulingSuccess => 'Programmazione eseguita con successo!';

  @override
  String get errorSchedulingFailed =>
      'Programmazione fallita. Si prega di riprovare.';

  @override
  String get scheduleVacancy => 'Programma Posto';

  @override
  String get termsAndConditionsTitle => 'Termini e Condizioni';

  @override
  String get termsAndConditionsBody =>
      'Ecco i termini e le condizioni di OnBus. Utilizzando l\'applicazione, accetti questi termini.';

  @override
  String get selectLanguage => 'Seleziona Lingua';

  @override
  String get languageNamePortuguese => 'Portoghese (Brasile)';

  @override
  String get languageNameEnglish => 'Inglese (USA)';

  @override
  String get languageNameSpanish => 'Spagnolo';

  @override
  String get languageNameFrench => 'Francese';

  @override
  String get languageNameGerman => 'Tedesco';

  @override
  String get languageNameItalian => 'Italiano';

  @override
  String get totalRecords => 'Totale Record: ';

  @override
  String get records => 'Record';

  @override
  String get plate => 'Targa';

  @override
  String unexpectedError(String error) {
    return 'Errore imprevisto: $error';
  }

  @override
  String loginError(String error) {
    return 'Errore durante l\'accesso: $error';
  }

  @override
  String get vacancy => 'Posto';

  @override
  String get all => 'Tutti';
}
