// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'facility.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Facility {

@JsonKey(name: 'car_type') CarType get carType; Map<String, Probability> get probabilities; String? get notes;
/// Create a copy of Facility
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FacilityCopyWith<Facility> get copyWith => _$FacilityCopyWithImpl<Facility>(this as Facility, _$identity);

  /// Serializes this Facility to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Facility&&(identical(other.carType, carType) || other.carType == carType)&&const DeepCollectionEquality().equals(other.probabilities, probabilities)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,carType,const DeepCollectionEquality().hash(probabilities),notes);

@override
String toString() {
  return 'Facility(carType: $carType, probabilities: $probabilities, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $FacilityCopyWith<$Res>  {
  factory $FacilityCopyWith(Facility value, $Res Function(Facility) _then) = _$FacilityCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'car_type') CarType carType, Map<String, Probability> probabilities, String? notes
});




}
/// @nodoc
class _$FacilityCopyWithImpl<$Res>
    implements $FacilityCopyWith<$Res> {
  _$FacilityCopyWithImpl(this._self, this._then);

  final Facility _self;
  final $Res Function(Facility) _then;

/// Create a copy of Facility
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? carType = null,Object? probabilities = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
carType: null == carType ? _self.carType : carType // ignore: cast_nullable_to_non_nullable
as CarType,probabilities: null == probabilities ? _self.probabilities : probabilities // ignore: cast_nullable_to_non_nullable
as Map<String, Probability>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Facility].
extension FacilityPatterns on Facility {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Facility value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Facility() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Facility value)  $default,){
final _that = this;
switch (_that) {
case _Facility():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Facility value)?  $default,){
final _that = this;
switch (_that) {
case _Facility() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'car_type')  CarType carType,  Map<String, Probability> probabilities,  String? notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Facility() when $default != null:
return $default(_that.carType,_that.probabilities,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'car_type')  CarType carType,  Map<String, Probability> probabilities,  String? notes)  $default,) {final _that = this;
switch (_that) {
case _Facility():
return $default(_that.carType,_that.probabilities,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'car_type')  CarType carType,  Map<String, Probability> probabilities,  String? notes)?  $default,) {final _that = this;
switch (_that) {
case _Facility() when $default != null:
return $default(_that.carType,_that.probabilities,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Facility extends Facility {
  const _Facility({@JsonKey(name: 'car_type') this.carType = CarType.unfixed, required final  Map<String, Probability> probabilities, this.notes}): _probabilities = probabilities,super._();
  factory _Facility.fromJson(Map<String, dynamic> json) => _$FacilityFromJson(json);

@override@JsonKey(name: 'car_type') final  CarType carType;
 final  Map<String, Probability> _probabilities;
@override Map<String, Probability> get probabilities {
  if (_probabilities is EqualUnmodifiableMapView) return _probabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_probabilities);
}

@override final  String? notes;

/// Create a copy of Facility
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FacilityCopyWith<_Facility> get copyWith => __$FacilityCopyWithImpl<_Facility>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FacilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Facility&&(identical(other.carType, carType) || other.carType == carType)&&const DeepCollectionEquality().equals(other._probabilities, _probabilities)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,carType,const DeepCollectionEquality().hash(_probabilities),notes);

@override
String toString() {
  return 'Facility(carType: $carType, probabilities: $probabilities, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$FacilityCopyWith<$Res> implements $FacilityCopyWith<$Res> {
  factory _$FacilityCopyWith(_Facility value, $Res Function(_Facility) _then) = __$FacilityCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'car_type') CarType carType, Map<String, Probability> probabilities, String? notes
});




}
/// @nodoc
class __$FacilityCopyWithImpl<$Res>
    implements _$FacilityCopyWith<$Res> {
  __$FacilityCopyWithImpl(this._self, this._then);

  final _Facility _self;
  final $Res Function(_Facility) _then;

/// Create a copy of Facility
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? carType = null,Object? probabilities = null,Object? notes = freezed,}) {
  return _then(_Facility(
carType: null == carType ? _self.carType : carType // ignore: cast_nullable_to_non_nullable
as CarType,probabilities: null == probabilities ? _self._probabilities : probabilities // ignore: cast_nullable_to_non_nullable
as Map<String, Probability>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
