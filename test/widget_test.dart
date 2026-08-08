import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ownkeep/src/l10n/app_localizations.dart';
import 'package:ownkeep/src/presentation/onboarding/05_set_pin_screen.dart';
import 'package:ownkeep/src/theme/app_theme.dart';

void main() {
  testWidgets('PIN setup renders and accepts keypad input', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const SetPinScreen(),
      ),
    );

    expect(find.text('Set a strong PIN'), findsOneWidget);
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.text('1'));
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}
