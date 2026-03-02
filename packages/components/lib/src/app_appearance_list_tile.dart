// ignore_for_file: deprecated_member_use

import 'package:constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

class AppAppearanceListTile extends StatelessWidget {
  const AppAppearanceListTile({required this.mode, this.groupMode, this.onChanged, super.key});

  final AppearanceMode mode;
  final AppearanceMode? groupMode;
  final ValueChanged<AppearanceMode>? onChanged;

  void _handleOnChanged(AppearanceMode? value) {
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
      // TODO(Civic24): Implement the use of RadioGroup to manage group value instead
      child: RadioListTile<AppearanceMode>(
        value: mode,
        groupValue: groupMode,
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: _handleOnChanged,
        title: Text(mode.title, style: context.titleMedium),
        subtitle: Text(mode.description, style: context.bodySmall?.copyWith(color: context.neutralHighest)),
      ),
    );
  }
}
