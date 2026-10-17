import 'package:flutter/widgets.dart';

import '../../i18n/strings.g.dart';

enum AppLanguage {
  en(AppLocale.en, 'English'),
  ar(AppLocale.ar, 'العربية');

  const AppLanguage(this.locale, this.nativeName);

  final AppLocale locale;

  final String nativeName;

  Locale get flutterLocale => locale.flutterLocale;

  String get languageTag => locale.languageTag;

  static const AppLanguage defaultLanguage = AppLanguage.en;

  static AppLanguage fromLocale(AppLocale locale) => AppLanguage.values
      .firstWhere((l) => l.locale == locale, orElse: () => defaultLanguage);
}
