import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../string_normalizer.dart';

part 'station.freezed.dart';
part 'station.g.dart';

enum Direction { up, down }

Object? _readDestinations(Map map, String key) => {
  'down': map['down_dest'] as String?,
  'up': map['up_dest'] as String?,
}..removeWhere((_, v) => v == null);

@freezed
abstract class Station with _$Station {
  const Station._();

  const factory Station({
    required String name,
    required String alias,
    required String intl,
    @JsonKey(readValue: _readDestinations)
    @Default({}) Map<Direction, String> destinations
  }) = _Station;

  factory Station.fromJson(Map<String, dynamic> json) => _$StationFromJson(json);

  bool matches(String q) => q.normalize().isNotEmpty && (
    name.normalize().contains(q.normalize()) ||
    alias.normalize().contains(q.normalize()) ||
    intl.normalize().contains(q.normalize())
  );
}
