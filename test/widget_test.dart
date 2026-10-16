import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fit_flow/main.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('shows FitFlow splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(const FitFlowApp());

    expect(find.text('FitFlow'), findsOneWidget);
    expect(find.text('ELEVATE YOUR MOVEMENT'), findsOneWidget);
  });
}
