import 'package:flutter/material.dart';
import 'app_colors.dart';

class ContainerButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isLoading;
  final double borderRadius;
  final Color borderColor;
  final Color textColor;
  final Color backgroundColor;
  final EdgeInsets padding;

  const ContainerButton({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.isLoading = false,
    this.borderRadius = 30,
    this.borderColor =  AppColors.primary,
    this.textColor = AppColors.primary,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: isLoading ? null : onTap,
        child: Container(
          width: double.infinity,
          padding: padding,
          decoration: BoxDecoration(
            color: isSelected
                ? borderColor.withOpacity(0.1)
                : backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: 1.2),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, color: textColor),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}