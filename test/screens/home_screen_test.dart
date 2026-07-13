import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/error_info.dart';
import 'package:power_suppliable_train_forecast/components/inputs/arv_stations_selector.dart';
import 'package:power_suppliable_train_forecast/components/inputs/cond_save_button.dart';
import 'package:power_suppliable_train_forecast/components/inputs/direction_selector.dart';
import 'package:power_suppliable_train_forecast/components/train_list_tile.dart';
import 'package:power_suppliable_train_forecast/models/facility.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/models/train.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';
import 'package:power_suppliable_train_forecast/screens/home_screen.dart';

final mockService = Service(
  id: 'test', service: 'test', companyName: 'test', companyShortName: 'test',
  stations: const {
    'OH01': Station(name: '新宿', alias: '', intl: ''),
    'OH03': Station(name: '小田原', alias: '', intl: ''),
  },
  facilities: const {'f1': Facility(carType: CarType.gse, probabilities: {})},
  trains: {TimetableDate.weekday: {Direction.up: {'t1': const Train(
    name: 'はこね', number: 1, facilityId: 'f1',
    stops: [
      TrainStop(id: 'OH01', hour: 10, min: 0),
      TrainStop(id: 'OH03', hour: 10, min: 30),
    ]
  )}}}
);

final mockServiceNoTrains = mockService.copyWith(trains: const {});

void main() {
  group('HomeScreen', () {
    late SharedPreferences sharedPrefs;

    setUp(() async {
      // already initialized, so AppInfoDialog is not shown
      SharedPreferences.setMockInitialValues({'init': 1});
      sharedPrefs = await SharedPreferences.getInstance();
    });

    Widget createWidgetUnderTest({required AsyncValue<Service> serviceValue}) =>
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(sharedPrefs),
            serviceProvider.overrideWithValue(serviceValue)
          ],
          child: const MaterialApp(home: HomeScreen())
        );

    testWidgets('shows a loading indicator while the service is loading', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(serviceValue: const AsyncLoading())
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(TrainListTile), findsNothing);
    });

    testWidgets(
      'shows ErrInfoWidget with debug details when the service errors',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest(
          serviceValue: AsyncError(Exception('boom'), StackTrace.current),
        ));
        await tester.pump();

        expect(find.byType(ErrInfoWidget), findsOneWidget);
        expect(find.textContaining('エラー: Exception: boom'), findsOneWidget);
        expect(find.byType(TrainListTile), findsNothing);
      }
    );

    testWidgets('shows a message when no trains match the current condition', (tester) async {
      await tester.pumpWidget(
        createWidgetUnderTest(serviceValue: AsyncData(mockServiceNoTrains))
      );
      await tester.pump();

      expect(find.text('条件に一致する列車はありません'), findsOneWidget);
      expect(find.byType(TrainListTile), findsNothing);
    });

    testWidgets(
      'renders matching trains and the condition inputs for a known station',
      (tester) async {
        await tester.pumpWidget(
          createWidgetUnderTest(serviceValue: AsyncData(mockService))
        );
        await tester.pump();

        // TargetDate.today depends on the real current date/time, which would
        // make this test flaky. Switch to TargetDate.weekday, whose matching
        // logic (and the fixture data above) is time-independent.
        ProviderScope.containerOf(tester.element(find.byType(HomeScreen)))
            .read(condProvider.notifier).updateProp(target: TargetDate.weekday);
        await tester.pump();

        expect(find.byType(TrainListTile), findsOneWidget);
        expect(find.text('条件に一致する列車はありません'), findsNothing);

        // depID 'OH01' exists in mockService.stations, so the extra condition
        // inputs should be shown.
        expect(find.byType(DirectionSelector), findsOneWidget);
        expect(find.byType(ArvStationsSelector), findsOneWidget);
        expect(find.byType(CondSaveButton), findsOneWidget);
      }
    );
  });
}
