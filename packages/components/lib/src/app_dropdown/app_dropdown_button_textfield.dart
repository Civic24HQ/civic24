import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class AppDropdownButtonTextField<T> extends StatelessWidget {
  const AppDropdownButtonTextField({
    required this.items,
    this.value,
    this.hintText,
    this.errorText,
    this.fillColor,
    this.label,
    this.onChanged,
    this.isEnabled = true,
    this.showRequiredIndicator = false,
    this.isDense = false,
    this.isExpanded = true,
    super.key,
  });
  final String? label;
  final bool showRequiredIndicator;
  final T? value;
  final String? hintText;
  final Color? fillColor;
  final String? errorText;
  final bool isEnabled;
  final bool isDense;
  final bool isExpanded;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Flexible(
            child: Text.rich(
              style: context.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
              maxLines: 3,
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
          ),
          AppSpacing.small,
        ],
        InputDecorator(
          decoration: InputDecoration(
            fillColor: fillColor,
            filled: fillColor != null,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              vertical: AppDimensions.padding2,
              horizontal: AppDimensions.padding16,
            ),
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: hasError ? context.error : context.neutralLow),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: context.colorScheme.outlineVariant.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.radius8,
              borderSide: BorderSide(color: context.primaryColor),
            ),
            enabled: isEnabled,
            errorText: errorText,
          ),
          child: DropdownButton<T>(
            underline: const SizedBox.shrink(),
            dropdownColor: context.colorScheme.surface,
            style: context.bodyLarge,
            isDense: isDense,
            menuMaxHeight: 300,
            icon: isEnabled
                ? Icon(SolarIconsOutline.altArrowDown, color: context.neutralHigh)
                : const SizedBox.shrink(),
            value: value,
            isExpanded: isExpanded,
            hint: Text(hintText ?? 'HintText', style: context.bodyMedium?.copyWith(color: context.onSurfaceVariant)),
            items: items,
            onChanged: isEnabled ? onChanged : null,
          ),
        ),
      ],
    );
  }
}
