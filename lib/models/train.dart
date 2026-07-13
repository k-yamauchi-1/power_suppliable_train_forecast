import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'facility.dart';
import 'station.dart';
import 'validate_helpers.dart';

part 'train.freezed.dart';
part 'train.g.dart';

@freezed
abstract class Train with _$Train {
  const Train._();

  const factory Train({
    required String name,
    required int number,
    @JsonKey(name: 'facility_id') required String facilityId,
    required List<TrainStop> stops,
    @JsonKey(name: 'except_dates') @Default([]) List<DateTime> exceptDates
  }) = _Train;

  factory Train.fromJson(Map<String, dynamic> json) => _$TrainFromJson(json);

  String get dispName => '$name$number号';

  Train? stopsAt({required String depID, List<String> arvIDs = const []}) {
    final sorted = [...stops]..sort((a, b) => a.dateMin.compareTo(b.dateMin));
    final idx = sorted.indexWhere((stop) => stop.id == depID);
    if (idx < 0 || idx >= stops.length - 1)  return null;

    return arvIDs.isEmpty || arvIDs.any(
      (arv) => sorted.sublist(idx + 1).any((s) => s.id == arv)
    ) ? copyWith(stops: sorted.sublist(idx)) : null;
  }

  bool get internalTozanLine => stops.firstOrNull?.id == "OH51" || (
    stops.firstOrNull?.id == "OH47" && stops.lastOrNull?.id == "OH51"
  );

  List<String> validate({
    required Map<String, Facility> facilities,
    required Map<String, Station> stations
  }) => [
    if (name.isEmpty) 'name が空です',
    if (number < 1) 'number が1未満です（実際: $number）',
    if (!facilities.containsKey(facilityId))
      'facilityId "$facilityId" が facilities に存在しません',
    validateSize('stops', stops.length),
    ...stops.expand(
      (s) => s.validate(stations).map((msg) => 'stops[${s.id}]: $msg')
    )
  ].nonNulls.toList();
}

@freezed
abstract class TrainStop with _$TrainStop {
  const TrainStop._();

  const factory TrainStop({
    required String id,
    required int hour,
    required int min
  }) = _TrainStop;

  factory TrainStop.fromJson(Map<String, dynamic> json) =>
      _$TrainStopFromJson(json);

  int get dateMin => hour * 60 + min;
  String get dispTime =>
      '${hour.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}';

  List<String> validate(Map<String, Station> stations) => [
    if (!stations.containsKey(id)) 'id "$id" が stations に存在しません',
    if (hour < 4 || hour > 26) 'hour(4-26) が範囲外です: $hour',
    if (min < 0 || min > 59) 'min(0-59) が範囲外です: $min'
  ];
}
