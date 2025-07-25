import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:styles/styles.dart';

part 'primary_button.dart';
part 'outline_button.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.title,
    required this.fillColorBuilder,
    required this.textColorBuilder,
    required this.size,
    this.onTap,
    this.width,
    this.height,
    this.disabled = false,
    this.isBusy = false,
    this.isOutline = false,
    this.textStyle,
    this.iconSize,
    this.borderColor,
    this.leading,
    this.iconColor,
    this.leadingIcon,
    this.trailingIcon,
    this.shape,
    super.key,
  });

  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool disabled;
  final bool isBusy;
  final bool isOutline;
  final String title;
  final Color? fillColorBuilder;
  final Color? textColorBuilder;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;
  final Color? borderColor;
  final Widget? leading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final ShapeBorder? shape;
  final AppButtonSize size;

  void _onTap() {
    if (!isBusy) onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(size: iconSize ?? size.iconSize),
      child: RawMaterialButton(
        onPressed: (disabled || isBusy) ? null : _onTap,
        elevation: 0,
        padding: AppEdgeInsets.padding8,
        fillColor: isOutline ? Colors.transparent : (disabled ? context.primaryContainer : fillColorBuilder),
        shape:
            shape ??
            RoundedRectangleBorder(
              borderRadius: AppBorderRadius.radius40,
              side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
            ),
        constraints: BoxConstraints(minWidth: width ?? size.width, minHeight: height ?? size.height),
        textStyle:
            textStyle ??
            size.getTextSize(context)?.copyWith(color: (disabled && !isOutline) ? context.onSurface : textColorBuilder),
        child: isBusy
            ? Center(
                child: AppBusyIndicator(color: textColorBuilder, size: size.spinnerSize),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) ...[leading!, size.iconSpacing],
                  if (leadingIcon != null) ...[Icon(leadingIcon, color: iconColor), size.iconSpacing],
                  Flexible(child: Text(title)),
                  if (trailingIcon != null) ...[size.iconSpacing, Icon(trailingIcon, color: iconColor)],
                ],
              ),
      ),
    );
  }
}
