part of 'base_button.dart';

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    required this.title,
    this.onTap,
    this.disabled = false,
    this.isBusy = false,
    this.width,
    this.height,
    this.textStyle,
    this.iconColor,
    this.iconSize,
    this.borderColor,
    this.leading,
    this.leadingIcon,
    this.trailingIcon,
    this.shape,
    super.key,
  }) : _size = AppButtonSize.normal;

  const OutlineButton.small({
    required this.title,
    this.width,
    this.height,
    this.disabled = false,
    this.isBusy = false,
    this.textStyle,
    this.onTap,
    this.iconSize,
    this.borderColor,
    this.iconColor,
    this.leading,
    this.leadingIcon,
    this.trailingIcon,
    this.shape,
    super.key,
  }) : _size = AppButtonSize.small;

  final VoidCallback? onTap;
  final bool disabled;
  final bool isBusy;
  final String title;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final Color? iconColor;
  final double? iconSize;
  final Color? borderColor;
  final Widget? leading;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final ShapeBorder? shape;
  final AppButtonSize _size;

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      title: title,
      onTap: onTap,
      disabled: disabled,
      isBusy: isBusy,
      width: width,
      height: height,
      isOutline: true,
      textStyle: textStyle,
      iconColor: iconColor ?? context.outline,
      iconSize: iconSize,
      fillColorBuilder: Colors.transparent,
      textColorBuilder: disabled ? context.outline : context.onSurface,
      borderColor: borderColor,
      leading: leading,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      shape: shape,
      size: _size,
    );
  }
}
