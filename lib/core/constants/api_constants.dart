class ApiConstants {
  static const String baseUrl = 'http://advisor.careai.in/';

  /// Login auth
  static const String sendOTP = 'CommonAPI/CheckAuthentication';
  static const String verifyOTP = 'CommonAPI/OtpVerification';

  /// Register auth
  static const String sendRegisterOTP = 'CommonAPI/ContactNoVerify';
  static const String getCountries = 'CommonAPI/GetCountry';
  static const String registerClient = 'CommonAPI/ClientRegistration';
  static const String verifyRegisterOTP = 'CommonAPI/OtpVerificationForOtherContact';

  /// CRM API
  static const String crmMastersList = 'BusCrmAPI/BusCRMMastersList';
  static const String crmGetList = 'BusCrmAPI/BusCrmGetList';
  static const String crmViewById = 'BusCrmAPI/BusCrmViewById';
  static const String crmAdd = 'BusCrmAPI/BusCrmAdd';
  static const String crmUpdate = 'BusCrmAPI/BusCrmUpdate';

  /// To-Do / Business Planner API
  static const String plannerDayList = 'BusSopAPI/BusPlannerDayList';
  static const String plannerAddPlan = 'BusSopAPI/BusPlannerAddPlan';
  static const String plannerUpdateStatus = 'BusSopAPI/BusPlannerUpdatePlanStatus';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Map<String, String> headers = {'Content-Type':  'application/json', 'Accept': 'application/json'};
}
