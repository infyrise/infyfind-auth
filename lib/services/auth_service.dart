import 'package:infyfind_auth/config/api/user_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/AuthResult.dart';
import '../models/User.dart';

class AuthService {


  // =========================
  // REQUEST OTP
  // =========================
  Future<bool> requestOtpEmail(String email) async {
    try {
     final response= await UserApiService.requestOtpEmail(email);
      print(response.data);
      return response.success;
    } catch (e) {
      return false;
    }
  }

  // =========================
  // VERIFY OTP
  // =========================
  Future<AuthResult> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await UserApiService.verifyOtpEmail(
        email: email,
        otp: otp,
        deviceName: "android/ios",
        deviceId: "device-id",
      );

      // API failed
      if (!response.success) {
        return AuthResult(
          token: '',
          message: response.message ?? 'Verification failed',
          user: User.fromJson({}),
        );
      }

      // Convert API response → Model
      final authResult = AuthResult.fromJson(response.data);

      // Save token locally
      if (authResult.token.isNotEmpty) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', authResult.token);
      }

      return authResult;

    } catch (e) {
      return AuthResult(
        token: '',
        message: 'Something went wrong',
        user: User.fromJson({}),
      );
    }
  }

  // =========================
  // GET TOKEN
  // =========================
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // =========================
  // CHECK LOGIN STATUS
  // =========================
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }
}