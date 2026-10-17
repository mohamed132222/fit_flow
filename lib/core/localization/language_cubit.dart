import 'package:flutter_bloc/flutter_bloc.dart';

import '../../i18n/strings.g.dart';
import 'app_language.dart';

class LanguageCubit extends Cubit<AppLanguage> {
  LanguageCubit() : super(AppLanguage.defaultLanguage);

  Future<void> changeLanguage(AppLanguage language) async {
    if (language == state) return;
    await LocaleSettings.setLocale(language.locale);
    emit(language);
  }
}
