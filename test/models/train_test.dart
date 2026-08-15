import 'package:flutter_test/flutter_test.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/train.dart';

void main() {
  setUp(() async => await LocaleSettings.setLocale(AppLocale.ja));

  group('TrainStop', () {
    test('dateMin calculation is correct', () {
      const stop1 = TrainStop(id: 'OH01', hour: 6, min: 5);
      expect(stop1.dateMin, 365);

      const stop2 = TrainStop(id: 'OH01', hour: 23, min: 59);
      expect(stop2.dateMin, 1439);
    });

    test('dispTime adds 0 padding correctly', () {
      const stop1 = TrainStop(id: 'OH01', hour: 6, min: 5);
      expect(stop1.dispTime, '06:05');

      const stop2 = TrainStop(id: 'OH01', hour: 12, min: 34);
      expect(stop2.dispTime, '12:34');
    });

    test('fromJson & toJson map correctly', () {
      final json = {'id': 'OH20', 'hour': 18, 'min': 45};
      final stop = TrainStop.fromJson(json);

      expect(stop.id, 'OH20');
      expect(stop.hour, 18);
      expect(stop.min, 45);

      expect(stop.toJson(), json);
    });
  });

  group('Train', () {
    final stdTestTrain = Train(
      name: 'はこね', number: 51, facilityId: 'f1',
      stops: [
        TrainStop(id: 'OH01', hour: 10, min: 0),
        TrainStop(id: 'OH02', hour: 10, min: 15),
        TrainStop(id: 'OH03', hour: 10, min: 30)
      ]
    );

    test('dispName formats train name and number', () {
      expect(
        Train(name: 'はこね', number: 51, facilityId: 'f1', stops: []).dispName,
        'はこね51号'
      );
    });

    test('stopsAt returns null if depID is not found or is the last stop', () {
      // 存在しない駅
      expect(stdTestTrain.stopsAt(depID: 'OH99'), isNull);
      // 終着駅を発駅に指定
      expect(stdTestTrain.stopsAt(depID: 'OH03'), isNull);
    });

    test('stopsAt slices stops and returns Train if depID is valid and arvIDs is empty', () {
      final train = stdTestTrain.stopsAt(depID: 'OH02');
      expect(train, isNotNull);

      final slicedStops = train!.stops.sublist(train.depIdx);
      expect(slicedStops.length, 2);
      expect(slicedStops.first.id, 'OH02');
      expect(slicedStops.last.id, 'OH03');
    });

    test('stopsAt matches arvIDs correctly and slices', () {
      // 下車駅がマッチする
      final sliced1 = stdTestTrain.stopsAt(depID: 'OH01', arvIDs: ['OH03']);
      expect(sliced1, isNotNull);
      expect(sliced1!.stops.first.id, 'OH01');

      // 下車駅がマッチしない (下車駅が発駅より前 or 停車しない)
      final sliced2 = stdTestTrain.stopsAt(depID: 'OH02', arvIDs: ['OH01', 'OH99']);
      expect(sliced2, isNull);
    });

    test('fromJson and toJson map correctly', () {
      final json = {
        'name': 'さがみ', 'number': 70, 'facility_id': 'fac_123',
        'stops': [{'id': 'OH01', 'hour': 9, 'min': 0}],
        'except_dates': ['2026-05-30T00:00:00.000']
      };

      final train = Train.fromJson(json);
      expect(train.name, 'さがみ');
      expect(train.number, 70);
      expect(train.facilityId, 'fac_123');
      expect(train.stops.first.id, 'OH01');
      expect(train.exceptDates.first, DateTime(2026, 5, 30));

      final serialized = train.toJson();
      expect(serialized['name'], 'さがみ');
      expect(serialized['except_dates'], contains('2026-05-30T00:00:00.000'));
    });

    group('internalTozanLine', () {
      test('returns true if the first stop is OH51', () {
        final train = Train(
          name: '登山電車', number: 1, facilityId: 'f1',
          stops: [
            TrainStop(id: 'OH51', hour: 10, min: 0),
            TrainStop(id: 'OH52', hour: 10, min: 10)
          ]
        );
        expect(train.internalTozanLine, isTrue);
      });

      test('returns true if the first stop is OH47 and the last stop is OH51', () {
        final train = Train(
          name: '登山電車', number: 2, facilityId: 'f1',
          stops: [
            TrainStop(id: 'OH47', hour: 10, min: 0),
            TrainStop(id: 'OH50', hour: 10, min: 10),
            TrainStop(id: 'OH51', hour: 10, min: 15)
          ]
        );
        expect(train.internalTozanLine, isTrue);
      });

      test('returns false if the first stop is neither OH51 nor OH47', () {
        final train = Train(
          name: 'はこね', number: 1, facilityId: 'f1',
          stops: [
            TrainStop(id: 'OH01', hour: 9, min: 0),
            TrainStop(id: 'OH47', hour: 10, min: 0),
            TrainStop(id: 'OH51', hour: 10, min: 15)
          ]
        );
        expect(train.internalTozanLine, isFalse);
      });

      test('returns false if the first stop is OH47 but the last stop is not OH51', () {
        final train = Train(
          name: '各駅停車', number: 1, facilityId: 'f1',
          stops: [
            TrainStop(id: 'OH47', hour: 10, min: 0),
            TrainStop(id: 'OH48', hour: 10, min: 5)
          ]
        );
        expect(train.internalTozanLine, isFalse);
      });

      test('returns false if stops is empty', () {
        final train = Train(name: '回送', number: 1, facilityId: 'f1', stops: []);
        expect(train.internalTozanLine, isFalse);
      });
    });
  });
}
