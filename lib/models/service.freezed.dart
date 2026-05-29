// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Surcharge {

 String get from; String get to; int get price;
/// Create a copy of Surcharge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurchargeCopyWith<Surcharge> get copyWith => _$SurchargeCopyWithImpl<Surcharge>(this as Surcharge, _$identity);

  /// Serializes this Surcharge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Surcharge&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,price);

@override
String toString() {
  return 'Surcharge(from: $from, to: $to, price: $price)';
}


}

/// @nodoc
abstract mixin class $SurchargeCopyWith<$Res>  {
  factory $SurchargeCopyWith(Surcharge value, $Res Function(Surcharge) _then) = _$SurchargeCopyWithImpl;
@useResult
$Res call({
 String from, String to, int price
});




}
/// @nodoc
class _$SurchargeCopyWithImpl<$Res>
    implements $SurchargeCopyWith<$Res> {
  _$SurchargeCopyWithImpl(this._self, this._then);

  final Surcharge _self;
  final $Res Function(Surcharge) _then;

/// Create a copy of Surcharge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? price = null,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Surcharge].
extension SurchargePatterns on Surcharge {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Surcharge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Surcharge() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Surcharge value)  $default,){
final _that = this;
switch (_that) {
case _Surcharge():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Surcharge value)?  $default,){
final _that = this;
switch (_that) {
case _Surcharge() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String to,  int price)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Surcharge() when $default != null:
return $default(_that.from,_that.to,_that.price);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String to,  int price)  $default,) {final _that = this;
switch (_that) {
case _Surcharge():
return $default(_that.from,_that.to,_that.price);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String to,  int price)?  $default,) {final _that = this;
switch (_that) {
case _Surcharge() when $default != null:
return $default(_that.from,_that.to,_that.price);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Surcharge implements Surcharge {
  const _Surcharge({required this.from, required this.to, required this.price});
  factory _Surcharge.fromJson(Map<String, dynamic> json) => _$SurchargeFromJson(json);

@override final  String from;
@override final  String to;
@override final  int price;

/// Create a copy of Surcharge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurchargeCopyWith<_Surcharge> get copyWith => __$SurchargeCopyWithImpl<_Surcharge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurchargeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Surcharge&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.price, price) || other.price == price));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,price);

@override
String toString() {
  return 'Surcharge(from: $from, to: $to, price: $price)';
}


}

/// @nodoc
abstract mixin class _$SurchargeCopyWith<$Res> implements $SurchargeCopyWith<$Res> {
  factory _$SurchargeCopyWith(_Surcharge value, $Res Function(_Surcharge) _then) = __$SurchargeCopyWithImpl;
@override @useResult
$Res call({
 String from, String to, int price
});




}
/// @nodoc
class __$SurchargeCopyWithImpl<$Res>
    implements _$SurchargeCopyWith<$Res> {
  __$SurchargeCopyWithImpl(this._self, this._then);

  final _Surcharge _self;
  final $Res Function(_Surcharge) _then;

/// Create a copy of Surcharge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? price = null,}) {
  return _then(_Surcharge(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Service {

 String get id; String get service;@JsonKey(name: 'company_name') String get companyName;@JsonKey(name: 'company_short_name') String get companyShortName; Map<String, Station> get stations; Map<String, Facility> get facilities; Map<TimetableDate, Map<Direction, Map<String, Train>>> get trains; List<Surcharge> get surcharges; List<DateTime> get holidays;
/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCopyWith<Service> get copyWith => _$ServiceCopyWithImpl<Service>(this as Service, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Service&&(identical(other.id, id) || other.id == id)&&(identical(other.service, service) || other.service == service)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyShortName, companyShortName) || other.companyShortName == companyShortName)&&const DeepCollectionEquality().equals(other.stations, stations)&&const DeepCollectionEquality().equals(other.facilities, facilities)&&const DeepCollectionEquality().equals(other.trains, trains)&&const DeepCollectionEquality().equals(other.surcharges, surcharges)&&const DeepCollectionEquality().equals(other.holidays, holidays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,service,companyName,companyShortName,const DeepCollectionEquality().hash(stations),const DeepCollectionEquality().hash(facilities),const DeepCollectionEquality().hash(trains),const DeepCollectionEquality().hash(surcharges),const DeepCollectionEquality().hash(holidays));

@override
String toString() {
  return 'Service(id: $id, service: $service, companyName: $companyName, companyShortName: $companyShortName, stations: $stations, facilities: $facilities, trains: $trains, surcharges: $surcharges, holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class $ServiceCopyWith<$Res>  {
  factory $ServiceCopyWith(Service value, $Res Function(Service) _then) = _$ServiceCopyWithImpl;
@useResult
$Res call({
 String id, String service,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'company_short_name') String companyShortName, Map<String, Station> stations, Map<String, Facility> facilities, Map<TimetableDate, Map<Direction, Map<String, Train>>> trains, List<Surcharge> surcharges, List<DateTime> holidays
});




}
/// @nodoc
class _$ServiceCopyWithImpl<$Res>
    implements $ServiceCopyWith<$Res> {
  _$ServiceCopyWithImpl(this._self, this._then);

  final Service _self;
  final $Res Function(Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? service = null,Object? companyName = null,Object? companyShortName = null,Object? stations = null,Object? facilities = null,Object? trains = null,Object? surcharges = null,Object? holidays = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyShortName: null == companyShortName ? _self.companyShortName : companyShortName // ignore: cast_nullable_to_non_nullable
as String,stations: null == stations ? _self.stations : stations // ignore: cast_nullable_to_non_nullable
as Map<String, Station>,facilities: null == facilities ? _self.facilities : facilities // ignore: cast_nullable_to_non_nullable
as Map<String, Facility>,trains: null == trains ? _self.trains : trains // ignore: cast_nullable_to_non_nullable
as Map<TimetableDate, Map<Direction, Map<String, Train>>>,surcharges: null == surcharges ? _self.surcharges : surcharges // ignore: cast_nullable_to_non_nullable
as List<Surcharge>,holidays: null == holidays ? _self.holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}

}


/// Adds pattern-matching-related methods to [Service].
extension ServicePatterns on Service {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Service value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Service value)  $default,){
final _that = this;
switch (_that) {
case _Service():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Service value)?  $default,){
final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String service, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'company_short_name')  String companyShortName,  Map<String, Station> stations,  Map<String, Facility> facilities,  Map<TimetableDate, Map<Direction, Map<String, Train>>> trains,  List<Surcharge> surcharges,  List<DateTime> holidays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that.id,_that.service,_that.companyName,_that.companyShortName,_that.stations,_that.facilities,_that.trains,_that.surcharges,_that.holidays);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String service, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'company_short_name')  String companyShortName,  Map<String, Station> stations,  Map<String, Facility> facilities,  Map<TimetableDate, Map<Direction, Map<String, Train>>> trains,  List<Surcharge> surcharges,  List<DateTime> holidays)  $default,) {final _that = this;
switch (_that) {
case _Service():
return $default(_that.id,_that.service,_that.companyName,_that.companyShortName,_that.stations,_that.facilities,_that.trains,_that.surcharges,_that.holidays);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String service, @JsonKey(name: 'company_name')  String companyName, @JsonKey(name: 'company_short_name')  String companyShortName,  Map<String, Station> stations,  Map<String, Facility> facilities,  Map<TimetableDate, Map<Direction, Map<String, Train>>> trains,  List<Surcharge> surcharges,  List<DateTime> holidays)?  $default,) {final _that = this;
switch (_that) {
case _Service() when $default != null:
return $default(_that.id,_that.service,_that.companyName,_that.companyShortName,_that.stations,_that.facilities,_that.trains,_that.surcharges,_that.holidays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(createToJson: false)

class _Service extends Service {
  const _Service({required this.id, required this.service, @JsonKey(name: 'company_name') required this.companyName, @JsonKey(name: 'company_short_name') required this.companyShortName, required final  Map<String, Station> stations, required final  Map<String, Facility> facilities, required final  Map<TimetableDate, Map<Direction, Map<String, Train>>> trains, final  List<Surcharge> surcharges = const [], final  List<DateTime> holidays = const []}): _stations = stations,_facilities = facilities,_trains = trains,_surcharges = surcharges,_holidays = holidays,super._();
  factory _Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

@override final  String id;
@override final  String service;
@override@JsonKey(name: 'company_name') final  String companyName;
@override@JsonKey(name: 'company_short_name') final  String companyShortName;
 final  Map<String, Station> _stations;
@override Map<String, Station> get stations {
  if (_stations is EqualUnmodifiableMapView) return _stations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stations);
}

 final  Map<String, Facility> _facilities;
@override Map<String, Facility> get facilities {
  if (_facilities is EqualUnmodifiableMapView) return _facilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_facilities);
}

 final  Map<TimetableDate, Map<Direction, Map<String, Train>>> _trains;
@override Map<TimetableDate, Map<Direction, Map<String, Train>>> get trains {
  if (_trains is EqualUnmodifiableMapView) return _trains;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_trains);
}

 final  List<Surcharge> _surcharges;
@override@JsonKey() List<Surcharge> get surcharges {
  if (_surcharges is EqualUnmodifiableListView) return _surcharges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_surcharges);
}

 final  List<DateTime> _holidays;
