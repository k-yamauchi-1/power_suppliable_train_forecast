// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'train.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Train {

 String get name; String get intl; int get number;@JsonKey(name: 'facility_id') String get facilityId; List<TrainStop> get stops;@JsonKey(name: 'except_dates') List<DateTime> get exceptDates;
/// Create a copy of Train
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainCopyWith<Train> get copyWith => _$TrainCopyWithImpl<Train>(this as Train, _$identity);

  /// Serializes this Train to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Train&&(identical(other.name, name) || other.name == name)&&(identical(other.intl, intl) || other.intl == intl)&&(identical(other.number, number) || other.number == number)&&(identical(other.facilityId, facilityId) || other.facilityId == facilityId)&&const DeepCollectionEquality().equals(other.stops, stops)&&const DeepCollectionEquality().equals(other.exceptDates, exceptDates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,intl,number,facilityId,const DeepCollectionEquality().hash(stops),const DeepCollectionEquality().hash(exceptDates));

@override
String toString() {
  return 'Train(name: $name, intl: $intl, number: $number, facilityId: $facilityId, stops: $stops, exceptDates: $exceptDates)';
}


}

/// @nodoc
abstract mixin class $TrainCopyWith<$Res>  {
  factory $TrainCopyWith(Train value, $Res Function(Train) _then) = _$TrainCopyWithImpl;
@useResult
$Res call({
 String name, String intl, int number,@JsonKey(name: 'facility_id') String facilityId, List<TrainStop> stops,@JsonKey(name: 'except_dates') List<DateTime> exceptDates
});




}
/// @nodoc
class _$TrainCopyWithImpl<$Res>
    implements $TrainCopyWith<$Res> {
  _$TrainCopyWithImpl(this._self, this._then);

  final Train _self;
  final $Res Function(Train) _then;

/// Create a copy of Train
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? intl = null,Object? number = null,Object? facilityId = null,Object? stops = null,Object? exceptDates = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intl: null == intl ? _self.intl : intl // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,facilityId: null == facilityId ? _self.facilityId : facilityId // ignore: cast_nullable_to_non_nullable
as String,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<TrainStop>,exceptDates: null == exceptDates ? _self.exceptDates : exceptDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}

}


/// Adds pattern-matching-related methods to [Train].
extension TrainPatterns on Train {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Train value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Train() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Train value)  $default,){
final _that = this;
switch (_that) {
case _Train():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Train value)?  $default,){
final _that = this;
switch (_that) {
case _Train() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String intl,  int number, @JsonKey(name: 'facility_id')  String facilityId,  List<TrainStop> stops, @JsonKey(name: 'except_dates')  List<DateTime> exceptDates)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Train() when $default != null:
return $default(_that.name,_that.intl,_that.number,_that.facilityId,_that.stops,_that.exceptDates);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String intl,  int number, @JsonKey(name: 'facility_id')  String facilityId,  List<TrainStop> stops, @JsonKey(name: 'except_dates')  List<DateTime> exceptDates)  $default,) {final _that = this;
switch (_that) {
case _Train():
return $default(_that.name,_that.intl,_that.number,_that.facilityId,_that.stops,_that.exceptDates);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String intl,  int number, @JsonKey(name: 'facility_id')  String facilityId,  List<TrainStop> stops, @JsonKey(name: 'except_dates')  List<DateTime> exceptDates)?  $default,) {final _that = this;
switch (_that) {
case _Train() when $default != null:
return $default(_that.name,_that.intl,_that.number,_that.facilityId,_that.stops,_that.exceptDates);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Train extends Train {
  const _Train({required this.name, this.intl = '', required this.number, @JsonKey(name: 'facility_id') required this.facilityId, required final  List<TrainStop> stops, @JsonKey(name: 'except_dates') final  List<DateTime> exceptDates = const []}): _stops = stops,_exceptDates = exceptDates,super._();
  factory _Train.fromJson(Map<String, dynamic> json) => _$TrainFromJson(json);

@override final  String name;
@override@JsonKey() final  String intl;
@override final  int number;
@override@JsonKey(name: 'facility_id') final  String facilityId;
 final  List<TrainStop> _stops;
@override List<TrainStop> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

 final  List<DateTime> _exceptDates;
@override@JsonKey(name: 'except_dates') List<DateTime> get exceptDates {
  if (_exceptDates is EqualUnmodifiableListView) return _exceptDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exceptDates);
}


/// Create a copy of Train
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainCopyWith<_Train> get copyWith => __$TrainCopyWithImpl<_Train>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Train&&(identical(other.name, name) || other.name == name)&&(identical(other.intl, intl) || other.intl == intl)&&(identical(other.number, number) || other.number == number)&&(identical(other.facilityId, facilityId) || other.facilityId == facilityId)&&const DeepCollectionEquality().equals(other._stops, _stops)&&const DeepCollectionEquality().equals(other._exceptDates, _exceptDates));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,intl,number,facilityId,const DeepCollectionEquality().hash(_stops),const DeepCollectionEquality().hash(_exceptDates));

