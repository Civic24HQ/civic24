import 'package:assets/asset_gen/fonts.gen.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:styles/src/border_radius.dart';
import 'package:styles/src/colors.dart';

part 'theme_extensions.dart';
part 'typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightThemeData {
    return FlexThemeData.light(
      appBarElevation: 0.5,
      typography: Typography.material2021(platform: defaultTargetPlatform),
      lightIsWhite: true,
      textTheme: _textTheme,
      scaffoldBackground: AppColors.whiteAlt,
      colorScheme: SeedColorScheme.fromSeeds(
        primaryKey: AppColors.primary,
        primary: AppColors.primary.shade500,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary.shade50,
        onPrimaryContainer: AppColors.primary.shade800,
        primaryFixed: AppColors.primary.shade200,
        primaryFixedDim: AppColors.primary.shade50,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondary.shade100,
        onSecondaryContainer: AppColors.secondary.shade800,
        tertiaryContainer: AppColors.neutral.shade50,
        onTertiaryContainer: AppColors.neutral.shade700,
        error: AppColors.errorAccent.shade200,
        onError: AppColors.errorAccent,
        errorContainer: AppColors.errorAccent.shade100,
        onErrorContainer: AppColors.errorAccent.shade400,
        surface: AppColors.white,
        surfaceContainerHighest: AppColors.whiteAlt,
        onSurface: AppColors.black,
        onSurfaceVariant: AppColors.neutral.shade600,
        outline: AppColors.neutral.shade100,
        
        outlineVariant: AppColors.neutral.shade300,
      ),
      extensions: <ThemeExtension<dynamic>>{_lightCustomColorsTheme},
    ).copyWith(
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _textTheme.headlineSmall?.copyWith(color: AppColors.black),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.neutral.shade100)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius12),
      ),
    );
  }

  static ThemeData get darkThemeData {
    return FlexThemeData.dark(
      appBarElevation: 1,
      typography: Typography.material2021(platform: defaultTargetPlatform),
      darkIsTrueBlack: true,
      textTheme: _textTheme,
      scaffoldBackground: AppColors.blackAlt,
      appBarBackground: AppColors.black,
      colorScheme: SeedColorScheme.fromSeeds(
        primaryKey: AppColors.primary,
        primary: AppColors.primary.shade400,
        onPrimary: AppColors.white,
        primaryContainer: AppColors.primary.shade800,
        onPrimaryContainer: AppColors.primary.shade50,
        primaryFixed: AppColors.primary.shade700,
        primaryFixedDim: AppColors.black,
        secondary: AppColors.secondary,
        onSecondary: AppColors.white,
        secondaryContainer: AppColors.secondary.shade800,
        onSecondaryContainer: AppColors.secondary.shade100,
        tertiaryContainer: AppColors.neutral.shade700,
        onTertiaryContainer: AppColors.neutral.shade50,
        error: AppColors.errorAccent.shade200,
        onError: AppColors.white,
        errorContainer: AppColors.errorAccent.shade700,
        onErrorContainer: AppColors.errorAccent.shade100,
        surface: AppColors.black,
        surfaceContainerHighest: AppColors.blackAlt,
        onSurface: AppColors.white,
        onSurfaceVariant: AppColors.neutral.shade100,
      ),
      extensions: <ThemeExtension<dynamic>>{_darkCustomColorsTheme},
    ).copyWith(
      scaffoldBackgroundColor: AppColors.blackAlt,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        titleTextStyle: _textTheme.headlineSmall?.copyWith(color: AppColors.white),
        backgroundColor: AppColors.black,
        shape: RoundedRectangleBorder(side: BorderSide(color: AppColors.neutral.shade700)),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.radius12),
      ),
      canvasColor: AppColors.blackAlt,
    );
  }
}
