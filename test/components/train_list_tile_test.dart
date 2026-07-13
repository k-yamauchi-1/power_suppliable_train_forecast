import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/app_icons/probability_icon.dart';
import 'package:power_suppliable_train_forecast/components/train_list_tile.dart';
import 'package:power_suppliable_train_forecast/models/facility.dart';
import 'package:power_suppliable_train_forecast/models/train.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/providers/facility_forecast.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

final mockService = Service(
  id: 'test',
  service: 'test',
  companyName: 'test',
  companyShortName: 'test',
  trains: const {},
  stations: const {
    'OH01': Station(name: '新宿', alias: '', intl: ''),
    'OH02': Station(name: '町田', alias: '', intl: ''),
    'OH03': Station(name: '小田原', alias: '', intl: '')
  },
  facilities: const {
    'f_typeOnly': Facility(carType: CarType.mse, probabilities: {}),
    'f_single': Facility(
      carType: CarType.gse,
      probabilities: {'1': Probability.a95}
    ),
    'f_multi': Facility(
      carType: CarType.exe,
      probabilities: {'1': Probability.a95, '2': Probability.w80}
    )
  }
);

class ErrorAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    throw Exception('Mock Asset Load Error');
  }
}

class MockForecast extends Forecast {
  final Object error;
  MockForecast(this.error);

  @override
  Future<Map<String, Facility>> build() async {
    await Future.delayed(const Duration(milliseconds: 10));
    throw error;
  }
}

void main() {
  late SharedPreferences sharedPrefs;

  const stdTestTrain = Train(
    name: 'はこね', number: 1, facilityId: 'f_single',
    stops: [
      TrainStop(id: 'OH01', hour: 10, min: 0),
      TrainStop(id: 'OH03', hour: 10, min: 30)
    ]
  );
  Widget createWidget([Train train = stdTestTrain]) => ProviderScope(
    overrides: [
      serviceProvider.overrideWithValue(AsyncData(mockService)),
      sharedPreferencesProvider.overrideWithValue(sharedPrefs)
    ],
    child: MaterialApp(home: Scaffold(body: TrainListTile(train: train)))
  );

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPrefs = await SharedPreferences.getInstance();
  });

  group('TrainListTile', () {
    testWidgets('renders empty space when train stops are empty', (tester) async {
      await tester.pumpWidget(createWidget(stdTestTrain.copyWith(stops: [])));
      expect(find.byType(Container), findsNothing);
    });

    testWidgets(
      'renders train info, fallback asset icons, destinations, and stopovers correctly',
      (tester) async {
        final train = stdTestTrain.copyWith(stops: [
          stdTestTrain.stops.first,
          TrainStop(id: 'OH02', hour: 10, min: 15),
          stdTestTrain.stops.last
        ]);

        await tester.pumpWidget(ProviderScope(
          overrides: [
            serviceProvider.overrideWithValue(AsyncData(mockService)),
            sharedPreferencesProvider.overrideWithValue(sharedPrefs)
          ],
          // フォールバック検証のため DefaultAssetBundle  ∴ createWidget 利用不可
          child: MaterialApp(home: Scaffold(body: DefaultAssetBundle(
            bundle: ErrorAssetBundle(),
            child: TrainListTile(train: train)
          )))
        ));

        // 1. facility cardType bgColor check
        final containerFinder = find.byType(Container).first;
        final decoratedBox =
            tester.widget<Container>(containerFinder).decoration as BoxDecoration;
        expect(decoratedBox.color, CarType.gse.bgColor);

        // 2. Fallback asset icon because asset binary is missing in tests
        // Pump twice to trigger and process asset error fallback
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.byIcon(Icons.train), findsOneWidget);
        expect(find.byIcon(Icons.question_mark), findsOneWidget);

        // 3. Train displays
        expect(find.text('GSE'), findsOneWidget);
        expect(find.text('10:00'), findsOneWidget);
        expect(find.text('はこね1号'), findsOneWidget);

        // 4. Destinations
        expect(find.text('小田原 行'), findsOneWidget);

        // 5. Stops (excluding last)
        expect(find.text('町田 に停車'), findsOneWidget);

        // 6. Probability icon is shown with null probability
        expect(find.byType(ProbabilityIcon), findsOneWidget);
      }
    );

    testWidgets('excludes stopover text if stopsNameList length < 3', (tester) async {
      await tester.pumpWidget(createWidget());

      expect(find.text('小田原 行'), findsOneWidget);
      expect(find.textContaining('に停車'), findsNothing);
    });
  });

  group('ProbabilityIcon', () {
    testWidgets(
      'renders single ProbabilityIcon directly when probabilities has one value',
      (tester) async {
        await tester.pumpWidget(
          createWidget(stdTestTrain.copyWith(facilityId: 'f_single'))
        );
        await tester.pump();

        expect(find.byType(ProbabilityIcon), findsOneWidget);
        expect(find.textContaining('号車'), findsNothing);
      }
    );

    testWidgets(
      'renders vertical column of rows with text and icons when multiple entries present',
      (tester) async {
        await tester.pumpWidget(
          createWidget(stdTestTrain.copyWith(facilityId: 'f_multi'))
        );
        await tester.pump();

        expect(find.byType(ProbabilityIcon), findsNWidgets(2));
        expect(find.text('1\n号車'), findsOneWidget);
        expect(find.text('2\n号車'), findsOneWidget);
      }
    );

    testWidgets(
      'renders red error icon when forecastProvider errors with FirebaseException',
      (tester) async {
        await tester.pumpWidget(UncontrolledProviderScope(
          // FirebaseException is a regular Exception (not an Error),
          // so Riverpod's default retry policy would keep the provider
          // in a "retrying" loading state instead of immediately
          // surfacing AsyncError. Disable retries via a manually
          // created container so the error becomes terminal right away.
          container: ProviderContainer.test(
            retry: (retryCount, error) => null,
            overrides: [
              serviceProvider.overrideWithValue(AsyncData(mockService)),
              sharedPreferencesProvider.overrideWithValue(sharedPrefs),
              forecastProvider.overrideWith(() => MockForecast(FirebaseException(
                plugin: 'firestore',
                code: 'permission-denied',
                message: 'The caller does not have permission'
              )))
            ]
          ),
          child: MaterialApp(home: Scaffold(body: DefaultAssetBundle(
            bundle: ErrorAssetBundle(),
            child: const TrainListTile(train: stdTestTrain)
          )))
        ));

        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(
          tester.widget<Icon>(find.byIcon(Icons.error)).color,
          Colors.redAccent
        );
      }
    );
  });
}
