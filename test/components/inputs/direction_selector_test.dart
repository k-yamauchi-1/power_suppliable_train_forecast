import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/inputs/direction_selector.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('DirectionSelector', () {
    late SharedPreferences sharedPrefs;
    late Service mockService;

    setUp(() async {
      await LocaleSettings.setLocale(AppLocale.ja);
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();

      final stationsMap = {
        'DEP0': const Station(
          name: '駅0', alias: 'えき0', intl: 'Station0',
          destinations: {} // 0 destinations
        ),
        'DEP1': const Station(
          name: '駅1', alias: 'えき1', intl: 'Station1',
          destinations: {Direction.down: '小田原方面'} // 1 destination
        ),
        'DEP2': const Station(
          name: '駅2', alias: 'えき2', intl: 'Station2',
          destinations: {Direction.up: '新宿方面', Direction.down: '小田原方面'} // 2 destinations
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

    Widget createWidgetUnderTest({required String initialDepID}) {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          serviceProvider.overrideWith((ref) => Future.value(mockService)),
        ],
        child: MaterialApp(home: Scaffold(body: Consumer(
          // Ensure we initialize cond with specific depID
          // Wait for a frame to run updating
          builder: (context, ref, child) => const DirectionSelector()
        )))
      );
    }

    testWidgets('renders SizedBox shrink when destinations are empty (0)', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(initialDepID: 'DEP0'));
      await tester.pumpAndSettle();

      final element = tester.element(find.byType(DirectionSelector));
      final container = ProviderScope.containerOf(element);
      container.read(condProvider.notifier).updateProp(depID: 'DEP0');
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButtonFormField<Direction>), findsNothing);
      expect(find.textContaining('方面:'), findsNothing);
    });

    testWidgets('renders Text only when there is exactly 1 destination', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(initialDepID: 'DEP1'));
      await tester.pumpAndSettle();

      final element = tester.element(find.byType(DirectionSelector));
      final container = ProviderScope.containerOf(element);
      container.read(condProvider.notifier).updateProp(depID: 'DEP1');
      await tester.pumpAndSettle();

      expect(find.byType(DropdownButtonFormField<Direction>), findsNothing);
      expect(find.text(t.toward(s: '小田原方面')), findsOneWidget);
    });

    testWidgets('renders DropdownButtonFormField when there are 2 or more destinations and allows switching', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(initialDepID: 'DEP2'));
      await tester.pumpAndSettle();

      final element = tester.element(find.byType(DirectionSelector));
      final container = ProviderScope.containerOf(element);
      container.read(condProvider.notifier)
          .updateProp(depID: 'DEP2', direction: Direction.up);
      await tester.pumpAndSettle();

      final dropdownFinder = find.byType(DropdownButtonFormField<Direction>);
      expect(dropdownFinder, findsOneWidget);

      // Current selection is UP, so '新宿方面' should be showing
      expect(find.text('新宿方面'), findsOneWidget);

      // Open dropdown
      await tester.tap(dropdownFinder);
      await tester.pumpAndSettle();

      // Tap '小田原方面'
      final optionFinder = find.text('小田原方面').last;
      await tester.tap(optionFinder);
      await tester.pumpAndSettle();

      // Expect cond state to update
      expect(container.read(condProvider).direction, Direction.down);
    });
  });
}
