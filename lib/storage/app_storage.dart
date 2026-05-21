import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class AppStorage {
  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';
  static const _userModeKey = 'user_mode';
  static const _key = 'APP_CONFIG';



  /// Clear AppConfig from local storage
  static Future<void> clear() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
    } catch (e) {
      debugPrint('Error clearing AppConfig: $e');
    }
  }

  static Future<void> saveUserMode(String mode) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_userModeKey, mode);
  }

  static Future<String?> getUserMode() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_userModeKey);
  }

  static Future<void> clearUserMode() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_userModeKey);
  }

  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  static Future<void> saveUser(UserModel user) async {
    final pref = await SharedPreferences.getInstance();
    // await pref.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(_userKey);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  static Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}

class UserMode {
  static const search = 'search_job';
  static const post = 'post_job';
}
