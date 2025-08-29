import 'package:flutter/material.dart';
import 'package:solar_icons/solar_icons.dart';
import 'package:styles/styles.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    required this.label,
    this.isSelected = false,
    this.tooltip,
    this.trailingIcon,
    this.trailingIconTooltip,
    this.onTrailingIconPressed,
    this.onSelected,
    this.smallChip = false,
    super.key,
  });

  final String label;
  final bool isSelected;
  final String? tooltip;
  final Widget? trailingIcon;
  final String? trailingIconTooltip;
  final VoidCallback? onTrailingIconPressed;
  final ValueChanged<bool>? onSelected;
  final bool smallChip;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      padding: smallChip
          ? const EdgeInsets.symmetric(horizontal: AppDimensions.padding12, vertical: AppDimensions.padding8)
          : const EdgeInsets.symmetric(horizontal: AppDimensions.padding24, vertical: AppDimensions.padding12),
      tooltip: tooltip,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.radius8,
        side: BorderSide(color: isSelected ? context.primary : Colors.transparent),
      ),
      label: Text(label),
      labelStyle: context.bodyMedium?.copyWith(color: context.onSurface),
      backgroundColor: isSelected ? context.surface : context.tertiaryContainer,
      deleteButtonTooltipMessage: trailingIconTooltip,
      deleteIconBoxConstraints: const BoxConstraints(minWidth: AppDimensions.size8, minHeight: AppDimensions.size8),
      onDeleted: onTrailingIconPressed,
      deleteIcon:
          trailingIcon ?? Icon(SolarIconsOutline.infoCircle, size: AppDimensions.size16, color: context.primary),
      onSelected: onSelected,
      selected: isSelected,
      showCheckmark: false,
      selectedColor: context.surface,
    );
  }
}