@override@JsonKey() List<DateTime> get holidays {
  if (_holidays is EqualUnmodifiableListView) return _holidays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holidays);
}


/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceCopyWith<_Service> get copyWith => __$ServiceCopyWithImpl<_Service>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Service&&(identical(other.id, id) || other.id == id)&&(identical(other.service, service) || other.service == service)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.companyShortName, companyShortName) || other.companyShortName == companyShortName)&&const DeepCollectionEquality().equals(other._stations, _stations)&&const DeepCollectionEquality().equals(other._facilities, _facilities)&&const DeepCollectionEquality().equals(other._trains, _trains)&&const DeepCollectionEquality().equals(other._surcharges, _surcharges)&&const DeepCollectionEquality().equals(other._holidays, _holidays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,service,companyName,companyShortName,const DeepCollectionEquality().hash(_stations),const DeepCollectionEquality().hash(_facilities),const DeepCollectionEquality().hash(_trains),const DeepCollectionEquality().hash(_surcharges),const DeepCollectionEquality().hash(_holidays));

@override
String toString() {
  return 'Service(id: $id, service: $service, companyName: $companyName, companyShortName: $companyShortName, stations: $stations, facilities: $facilities, trains: $trains, surcharges: $surcharges, holidays: $holidays)';
}


}

