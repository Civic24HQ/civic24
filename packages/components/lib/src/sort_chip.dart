import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

class SortChip extends StatelessWidget {
  const SortChip({required this.value, this.groupValue, this.onChanged, super.key});

  final String value;
  final String? groupValue;
  final ValueChanged<String?>? onChanged;

  bool get _selected => value == groupValue;

  void _handleChanged(bool? selected) {
    if (selected == null) {
      onChanged!(null);
      return;
    }
    if (selected) {
      onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = _selected ? context.colorScheme.onPrimary : context.colorScheme.onSurface;

    final backgroundColor = _selected ? context.colorScheme.primary : context.neutralLowest;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius4),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      child: InkWell(
        onTap: () => _handleChanged(!_selected),
        borderRadius: AppBorderRadius.radius4,
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: AppDimensions.size8, vertical: AppDimensions.size4),
          child: Text(value, style: context.bodyMedium?.copyWith(color: textColor)),
        ),
      ),
    );
  }
}
