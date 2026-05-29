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

part 'service.freezed.dart';
part 'service.g.dart';

enum TimetableDate { weekday, holiday, extra }

typedef Reachable = ({String id, String name, int surcharge});

@freezed
abstract class Surcharge with _$Surcharge {
  const factory Surcharge({
    required String from,
    required String to,
    required int price
  }) = _Surcharge;

  factory Surcharge.fromJson(Map<String, dynamic> json) =>
      _$SurchargeFromJson(json);
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
    ).where((t) => !t.exceptDates.contains(cond.target.date)).toList();
    final extraTrains = (
      trains[TimetableDate.extra]?[_direction(cond)]?.values ?? []
    ).where((t) => t.exceptDates.contains(cond.target.date)).toList();

    return (regularTrains + extraTrains).map(
      (t) => t.stopsAt(depID: cond.depID, arvIDs: cond.arvIDs)
    ).nonNulls.where(
      (t) => cond.matchTime(hour: t.stops.first.hour, min: t.stops.first.min)
    ).toList()..sort(
      (a, b) => (a.stops.first.dateMin).compareTo(b.stops.first.dateMin)
    );
  }
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

    return Service.fromJson(json.decode(
      utf8.decode(await media.stream.reduce((a, b) => [...a, ...b]))
    ) as Map<String, dynamic>);
  } finally {
    client.close();  // クライアントは必ずクローズする
  }
}
