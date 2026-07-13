import 'package:flutter_test/flutter_test.dart';

import 'package:power_suppliable_train_forecast/models/facility.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/models/station.dart';
import 'package:power_suppliable_train_forecast/models/train.dart';

void main() {
  group('Surcharge', () {
    test('fromJson & toJson map correctly', () {
      final json = {'from': 'OH01', 'to': 'OH02', 'price': 500};
      final surcharge = Surcharge.fromJson(json);

      expect(surcharge.from, 'OH01');
      expect(surcharge.to, 'OH02');
      expect(surcharge.price, 500);

      expect(surcharge.toJson(), json);
    });
  });

  group('Service', () {
    final mockStations = {
      'OH01': const Station(
        name: '新宿', alias: '新宿', intl: 'Shinjuku',
        destinations: {Direction.down: '小田原方面'}
      ),
      'OH02': const Station(
        name: '町田', alias: '町田', intl: 'Machida',
        destinations: {Direction.up: '新宿方面', Direction.down: '小田原方面'}
      ),
      'OH03': const Station(
        name: '小田原', alias: '小田原', intl: 'Odawara',
        destinations: {Direction.up: '新宿方面'}
      )
    };

    final mockFacilities = {'gse_fac': const Facility(
      carType: CarType.gse,
      probabilities: {'1': Probability.a95}
    )};

    // TrainStop definitions
    final stopShinjuku = const TrainStop(id: 'OH01', hour: 10, min: 0);
    final stopMachida = const TrainStop(id: 'OH02', hour: 10, min: 30);
    final stopOdawara = const TrainStop(id: 'OH03', hour: 11, min: 0);

    final mockService = Service(
      id: 'romancecar', service: 'ロマンスカー',
      companyName: '小田急電鉄', companyShortName: '小田急',
      stations: mockStations, facilities: mockFacilities,
      trains: {
        TimetableDate.weekday: {
          Direction.down: {'train_wd_1': Train(
            name: 'はこね', number: 1, facilityId: 'gse_fac',
            stops: [stopShinjuku, stopMachida, stopOdawara]
          )},
          Direction.up: {}
        },
        TimetableDate.holiday: {
          Direction.down: {'train_hd_1': Train(
            name: 'スーパーはこね', number: 1, facilityId: 'gse_fac',
            stops: [stopShinjuku, stopOdawara]
          )},
          Direction.up: {}
        },
        TimetableDate.extra: {
          Direction.down: {'train_ex_1': Train(
            name: '臨時はこね', number: 91, facilityId: 'gse_fac',
            stops: [stopShinjuku, stopMachida, stopOdawara],
            exceptDates: [DateTime(2026, 5, 30)]
          )},
          Direction.up: {}
        }
      },
      surcharges: [
        const Surcharge(from: 'OH01', to: 'OH02', price: 450),
        const Surcharge(from: 'OH01', to: 'OH03', price: 950),
        const Surcharge(from: 'OH02', to: 'OH03', price: 500)
      ],
      holidays: [DateTime(2026, 5, 1)] // 祝日設定
    );

    test('reachables returns reachable stations with surcharge', () {
      // 下り (新宿 OH01 発)
      final reachDown = mockService.reachables(
        const SearchCond(depID: 'OH01', direction: Direction.down)
      );

      expect(reachDown.length, 2);
      expect(reachDown[0].id, 'OH02');
      expect(reachDown[0].name, '町田');
      expect(reachDown[0].surcharge, 450);

      expect(reachDown[1].id, 'OH03');
      expect(reachDown[1].name, '小田原');
      expect(reachDown[1].surcharge, 950);

      // 上り (小田原 OH03 発)
      final reachUp = mockService.reachables(
        const SearchCond(depID: 'OH03', direction: Direction.up)
      );

      expect(reachUp.length, 2);
      expect(reachUp[0].id, 'OH01');
      expect(reachUp[0].surcharge, 950);
      expect(reachUp[1].id, 'OH02');
      expect(reachUp[1].surcharge, 500);

      // 存在しない駅の場合
      final condInvalid = const SearchCond(depID: 'OH99');
      expect(mockService.reachables(condInvalid), isEmpty);
    });

    test('getTrains returns correct regular weekday trains', () {
      // 内部で cond.target.isHoliday || holidays.contains(cond.target.date) が使われる。
      // weekday なので isHoliday = false よって weekday ダイヤが選ばれる
      // 念のため cond を作成する際、明示的に target の date が平日になるように、
      // TargetDate.weekday は isHoliday が false で、date は null を返し、
      // `isHoliday` の判定：isHoliday => this == TargetDate.holiday || (date?.weekday ?? 0) >= 6;
      // よって TargetDate.weekday は isHoliday が false になる。
      final trains = mockService.getTrains(SearchCond(
        depID: 'OH01', direction: Direction.down,
        target: TargetDate.weekday, hourFrom: -1
      ));
      expect(trains.length, 1);
      expect(trains.first.name, 'はこね');
    });

    test('getTrains filters out trains based on exceptDates on weekdays', () {
      // テストの実行日によって変動するため、TargetDate.today ではなく、自由な日付を扱うために
      // `getTrains` のロジック：
      // (cond.target.isHoliday || holidays.contains(cond.target.date)) ? holiday : weekday;
      // そして `t.exceptDates.contains(cond.target.date)`
      //
      // TargetDate.today / TargetDate.nextDay の date は DateTime(year, month, day) になる。
      // なので、cond.target の mock が必要になる、または cond.target の get date が今日か明日を指すので
      // cond の `target` を `TargetDate.today` にして、その date (本日) を mockServiceWithExcept の exceptDates に入れる
      final todayDate = TargetDate.today.date!;

      final mockServiceWithExceptToday = mockService.copyWith(trains: {
        TimetableDate.weekday: {
          Direction.down: {'train_wd_1': Train(
            name: 'はこね', number: 1, facilityId: 'gse_fac',
            stops: [stopShinjuku, stopMachida, stopOdawara],
            exceptDates: [todayDate] // 本日運休
          )},
          Direction.up: {}
        },
        TimetableDate.holiday: {},
        TimetableDate.extra: {}
      });

      expect(mockServiceWithExceptToday.getTrains(
        const SearchCond(depID: 'OH01', target: TargetDate.today, hourFrom: 1)
      ).isEmpty, isTrue);
    });

    test('getTrains returns extra trains matching todayDate', () {
      final todayDate = TargetDate.today.date!;

      final mockServiceWithExtra = mockService.copyWith(trains: {
        TimetableDate.weekday: {},
        TimetableDate.holiday: {},
        TimetableDate.extra: {
          Direction.down: {
            'train_ex_1': Train(
              name: '臨時はこね', number: 91, facilityId: 'gse_fac',
              stops: [stopShinjuku, stopMachida, stopOdawara],
              exceptDates: [todayDate] // この日にだけ特別運転
            ),
          },
          Direction.up: {}
        }
      });

      final trains = mockServiceWithExtra.getTrains(
        const SearchCond(depID: 'OH01', target: TargetDate.today, hourFrom: 1)
      );
      expect(trains.length, 1);
      expect(trains.first.name, '臨時はこね');
    });

    test('getTrains returns empty list if depID is invalid', () {
      final trains = mockService.getTrains(const SearchCond(depID: 'OH99'));
      expect(trains, isEmpty);
    });
  });
}
