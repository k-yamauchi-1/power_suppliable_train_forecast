import 'package:flutter_test/flutter_test.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';

void main() {
  group('Station', () {
    setUp(() async => await LocaleSettings.setLocale(AppLocale.ja));
    tearDown(() async => await LocaleSettings.setLocale(AppLocale.ja));

    test('fromJson custom readValue converts up/down dest correctly', () {
      final json = {
        'name': '新宿',
        'alias': '新宿',
        'intl': 'Shinjuku',
        'down_dest': '小田原',
        'up_dest': '新宿'
      };

      final station = Station.fromJson(json);
      expect(station.name, '新宿');
      expect(station.alias, '新宿');
      expect(station.intl, 'Shinjuku');
      expect(station.destinations[Direction.down], '小田原');
      expect(station.destinations[Direction.up], '新宿');
    });

    test('fromJson missing destinations is handled with default empty map', () {
      final json = {'name': '町田', 'alias': '町田', 'intl': 'Machida'};

      final station = Station.fromJson(json);
      expect(station.destinations, isEmpty);
    });

    test('matches matches queries case-insensitively', () {
      final station = const Station(
        name: '本厚木', alias: 'ほんあつぎ', intl: 'Hon-atsugi', destinations: {}
      );

      // 空白クエリは true
      expect(station.matches(''), isTrue);

      // name 一致
      expect(station.matches('本厚'), isTrue);
      expect(station.matches('本厚木'), isTrue);

      // alias 一致
      expect(station.matches('ほんあつ'), isTrue);

      // intl 一致 (大文字小文字無視)
      expect(station.matches('hon-atsugi'), isTrue);
      expect(station.matches('HON-ATSUGI'), isTrue);
      expect(station.matches('hon'), isTrue);

      // 不一致
      expect(station.matches('新宿'), isFalse);
    });

    test('displayName returns name for ja and intl for non-ja locales', () async {
      final station = const Station(
        name: '新宿', alias: 'しんじゅく', intl: 'Shinjuku', destinations: {}
      );

      try {
        await LocaleSettings.setLocale(AppLocale.ja);
        expect(station.lName, '新宿');

        await LocaleSettings.setLocale(AppLocale.en);
        expect(station.lName, 'Shinjuku');
      } finally {
        await LocaleSettings.setLocale(AppLocale.ja);
      }
    });
  });
}
