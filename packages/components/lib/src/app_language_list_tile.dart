import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:styles/styles.dart';

class AppLanguageListTile extends StatelessWidget {
  const AppLanguageListTile({required this.value, required this.groupValue, required this.onChanged, super.key});

  final LanguageType value;
  final LanguageType groupValue;
  final ValueChanged<LanguageType>? onChanged;

  bool get _isSelected => groupValue == value;

  void _handleOnChanged(LanguageType? value) {
    if (onChanged != null) {
      onChanged?.call(value!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius8),
      child: RadioListTile(
        value: value,
        groupValue: groupValue,
        onChanged: _handleOnChanged,
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: context.primary,
        title: Text(value.title, style: context.titleMedium),
        subtitle: Text(
          _isSelected ? l10n.featureSettingsLanguageDefault : value.subtitle,
          style: context.bodySmall?.copyWith(color: context.neutralHighest),
        ),
        secondary: Text(value.flag, style: context.headlineLarge),
      ),
    );
  }
}
