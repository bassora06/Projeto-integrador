// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get askRegisterBusBeforeScheduling =>
      'Do you want to register a new bus before scheduling?';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get changeRecord => 'Change Record';

  @override
  String get close => 'Close';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get companyName => 'Company Name';

  @override
  String get companyRegisteredSuccess => 'Company registered successfully!';

  @override
  String get companyUpdatedSuccess => 'Company updated successfully!';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get corporateName => 'Corporate Name';

  @override
  String get counterExample => 'Example Counter';

  @override
  String get counterRegisteredSuccess => 'Counter registered successfully!';

  @override
  String get cpf => 'CPF';

  @override
  String get createAccountCompany => 'Create Account - Company';

  @override
  String get createAccountCounter => 'Create Account - Counter';

  @override
  String get distance => 'Distance';

  @override
  String get docks => 'Docks';

  @override
  String get docksOrganization => 'Docks Organization';

  @override
  String get editCompany => 'Edit Company';

  @override
  String get email => 'Email';

  @override
  String get error => 'Error';

  @override
  String get exit => 'EXIT';

  @override
  String get featureInProgress => 'Feature in development.';

  @override
  String get fillAllFields => 'Please fill in all required fields.';

  @override
  String get filtering => 'Filtering';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get free => 'Free';

  @override
  String get includeRegistration => 'Add Record';

  @override
  String get language => 'Language';

  @override
  String get login => 'LOGIN';

  @override
  String get logOut => 'Log Out';

  @override
  String get monitoring => 'Monitoring';

  @override
  String get name => 'Name';

  @override
  String get noContinueScheduling => 'No, continue scheduling';

  @override
  String get noVacanciesAvailable => 'No vacancies available at the moment.';

  @override
  String get occupied => 'Occupied';

  @override
  String get ok => 'OK';

  @override
  String get password => 'Password';

  @override
  String get passwordError => 'Password Error';

  @override
  String get passwordsDoNotMatch =>
      'The entered passwords do not match. Please check and try again.';

  @override
  String get phone => 'Phone';

  @override
  String get register => 'REGISTER';

  @override
  String get registerCompany => 'Register Company';

  @override
  String get registerCounter => 'Register Counter';

  @override
  String get registrationFailed => 'Registration failed. Please try again.';

  @override
  String get removeFilter => 'Remove Filter';

  @override
  String get saveChanges => 'SAVE CHANGES';

  @override
  String get scheduleArrival => 'Schedule Arrival';

  @override
  String get scheduleArrivalButton => 'SCHEDULE ARRIVAL';

  @override
  String get settings => 'Settings';

  @override
  String get standBy => 'Stand by';

  @override
  String get status => 'Status';

  @override
  String get success => 'Success';

  @override
  String get termsAndConditions =>
      'I declare that I have read and agree to the terms of use';

  @override
  String get unknownUserType => 'Unknown user type.';

  @override
  String get vacanciesStatus => 'Vacancies Status:';

  @override
  String get vacancyDetails => 'Vacancy Details';

  @override
  String get yesRegisterBus => 'Yes, register bus';

  @override
  String errorLoadingData(String error) {
    return 'Error loading data: $error';
  }

  @override
  String errorLoadingVacancies(String error) {
    return 'Error loading vacancies: $error';
  }

  @override
  String errorSavingCompany(String error) {
    return 'Error saving company: $error';
  }

  @override
  String registrationError(String error) {
    return 'Registration error: $error';
  }

  @override
  String get busPlate => 'Bus Plate';

  @override
  String get selectPlate => 'Select Plate';

  @override
  String get arrivalTime => 'Arrival Time';

  @override
  String get selectTime => 'Select Time';

  @override
  String get arrivalDate => 'Arrival Date';

  @override
  String get selectDate => 'Select Date';

  @override
  String get additionalData => 'Additional Data';

  @override
  String get schedule => 'SCHEDULE';

  @override
  String get plateCannotBeEmpty => 'The plate cannot be empty.';

  @override
  String get plateRegisteredSuccess => 'Plate registered successfully!';

  @override
  String get plateRegistrationError =>
      'Error: Plate already registered or service failure.';

  @override
  String get registerBus => 'Register Bus';

  @override
  String get attention => 'Attention';

  @override
  String get selectVacancyToSchedule => 'Select a vacancy to schedule arrival.';

  @override
  String get confirmSaveChanges => 'Do you want to save the changes?';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get recordUpdatedSuccess => 'Record updated successfully.';

  @override
  String get recordUpdateFailed => 'Failed to update record.';

  @override
  String get registrationHistory => 'Registration History';

  @override
  String get failedToSendSchedule => 'Failed to send schedule';

  @override
  String get serverCommunicationFailed => 'Server communication failed';

  @override
  String get failedToFetchCompany => 'Failed to fetch company';

  @override
  String get failedToUpdateCompany => 'Failed to update company';

  @override
  String get failedToFetchVacancies => 'Failed to fetch vacancies';

  @override
  String get failedToFetchCounterName => 'Failed to fetch counter name';

  @override
  String get unauthenticatedUser => 'Unauthenticated user or invalid token.';

  @override
  String get failedToFetchCounterNameStatusCode =>
      'Failed to fetch counter name: Status code ';

  @override
  String get invalidCredentials => 'Invalid credentials';

  @override
  String get failedToFetchBusPlates => 'Failed to fetch bus plates';

  @override
  String get failedToRegisterBus => 'Failed to register bus';

  @override
  String get failedToFetchRecords => 'Failed to fetch records';

  @override
  String get schedulingSuccess => 'Scheduling successful!';

  @override
  String get errorSchedulingFailed => 'Scheduling failed. Please try again.';

  @override
  String get scheduleVacancy => 'Schedule Vacancy';

  @override
  String get termsAndConditionsTitle => 'Terms & Conditions';

  @override
  String get termsAndConditionsBody =>
      'Here are the terms and conditions of OnBus. By using the app, you agree to these terms.';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageNamePortuguese => 'Portuguese (Brazil)';

  @override
  String get languageNameEnglish => 'English (US)';

  @override
  String get languageNameSpanish => 'Spanish';

  @override
  String get languageNameFrench => 'French';

  @override
  String get languageNameGerman => 'German';

  @override
  String get languageNameItalian => 'Italian';

  @override
  String get totalRecords => 'Total Records: ';

  @override
  String get records => 'Records';

  @override
  String get plate => 'Plate';

  @override
  String unexpectedError(String error) {
    return 'Unexpected error: $error';
  }

  @override
  String loginError(String error) {
    return 'Error logging in: $error';
  }

  @override
  String get vacancy => 'Vacancy';
}
