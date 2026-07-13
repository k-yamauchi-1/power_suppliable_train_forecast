import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_suppliable_train_forecast/models/facility.dart';

void main() {
  group('CarType', () {
    test('dispName returns expected values', () {
      expect(CarType.gse.dispName, 'GSE');
      expect(CarType.mse.dispName, 'MSE');
      expect(CarType.exe.dispName, 'EXE');
      expect(CarType.exeAlpha.dispName, 'EXEα');
      expect(CarType.exeEither.dispName, 'EXE/\nEXEα');
      expect(CarType.unfixed.dispName, '不定');
    });

    test('iconFileName returns expected values', () {
      expect(CarType.gse.iconFileName, 'gse');
      expect(CarType.mse.iconFileName, 'mse');
      expect(CarType.exe.iconFileName, 'exe');
      expect(CarType.exeAlpha.iconFileName, 'exe_alpha');
      expect(CarType.exeEither.iconFileName, 'exe_alpha');
      expect(CarType.unfixed.iconFileName, isNull);
    });

    test('bgColor returns expected Colors', () {
      expect(CarType.gse.bgColor, Colors.orange.shade100);
      expect(CarType.mse.bgColor, Colors.lightBlue.shade100);
      expect(CarType.exe.bgColor, Colors.grey.shade200);
      expect(CarType.exeAlpha.bgColor, Colors.grey.shade200);
      expect(CarType.exeEither.bgColor, Colors.grey.shade200);
      expect(CarType.unfixed.bgColor, Colors.white);
    });
  });

  group('Probability', () {
    test('allSeats returns true for asX and false for wXX', () {
      expect(Probability.a95.allSeats, isTrue);
      expect(Probability.a80.allSeats, isTrue);
      expect(Probability.a60.allSeats, isTrue);
      expect(Probability.a40.allSeats, isTrue);
      expect(Probability.a20.allSeats, isTrue);
      expect(Probability.a5.allSeats, isTrue);

      expect(Probability.w95.allSeats, isFalse);
      expect(Probability.w80.allSeats, isFalse);
      expect(Probability.w60.allSeats, isFalse);
      expect(Probability.w40.allSeats, isFalse);
      expect(Probability.w20.allSeats, isFalse);
      expect(Probability.w5.allSeats, isFalse);

      expect((null as Probability?).allSeats, isFalse);
    });

    test('asStr returns correct string representation', () {
      expect(Probability.a95.asStr, '95');
      expect(Probability.w80.asStr, '80');
      expect(Probability.a60.asStr, '60');
      expect(Probability.w40.asStr, '40');
      expect(Probability.a20.asStr, '20');
      expect(Probability.w5.asStr, '5');

      expect((null as Probability?).asStr, '??');
    });

    test('percentage returns parsed trailing numbers', () {
      expect(Probability.a95.percentage, 95);
      expect(Probability.w80.percentage, 80);
      expect(Probability.a60.percentage, 60);
      expect(Probability.w40.percentage, 40);
      expect(Probability.a20.percentage, 20);
      expect(Probability.w5.percentage, 5);

      expect((null as Probability?).percentage, 0);
    });

    test('bgColor returns fixed colors by seating type', () {
      // 窓側 (blue)
      expect(Probability.w80.bgColor, Colors.lightBlue);

      // 全席 (orange)
      expect(Probability.a95.bgColor, Colors.deepOrange);

      expect((null as Probability?).bgColor, Colors.grey);
    });

    test('explanation returns correct message', () {
      expect(Probability.a95.explanation, '全席コンセント確率: 95％');
      expect(Probability.w80.explanation, '窓側席コンセント確率: 80％');

      expect((null as Probability?).explanation, '');
    });
  });

  group('Facility', () {
    test('fromJson & toJson constructs Facility correctly', () {
      final json = {
        'car_type': 'gse',
        'probabilities': {'1': 'a95', '2': 'w80'},
        'notes': 'Some notes'
      };

      final facility = Facility.fromJson(json);
      expect(facility.carType, CarType.gse);
      expect(facility.probabilities['1'], Probability.a95);
      expect(facility.probabilities['2'], Probability.w80);
      expect(facility.notes, 'Some notes');

      final serialized = facility.toJson();
      expect(serialized['car_type'], 'gse');
      expect(serialized['probabilities']['1'], 'a95');
      expect(serialized['notes'], 'Some notes');
    });

    test('fromJson with default carType', () {
      final facility = Facility.fromJson({'probabilities': <String, dynamic>{}});
      expect(facility.carType, CarType.unfixed);
      expect(facility.notes, isNull);
    });
  });
}
