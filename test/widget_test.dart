import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fit_flow/core/localization/language_cubit.dart';
import 'package:fit_flow/main.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('shows FitFlow splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LanguageCubit(),
        child: const FitFlowApp(),
      ),
    );

    expect(find.text('FitFlow'), findsOneWidget);
    expect(find.text('ELEVATE YOUR MOVEMENT'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
  });
}
