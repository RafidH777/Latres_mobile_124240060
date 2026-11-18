import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _keyIsLogin = 'isLogin';
  static const String _keyUsername = 'username';

  // Save session when user logs in
  Future<bool> saveLoginSession(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLogin, true);
    await prefs.setString(_keyUsername, username);
    return true;
  }

  // Check whether user is logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLogin) ?? false;
  }

  // Retrieve saved username
  Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername) ?? '';
  }

  // Clear session on logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLogin, false);
    await prefs.remove(_keyUsername);
  }
}
