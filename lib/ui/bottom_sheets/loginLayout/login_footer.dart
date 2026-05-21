import 'package:flutter/material.dart';
import 'package:infyfind_auth/ui/bottom_sheets/loginLayout/terms_text.dart';


class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(child: Divider()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text("You can Connect with"),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        InkWell(
            onTap: () async {
              // final result = await GoogleAuthService().signInWithGoogle();
              //
              // if (result != null) {
              //   print("Logged in as: ${result.user?.email}");
              //   print("Logged in as: ${result.user?.emailVerified}");
              //   print("Logged in as: ${result.user?.displayName}");
              //   print("Logged in as: ${result.user?.phoneNumber}");
              // }
            },
    child: Text("data")),
            // child: const SocialLogin()),
        const SizedBox(height: 20),
        TermsText()
      ],
    );
  }
}
