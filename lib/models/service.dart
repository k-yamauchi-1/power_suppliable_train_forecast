import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:googleapis/storage/v1.dart' hide Object;
import 'package:googleapis_auth/auth_io.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'facility.dart';
import 'search_condition.dart';
import 'station.dart';
import 'train.dart';
import 'validate_helpers.dart';

part 'service.freezed.dart';
part 'service.g.dart';

enum TimetableDate { weekday, holiday, extra }

typedef Reachable = ({String id, String name, int surcharge});

@freezed
abstract class Surcharge with _$Surcharge {
  const Surcharge._();

  const factory Surcharge({
    required String from,
    required String to,
    required int price
  }) = _Surcharge;

  factory Surcharge.fromJson(Map<String, dynamic> json) =>
      _$SurchargeFromJson(json);

  /// from も to も stations に存在するIDである必要がある。
  List<String> validate(Map<String, Station> stations) => [
    if (!stations.containsKey(from)) 'from "$from" が stations に存在しません',
    if (!stations.containsKey(to)) 'to "$to" が stations に存在しません'
  ];
}

@Freezed(toJson: false)
abstract class Service with _$Service {
  const Service._();

  const factory Service({
    required String id,
    required String service,
    @JsonKey(name: 'company_name') required String companyName,
    @JsonKey(name: 'company_short_name') required String companyShortName,
    required Map<String, Station> stations,
    required Map<String, Facility> facilities,
    required Map<TimetableDate, Map<Direction, Map<String, Train>>> trains,
    @Default([]) List<Surcharge> surcharges,
    @Default([]) List<DateTime> holidays
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Direction _direction(SearchCond cond) =>
      stations[cond.depID]?.destinations.keys.singleOrNull ?? cond.direction;

  List<Reachable> reachables(SearchCond cond) {
    final isDirectionDown = _direction(cond) == Direction.down;
    return stations[cond.depID] != null ? surcharges.where(
      (sc) => cond.depID == (isDirectionDown ? sc.from : sc.to)
    ).map((sc) {
      final id = isDirectionDown ? sc.to : sc.from;
      return (id: id, name: stations[id]!.name, surcharge: sc.price);
    }).toList() : [];
  }

  List<Train> getTrains(SearchCond cond) {
    final dep = stations[cond.depID];
    if (dep == null)  return [];

    final timetableDate = (
      cond.target.isHoliday || holidays.contains(cond.target.date)
    ) ? TimetableDate.holiday : TimetableDate.weekday;
    final regularTrains = (
      trains[timetableDate]?[_direction(cond)]?.values ?? []
    ).where((trn) => !trn.exceptDates.contains(cond.target.date)).toList();
    final extraTrains = (
      trains[TimetableDate.extra]?[_direction(cond)]?.values ?? []
    ).where((trn) => trn.exceptDates.contains(cond.target.date)).toList();

    return (regularTrains + extraTrains).map(
      (trn) => trn.stopsAt(depID: cond.depID, arvIDs: cond.arvIDs)
    ).nonNulls.where((trn) => cond.matchTime(
      hour: trn.stops.first.hour, min: trn.stops.first.min
    )).toList()..sort(
      (a, b) => (a.stops.first.dateMin).compareTo(b.stops.first.dateMin)
    );
  }

  /// マスタデータ全体の検証を行う。不備がなければ空の List を返す。
  List<String> validate() => [
    validateSize('stations', stations.length),
    validateKeysNotEmpty('stations', stations.keys),
    ...stations.entries.expand(
      (e) => e.value.validate().map((msg) => 'stations[${e.key}]: $msg')
    ),

    validateSize('facilities', facilities.length),
    validateKeysNotEmpty('facilities', facilities.keys),
    ...facilities.entries.expand(
      (e) => e.value.validate().map((msg) => 'facilities[${e.key}]: $msg')
    ),

    validateSize('trains', trains.length),
    ...trains.entries.expand((dateTrainsMap) {
      final dateLabel = 'trains[${dateTrainsMap.key}]';
      return [
        validateSize(dateLabel, dateTrainsMap.value.length),
        ...dateTrainsMap.value.entries.expand((dircTrainsMap) {
          final dircLabel = '$dateLabel[${dircTrainsMap.key}]';
          return [
            validateKeysNotEmpty(dircLabel, dircTrainsMap.value.keys),
            ...dircTrainsMap.value.entries.expand((train) => train.value.validate(
              facilities: facilities, stations: stations
            ).map((msg) => '$dircLabel[${train.key}]: $msg'))
          ];
        })
      ];
    }),

    validateSize('surcharges', surcharges.length),
    ...surcharges.expand((sc) => sc.validate(stations).map(
      (msg) => 'surcharges[${sc.from}->${sc.to}]: $msg'
    ))
  ].nonNulls.toList();
}

@riverpod
Future<Service> service(Ref ref) async {
  const String keyFile = 'assets/gcp_credentials.json';
  final client = await clientViaServiceAccount(
    ServiceAccountCredentials.fromJson(await rootBundle.loadString(keyFile)),
    [StorageApi.devstorageReadOnlyScope]
  );

  try {
    final media = await StorageApi(client).objects.get(
      'service-master',  // bucketName,
      'romancecar.json',  // fileName
      downloadOptions: DownloadOptions.fullMedia,
    ) as Media;

    final service = Service.fromJson(json.decode(
      utf8.decode(await media.stream.reduce((a, b) => [...a, ...b]))
    ) as Map<String, dynamic>);

    if (service.validate().isNotEmpty) {
      throw Exception('【マスタデータ不備】\n${service.validate().join('\n')}');
    }
    return service;
  } finally {
    client.close();  // クライアントは必ずクローズする
  }
}
