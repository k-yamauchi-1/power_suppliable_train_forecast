import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:power_suppliable_train_forecast/components/dialogs/stoplist_dialog.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/facility.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/models/train.dart';
import 'package:power_suppliable_train_forecast/providers/facility_forecast.dart';

class MockForecastSuccess extends Forecast {
  final Map<String, Facility> data;
  MockForecastSuccess([this.data = const {}]);

  @override
  Future<Map<String, Facility>> build() async => data;
}

class MockForecastLoading extends Forecast {
  @override
  Future<Map<String, Facility>> build() => Completer<Map<String, Facility>>().future;
}

class MockForecastError extends Forecast {
  final Object error;
  MockForecastError(this.error);

  @override
  Future<Map<String, Facility>> build() async {
    await Future.delayed(const Duration(milliseconds: 10));
    throw error;
  }
}

final mockService = Service(
  id: 'test',
  service: 'test',
  companyName: 'test',
  companyShortName: 'test',
  trains: const {},
  stations: const {
    'OH01': Station(name: '新宿', alias: '', intl: ''),
    'OH02': Station(name: '町田', alias: '', intl: ''),
    'OH03': Station(name: '小田原', alias: '', intl: ''),
  },
  facilities: const {
    'f1': Facility(carType: CarType.gse, probabilities: {'1': Probability.a95})
  }
);

void main() {
  setUp(() async => await LocaleSettings.setLocale(AppLocale.ja));

  final train = Train(name: 'はこね', number: 51, facilityId: 'f1', stops: [
    TrainStop(id: 'OH01', hour: 10, min: 0, stopMin: 0),
    TrainStop(id: 'OH02', hour: 10, min: 15, stopMin: 2),
    TrainStop(id: 'OH03', hour: 10, min: 30, stopMin: 3),
  ]);

  testWidgets('renders StopListDialog with title, train stops, and forecast when forecastProvider has value', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        serviceProvider.overrideWithValue(AsyncData(mockService)),
        forecastProvider.overrideWith(() => MockForecastSuccess()),
      ],
      child: MaterialApp(home: Scaffold(
        body: StopListDialog(train: train, stopsNameList: train.stops.map(
          (s) => mockService.stations[s.id]?.name ?? s.id
        ).toList(), facility: mockService.facilities['f1'])
      ))
    ));
    await tester.pumpAndSettle();

    // タイトル部の確認
    expect(find.text('はこね51号'), findsOneWidget);
    expect(find.text('小田原 行'), findsOneWidget);
    expect(find.text(Probability.a95.explanation), findsOneWidget);

    // ヘッダーの確認
    expect(find.text('駅名'), findsOneWidget);
    expect(find.text('着'), findsOneWidget);
    expect(find.text('発'), findsOneWidget);

    // 駅名の確認
    expect(find.text('新宿'), findsOneWidget);
    expect(find.text('町田'), findsOneWidget);
    expect(find.text('小田原'), findsOneWidget);

    // 時刻表示の確認
    // 始発 (新宿): 着「―」, 発「10:00」
    // 途中 (町田): 着「10:13」 (10:15 - 2分), 発「10:15」
    // 終点 (小田原): 着「10:30」 (元時刻), 発「―」
    expect(find.text('10:00'), findsOneWidget);
    expect(find.text('10:13'), findsOneWidget);
    expect(find.text('10:15'), findsOneWidget);
    expect(find.text('10:30'), findsOneWidget);
    expect(find.text('―'), findsNWidgets(2)); // 始発の着と終点の発
  });

  testWidgets('does not render forecast explanation when forecastProvider is loading', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        serviceProvider.overrideWithValue(AsyncData(mockService)),
        forecastProvider.overrideWith(() => MockForecastLoading()),
      ],
      child: MaterialApp(home: Scaffold(
        body: StopListDialog(train: train, stopsNameList: train.stops.map(
          (s) => mockService.stations[s.id]?.name ?? s.id
        ).toList(), facility: mockService.facilities['f1'])
      ))
    ));
    await tester.pump();

    expect(find.text('はこね51号'), findsOneWidget);
    expect(find.text(Probability.a95.explanation), findsNothing);
  });

  testWidgets('does not render forecast explanation when forecastProvider has error', (tester) async {
    await tester.pumpWidget(UncontrolledProviderScope(
      container: ProviderContainer.test(
        retry: (retryCount, error) => null,
        overrides: [
          serviceProvider.overrideWithValue(AsyncData(mockService)),
          forecastProvider.overrideWith(() => MockForecastError(Exception('Mock Error'))),
        ]
      ),
      child: MaterialApp(home: Scaffold(
        body: StopListDialog(train: train, stopsNameList: train.stops.map(
          (s) => mockService.stations[s.id]?.name ?? s.id
        ).toList(), facility: mockService.facilities['f1'])
      ))
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('はこね51号'), findsOneWidget);
    expect(find.text(Probability.a95.explanation), findsNothing);
  });

  testWidgets('closes dialog when close button is tapped', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [serviceProvider.overrideWithValue(AsyncData(mockService))],
      child: MaterialApp(home: Scaffold(body: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => StopListDialog(
              train: train, stopsNameList: train.stops.map(
                (s) => mockService.stations[s.id]?.name ?? s.id
              ).toList(), facility: mockService.facilities['f1']
            )
          ),
          child: const Text('Open')
        )
      )))
    ));

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.byType(StopListDialog), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.byType(StopListDialog), findsNothing);
  });
}
