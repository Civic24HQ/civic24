import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styles/styles.dart';

part 'base_text_field.dart';

enum AppTextFieldType { regular }

class AppTextField extends StatelessWidget {
  const AppTextField({
    this.controller,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters = const [],
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.autofocus = false,
    this.helperText,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.label,
    this.onChanged,
    this.onTap,
    this.validator,
    this.readOnly = false,
    this.fillColor,
    this.filled = false,
    this.obscureText = false,
    this.showRequiredIndicator = false,
    super.key,
    this.focusNode,
    this.enabledBorder,
    this.initialValue,
    this.onEditingComplete,
    this.textInputAction,
    this.autofillHints,
    this.maxLines = 1,
    this.type = AppTextFieldType.regular,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool enabled;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final String? label;
  final String? errorText;
  final String? helperText;
  final String? hintText;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onEditingComplete;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final List<String>? autofillHints;
  final int? maxLines;
  final AppTextFieldType type;
  final bool showRequiredIndicator;
  final bool? filled;
  final Color? fillColor;
  final Color? enabledBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      AppTextFieldType.regular => _BaseTextField(
        filled: filled,
        onTap: onTap,
        enabledBorder: enabledBorder,
        fillColor: fillColor,
        label: label,
        showRequiredIndicator: showRequiredIndicator,
        readOnly: readOnly,
        autofocus: autofocus,
        obscureText: obscureText,
        controller: controller,
        enabled: enabled,
        errorText: errorText,
        helperText: helperText,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        textCapitalization: textCapitalization,
        autofillHints: autofillHints,
        focusNode: focusNode,
        hintText: hintText,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        onEditingComplete: onEditingComplete,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        textInputAction: textInputAction,
      ),
    };
  }
}
