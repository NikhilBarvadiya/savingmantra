import 'package:shared_preferences/shared_preferences.dart';
import 'package:savingmantra/core/constants/app_constants.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Token Management
  static Future<void> setToken(String token) async {
    await _prefs?.setString(AppConstants.tokenKey, token);
  }

  static String getToken() {
    return _prefs?.getString(AppConstants.tokenKey) ?? '';
  }

  static Future<void> removeToken() async {
    await _prefs?.remove(AppConstants.tokenKey);
  }

  /// User Data Management
  static Future<void> setUserData(String userData) async {
    await _prefs?.setString(AppConstants.userKey, userData);
  }

  static String getUserData() {
    return _prefs?.getString(AppConstants.userKey) ?? '';
  }

  /// Login Status
  static Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(AppConstants.isLoggedInKey, value);
  }

  static bool isLoggedIn() {
    return _prefs?.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  /// Clear all data
  static Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
