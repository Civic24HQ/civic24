import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:localization/src/l10n/generated/l10n.dart';

S get l10n => S.current;

AppLocalizationDelegate get delegate => S.delegate;

Iterable<Locale> get appSupportedLocales => S.delegate.supportedLocales;

Future<void> preloadFirstLocale() async {
  await S.delegate.load(S.delegate.supportedLocales.first);
}

List<LocalizationsDelegate<dynamic>> appLocalizationsDelegates = const [
  S.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

Locale? localeListResolutionCallback(Locale? deviceLocale, Iterable<Locale> supportedLocales) {
  // Helper to find the first supported locale that MaterialLocalizations supports
  Locale firstMaterialSupportedLocale() {
    for (final locale in supportedLocales) {
      if (GlobalMaterialLocalizations.delegate.isSupported(locale)) {
        return locale;
      }
    }
    return supportedLocales.first;
  }

  if (deviceLocale == null) {
    final fallback = firstMaterialSupportedLocale();
    Intl.defaultLocale = fallback.languageCode;
    return fallback;
  }

  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == deviceLocale.languageCode) {
      // If MaterialLocalizations supports this locale, use it; otherwise fall back
      if (GlobalMaterialLocalizations.delegate.isSupported(supportedLocale)) {
        Intl.defaultLocale = supportedLocale.languageCode;
        return supportedLocale;
      }
      final fallback = firstMaterialSupportedLocale();
      Intl.defaultLocale = fallback.languageCode;
      return fallback;
    }
  }

  final fallback = firstMaterialSupportedLocale();
  Intl.defaultLocale = fallback.languageCode;
  return fallback;
}
