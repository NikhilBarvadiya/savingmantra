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

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const Map<String, String> headers = {'Content-Type': 'application/json', 'Accept': 'application/json'};
}
