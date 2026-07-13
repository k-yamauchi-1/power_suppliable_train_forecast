import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'validate_helpers.dart';

part 'facility.freezed.dart';
part 'facility.g.dart';

enum CarType {
  gse, mse, exe, exeAlpha, exeEither, unfixed;

  String get dispName => switch (this) {
    CarType.exeAlpha => 'EXEα',
    CarType.exeEither => 'EXE/\nEXEα',
    CarType.unfixed => '不定',
    _ => name.toUpperCase()
  };

  String? get iconFileName => switch (this) {
    CarType.exeAlpha || CarType.exeEither => 'exe_alpha',
    CarType.unfixed => null,
    _ => name
  };

  Color get bgColor => switch (this) {
    CarType.gse => Colors.orange.shade100,
    CarType.mse => Colors.lightBlue.shade100,
    CarType.unfixed => Colors.white,
    _ => Colors.grey.shade200
  };
}

enum Probability {
  w95, w80, w60, w40, w20, w5, a95, a80, a60, a40, a20, a5;
}
extension NullableProbabilityExtension on Probability? {
  bool get allSeats => this?.name.startsWith('a') == true;

  String get asStr => this?.name.substring(1) ?? '??';
  int get percentage => int.tryParse(asStr) ?? 0;

  Color get bgColor => this == null ? Colors.grey : (
    allSeats ? Colors.deepOrange : Colors.lightBlue
  );
  String get explanation => this == null ? '' : (
    allSeats ? '全席コンセント確率: $asStr％' : '窓側席コンセント確率: $asStr％'
  );
}

@freezed
abstract class Facility with _$Facility {
  const Facility._();

  const factory Facility({
    @JsonKey(name: 'car_type')
    @Default(CarType.unfixed) CarType carType,
    required Map<String, Probability> probabilities,
    String? notes
  }) = _Facility;

  factory Facility.fromJson(Map<String, dynamic> json) =>
      _$FacilityFromJson(json);

  /// probabilities は1つ以上必須。1つだけの場合は空のキーを許容する。
  List<String> validate() => [
    validateSize('probabilities', probabilities.length, min: 1),
    if (probabilities.length > 1)
      validateKeysNotEmpty('probabilities', probabilities.keys)
  ].nonNulls.toList();
}
