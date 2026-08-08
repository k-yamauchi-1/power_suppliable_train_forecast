import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:power_suppliable_train_forecast/components/app_icons/app_icon_base.dart';
import 'package:power_suppliable_train_forecast/components/app_icons/probability_icon.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/facility.dart';

void main() {
  group('ProbabilityIcon', () {
    setUp(() async => await LocaleSettings.setLocale(AppLocale.ja));

    testWidgets('displays correct info and tooltip for w80 (partial seats)', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(
        body: ProbabilityIcon(probability: Probability.w80, size: 50)
      )));

      // AppIconBase check
      expect(find.byType(AppIconBase), findsOneWidget);
      final AppIconBase appIconBase = tester.widget(find.byType(AppIconBase));
      expect(appIconBase.size, 50);
      expect(appIconBase.boltIconDouble, isFalse); // w80 is not allSeats

      // Tooltip message
      expect(find.byType(Tooltip), findsOneWidget);

      final Tooltip tooltip = tester.widget(find.byType(Tooltip));
      expect(tooltip.message, Probability.w80.explanation);

      // Percentage text should be displayed twice (stroke text & fill text)
      expect(find.text('80'), findsNWidgets(2));
      expect(find.byIcon(Icons.bolt), findsOneWidget);
    });

    testWidgets('displays correct info and double bolt icon for a95 (all seats)', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ProbabilityIcon(probability: Probability.a95, size: 60),
        ),
      ));

      final appIconBaseFinder = find.byType(AppIconBase);
      expect(appIconBaseFinder, findsOneWidget);
      final AppIconBase appIconBase = tester.widget(appIconBaseFinder);
      expect(appIconBase.size, 60);
      expect(appIconBase.boltIconDouble, isTrue); // a95 has allSeats = true

      expect(find.text('95'), findsNWidgets(2));
      expect(find.byIcon(Icons.bolt), findsNWidgets(2));
    });

    testWidgets('displays correct fallback info when probability is null', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Scaffold(
        body: ProbabilityIcon(probability: null, size: 50)
      )));

      expect(find.byType(Tooltip), findsOneWidget);
      expect((tester.widget(find.byType(Tooltip)) as Tooltip).message, '');
      expect(find.text('??'), findsNWidgets(2)); // Fallback text '??'
    });
  });
}
