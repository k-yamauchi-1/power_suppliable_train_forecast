import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/dialogs/saved_cond_dialog.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('RecordsDialog & RecordListTile', () {
    late SharedPreferences sharedPrefs;
    late Service mockService;

    setUp(() async {
      await LocaleSettings.setLocale(AppLocale.ja);
      final stationsMap = {
        'OH01': const Station(
          name: '新宿', alias: '新宿', intl: 'Shinjuku',
          destinations: {Direction.down: '小田原方面'}
        ),
        'OH02': const Station(
          name: '本厚木', alias: '本厚木', intl: 'Hon-Atsugi',
          destinations: {Direction.up: '新宿方面'}
        ),
      };

      mockService = Service(
        id: 'romancecar',
        service: 'ロマンスカー',
        companyName: '小田急',
        companyShortName: '小田急',
        stations: stationsMap,
        facilities: {},
        trains: {},
      );
    });

    Widget createWidgetUnderTest(SharedPreferences prefs) {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          serviceProvider.overrideWith((ref) => Future.value(mockService))
        ],
        child: MaterialApp(home: Scaffold(
          body: Consumer(builder: (context, ref, child) {
            // Watch serviceProvider so that it starts resolving immediately and
            // becomes AsyncData by the time the button is clicked and the dialog reads it.
            ref.watch(serviceProvider);
            return ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const RecordsDialog(),
              ),
              child: const Text('Show')
            );
          })
        ))
      );
    }

    testWidgets('renders records dialog details, supports pinning, deletion, and selection', (WidgetTester tester) async {
      // 1. Initial Preferences setup with 2 records
      final cond1 = const SearchCond(depID: 'OH01', target: TargetDate.today);
      final cond2 = const SearchCond(depID: 'OH02', target: TargetDate.weekday);

      SharedPreferences.setMockInitialValues({
        'saved_conditions': jsonEncode({
          '100': cond1.toJson(),
          '200': cond2.toJson()
        }),
        'init': 100  // initialized with cond1 pinned
      });
      sharedPrefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(createWidgetUnderTest(sharedPrefs));
      await tester.pumpAndSettle();

      // Click "Show"
      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Dialog is shown
      expect(find.byType(RecordsDialog), findsOneWidget);
      expect(find.text('保存した検索条件'), findsOneWidget);

      // Verify records details are shown
      // cond1:新宿発 本日
      // cond2:本厚木発 平日
      expect(find.textContaining('新宿発'), findsOneWidget);
      expect(find.textContaining('本厚木発'), findsOneWidget);

      final element = tester.element(find.byType(RecordsDialog));
      final container = ProviderScope.containerOf(element);

      // Verify pin state of Record 1 (Key 100) vs Record 2 (Key 200)
      // Since Record 1 is pinned, its icon is Icons.push_pin_outlined (which is odd code logic: if record.key == initKey then push_pin_outlined else push_pin. Let's verify from code: record.key == repository.state.initKey ? push_pin_outlined : push_pin)
      // Key 100: push_pin_outlined, Key 200: push_pin
      expect(find.byIcon(Icons.push_pin_outlined), findsOneWidget);
      expect(find.byIcon(Icons.push_pin), findsOneWidget);

      // Tap Pin on Key 200
      final pinButtonFinder = find.byIcon(Icons.push_pin);
      await tester.tap(pinButtonFinder);
      await tester.pumpAndSettle();

      // Verified updated initKey in SharedPreferences / local repo state
      expect(container.read(localStorageProvider).initKey, 200);

      // Tap reverse order toggle button
      await tester.tap(find.byIcon(Icons.swap_vert));
      await tester.pumpAndSettle();

      // Tap onDelete button for Key 100 (it should delete Key 100)
      final deleteButtons = find.byIcon(Icons.delete);
      expect(deleteButtons, findsNWidgets(2));

      // Delete first record in list
      await tester.tap(deleteButtons.first);
      await tester.pumpAndSettle();

      // Verify one condition is remaining
      expect(container.read(localStorageProvider).conds.length, 1);

      // Tap remaining list item to choose SearchCond and close Dialog
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      // Dialog should close, and condProvider should be updated
      expect(find.byType(RecordsDialog), findsNothing);
      expect(container.read(condProvider).depID, isNotNull);
    });

    testWidgets('clicking close button dismisses dialog', (WidgetTester tester) async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(createWidgetUnderTest(sharedPrefs));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      expect(find.byType(RecordsDialog), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(find.byType(RecordsDialog), findsNothing);
    });
  });
}
