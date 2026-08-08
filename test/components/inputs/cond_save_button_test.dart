import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/inputs/cond_save_button.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('CondSaveButton', () {
    late SharedPreferences sharedPrefs;

    setUp(() async {
      await LocaleSettings.setLocale(AppLocale.ja);
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();
    });

    Widget createWidgetUnderTest() => ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
      child: const MaterialApp(
        home: Scaffold(body: CondSaveButton()),
      ),
    );

    testWidgets('renders the save label and icon', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('検索条件を保存'), findsOneWidget);
      expect(find.byIcon(Icons.bookmark_add), findsOneWidget);
    });

    testWidgets(
      'tapping saves the current condition and shows a confirmation SnackBar',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());
        final element = tester.element(find.byType(CondSaveButton));
        final container = ProviderScope.containerOf(element);

        expect(container.read(localStorageProvider).conds, isEmpty);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(container.read(localStorageProvider).conds.length, 1);
        expect(
          container.read(localStorageProvider).conds.values.first.depID,
          container.read(condProvider).depID
        );

        expect(find.text('保存しました'), findsOneWidget);
      }
    );
  });
}
