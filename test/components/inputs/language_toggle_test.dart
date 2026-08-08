import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:power_suppliable_train_forecast/components/inputs/language_toggle.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';

void main() {
  group('LanguageToggle', () {
    setUp(() async => await LocaleSettings.setLocale(AppLocale.ja));

    Widget createWidgetUnderTest() => ProviderScope(child: TranslationProvider(
      child: const MaterialApp(home: Scaffold(body: LanguageToggle()))
    ));

    testWidgets('renders SegmentedButton with ja and en options', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(SegmentedButton<AppLocale>), findsOneWidget);
      expect(find.text('日本語'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });

    testWidgets('switching locale updates currentLocale', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(LocaleSettings.currentLocale, AppLocale.ja);

      // Tap English
      await tester.tap(find.text('English'));
      await tester.pumpAndSettle();

      expect(LocaleSettings.currentLocale, AppLocale.en);
    });

    testWidgets('renders without overflow inside a Row', (tester) async {
      await tester.pumpWidget(ProviderScope(child: TranslationProvider(
        child: const MaterialApp(home: Scaffold(
          body: Row(children: [LanguageToggle(), Text('Other content')])
        ))
      )));

      expect(find.byType(LanguageToggle), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
