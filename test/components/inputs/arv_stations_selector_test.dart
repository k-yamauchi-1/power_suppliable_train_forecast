import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/inputs/arv_stations_selector.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('ArvStationsSelector', () {
    late SharedPreferences sharedPrefs;
    late Service mockServiceEmpty;
    late Service mockServiceWithReachables;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();

      final stationsMap = {
        'OH01': const Station(
          name: '新宿', alias: '新宿', intl: 'Shinjuku',
          destinations: {Direction.down: '小田原方面'}
        ),
        'OH02': const Station(
          name: '町田', alias: '町田', intl: 'Machida',
          destinations: {Direction.up: '新宿方面'}
        ),
      };

      mockServiceEmpty = Service(
        id: 'romancecar',
        service: 'ロマンスカー',
        companyName: '小田急',
        companyShortName: '小田急',
        stations: stationsMap,
        facilities: {},
        trains: {},
        surcharges: [],
      );

      mockServiceWithReachables = Service(
        id: 'romancecar',
        service: 'ロマンスカー',
        companyName: '小田急',
        companyShortName: '小田急',
        stations: stationsMap,
        facilities: {},
        trains: {},
        surcharges: [
          const Surcharge(from: 'OH01', to: 'OH02', price: 450),
        ],
      );
    });

    Widget createWidgetUnderTest(Service service) {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          serviceProvider.overrideWith((ref) => Future.value(service)),
        ],
        child: const MaterialApp(home: Scaffold(
            body: SingleChildScrollView(child: ArvStationsSelector())
        ))
      );
    }

    testWidgets('renders SizedBox shrink when reachables is empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(mockServiceEmpty));
      await tester.pumpAndSettle();

      expect(find.byType(ExpansionTile), findsNothing);
    });

    testWidgets('renders ExpansionTile and FilterChips when reachables exist, and reacts to toggling selection', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(mockServiceWithReachables));
      await tester.pumpAndSettle();

      // ExpansionTile should be rendered
      expect(find.byType(ExpansionTile), findsOneWidget);
      expect(find.text('停車駅で絞込み'), findsOneWidget);

      // Expand the ExpansionTile
      await tester.tap(find.text('停車駅で絞込み'));
      await tester.pumpAndSettle();

      // Find FilterChip for "町田 450円"
      final chipFinder = find.byType(FilterChip);
      expect(chipFinder, findsOneWidget);
      expect(find.textContaining('町田'), findsOneWidget);
      expect(find.textContaining('450円'), findsOneWidget);

      // Currently, it is unselected. Let's tap it.
      await tester.tap(chipFinder);
      await tester.pumpAndSettle();

      // Verify condProvider state updated
      final element = tester.element(find.byType(ArvStationsSelector));
      final container = ProviderScope.containerOf(element);
      expect(container.read(condProvider).arvIDs, contains('OH02'));

      // Checkmark or selected color should apply now. Let's tap again to remove selection.
      await tester.tap(chipFinder);
      await tester.pumpAndSettle();

      expect(container.read(condProvider).arvIDs, isEmpty);
    });
  });
}