/// @nodoc
abstract mixin class _$ServiceCopyWith<$Res> implements $ServiceCopyWith<$Res> {
  factory _$ServiceCopyWith(_Service value, $Res Function(_Service) _then) = __$ServiceCopyWithImpl;
@override @useResult
$Res call({
 String id, String service,@JsonKey(name: 'company_name') String companyName,@JsonKey(name: 'company_short_name') String companyShortName, Map<String, Station> stations, Map<String, Facility> facilities, Map<TimetableDate, Map<Direction, Map<String, Train>>> trains, List<Surcharge> surcharges, List<DateTime> holidays
});




}
/// @nodoc
class __$ServiceCopyWithImpl<$Res>
    implements _$ServiceCopyWith<$Res> {
  __$ServiceCopyWithImpl(this._self, this._then);

  final _Service _self;
  final $Res Function(_Service) _then;

/// Create a copy of Service
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? service = null,Object? companyName = null,Object? companyShortName = null,Object? stations = null,Object? facilities = null,Object? trains = null,Object? surcharges = null,Object? holidays = null,}) {
  return _then(_Service(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,service: null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as String,companyName: null == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String,companyShortName: null == companyShortName ? _self.companyShortName : companyShortName // ignore: cast_nullable_to_non_nullable
as String,stations: null == stations ? _self._stations : stations // ignore: cast_nullable_to_non_nullable
as Map<String, Station>,facilities: null == facilities ? _self._facilities : facilities // ignore: cast_nullable_to_non_nullable
as Map<String, Facility>,trains: null == trains ? _self._trains : trains // ignore: cast_nullable_to_non_nullable
as Map<TimetableDate, Map<Direction, Map<String, Train>>>,surcharges: null == surcharges ? _self._surcharges : surcharges // ignore: cast_nullable_to_non_nullable
as List<Surcharge>,holidays: null == holidays ? _self._holidays : holidays // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}


}

// dart format on
