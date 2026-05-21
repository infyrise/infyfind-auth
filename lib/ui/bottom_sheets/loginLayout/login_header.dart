import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// ANIMATION
        SizedBox(
          height: 180,
          child: Center(
            child: Lottie.asset(
              'packages/infyfind_auth/assets/lottie/login_first.json',
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(height: 12),

        /// TITLE
        const Text(
          "Welcome Back 👋",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: 0.3,
          ),
        ),

        const SizedBox(height: 6),

        /// SUBTITLE
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Login to continue your journey and access your account securely",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13.5,
              color: Colors.black,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}