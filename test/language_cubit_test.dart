import 'package:flutter_test/flutter_test.dart';

import 'package:fit_flow/core/localization/app_language.dart';
import 'package:fit_flow/core/localization/language_cubit.dart';
import 'package:fit_flow/i18n/strings.g.dart';

void main() {
  tearDown(
    () => LocaleSettings.setLocale(AppLanguage.defaultLanguage.locale),
  );

  test('starts on the default language', () {
    final cubit = LanguageCubit();
    expect(cubit.state, AppLanguage.defaultLanguage);
    cubit.close();
  });

  test('changeLanguage updates both the Cubit and slang', () async {
    final cubit = LanguageCubit();
    final other = AppLanguage.values
        .firstWhere((l) => l != AppLanguage.defaultLanguage);

    await cubit.changeLanguage(other);

    expect(cubit.state, other);
    expect(LocaleSettings.currentLocale, other.locale);
    cubit.close();
  });

  test('every generated AppLocale has an AppLanguage', () {
    for (final locale in AppLocale.values) {
      expect(AppLanguage.fromLocale(locale).locale, locale);
    }
  });
}
