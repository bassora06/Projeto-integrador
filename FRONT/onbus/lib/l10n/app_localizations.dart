import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt')
  ];

  /// No description provided for @askRegisterBusBeforeScheduling.
  ///
  /// In en, this message translates to:
  /// **'Do you want to register a new bus before scheduling?'**
  String get askRegisterBusBeforeScheduling;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @changeRecord.
  ///
  /// In en, this message translates to:
  /// **'Change Record'**
  String get changeRecord;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @cnpj.
  ///
  /// In en, this message translates to:
  /// **'CNPJ'**
  String get cnpj;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get companyName;

  /// No description provided for @companyRegisteredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Company registered successfully!'**
  String get companyRegisteredSuccess;

  /// No description provided for @companyUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Company updated successfully!'**
  String get companyUpdatedSuccess;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @corporateName.
  ///
  /// In en, this message translates to:
  /// **'Corporate Name'**
  String get corporateName;

  /// No description provided for @counterExample.
  ///
  /// In en, this message translates to:
  /// **'Example Counter'**
  String get counterExample;

  /// No description provided for @counterRegisteredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Counter registered successfully!'**
  String get counterRegisteredSuccess;

  /// No description provided for @cpf.
  ///
  /// In en, this message translates to:
  /// **'CPF'**
  String get cpf;

  /// No description provided for @createAccountCompany.
  ///
  /// In en, this message translates to:
  /// **'Create Account - Company'**
  String get createAccountCompany;

  /// No description provided for @createAccountCounter.
  ///
  /// In en, this message translates to:
  /// **'Create Account - Counter'**
  String get createAccountCounter;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @docks.
  ///
  /// In en, this message translates to:
  /// **'Docks'**
  String get docks;

  /// No description provided for @docksOrganization.
  ///
  /// In en, this message translates to:
  /// **'Docks Organization'**
  String get docksOrganization;

  /// No description provided for @editCompany.
  ///
  /// In en, this message translates to:
  /// **'Edit Company'**
  String get editCompany;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'EXIT'**
  String get exit;

  /// No description provided for @featureInProgress.
  ///
  /// In en, this message translates to:
  /// **'Feature in development.'**
  String get featureInProgress;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields.'**
  String get fillAllFields;

  /// No description provided for @filtering.
  ///
  /// In en, this message translates to:
  /// **'Filtering'**
  String get filtering;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @includeRegistration.
  ///
  /// In en, this message translates to:
  /// **'Add Record'**
  String get includeRegistration;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get login;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @monitoring.
  ///
  /// In en, this message translates to:
  /// **'Monitoring'**
  String get monitoring;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @noContinueScheduling.
  ///
  /// In en, this message translates to:
  /// **'No, continue scheduling'**
  String get noContinueScheduling;

  /// No description provided for @noVacanciesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No vacancies available at the moment.'**
  String get noVacanciesAvailable;

  /// No description provided for @occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get occupied;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Password Error'**
  String get passwordError;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'The entered passwords do not match. Please check and try again.'**
  String get passwordsDoNotMatch;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get register;

  /// No description provided for @registerCompany.
  ///
  /// In en, this message translates to:
  /// **'Register Company'**
  String get registerCompany;

  /// No description provided for @registerCounter.
  ///
  /// In en, this message translates to:
  /// **'Register Counter'**
  String get registerCounter;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @removeFilter.
  ///
  /// In en, this message translates to:
  /// **'Remove Filter'**
  String get removeFilter;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'SAVE CHANGES'**
  String get saveChanges;

  /// No description provided for @scheduleArrival.
  ///
  /// In en, this message translates to:
  /// **'Schedule Arrival'**
  String get scheduleArrival;

  /// No description provided for @scheduleArrivalButton.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE ARRIVAL'**
  String get scheduleArrivalButton;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @standBy.
  ///
  /// In en, this message translates to:
  /// **'Stand by'**
  String get standBy;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'I declare that I have read and agree to the terms of use'**
  String get termsAndConditions;

  /// No description provided for @unknownUserType.
  ///
  /// In en, this message translates to:
  /// **'Unknown user type.'**
  String get unknownUserType;

  /// No description provided for @vacanciesStatus.
  ///
  /// In en, this message translates to:
  /// **'Vacancies Status:'**
  String get vacanciesStatus;

  /// No description provided for @vacancyDetails.
  ///
  /// In en, this message translates to:
  /// **'Vacancy Details'**
  String get vacancyDetails;

  /// No description provided for @yesRegisterBus.
  ///
  /// In en, this message translates to:
  /// **'Yes, register bus'**
  String get yesRegisterBus;

  /// Error message displayed when data cannot be loaded.
  ///
  /// In en, this message translates to:
  /// **'Error loading data: {error}'**
  String errorLoadingData(String error);

  /// Error message displayed when vacancies fail to load.
  ///
  /// In en, this message translates to:
  /// **'Error loading vacancies: {error}'**
  String errorLoadingVacancies(String error);

  /// Error message displayed on failure to save the company.
  ///
  /// In en, this message translates to:
  /// **'Error saving company: {error}'**
  String errorSavingCompany(String error);

  /// Generic error message for the registration screen.
  ///
  /// In en, this message translates to:
  /// **'Registration error: {error}'**
  String registrationError(String error);

  /// No description provided for @busPlate.
  ///
  /// In en, this message translates to:
  /// **'Bus Plate'**
  String get busPlate;

  /// No description provided for @selectPlate.
  ///
  /// In en, this message translates to:
  /// **'Select Plate'**
  String get selectPlate;

  /// No description provided for @arrivalTime.
  ///
  /// In en, this message translates to:
  /// **'Arrival Time'**
  String get arrivalTime;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @arrivalDate.
  ///
  /// In en, this message translates to:
  /// **'Arrival Date'**
  String get arrivalDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @additionalData.
  ///
  /// In en, this message translates to:
  /// **'Additional Data'**
  String get additionalData;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'SCHEDULE'**
  String get schedule;

  /// No description provided for @plateCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'The plate cannot be empty.'**
  String get plateCannotBeEmpty;

  /// No description provided for @plateRegisteredSuccess.
  ///
  /// In en, this message translates to:
  /// **'Plate registered successfully!'**
  String get plateRegisteredSuccess;

  /// No description provided for @plateRegistrationError.
  ///
  /// In en, this message translates to:
  /// **'Error: Plate already registered or service failure.'**
  String get plateRegistrationError;

  /// No description provided for @registerBus.
  ///
  /// In en, this message translates to:
  /// **'Register Bus'**
  String get registerBus;

  /// No description provided for @attention.
  ///
  /// In en, this message translates to:
  /// **'Attention'**
  String get attention;

  /// No description provided for @selectVacancyToSchedule.
  ///
  /// In en, this message translates to:
  /// **'Select a vacancy to schedule arrival.'**
  String get selectVacancyToSchedule;

  /// No description provided for @confirmSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save the changes?'**
  String get confirmSaveChanges;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @recordUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Record updated successfully.'**
  String get recordUpdatedSuccess;

  /// No description provided for @recordUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update record.'**
  String get recordUpdateFailed;

  /// No description provided for @registrationHistory.
  ///
  /// In en, this message translates to:
  /// **'Registration History'**
  String get registrationHistory;

  /// No description provided for @failedToSendSchedule.
  ///
  /// In en, this message translates to:
  /// **'Failed to send schedule'**
  String get failedToSendSchedule;

  /// No description provided for @serverCommunicationFailed.
  ///
  /// In en, this message translates to:
  /// **'Server communication failed'**
  String get serverCommunicationFailed;

  /// No description provided for @failedToFetchCompany.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch company'**
  String get failedToFetchCompany;

  /// No description provided for @failedToUpdateCompany.
  ///
  /// In en, this message translates to:
  /// **'Failed to update company'**
  String get failedToUpdateCompany;

  /// No description provided for @failedToFetchVacancies.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch vacancies'**
  String get failedToFetchVacancies;

  /// No description provided for @failedToFetchCounterName.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch counter name'**
  String get failedToFetchCounterName;

  /// No description provided for @unauthenticatedUser.
  ///
  /// In en, this message translates to:
  /// **'Unauthenticated user or invalid token.'**
  String get unauthenticatedUser;

  /// No description provided for @failedToFetchCounterNameStatusCode.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch counter name: Status code '**
  String get failedToFetchCounterNameStatusCode;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get invalidCredentials;

  /// No description provided for @failedToFetchBusPlates.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch bus plates'**
  String get failedToFetchBusPlates;

  /// No description provided for @failedToRegisterBus.
  ///
  /// In en, this message translates to:
  /// **'Failed to register bus'**
  String get failedToRegisterBus;

  /// No description provided for @failedToFetchRecords.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch records'**
  String get failedToFetchRecords;

  /// No description provided for @schedulingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Scheduling successful!'**
  String get schedulingSuccess;

  /// No description provided for @errorSchedulingFailed.
  ///
  /// In en, this message translates to:
  /// **'Scheduling failed. Please try again.'**
  String get errorSchedulingFailed;

  /// No description provided for @scheduleVacancy.
  ///
  /// In en, this message translates to:
  /// **'Schedule Vacancy'**
  String get scheduleVacancy;

  /// No description provided for @termsAndConditionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsAndConditionsTitle;

  /// No description provided for @termsAndConditionsBody.
  ///
  /// In en, this message translates to:
  /// **'Here are the terms and conditions of OnBus. By using the app, you agree to these terms.'**
  String get termsAndConditionsBody;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @languageNamePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese (Brazil)'**
  String get languageNamePortuguese;

  /// No description provided for @languageNameEnglish.
  ///
  /// In en, this message translates to:
  /// **'English (US)'**
  String get languageNameEnglish;

  /// No description provided for @languageNameSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageNameSpanish;

  /// No description provided for @languageNameFrench.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get languageNameFrench;

  /// No description provided for @languageNameGerman.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get languageNameGerman;

  /// No description provided for @languageNameItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get languageNameItalian;

  /// No description provided for @totalRecords.
  ///
  /// In en, this message translates to:
  /// **'Total Records: '**
  String get totalRecords;

  /// No description provided for @records.
  ///
  /// In en, this message translates to:
  /// **'Records'**
  String get records;

  /// No description provided for @plate.
  ///
  /// In en, this message translates to:
  /// **'Plate'**
  String get plate;

  /// Error message for unforeseen failures.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error: {error}'**
  String unexpectedError(String error);

  /// Error message displayed when login fails.
  ///
  /// In en, this message translates to:
  /// **'Error logging in: {error}'**
  String loginError(String error);

  /// No description provided for @vacancy.
  ///
  /// In en, this message translates to:
  /// **'Vacancy'**
  String get vacancy;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'de',
        'en',
        'es',
        'fr',
        'it',
        'pt'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
