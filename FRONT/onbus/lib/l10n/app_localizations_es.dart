// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get askRegisterBusBeforeScheduling =>
      '¿Desea registrar un nuevo autobús antes de programar?';

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get changeRecord => 'Modificar registro';

  @override
  String get close => 'Cerrar';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get companyName => 'Nombre de la empresa';

  @override
  String get companyRegisteredSuccess => '¡Empresa registrada con éxito!';

  @override
  String get companyUpdatedSuccess => '¡Empresa actualizada con éxito!';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get corporateName => 'Razón social';

  @override
  String get counterExample => 'Taquilla de ejemplo';

  @override
  String get counterRegisteredSuccess => '¡Taquilla registrada con éxito!';

  @override
  String get cpf => 'CPF';

  @override
  String get createAccountCompany => 'Crear cuenta - Empresa';

  @override
  String get createAccountCounter => 'Crear cuenta - Taquilla';

  @override
  String get distance => 'Distancia';

  @override
  String get docks => 'Dársenas';

  @override
  String get docksOrganization => 'Organización de dársenas';

  @override
  String get editCompany => 'Editar empresa';

  @override
  String get email => 'Correo electrónico';

  @override
  String get error => 'Error';

  @override
  String get exit => 'SALIR';

  @override
  String get featureInProgress => 'Funcionalidad en desarrollo.';

  @override
  String get fillAllFields =>
      'Por favor, complete todos los campos obligatorios.';

  @override
  String get filtering => 'Filtrado';

  @override
  String get forgotPassword => '¿Olvidó su contraseña?';

  @override
  String get free => 'Libre';

  @override
  String get includeRegistration => 'Añadir registro';

  @override
  String get language => 'Idioma';

  @override
  String get login => 'ENTRAR';

  @override
  String get logOut => 'Cerrar sesión';

  @override
  String get monitoring => 'Monitoreo';

  @override
  String get name => 'Nombre';

  @override
  String get noContinueScheduling => 'No, continuar programando';

  @override
  String get noVacanciesAvailable =>
      'No hay plazas disponibles en este momento.';

  @override
  String get occupied => 'Ocupado';

  @override
  String get ok => 'OK';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordError => 'Error de contraseña';

  @override
  String get passwordsDoNotMatch =>
      'Las contraseñas introducidas no coinciden. Por favor, verifique e inténtelo de nuevo.';

  @override
  String get phone => 'Teléfono';

  @override
  String get register => 'REGISTRAR';

  @override
  String get registerCompany => 'Registrar empresa';

  @override
  String get registerCounter => 'Registrar taquilla';

  @override
  String get registrationFailed =>
      'El registro ha fallado. Por favor, inténtelo de nuevo.';

  @override
  String get removeFilter => 'Quitar filtro';

  @override
  String get saveChanges => 'GUARDAR CAMBIOS';

  @override
  String get scheduleArrival => 'Programar llegada';

  @override
  String get scheduleArrivalButton => 'PROGRAMAR LLEGADA';

  @override
  String get settings => 'Configuración';

  @override
  String get standBy => 'En espera';

  @override
  String get status => 'Estado';

  @override
  String get success => 'Éxito';

  @override
  String get termsAndConditions =>
      'Declaro que he leído y acepto los términos de uso';

  @override
  String get unknownUserType => 'Tipo de usuario desconocido.';

  @override
  String get vacanciesStatus => 'Estado de las plazas:';

  @override
  String get vacancyDetails => 'Detalles de la plaza';

  @override
  String get yesRegisterBus => 'Sí, registrar autobús';

  @override
  String errorLoadingData(String error) {
    return 'Error al cargar los datos: $error';
  }

  @override
  String errorLoadingVacancies(String error) {
    return 'Error al cargar las plazas: $error';
  }

  @override
  String errorSavingCompany(String error) {
    return 'Error al guardar la empresa: $error';
  }

  @override
  String registrationError(String error) {
    return 'Error de registro: $error';
  }

  @override
  String get busPlate => 'Matrícula del Autobús';

  @override
  String get selectPlate => 'Seleccionar Matrícula';

  @override
  String get arrivalTime => 'Hora de Llegada';

  @override
  String get selectTime => 'Seleccionar Hora';

  @override
  String get arrivalDate => 'Fecha de Llegada';

  @override
  String get selectDate => 'Seleccionar Fecha';

  @override
  String get additionalData => 'Datos Adicionales';

  @override
  String get schedule => 'PROGRAMAR';

  @override
  String get plateCannotBeEmpty => 'La matrícula no puede estar vacía.';

  @override
  String get plateRegisteredSuccess => '¡Matrícula registrada con éxito!';

  @override
  String get plateRegistrationError =>
      'Error: Matrícula ya registrada o fallo en el servicio.';

  @override
  String get registerBus => 'Registrar Autobús';

  @override
  String get attention => 'Atención';

  @override
  String get selectVacancyToSchedule =>
      'Seleccione una plaza para programar la llegada.';

  @override
  String get confirmSaveChanges => '¿Desea guardar los cambios?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Guardar';

  @override
  String get recordUpdatedSuccess => 'Registro actualizado con éxito.';

  @override
  String get recordUpdateFailed => 'Error al actualizar el registro.';

  @override
  String get registrationHistory => 'Historial de Registros';

  @override
  String get failedToSendSchedule => 'Error al enviar la programación';

  @override
  String get serverCommunicationFailed =>
      'Fallo en la comunicación con el servidor';

  @override
  String get failedToFetchCompany => 'Error al buscar la empresa';

  @override
  String get failedToUpdateCompany => 'Error al actualizar la empresa';

  @override
  String get failedToFetchVacancies => 'Error al buscar las plazas';

  @override
  String get failedToFetchCounterName =>
      'Error al buscar el nombre de la taquilla';

  @override
  String get unauthenticatedUser => 'Usuario no autenticado o token no válido.';

  @override
  String get failedToFetchCounterNameStatusCode =>
      'Error al buscar el nombre de la taquilla: Código de estado ';

  @override
  String get invalidCredentials => 'Credenciales no válidas';

  @override
  String get failedToFetchBusPlates =>
      'Error al buscar las matrículas de los autobuses';

  @override
  String get failedToRegisterBus => 'Error al registrar el autobús';

  @override
  String get failedToFetchRecords => 'Error al buscar los registros';

  @override
  String get schedulingSuccess => '¡Programación realizada con éxito!';

  @override
  String get errorSchedulingFailed =>
      'La programación ha fallado. Por favor, inténtelo de nuevo.';

  @override
  String get scheduleVacancy => 'Programar Plaza';

  @override
  String get termsAndConditionsTitle => 'Términos y Condiciones';

  @override
  String get termsAndConditionsBody =>
      'Aquí están los términos y condiciones de OnBus. Al usar la aplicación, usted acepta estos términos.';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get languageNamePortuguese => 'Portugués (Brasil)';

  @override
  String get languageNameEnglish => 'Inglés (EE. UU.)';

  @override
  String get languageNameSpanish => 'Español';

  @override
  String get languageNameFrench => 'Francés';

  @override
  String get languageNameGerman => 'Alemán';

  @override
  String get languageNameItalian => 'Italiano';

  @override
  String get totalRecords => 'Total de Registros: ';

  @override
  String get records => 'Registros';

  @override
  String get plate => 'Matrícula';

  @override
  String unexpectedError(String error) {
    return 'Error inesperado: $error';
  }

  @override
  String loginError(String error) {
    return 'Error al iniciar sesión: $error';
  }

  @override
  String get vacancy => 'Plaza';

  @override
  String get all => 'Todos';
}
