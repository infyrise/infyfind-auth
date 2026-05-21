import 'dart:async';
import 'package:flutter/material.dart';

class VerificationText extends StatefulWidget {
  final String email;
  final Future<void> Function()? onResend;

  const VerificationText({
    super.key,
    required this.email,
    this.onResend,
  });

  @override
  State<VerificationText> createState() => _VerificationTextState();
}

class _VerificationTextState extends State<VerificationText> {
  Timer? _timer;

  int minutes = 0;
  int seconds = 30;

  bool get canResend => minutes == 0 && seconds == 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();

    minutes = 0;
    seconds = 30;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (seconds == 0) {
        if (minutes == 0) {
          timer.cancel();
          setState(() {});
          return;
        }
        minutes--;
        seconds = 59;
      } else {
        seconds--;
      }

      setState(() {});
    });
  }

  void resetTimer() => startTimer();

  String get formattedTime {
    final m = minutes.toString().padLeft(2, '0');
    final s = seconds.toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER ROW (TEXT + BUTTON)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LEFT TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Verify your email",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                          height: 1.3,
                        ),
                        children: [
                          const TextSpan(text: "We’ve sent OTP to "),
                          TextSpan(
                            text: widget.email,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// RIGHT SIDE (TIMER / RESEND)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: canResend
                      ? Colors.black
                      : Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: canResend
                    ? InkWell(
                  onTap: () async {
                    await widget.onResend?.call();
                    resetTimer();
                  },
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Resend in",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}