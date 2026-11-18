import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoggedIn = false.obs;
  final RxString currentUsername = ''.obs;
  final RxBool isPasswordHidden = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Toggle password obscure state
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Check login state from SharedPreferences
  Future<void> checkLoginStatus() async {
    final loggedIn = await _authService.isLoggedIn();
    if (loggedIn) {
      isLoggedIn.value = true;
      currentUsername.value = await _authService.getUsername();
    } else {
      isLoggedIn.value = false;
      currentUsername.value = '';
    }
  }

  // Login method according to criteria:
  // Username must be exactly NIM: 124240060
  // Password must be exactly: 123
  Future<bool> login(String username, String password) async {
    final cleanUsername = username.trim();
    final cleanPassword = password.trim();

    if (cleanUsername != '124240060') {
      Get.snackbar(
        'Login Gagal',
        'Username salah! Gunakan NIM: 124240060',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return false;
    }

    if (cleanPassword != '123') {
      Get.snackbar(
        'Login Gagal',
        'Password salah! Gunakan password: 123',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
      );
      return false;
    }

    // Save session in SharedPreferences
    await _authService.saveLoginSession(cleanUsername);
    isLoggedIn.value = true;
    currentUsername.value = cleanUsername;

    Get.snackbar(
      'Login Berhasil',
      'Selamat datang, $cleanUsername!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );

    Get.offAllNamed('/home');
    return true;
  }

  // Logout method: removes session and returns to login
  Future<void> logout() async {
    await _authService.logout();
    isLoggedIn.value = false;
    currentUsername.value = '';

    Get.snackbar(
      'Logout',
      'Anda telah keluar dari aplikasi.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.grey.shade800,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
    );

    Get.offAllNamed('/login');
  }
}
