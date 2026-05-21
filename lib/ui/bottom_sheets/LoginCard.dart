import 'package:flutter/material.dart';
import 'package:infyfind_auth/models/User.dart';
import '../../models/AuthResult.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/app_form_field.dart';
import '../../widgets/app_text.dart';
import 'loginLayout/login_header.dart';
import 'loginLayout/terms_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'loginLayout/verification_text.dart';

enum LoginStep { email, otp, success }

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode otpFocusNode = FocusNode();
  LoginStep step = LoginStep.email;

  final emailController = TextEditingController(text: 'admin@infyrise.com');
  final _otpController = TextEditingController();

  String email = "";
  AuthResult? userData;

  bool isLogin = false;
  String? otpError;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(emailFocusNode);
    });
  }
  // ---------------- EMAIL STEP ----------------
  Widget _emailStep() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const LoginHeader(),
          const SizedBox(height: 20),

          Form(
            key: _formKey,
            child: Column(
              children: [
                AppFormField(
                  focusNode: emailFocusNode,
                  controller: emailController,
                  label: 'Email Id',
                  hint: 'Email Id',
                  required: true,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Email is required';
                    }

                    final regex =
                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                    if (!regex.hasMatch(value.trim())) {
                      return 'Enter a valid email address';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 14),

                AppButton(
                  isLoading: isLogin,
                  title: "Continue",
                  onTap: () async {
                    if (!_formKey.currentState!.validate()) return;

                    setState(() => isLogin = true);

                    email = emailController.text.trim();

                    final ok =
                    await authService.requestOtpEmail(email);
                    if (ok) {
                      setState(() => isLogin = false);
                      setState(() => step = LoginStep.otp);
                      FocusScope.of(context).requestFocus(otpFocusNode);
                    }
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          const TermsText(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------- VERIFY OTP FUNCTION ----------------
  Future<void> _verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.length != 6) return;

    setState(() {
      isLogin = true;
      otpError = null;
    });

    final res = await authService.verifyOtp(
      email: email,
      otp: otp,
    );

    setState(() => isLogin = false);

    if (res.token.isNotEmpty) {
      userData = res;

      setState(() => step = LoginStep.success);

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context, res);
      });
    } else {
      setState(() {
        otpError = res.message.isNotEmpty
            ? res.message
            : "Wrong OTP. Please try again";
      });
    }
  }

  // ---------------- OTP STEP ----------------
  Widget _otpStep() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          AppText(
            'Enter Your Verification Code',
            fontSize: 30,
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),

          const SizedBox(height: 24),

          // ---------------- OTP FIELD ----------------
          PinCodeTextField(
            focusNode: otpFocusNode,
            enablePinAutofill: true,
            controller: _otpController,
            appContext: context,
            length: 6,
            keyboardType: TextInputType.number,

            onChanged: (value) {
              if (otpError != null) {
                setState(() => otpError = null);
              }
            },

            onCompleted: (value) async {
              await _verifyOtp();
            },

            pinTheme: PinTheme(
              inactiveColor: Colors.grey,
              selectedColor: AppColors.primary,
              activeColor: AppColors.primary,
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12),
              fieldHeight: 55,
              fieldWidth: 45,
            ),
          ),

          // ---------------- ERROR MESSAGE ----------------
          if (otpError != null) ...[
            const SizedBox(height: 8),
            Text(
              otpError!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

          const SizedBox(height: 16),

          // ---------------- RESEND ----------------
          VerificationText(
            email: email,
            onResend: () async {
              await authService.requestOtpEmail(email);
            },
          ),

          const SizedBox(height: 28),

          // ---------------- VERIFY BUTTON ----------------
          SizedBox(
            width: double.infinity,
            child: AppButton(
              isLoading: isLogin,
              title: 'Verify',
              onTap: _verifyOtp,
            ),
          ),

          const SizedBox(height: 20),
          const TermsText(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ---------------- SUCCESS ----------------
  Widget _successStep() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 70),
        SizedBox(height: 10),
        Text("Login Successful"),
        const SizedBox(height: 30),
      ],
    );
  }

  // ---------------- BUILD ----------------
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _buildStep(),
    );
  }

  Widget _buildStep() {
    switch (step) {
      case LoginStep.email:
        return _emailStep();
      case LoginStep.otp:
        return _otpStep();
      case LoginStep.success:
        return _successStep();
    }
  }
}