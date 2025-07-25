part of 'base_button.dart';

enum AppButtonSize {
  small,
  normal;

  double get height => switch (this) {
    small => AppDimensions.size28,
    normal => AppDimensions.size48,
  };

  double get width => switch (this) {
    small => AppDimensions.size120,
    normal => double.infinity,
  };

  double get spinnerSize => switch (this) {
    small => AppDimensions.size12,
    normal => AppDimensions.size24,
  };

  double get iconSize => switch (this) {
    small => AppDimensions.size20,
    normal => AppDimensions.size24,
  };

  TextStyle? getTextSize(BuildContext context) => switch (this) {
    small => context.titleSmall,
    normal => context.titleMedium,
  };

  Widget get iconSpacing => switch (this) {
    small => AppSpacing.small,
    normal => AppSpacing.medium,
  };
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
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
    this.leading,
    this.leadingIcon,
    this.trailingIcon,
    this.shape,
    super.key,
  }) : _size = AppButtonSize.normal;

  const PrimaryButton.small({
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
    this.leading,
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
  final Widget? leading;
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
      fillColorBuilder: isDisable ? context.primaryContainer : backgroundColor ?? context.primary,
      textColorBuilder: isDisable ? context.onSurfaceVariant : titleColor ?? context.onPrimary,
      onTap: onTap,
      width: width,
      height: height,
      disabled: isDisable,
      isBusy: isBusy,
      textStyle: textStyle,
      iconSize: iconSize,
      borderColor: borderColor,
      iconColor: iconColor,
      leading: leading,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      shape: shape,
    );
  }
}
