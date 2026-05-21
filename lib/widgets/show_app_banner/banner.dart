import 'package:flutter/material.dart';

import '../app_colors.dart';
enum BannerType {
  success,
  error,
  warning,
  info,
}

void showAppBanner(
    BuildContext context, {
      String? message,
      BannerType type = BannerType.success, // ✅ default success
    }) {
  final messenger = ScaffoldMessenger.of(context);

  Color bgColor;
  IconData icon;

  switch (type) {
    case BannerType.success:
      bgColor = AppColors.primary;
      icon = Icons.check_circle;
      break;
    case BannerType.error:
      bgColor = Colors.red;
      icon = Icons.error;
      break;
    case BannerType.warning:
      bgColor = Colors.orange;
      icon = Icons.warning;
      break;
    case BannerType.info:
      bgColor = Colors.blue;
      icon = Icons.info;
      break;
  }

  messenger.hideCurrentMaterialBanner();

  messenger.showMaterialBanner(
    MaterialBanner(
      backgroundColor: bgColor,
      elevation: 2,
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message ?? "Success", // ✅ fallback text
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            messenger.hideCurrentMaterialBanner();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );

  Future.delayed(const Duration(seconds: 3), () {
    messenger.hideCurrentMaterialBanner();
  });
}