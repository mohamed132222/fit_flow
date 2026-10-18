import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection_container.dart';
import 'core/localization/app_language.dart';
import 'core/localization/language_cubit.dart';
import 'core/localization/rebuild_all_children.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'i18n/strings.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    BlocProvider(
      create: (_) => LanguageCubit(),
      child: const FitFlowApp(),
    ),
  );
}

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, AppLanguage>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, _) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => rebuildAllChildren(),
        );
      },
      child: BlocBuilder<LanguageCubit, AppLanguage>(
        builder: (context, language) {
          return MaterialApp.router(
            locale: language.flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            onGenerateTitle: (_) => t.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