@override
String toString() {
  return 'Train(name: $name, intl: $intl, number: $number, facilityId: $facilityId, stops: $stops, exceptDates: $exceptDates)';
}


}

/// @nodoc
abstract mixin class _$TrainCopyWith<$Res> implements $TrainCopyWith<$Res> {
  factory _$TrainCopyWith(_Train value, $Res Function(_Train) _then) = __$TrainCopyWithImpl;
@override @useResult
$Res call({
 String name, String intl, int number,@JsonKey(name: 'facility_id') String facilityId, List<TrainStop> stops,@JsonKey(name: 'except_dates') List<DateTime> exceptDates
});




}
/// @nodoc
class __$TrainCopyWithImpl<$Res>
    implements _$TrainCopyWith<$Res> {
  __$TrainCopyWithImpl(this._self, this._then);

  final _Train _self;
  final $Res Function(_Train) _then;

/// Create a copy of Train
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? intl = null,Object? number = null,Object? facilityId = null,Object? stops = null,Object? exceptDates = null,}) {
  return _then(_Train(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,intl: null == intl ? _self.intl : intl // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,facilityId: null == facilityId ? _self.facilityId : facilityId // ignore: cast_nullable_to_non_nullable
as String,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<TrainStop>,exceptDates: null == exceptDates ? _self._exceptDates : exceptDates // ignore: cast_nullable_to_non_nullable
as List<DateTime>,
  ));
}


}


/// @nodoc
mixin _$TrainStop {

 String get id; int get hour; int get min;
/// Create a copy of TrainStop
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainStopCopyWith<TrainStop> get copyWith => _$TrainStopCopyWithImpl<TrainStop>(this as TrainStop, _$identity);

  /// Serializes this TrainStop to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainStop&&(identical(other.id, id) || other.id == id)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.min, min) || other.min == min));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hour,min);

@override
String toString() {
  return 'TrainStop(id: $id, hour: $hour, min: $min)';
}


}

/// @nodoc
abstract mixin class $TrainStopCopyWith<$Res>  {
  factory $TrainStopCopyWith(TrainStop value, $Res Function(TrainStop) _then) = _$TrainStopCopyWithImpl;
@useResult
$Res call({
 String id, int hour, int min
});




}
/// @nodoc
class _$TrainStopCopyWithImpl<$Res>
    implements $TrainStopCopyWith<$Res> {
  _$TrainStopCopyWithImpl(this._self, this._then);

  final TrainStop _self;
  final $Res Function(TrainStop) _then;

/// Create a copy of TrainStop
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? hour = null,Object? min = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainStop].
extension TrainStopPatterns on TrainStop {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainStop value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainStop() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainStop value)  $default,){
final _that = this;
switch (_that) {
case _TrainStop():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainStop value)?  $default,){
final _that = this;
switch (_that) {
case _TrainStop() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int hour,  int min)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainStop() when $default != null:
return $default(_that.id,_that.hour,_that.min);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int hour,  int min)  $default,) {final _that = this;
switch (_that) {
case _TrainStop():
return $default(_that.id,_that.hour,_that.min);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int hour,  int min)?  $default,) {final _that = this;
switch (_that) {
case _TrainStop() when $default != null:
return $default(_that.id,_that.hour,_that.min);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainStop extends TrainStop {
  const _TrainStop({required this.id, required this.hour, required this.min}): super._();
  factory _TrainStop.fromJson(Map<String, dynamic> json) => _$TrainStopFromJson(json);

@override final  String id;
@override final  int hour;
@override final  int min;

/// Create a copy of TrainStop
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainStopCopyWith<_TrainStop> get copyWith => __$TrainStopCopyWithImpl<_TrainStop>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainStopToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainStop&&(identical(other.id, id) || other.id == id)&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.min, min) || other.min == min));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,hour,min);

@override
String toString() {
  return 'TrainStop(id: $id, hour: $hour, min: $min)';
}


}

/// @nodoc
abstract mixin class _$TrainStopCopyWith<$Res> implements $TrainStopCopyWith<$Res> {
  factory _$TrainStopCopyWith(_TrainStop value, $Res Function(_TrainStop) _then) = __$TrainStopCopyWithImpl;
@override @useResult
$Res call({
 String id, int hour, int min
});




}
/// @nodoc
class __$TrainStopCopyWithImpl<$Res>
    implements _$TrainStopCopyWith<$Res> {
  __$TrainStopCopyWithImpl(this._self, this._then);

  final _TrainStop _self;
  final $Res Function(_TrainStop) _then;

/// Create a copy of TrainStop
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? hour = null,Object? min = null,}) {
  return _then(_TrainStop(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,min: null == min ? _self.min : min // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
