import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('TargetDate', () {
    test('date returns correct DateTime or null', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      expect(TargetDate.today.date, today);
      expect(TargetDate.nextDay.date, today.add(const Duration(days: 1)));
      expect(TargetDate.weekday.date, isNull);
      expect(TargetDate.holiday.date, isNull);
    });

    test('isHoliday returns expected values', () {
      expect(TargetDate.holiday.isHoliday, isTrue);
      expect(TargetDate.weekday.isHoliday, isFalse);

      final today = TargetDate.today;
      expect(today.isHoliday, (today.date?.weekday ?? 0) >= 6);
    });

    test('note returns formatted string', () {
      expect(TargetDate.weekday.note, '予報なし');
      expect(TargetDate.holiday.note, '予報なし');

      final tDate = TargetDate.today.date!;
      final expectedTodayNote =
          ' ${tDate.month}/${tDate.day.toString().padLeft(2, '0')}'
          '(${['月', '火', '水', '木', '金', '土', '日'][tDate.weekday - 1]})';
      expect(TargetDate.today.note, expectedTodayNote);
    });

    test('complement returns expected values', () {
      expect(TargetDate.weekday.complement, '充電可能な車両の比率のみに基づく確率表示です');
      expect(TargetDate.holiday.complement, '充電可能な車両の比率のみに基づく確率表示です');
      expect(TargetDate.today.complement, '');
      expect(TargetDate.nextDay.complement, '');
    });
  });

  group('SearchCond', () {
    test('fromJson and toJson maps correctly', () {
      final json = {
        'depID': 'OH02', 'direction': 'down', 'arvIDs': ['OH03', 'OH04'],
        'target': 'weekday', 'hourFrom': 10
      };

      final cond = SearchCond.fromJson(json);
      expect(cond.depID, 'OH02');
      expect(cond.direction, Direction.down);
      expect(cond.arvIDs, ['OH03', 'OH04']);
      expect(cond.target, TargetDate.weekday);
      expect(cond.hourFrom, 10);

      final sJson = cond.toJson();
      expect(sJson['depID'], 'OH02');
      expect(sJson['direction'], 'down');
      expect(sJson['arvIDs'], ['OH03', 'OH04']);
      expect(sJson['target'], 'weekday');
      expect(sJson['hourFrom'], 10);
    });

    test('matchTime returns correct true/false based on hourFrom', () {
      final condWithHour = const SearchCond(hourFrom: 12);
      expect(condWithHour.matchTime(hour: 12, min: 30), isTrue);
      expect(condWithHour.matchTime(hour: 13, min: 0), isTrue);
      expect(condWithHour.matchTime(hour: 11, min: 59), isFalse);

      final condNextDay =
          const SearchCond(target: TargetDate.nextDay, hourFrom: -1);
      expect(condNextDay.matchTime(hour: 6, min: 0), isTrue);

      // today の場合、現在時刻より後なら true、前なら false
      final condToday = const SearchCond(target: TargetDate.today, hourFrom: -1);
      final currentHour = DateTime.now().hour;
      final currentMinute = DateTime.now().minute;

      expect(condToday.matchTime(hour: currentHour + 1, min: 0), isTrue);
      expect(
        condToday.matchTime(hour: currentHour, min: currentMinute + 5),
        isTrue
      );
      if (currentHour > 0) {
        expect(condToday.matchTime(hour: currentHour - 1, min: 30), isFalse);
      }
    });
  });

  group('Cond notifier', () {
    test('Cond updates state correctly and initializes with local repos default', () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ]);
      addTearDown(container.dispose);

      // Listen to condProvider to trigger its build
      SearchCond condState() => container.read(condProvider);
      expect(condState().depID, 'OH01'); // Default depID

      final notifier = container.read(condProvider.notifier);
      expect(notifier.fromHours, isNotEmpty);

      // updateProp
      notifier.updateProp(depID: 'OH02', direction: Direction.down);
      expect(condState().depID, 'OH02');
      expect(condState().direction, Direction.down);

      // update with full search condition
      notifier.update(
        const SearchCond(depID: 'OH03', direction: Direction.up, arvIDs: ['OH04'])
      );
      expect(condState().depID, 'OH03');
      expect(condState().arvIDs, contains('OH04'));
    });
  });
}
