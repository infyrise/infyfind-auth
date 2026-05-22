import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final bool isOutline;
  final IconData? icon;
  final double? height;
  final double? textFontSize;

  const AppButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.isOutline = false,
    this.height = 52,
    this.textFontSize = 18,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = AppColors.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: height,
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : primaryColor,
        borderRadius: BorderRadius.circular(14),
        border: isOutline ? Border.all(color: primaryColor, width: 1.5) : null,
        boxShadow: isOutline
            ? []
            : [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: isLoading ? null : onTap,
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon,
                              color: isOutline ? primaryColor : Colors.white),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: textFontSize,
                            fontWeight: FontWeight.w600,
                            color: isOutline ? primaryColor : Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
