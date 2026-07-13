// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Surcharge _$SurchargeFromJson(Map<String, dynamic> json) => _Surcharge(
  from: json['from'] as String,
  to: json['to'] as String,
  price: (json['price'] as num).toInt(),
);

Map<String, dynamic> _$SurchargeToJson(_Surcharge instance) =>
    <String, dynamic>{
      'from': instance.from,
      'to': instance.to,
      'price': instance.price,
    };

_Service _$ServiceFromJson(Map<String, dynamic> json) => _Service(
  id: json['id'] as String,
  service: json['service'] as String,
  companyName: json['company_name'] as String,
  companyShortName: json['company_short_name'] as String,
  stations: (json['stations'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Station.fromJson(e as Map<String, dynamic>)),
  ),
  facilities: (json['facilities'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, Facility.fromJson(e as Map<String, dynamic>)),
  ),
  trains: (json['trains'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(
      $enumDecode(_$TimetableDateEnumMap, k),
      (e as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          $enumDecode(_$DirectionEnumMap, k),
          (e as Map<String, dynamic>).map(
            (k, e) => MapEntry(k, Train.fromJson(e as Map<String, dynamic>)),
          ),
        ),
      ),
    ),
  ),
  surcharges:
      (json['surcharges'] as List<dynamic>?)
          ?.map((e) => Surcharge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  holidays:
      (json['holidays'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList() ??
      const [],
);

const _$DirectionEnumMap = {Direction.up: 'up', Direction.down: 'down'};

const _$TimetableDateEnumMap = {
  TimetableDate.weekday: 'weekday',
  TimetableDate.holiday: 'holiday',
  TimetableDate.extra: 'extra',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(service)
final serviceProvider = ServiceProvider._();

final class ServiceProvider
    extends $FunctionalProvider<AsyncValue<Service>, Service, FutureOr<Service>>
    with $FutureModifier<Service>, $FutureProvider<Service> {
  ServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serviceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serviceHash();

  @$internal
  @override
  $FutureProviderElement<Service> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Service> create(Ref ref) {
    return service(ref);
  }
}

String _$serviceHash() => r'bc1a48b9fe1becca08c7b5efe852a1abfdc31bcc';
