import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/inputs/station_input.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('StationInput', () {
    late SharedPreferences sharedPrefs;
    late Service mockService;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();

      final stationsMap = {
        'OH01': const Station(
          name: '新宿', alias: 'しんじゅく', intl: 'Shinjuku',
          destinations: {Direction.down: '小田原方面'}
        ),
        'OH02': const Station(
          name: '町田', alias: 'まちだ', intl: 'Machida',
          destinations: {Direction.up: '新宿方面', Direction.down: '小田原方面'}
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

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          serviceProvider.overrideWith((ref) => Future.value(mockService)),
        ],
        child: const MaterialApp(home: Scaffold(body: StationInput()))
      );
    }

    testWidgets('renders Autocomplete with initial departure station name', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle(); // Resolve service Future

      expect(find.byType(Autocomplete<MapEntry<String, Station>>), findsOneWidget);
      expect(find.widgetWithText(TextField, '新宿'), findsOneWidget);
    });

    testWidgets('typing a query shows matching station options and selecting one updates condProvider', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Clear initial text and enter "町"
      await tester.enterText(find.byType(TextField), '町');
      await tester.pumpAndSettle(); // Show Autocomplete overlay

      // Option "町田" should appear in the suggestions overlay
      final optionFinder = find.text('町田');
      expect(optionFinder, findsAtLeastNWidgets(1)); // might find in input and in overlay

      // Tap the option in overlay (usually the last or with a specific type, but tap-by-text is fine)
      await tester.tap(optionFinder.last);
      await tester.pumpAndSettle();

      // Check revised state in condProvider
      final element = tester.element(find.byType(StationInput));
      final container = ProviderScope.containerOf(element);
      expect(container.read(condProvider).depID, 'OH02');
      expect(container.read(condProvider).arvIDs, isEmpty);
    });
  });
}
