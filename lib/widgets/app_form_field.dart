import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class AppFormField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefix;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  final String? errorText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool required;

  final bool obscureText;
  final bool enabled;
  final int maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final FocusNode? focusNode;

  /// ✅ NEW
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;

  final List<String>? autofillHints;

  const AppFormField({
    super.key,
    required this.label,
    required this.hint,
    this.prefix,
    this.suffixIcon,
    this.onSuffixTap,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.required = false,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onTap,
    this.textInputAction,
    this.onSubmitted,
    this.autofillHints, this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              children: required
                  ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
                  : [],
            ),
          ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction, // ✅ HERE
          onFieldSubmitted: onSubmitted, // ✅ HERE
          obscureText: obscureText,
          enabled: enabled,
          maxLines: maxLines,
          minLines: minLines,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onTap: onTap,
          autofillHints: autofillHints,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix != null ? Icon(prefix, size: 20) : null,
            suffixIcon: suffixIcon != null
                ? InkWell(
                    onTap: onSuffixTap,
                    borderRadius: BorderRadius.circular(20),
                    child: Icon(
                      suffixIcon,
                      size: 20,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              errorText!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ],
    );
  }
}
