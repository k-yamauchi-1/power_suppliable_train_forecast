// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Station _$StationFromJson(Map<String, dynamic> json) => _Station(
  name: json['name'] as String,
  alias: json['alias'] as String,
  intl: json['intl'] as String,
  destinations:
      (_readDestinations(json, 'destinations') as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry($enumDecode(_$DirectionEnumMap, k), e as String),
      ) ??
      const {},
);

Map<String, dynamic> _$StationToJson(_Station instance) => <String, dynamic>{
  'name': instance.name,
  'alias': instance.alias,
  'intl': instance.intl,
  'destinations': instance.destinations.map(
    (k, e) => MapEntry(_$DirectionEnumMap[k]!, e),
  ),
};

const _$DirectionEnumMap = {Direction.up: 'up', Direction.down: 'down'};
