// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'train.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Train _$TrainFromJson(Map<String, dynamic> json) => _Train(
  name: json['name'] as String,
  intl: json['intl'] as String? ?? '',
  number: (json['number'] as num).toInt(),
  facilityId: json['facility_id'] as String,
  stops: (json['stops'] as List<dynamic>)
      .map((e) => TrainStop.fromJson(e as Map<String, dynamic>))
      .toList(),
  exceptDates:
      (json['except_dates'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList() ??
      const [],
  depIdx: (json['depIdx'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TrainToJson(_Train instance) => <String, dynamic>{
  'name': instance.name,
  'intl': instance.intl,
  'number': instance.number,
  'facility_id': instance.facilityId,
  'stops': instance.stops,
  'except_dates': instance.exceptDates.map((e) => e.toIso8601String()).toList(),
  'depIdx': instance.depIdx,
};

_TrainStop _$TrainStopFromJson(Map<String, dynamic> json) => _TrainStop(
  id: json['id'] as String,
  hour: (json['hour'] as num).toInt(),
  min: (json['min'] as num).toInt(),
);

Map<String, dynamic> _$TrainStopToJson(_TrainStop instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hour': instance.hour,
      'min': instance.min,
    };
