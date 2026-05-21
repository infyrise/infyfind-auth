import 'package:flutter/material.dart';
import 'package:infyfind_auth/widgets/bottom_sheet.dart';
import '../../models/AuthResult.dart';
import 'LoginCard.dart';

class InfyFindAuth {
  static Future<AuthResult?> login(BuildContext context) {
    return appModalBottomSheet<AuthResult>(
      context: context,
      child: const LoginCard(),
    );
  }
}