import 'User.dart';

class AuthResult {
  final String token;
  final User user;
  final String message;

  AuthResult({
    required this.token,
    required this.user,
    required this.message,
  });

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    return AuthResult(
      token: json['token'] ?? '',
      message: json['message'] ?? '',
      user: User.fromJson(json['data'] ?? {}),
    );
  }

  bool get hasToken => token.isNotEmpty;
}