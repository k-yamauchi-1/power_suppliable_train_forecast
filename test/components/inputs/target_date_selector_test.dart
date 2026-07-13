import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/inputs/target_date_selector.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('TargetDateSelector', () {
    late SharedPreferences sharedPrefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
        child: const MaterialApp(home: Scaffold(body: TargetDateSelector()))
      );
    }

    testWidgets('renders all TargetDate options with radio buttons and allows selection', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Check for labels of options
      expect(find.text('本日'), findsOneWidget);
      expect(find.text('明日'), findsOneWidget);
      expect(find.text('平日'), findsOneWidget);
      expect(find.text('土休日'), findsOneWidget);

      // Verify that Radio widgets are rendered (4 options)
      expect(find.byType(Radio<TargetDate>), findsNWidgets(4));

      // Initially, Today is selected.
      // Let's tap '明日' (or its label via InkWell)
      await tester.tap(find.text('明日'));
      await tester.pumpAndSettle();

      // Verify the state is updated (we can check if '明日''s Radio is the selected one,
      // or we can test that it successfully processed with pumpAndSettle.
      // We can also verify that the correct target can be read from the container)
      final element = tester.element(find.byType(TargetDateSelector));
      final container = ProviderScope.containerOf(element);
      expect(container.read(condProvider).target, TargetDate.nextDay);

      // Now tap '平日' and verify
      await tester.tap(find.text('平日'));
      await tester.pumpAndSettle();
      expect(container.read(condProvider).target, TargetDate.weekday);
    });
  });
}
