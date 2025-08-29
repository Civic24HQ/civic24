part of 'base_button.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.title,
    this.width,
    this.height,
    this.disabled = false,
    this.isBusy = false,
    this.titleColor,
    this.backgroundColor,
    this.textStyle,
    this.onTap,
    this.iconSize,
    this.borderColor,
    this.iconColor,
    this.leadingIcon,
    this.trailingIcon,
    this.shape,
    super.key,
  }) : _size = AppButtonSize.normal;

  const SecondaryButton.small({
    required this.title,
    this.width,
    this.height,
    this.disabled = false,
    this.isBusy = false,
    this.titleColor,
    this.backgroundColor,
    this.textStyle,
    this.onTap,
    this.iconSize,
    this.borderColor,
    this.iconColor,
    this.leadingIcon,
    this.trailingIcon,
    this.shape,
    super.key,
  }) : _size = AppButtonSize.small;

  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final bool disabled;
  final bool isBusy;
  final String title;
  final Color? titleColor;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final Color? borderColor;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final ShapeBorder? shape;

  final AppButtonSize _size;

  @override
  Widget build(BuildContext context) {
    final isDisable = disabled || onTap == null;

    return BaseButton(
      size: _size,
      title: title,
      fillColorBuilder: isDisable ? context.neutralLow : backgroundColor ?? context.primaryContainer,
      textColorBuilder: isDisable ? context.onSurfaceVariant : titleColor ?? context.onPrimaryContainer,
      onTap: onTap,
      width: width,
      height: height,
      disabled: isDisable,
      isBusy: isBusy,
      textStyle: textStyle,
      iconSize: iconSize,
      borderColor: borderColor,
      iconColor: iconColor,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      shape: shape,
    );
  }
}
