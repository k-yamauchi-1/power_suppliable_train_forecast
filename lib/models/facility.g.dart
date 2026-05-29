// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Facility _$FacilityFromJson(Map<String, dynamic> json) => _Facility(
  carType:
      $enumDecodeNullable(_$CarTypeEnumMap, json['car_type']) ??
      CarType.unfixed,
  probabilities: (json['probabilities'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, $enumDecode(_$ProbabilityEnumMap, e)),
  ),
  notes: json['notes'] as String?,
);

Map<String, dynamic> _$FacilityToJson(_Facility instance) => <String, dynamic>{
  'car_type': _$CarTypeEnumMap[instance.carType]!,
  'probabilities': instance.probabilities.map(
    (k, e) => MapEntry(k, _$ProbabilityEnumMap[e]!),
  ),
  'notes': instance.notes,
};

const _$CarTypeEnumMap = {
  CarType.gse: 'gse',
  CarType.mse: 'mse',
  CarType.exe: 'exe',
  CarType.exeAlpha: 'exeAlpha',
  CarType.exeEither: 'exeEither',
  CarType.unfixed: 'unfixed',
};

const _$ProbabilityEnumMap = {
  Probability.w95: 'w95',
  Probability.w80: 'w80',
  Probability.w60: 'w60',
  Probability.w40: 'w40',
  Probability.w20: 'w20',
  Probability.w5: 'w5',
  Probability.a95: 'a95',
  Probability.a80: 'a80',
  Probability.a60: 'a60',
  Probability.a40: 'a40',
  Probability.a20: 'a20',
  Probability.a5: 'a5',
};
