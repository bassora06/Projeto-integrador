// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get askRegisterBusBeforeScheduling =>
      'Deseja cadastrar uma nova placa de ônibus antes de agendar?';

  @override
  String get changeLanguage => 'Mudar Idioma';

  @override
  String get changeRecord => 'Alterar Registro';

  @override
  String get close => 'Fechar';

  @override
  String get cnpj => 'CNPJ';

  @override
  String get companyName => 'Nome da Empresa';

  @override
  String get companyRegisteredSuccess => 'Empresa cadastrada com sucesso!';

  @override
  String get companyUpdatedSuccess => 'Empresa atualizada com sucesso!';

  @override
  String get confirmPassword => 'Confirmar Senha';

  @override
  String get corporateName => 'Razão Social';

  @override
  String get counterExample => 'Guichê Exemplo';

  @override
  String get counterRegisteredSuccess => 'Guichê cadastrado com sucesso!';

  @override
  String get cpf => 'CPF';

  @override
  String get createAccountCompany => 'Criar Conta - Empresa';

  @override
  String get createAccountCounter => 'Criar Conta - Guichê';

  @override
  String get distance => 'Distância';

  @override
  String get docks => 'Docas';

  @override
  String get docksOrganization => 'Organização de Docas';

  @override
  String get editCompany => 'Editar Empresa';

  @override
  String get email => 'Email';

  @override
  String get error => 'Erro';

  @override
  String get exit => 'SAIR';

  @override
  String get featureInProgress => 'Funcionalidade em desenvolvimento.';

  @override
  String get fillAllFields => 'Preencha todos os campos obrigatórios.';

  @override
  String get filtering => 'Filtragem';

  @override
  String get forgotPassword => 'Esqueceu sua senha?';

  @override
  String get free => 'Livre';

  @override
  String get includeRegistration => 'Incluir Cadastro';

  @override
  String get language => 'Idioma';

  @override
  String get login => 'ENTRAR';

  @override
  String get logOut => 'Sair da Conta';

  @override
  String get monitoring => 'Monitoramento';

  @override
  String get name => 'Nome';

  @override
  String get noContinueScheduling => 'Não, continuar agendando';

  @override
  String get noVacanciesAvailable => 'Não há vagas disponíveis no momento.';

  @override
  String get occupied => 'Preenchido';

  @override
  String get ok => 'OK';

  @override
  String get password => 'Senha';

  @override
  String get passwordError => 'Erro de Senha';

  @override
  String get passwordsDoNotMatch =>
      'As senhas digitadas não coincidem. Por favor, verifique e tente novamente.';

  @override
  String get phone => 'Telefone';

  @override
  String get register => 'CADASTRAR';

  @override
  String get registerCompany => 'Cadastrar Empresa';

  @override
  String get registerCounter => 'Cadastrar Guichê';

  @override
  String get registrationFailed => 'O cadastro falhou. Tente novamente.';

  @override
  String get removeFilter => 'Remover Filtro';

  @override
  String get saveChanges => 'SALVAR ALTERAÇÕES';

  @override
  String get scheduleArrival => 'Agendar Chegada';

  @override
  String get scheduleArrivalButton => 'AGENDAR CHEGADA';

  @override
  String get settings => 'Configurações';

  @override
  String get standBy => 'Stand by';

  @override
  String get status => 'Status';

  @override
  String get success => 'Sucesso';

  @override
  String get termsAndConditions =>
      'Declaro que li e concordo com os termos de uso';

  @override
  String get unknownUserType => 'Tipo de usuário desconhecido.';

  @override
  String get vacanciesStatus => 'Status das Vagas:';

  @override
  String get vacancyDetails => 'Detalhes da Vaga';

  @override
  String get yesRegisterBus => 'Sim, cadastrar ônibus';

  @override
  String errorLoadingData(String error) {
    return 'Erro ao carregar os dados: $error';
  }

  @override
  String errorLoadingVacancies(String error) {
    return 'Erro ao carregar vagas: $error';
  }

  @override
  String errorSavingCompany(String error) {
    return 'Erro ao salvar a empresa: $error';
  }

  @override
  String registrationError(String error) {
    return 'Erro no cadastro: $error';
  }

  @override
  String get busPlate => 'Placa do Ônibus';

  @override
  String get selectPlate => 'Selecione a Placa';

  @override
  String get arrivalTime => 'Horário de Chegada';

  @override
  String get selectTime => 'Selecionar Horário';

  @override
  String get arrivalDate => 'Data de Chegada';

  @override
  String get selectDate => 'Selecionar Data';

  @override
  String get additionalData => 'Dados Adicionais';

  @override
  String get schedule => 'AGENDAR';

  @override
  String get plateCannotBeEmpty => 'A placa não pode estar vazia.';

  @override
  String get plateRegisteredSuccess => 'Placa cadastrada com sucesso!';

  @override
  String get plateRegistrationError =>
      'Erro: Placa já cadastrada ou falha no serviço.';

  @override
  String get registerBus => 'Cadastrar Ônibus';

  @override
  String get attention => 'Atenção';

  @override
  String get selectVacancyToSchedule =>
      'Selecione uma vaga para agendar a chegada.';

  @override
  String get confirmSaveChanges => 'Deseja salvar as alterações?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get recordUpdatedSuccess => 'Registro atualizado com sucesso.';

  @override
  String get recordUpdateFailed => 'Falha ao atualizar o registro.';

  @override
  String get registrationHistory => 'Histórico de Registros';

  @override
  String get failedToSendSchedule => 'Falha ao enviar agendamento';

  @override
  String get serverCommunicationFailed => 'Falha na comunicação com o servidor';

  @override
  String get failedToFetchCompany => 'Falha ao buscar empresa';

  @override
  String get failedToUpdateCompany => 'Falha ao atualizar empresa';

  @override
  String get failedToFetchVacancies => 'Falha ao buscar vagas';

  @override
  String get failedToFetchCounterName => 'Falha ao buscar nome do guichê';

  @override
  String get unauthenticatedUser =>
      'Usuário não autenticado ou token inválido.';

  @override
  String get failedToFetchCounterNameStatusCode =>
      'Falha ao buscar nome do guichê: Status code ';

  @override
  String get invalidCredentials => 'Credenciais inválidas';

  @override
  String get failedToFetchBusPlates => 'Falha ao buscar placas de ônibus';

  @override
  String get failedToRegisterBus => 'Falha ao cadastrar ônibus';

  @override
  String get failedToFetchRecords => 'Falha ao buscar registros';

  @override
  String get schedulingSuccess => 'Agendamento realizado com sucesso!';

  @override
  String get errorSchedulingFailed => 'O agendamento falhou. Tente novamente.';

  @override
  String get scheduleVacancy => 'Agendar Vaga';

  @override
  String get termsAndConditionsTitle => 'Termos & Condições';

  @override
  String get termsAndConditionsBody =>
      'Aqui estão os termos e condições do OnBus. Ao usar o aplicativo, você concorda com estes termos.';

  @override
  String get selectLanguage => 'Selecionar Idioma';

  @override
  String get languageNamePortuguese => 'Português (Brasil)';

  @override
  String get languageNameEnglish => 'Inglês (EUA)';

  @override
  String get languageNameSpanish => 'Espanhol';

  @override
  String get languageNameFrench => 'Francês';

  @override
  String get languageNameGerman => 'Alemão';

  @override
  String get languageNameItalian => 'Italiano';

  @override
  String get totalRecords => 'Total de Registros: ';

  @override
  String get records => 'Registros';

  @override
  String get plate => 'Placa';

  @override
  String unexpectedError(String error) {
    return 'Erro inesperado: $error';
  }

  @override
  String loginError(String error) {
    return 'Erro ao fazer login: $error';
  }

  @override
  String get vacancy => 'Vaga';
}
