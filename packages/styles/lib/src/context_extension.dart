import 'package:flutter/material.dart';
import 'package:styles/src/theme.dart';

extension ThemeContextX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// performs a simple [Theme.of(context)] action and returns given [theme]
  ThemeData get theme => Theme.of(this);

  TextTheme get _textTheme => Theme.of(this).textTheme;

  CustomColors get _customColorScheme => theme.extension<CustomColors>()!;

  // SCHEME COLORS

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// performs a simple [Theme.of(context).surface] action
  /// and returns given [backgroundColor]
  Color get backgroundColor => Theme.of(this).colorScheme.surface;

  /// performs a simple [Theme.of(context).primaryColor] action
  /// and returns given [primaryColor]
  Color get primaryColor => Theme.of(this).primaryColor;

  /// The color of the [Text] and [Icon]s in the [AppBar].
  /// This color is used to configure the [IconTheme] for the app bar.
  /// It is used to color the back button icon, the leading and trailing icons
  /// and the title text.
  Color get textColor => Theme.of(this).colorScheme.onPrimary;

  Color get surface => Theme.of(this).colorScheme.surface;

  Color get primary => Theme.of(this).colorScheme.primary;

  Color get onPrimary => Theme.of(this).colorScheme.onPrimary;

  Color get primaryContainer => Theme.of(this).colorScheme.primaryContainer;

  Color get onPrimaryContainer => Theme.of(this).colorScheme.onPrimaryContainer;

  Color get secondary => Theme.of(this).colorScheme.secondary;

  Color get secondaryContainer => Theme.of(this).colorScheme.secondaryContainer;

  Color get onSecondary => Theme.of(this).colorScheme.onSecondary;

  Color get onSecondaryContainer => Theme.of(this).colorScheme.onSecondaryContainer;

  Color get onSurfaceVariant => Theme.of(this).colorScheme.onSurfaceVariant;

  Color get onSurface => Theme.of(this).colorScheme.onSurface;

  Color get surfaceContainer => Theme.of(this).colorScheme.surfaceContainer;

  Color get surfaceVariant => Theme.of(this).colorScheme.surfaceContainerHighest;

  Color get error => Theme.of(this).colorScheme.error;

  Color get onError => Theme.of(this).colorScheme.onError;

  Color get errorContainer => Theme.of(this).colorScheme.errorContainer;

  Color get onErrorContainer => Theme.of(this).colorScheme.onErrorContainer;

  Color get outline => Theme.of(this).colorScheme.outline;

  Color get outlineVariant => Theme.of(this).colorScheme.outlineVariant;

  /// The color of [Divider]s and [PopupMenuDivider]s, also used
  /// between [ListTile]s, between rows in [DataTable]s, and so forth.
  ///
  /// To create an appropriate [BorderSide] that uses this color, consider
  /// [Divider.createBorderSide].
  Color get dividerColor => Theme.of(this).dividerColor;

  /// The color of the [Text] and [Icon]s in the [AppBar].
  /// This color is used to configure the [IconTheme] for the app bar.
  /// It is used to color the back button icon, the leading and trailing icons
  /// and the title text.

  // CUSTOM COLORS
  Color get primaryAccent => _customColorScheme.primaryAccent!;

  Color get onPrimaryAccent => _customColorScheme.onPrimaryAccent!;

  Color get warning => _customColorScheme.warning!;

  Color get onWarning => _customColorScheme.onWarning!;

  Color get warningContainer => _customColorScheme.warningContainer!;

  Color get onWarningContainer => _customColorScheme.onWarningContainer!;

  Color get success => _customColorScheme.success!;

  Color get onSuccess => _customColorScheme.onSuccess!;

  Color get successContainer => _customColorScheme.successContainer!;

  Color get onSuccessContainer => _customColorScheme.onSuccessContainer!;

  Color get neutralLowest => _customColorScheme.neutralLowest!;

  Color get neutralHighest => _customColorScheme.neutralHighest!;

  Color get neutralLow => _customColorScheme.neutralLow!;

  Color get neutralHigh => _customColorScheme.neutralHigh!;

  // TYPOGRAPHY 2021
  /// Largest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displayLarge => _textTheme.displayLarge;

  /// Middle size of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displayMedium => _textTheme.displayMedium;

  /// Smallest of the display styles.
  ///
  /// As the largest text on the screen, display styles are reserved for short,
  /// important text or numerals. They work best on large screens.
  TextStyle? get displaySmall => _textTheme.displaySmall;

  /// Largest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineLarge => _textTheme.headlineLarge;

  /// Middle size of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineMedium => _textTheme.headlineMedium;

  /// Smallest of the headline styles.
  ///
  /// Headline styles are smaller than display styles. They're best-suited for
  /// short, high-emphasis text on smaller screens.
  TextStyle? get headlineSmall => _textTheme.headlineSmall;

  /// Largest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleLarge => _textTheme.titleLarge;

  /// Middle size of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleMedium => _textTheme.titleMedium;

  /// Smallest of the title styles.
  ///
  /// Titles are smaller than headline styles and should be used for shorter,
  /// medium-emphasis text.
  TextStyle? get titleSmall => _textTheme.titleSmall;

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  TextStyle? get bodyLarge => _textTheme.bodyLarge;

  /// Middle size of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  ///
  /// The default text style for [Material].
  TextStyle? get bodyMedium => _textTheme.bodyMedium;

  /// Smallest of the body styles.
  ///
  /// Body styles are used for longer passages of text.
  TextStyle? get bodySmall => _textTheme.bodySmall;

  /// Largest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  ///
  /// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
  TextStyle? get labelLarge => _textTheme.labelLarge;

  /// Middle size of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions.
  TextStyle? get labelMedium => _textTheme.labelMedium;

  /// Smallest of the label styles.
  ///
  /// Label styles are smaller, utilitarian styles, used for areas of the UI
  /// such as text inside of components or very small supporting text in the
  /// content body, like captions
  TextStyle? get labelSmall => _textTheme.labelSmall;
}
