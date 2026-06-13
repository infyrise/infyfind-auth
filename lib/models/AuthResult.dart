import 'User.dart';

class AuthResult {
  final String accessToken;
  final String refreshToken;
  final User user;
  final String message;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.message,
  });

  factory AuthResult.fromJson(
      Map<String, dynamic> json,
      ) {
    return AuthResult(
      accessToken:
      json['accessToken'] ?? '',

      refreshToken:
      json['refreshToken'] ?? '',

      message:
      json['message'] ?? '',

      user: User.fromJson(
        json['data'] ?? {},
      ),
    );
  }

  bool get hasAccessToken =>
      accessToken.isNotEmpty;

  bool get hasRefreshToken =>
      refreshToken.isNotEmpty;
}