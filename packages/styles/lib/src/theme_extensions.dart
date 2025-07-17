part of 'theme.dart';

final _lightCustomColorsTheme = CustomColors(
  success: AppColors.successAccent.shade200,
  onSuccess: AppColors.white,
  successContainer: AppColors.successAccent.shade100,
  onSuccessContainer: AppColors.successAccent.shade400,
  warning: AppColors.warningAccent.shade200,
  onWarning: AppColors.black,
  warningContainer: AppColors.warningAccent.shade100,
  onWarningContainer: AppColors.warningAccent.shade400,
  primaryAccent: AppColors.primary.shade400,
  onPrimaryAccent: AppColors.white,
  neutralLowest: AppColors.neutral.shade50,
  neutralLow: AppColors.neutral.shade100,
  neutralHigh: AppColors.neutral.shade300,
  neutralHighest: AppColors.neutral.shade600,
);

final _darkCustomColorsTheme = CustomColors(
  success: AppColors.successAccent.shade200,
  onSuccess: AppColors.white,
  successContainer: AppColors.successAccent.shade700,
  onSuccessContainer: AppColors.successAccent.shade100,
  warning: AppColors.warningAccent.shade200,
  onWarning: AppColors.black,
  warningContainer: AppColors.warningAccent.shade700,
  onWarningContainer: AppColors.warningAccent.shade100,
  primaryAccent: AppColors.primary.shade500,
  onPrimaryAccent: AppColors.black,
  neutralLowest: AppColors.neutral.shade700,
  neutralHighest: AppColors.neutral.shade100,
  neutralLow: AppColors.neutral.shade500,
  neutralHigh: AppColors.neutral.shade300,
);

class CustomColors extends ThemeExtension<CustomColors> {
  CustomColors({
    this.warning,
    this.onWarning,
    this.warningContainer,
    this.onWarningContainer,
    this.success,
    this.successContainer,
    this.onSuccess,
    this.onSuccessContainer,
    this.primaryAccent,
    this.onPrimaryAccent,
    this.neutralLowest,
    this.neutralHighest,
    this.neutralLow,
    this.neutralHigh,
  });
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? success;
  final Color? successContainer;
  final Color? onSuccess;
  final Color? onSuccessContainer;
  final Color? primaryAccent;
  final Color? onPrimaryAccent;
  final Color? neutralLowest;
  final Color? neutralHighest;
  final Color? neutralLow;
  final Color? neutralHigh;
  @override
  ThemeExtension<CustomColors> copyWith({
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? success,
    Color? successContainer,
    Color? onSuccess,
    Color? onSuccessContainer,
    Color? primaryAccent,
    Color? onPrimaryAccent,
    Color? neutralLowest,
    Color? neutralHighest,
    Color? neutralLow,
    Color? neutralHigh,
  }) {
    return CustomColors(
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      success: success ?? this.success,
      successContainer: successContainer ?? this.successContainer,
      onSuccess: onSuccess ?? this.onSuccess,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      primaryAccent: primaryAccent ?? this.primaryAccent,
      onPrimaryAccent: onPrimaryAccent ?? this.onPrimaryAccent,
      neutralLowest: neutralLowest ?? this.neutralLowest,
      neutralHighest: neutralHighest ?? this.neutralHighest,
      neutralLow: neutralLow ?? this.neutralLow,
      neutralHigh: neutralHigh ?? this.neutralHigh,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      success: Color.lerp(success, other.success, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      primaryAccent: Color.lerp(primaryAccent, other.primaryAccent, t),
      onPrimaryAccent: Color.lerp(onPrimaryAccent, other.onPrimaryAccent, t),
      neutralLowest: Color.lerp(neutralLowest, other.neutralLowest, t),
      neutralHighest: Color.lerp(neutralHighest, other.neutralHighest, t),
      neutralLow: Color.lerp(neutralLow, other.neutralLow, t),
      neutralHigh: Color.lerp(neutralHigh, other.neutralHigh, t),
    );
  }
}
