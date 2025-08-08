import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styles/styles.dart';

class AutoCompleteField extends StatelessWidget {
  const AutoCompleteField({
    required this.hintText,
    required this.suggestions,
    this.label,
    this.showRequiredIndicator = false,
    this.validationMessage,
    this.onChanged,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.autofillHints,
    super.key,
  });

  final String hintText;
  final String? label;
  final bool showRequiredIndicator;
  final List<String> suggestions;
  final String? validationMessage;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text.rich(
            style: context.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            TextSpan(
              text: label,
              children: [
                if (showRequiredIndicator)
                  TextSpan(
                    text: ' *',
                    style: context.bodyMedium?.copyWith(color: context.error),
                  ),
              ],
            ),
          ),
          AppSpacing.small,
        ],
        Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return const Iterable<String>.empty();
            }

            final input = textEditingValue.text.toLowerCase();

            // Email-specific filtering logic
            if (keyboardType == TextInputType.emailAddress) {
              // If it contains @ and additional character
              final emailRegex = RegExp('@[a-zA-Z0-9_.]+');

              if (textEditingValue.text.contains(emailRegex)) {
                final prefix = textEditingValue.text.substring(0, textEditingValue.text.indexOf('@') + 1);
                final generatedDomainList = suggestions
                    .map((domain) => '$prefix$domain')
                    .where((domain) => domain.toLowerCase().startsWith(input))
                    .toSet()
                    .toList();
                return generatedDomainList;
              } else {
                return const Iterable<String>.empty();
              }
            }

            // General case (non-email autocomplete)
            return suggestions
                .where((suggestion) => suggestion.toLowerCase().startsWith(input))
                .toSet() // Remove duplicates
                .toList();
          },
          fieldViewBuilder:
              (BuildContext context, TextEditingController controller, FocusNode focusNode, VoidCallback _) {
                return TextFormField(
                  key: const ValueKey('autocomplete_field'),
                  controller: controller,
                  focusNode: focusNode,
                  keyboardType: keyboardType,
                  autofillHints: autofillHints,
                  textCapitalization: textCapitalization,
                  inputFormatters: inputFormatters,
                  textInputAction: textInputAction,
                  style: context.bodyMedium,
                  onChanged: onChanged,
                  onFieldSubmitted: onFieldSubmitted,
                  decoration: InputDecoration(
                    errorText: validationMessage,
                    errorStyle: context.bodyMedium?.copyWith(color: context.colorScheme.error),
                    hintStyle: context.bodyMedium?.copyWith(color: context.neutralHigh),
                    hintText: hintText,
                    labelStyle: context.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
                    isDense: true,
                    filled: true,
                    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: AppDimensions.padding16),
                    border: OutlineInputBorder(
                      borderRadius: AppBorderRadius.radius8,
                      borderSide: BorderSide(color: context.primaryColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: AppBorderRadius.radius8,
                      borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: AppBorderRadius.radius8,
                      borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: AppBorderRadius.radius8,
                      borderSide: BorderSide(color: context.primaryColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: AppBorderRadius.radius8,
                      borderSide: BorderSide(color: context.colorScheme.error),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: AppBorderRadius.radius8,
                      borderSide: BorderSide(color: context.colorScheme.error),
                    ),
                  ),
                );
              },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: AlignmentDirectional.topStart,
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius12),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.92,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final option = options.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          onSelected(option);
                          onChanged?.call(option);
                          onFieldSubmitted?.call(option);
                        },
                        child: ListTile(title: Text(option)),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
