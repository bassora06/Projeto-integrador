// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get askRegisterBusBeforeScheduling =>
      'Voulez-vous enregistrer un nouveau bus avant de planifier ?';

  @override
  String get changeLanguage => 'Changer de langue';

  @override
  String get changeRecord => 'Modifier l\'enregistrement';

  @override
  String get close => 'Fermer';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get companyName => 'Nom de l\'entreprise';

  @override
  String get companyRegisteredSuccess => 'Entreprise enregistrée avec succès !';

  @override
  String get companyUpdatedSuccess => 'Entreprise mise à jour avec succès !';

  @override
  String get confirmPassword => 'Confirmez le mot de passe';

  @override
  String get corporateName => 'Raison sociale';

  @override
  String get counterExample => 'Guichet d\'exemple';

  @override
  String get counterRegisteredSuccess => 'Guichet enregistré avec succès !';

  @override
  String get cpf => 'CPF';

  @override
  String get createAccountCompany => 'Créer un compte - Entreprise';

  @override
  String get createAccountCounter => 'Créer un compte - Guichet';

  @override
  String get distance => 'Distance';

  @override
  String get docks => 'Quais';

  @override
  String get docksOrganization => 'Organisation des quais';

  @override
  String get editCompany => 'Modifier l\'entreprise';

  @override
  String get email => 'E-mail';

  @override
  String get error => 'Erreur';

  @override
  String get exit => 'SORTIR';

  @override
  String get featureInProgress => 'Fonctionnalité en cours de développement.';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs obligatoires.';

  @override
  String get filtering => 'Filtrage';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get free => 'Libre';

  @override
  String get includeRegistration => 'Ajouter un enregistrement';

  @override
  String get language => 'Langue';

  @override
  String get login => 'CONNEXION';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get monitoring => 'Surveillance';

  @override
  String get name => 'Nom';

  @override
  String get noContinueScheduling => 'Non, continuer la planification';

  @override
  String get noVacanciesAvailable => 'Aucune place disponible pour le moment.';

  @override
  String get occupied => 'Occupé';

  @override
  String get ok => 'D\'accord';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordError => 'Erreur de mot de passe';

  @override
  String get passwordsDoNotMatch =>
      'Les mots de passe saisis ne correspondent pas. Veuillez vérifier et réessayer.';

  @override
  String get phone => 'Téléphone';

  @override
  String get register => 'S\'INSCRIRE';

  @override
  String get registerCompany => 'Enregistrer l\'entreprise';

  @override
  String get registerCounter => 'Enregistrer le guichet';

  @override
  String get registrationFailed =>
      'L\'inscription a échoué. Veuillez réessayer.';

  @override
  String get removeFilter => 'Supprimer le filtre';

  @override
  String get saveChanges => 'ENREGISTRER LES MODIFICATIONS';

  @override
  String get scheduleArrival => 'Planifier l\'arrivée';

  @override
  String get scheduleArrivalButton => 'PLANIFIER L\'ARRIVÉE';

  @override
  String get settings => 'Paramètres';

  @override
  String get standBy => 'En attente';

  @override
  String get status => 'Statut';

  @override
  String get success => 'Succès';

  @override
  String get termsAndConditions =>
      'Je déclare avoir lu et accepté les conditions d\'utilisation';

  @override
  String get unknownUserType => 'Type d\'utilisateur inconnu.';

  @override
  String get vacanciesStatus => 'Statut des places :';

  @override
  String get vacancyDetails => 'Détails de la place';

  @override
  String get yesRegisterBus => 'Oui, enregistrer le bus';

  @override
  String errorLoadingData(String error) {
    return 'Erreur lors du chargement des données : $error';
  }

  @override
  String errorLoadingVacancies(String error) {
    return 'Erreur lors du chargement des places : $error';
  }

  @override
  String errorSavingCompany(String error) {
    return 'Erreur lors de l\'enregistrement de l\'entreprise : $error';
  }

  @override
  String registrationError(String error) {
    return 'Erreur d\'inscription : $error';
  }

  @override
  String get busPlate => 'Plaque d\'Immatriculation du Bus';

  @override
  String get selectPlate => 'Sélectionner la Plaque';

  @override
  String get arrivalTime => 'Heure d\'Arrivée';

  @override
  String get selectTime => 'Sélectionner l\'Heure';

  @override
  String get arrivalDate => 'Date d\'Arrivée';

  @override
  String get selectDate => 'Sélectionner la Date';

  @override
  String get additionalData => 'Données Supplémentaires';

  @override
  String get schedule => 'PLANIFIER';

  @override
  String get plateCannotBeEmpty => 'La plaque ne peut pas être vide.';

  @override
  String get plateRegisteredSuccess => 'Plaque enregistrée avec succès !';

  @override
  String get plateRegistrationError =>
      'Erreur : Plaque déjà enregistrée ou échec du service.';

  @override
  String get registerBus => 'Enregistrer le Bus';

  @override
  String get attention => 'Attention';

  @override
  String get selectVacancyToSchedule =>
      'Sélectionnez une place pour planifier l\'arrivée.';

  @override
  String get confirmSaveChanges =>
      'Voulez-vous enregistrer les modifications ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get recordUpdatedSuccess => 'Enregistrement mis à jour avec succès.';

  @override
  String get recordUpdateFailed =>
      'Échec de la mise à jour de l\'enregistrement.';

  @override
  String get registrationHistory => 'Historique des Enregistrements';

  @override
  String get failedToSendSchedule => 'Échec de l\'envoi de la planification';

  @override
  String get serverCommunicationFailed =>
      'Échec de la communication avec le serveur';

  @override
  String get failedToFetchCompany =>
      'Échec de la récupération de l\'entreprise';

  @override
  String get failedToUpdateCompany =>
      'Échec de la mise à jour de l\'entreprise';

  @override
  String get failedToFetchVacancies => 'Échec de la récupération des places';

  @override
  String get failedToFetchCounterName =>
      'Échec de la récupération du nom du guichet';

  @override
  String get unauthenticatedUser =>
      'Utilisateur non authentifié ou jeton invalide.';

  @override
  String get failedToFetchCounterNameStatusCode =>
      'Échec de la récupération du nom du guichet : Code de statut ';

  @override
  String get invalidCredentials => 'Identifiants invalides';

  @override
  String get failedToFetchBusPlates =>
      'Échec de la récupération des plaques de bus';

  @override
  String get failedToRegisterBus => 'Échec de l\'enregistrement du bus';

  @override
  String get failedToFetchRecords =>
      'Échec de la récupération des enregistrements';

  @override
  String get schedulingSuccess => 'Planification réussie !';

  @override
  String get errorSchedulingFailed =>
      'La planification a échoué. Veuillez réessayer.';

  @override
  String get scheduleVacancy => 'Planifier une Place';

  @override
  String get termsAndConditionsTitle => 'Termes et Conditions';

  @override
  String get termsAndConditionsBody =>
      'Voici les termes et conditions d\'OnBus. En utilisant l\'application, vous acceptez ces termes.';

  @override
  String get selectLanguage => 'Sélectionner la Langue';

  @override
  String get languageNamePortuguese => 'Portugais (Brésil)';

  @override
  String get languageNameEnglish => 'Anglais (États-Unis)';

  @override
  String get languageNameSpanish => 'Espagnol';

  @override
  String get languageNameFrench => 'Français';

  @override
  String get languageNameGerman => 'Allemand';

  @override
  String get languageNameItalian => 'Italien';

  @override
  String get totalRecords => 'Total des Enregistrements : ';

  @override
  String get records => 'Enregistrements';

  @override
  String get plate => 'Plaque';

  @override
  String unexpectedError(String error) {
    return 'Erreur inattendue: $error';
  }

  @override
  String loginError(String error) {
    return 'Erreur de connexion: $error';
  }

  @override
  String get vacancy => 'Place';

  @override
  String get all => 'Tous';
}
