import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../i18n/strings.g.dart';
import '../string_normalizer.dart';
import 'validate_helpers.dart';

part 'station.freezed.dart';
part 'station.g.dart';

enum Direction { up, down }

Object? _readDestinations(Map map, String key) => {
  'down': map['down_dest'] as String?,
  'up': map['up_dest'] as String?,
}..removeWhere((_, v) => v == null);

Object? _readDestinationsIntl(Map map, String key) => {
  'down': map['down_intl'] as String?,
  'up': map['up_intl'] as String?,
}..removeWhere((_, v) => v == null);

@freezed
abstract class Station with _$Station {
  const Station._();

  const factory Station({
    required String name,
    required String alias,
    required String intl,
    @JsonKey(readValue: _readDestinations)
    @Default({}) Map<Direction, String> destinations,
    @JsonKey(readValue: _readDestinationsIntl)
    @Default({}) Map<Direction, String> destinationsIntl
  }) = _Station;

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  String get lName => t.$meta.locale == AppLocale.ja ? name : intl;
  Map<Direction, String> get lDestinations =>
      t.$meta.locale == AppLocale.ja ? destinations : destinationsIntl;

  bool matches(String q) => (
    name.normalize().contains(q.normalize()) ||
    alias.normalize().contains(q.normalize()) ||
    intl.normalize().contains(q.normalize())
  );

  /// destinations は down_dest, up_dest の少なくとも片方が必須。
  List<String> validate() => [
    if (name.isEmpty) 'name が空です',
    validateSize('destinations', destinations.length, min: 1)
  ].nonNulls.toList();
}
