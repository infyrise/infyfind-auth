import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infyfind_auth/config/string.dart';

import '../../../util/UrlHelper.dart';

class TermsText extends StatelessWidget {
  const TermsText({super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "By signing up, you agree to ",
          style: const TextStyle(color: Colors.black54, fontSize: 14),
          children: [
            TextSpan(
              text: "InfyFind Terms & Conditions",
              style: const TextStyle(
                color: Color(0xFF4F7C7A),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  UrlHelper.openUrl("${ApiConstants.mainUrl}/privacy-policy");
                },
            ),
            const TextSpan(text: " and "),
            TextSpan(
              text: "Privacy Policy",
              style: const TextStyle(
                color: Color(0xFF4F7C7A),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  UrlHelper.openUrl("${ApiConstants.mainUrl}/privacy-policy");
                },
            ),
            const TextSpan(text: "."),
          ],
        ),
      ),
    );
  }
}
