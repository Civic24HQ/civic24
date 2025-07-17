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
  if (deviceLocale == null) {
    Intl.defaultLocale = supportedLocales.first.languageCode;
    return supportedLocales.first;
  }

  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == deviceLocale.languageCode) {
      Intl.defaultLocale = supportedLocale.languageCode;
      return supportedLocale;
    }
  }

  Intl.defaultLocale = supportedLocales.first.languageCode;
  return supportedLocales.first;
}
