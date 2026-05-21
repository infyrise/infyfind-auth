import 'dart:math';

import 'package:dio/dio.dart';

import '../api_config.dart';
import '../api_response.dart';
import '../dio_client.dart';

class UserApiService {
  /// 📩 Request OTP
  static Future<ApiResponse> requestOtpEmail(String email) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.sendOtp,
        data: {
          "email": email.trim(),
        },
      );
      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?['message'] ?? 'Something went wrong',
      );
    } catch (_) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  /// 🔐 Verify OTP
  static Future<ApiResponse> verifyOtpEmail({
    required String email,
    required String otp,
    required String deviceName,
    required String deviceId,
    String? os,
    String? browser,
    String? appVersion,
    String? location,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        ApiEndpoints.verifyOtp,
        data: {
          "email": email.trim(),
          "otp": otp.trim(),
          "device_name": deviceName,
          "device_id": deviceId,
          "os": os ?? '',
          "browser": browser ?? '',
          "app_version": appVersion ?? '',
          "location": location ?? '',
        },
      );

      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?['message'] ?? 'Invalid OTP',
      );
    } catch (_) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  /// 👤 Get User Profile
  static Future<ApiResponse> getUser() async {
    try {
      final response = await ApiClient.dio.get(ApiEndpoints.me);
      return ApiResponse.success(response.data);
    } on DioException catch (_) {
      return ApiResponse.error('Unauthorized');
    } catch (_) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }

  /// ✏️ Update Profile
  static Future<ApiResponse> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await ApiClient.dio.put(
        ApiEndpoints.userUpdate,
        data: data,
      );

      return ApiResponse.success(response.data);
    } on DioException catch (e) {
      return ApiResponse.error(
        e.response?.data?['message'] ?? 'Update failed',
      );
    } catch (_) {
      return ApiResponse.error('Unexpected error occurred');
    }
  }
}