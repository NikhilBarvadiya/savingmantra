abstract class IAuthRepository {
  Future<Map<String, dynamic>> sendOTP(String phoneNumber, String loginType);

  Future<Map<String, dynamic>> sendRegisterOTP(String phoneNumber, String loginType);

  Future<Map<String, dynamic>> verifyOTP(String authToken, String phoneNumber, String otp);

  Future<Map<String, dynamic>> verifyRegisterOTP(String authToken, String phoneNumber, String otp);

  Future<Map<String, dynamic>> registerUser({
    required String authToken,
    required String phoneNumber,
    required String fullName,
    required String email,
    required String countryId,
    required String city,
    required String authPin,
  });

  Future<Map<String, dynamic>> getCountries();
}
