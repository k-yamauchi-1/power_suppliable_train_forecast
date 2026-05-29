// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_condition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchCond {

 String get depID; Direction get direction; List<String> get arvIDs; TargetDate get target; int get hourFrom;
/// Create a copy of SearchCond
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchCondCopyWith<SearchCond> get copyWith => _$SearchCondCopyWithImpl<SearchCond>(this as SearchCond, _$identity);

  /// Serializes this SearchCond to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchCond&&(identical(other.depID, depID) || other.depID == depID)&&(identical(other.direction, direction) || other.direction == direction)&&const DeepCollectionEquality().equals(other.arvIDs, arvIDs)&&(identical(other.target, target) || other.target == target)&&(identical(other.hourFrom, hourFrom) || other.hourFrom == hourFrom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,depID,direction,const DeepCollectionEquality().hash(arvIDs),target,hourFrom);

@override
String toString() {
  return 'SearchCond(depID: $depID, direction: $direction, arvIDs: $arvIDs, target: $target, hourFrom: $hourFrom)';
}


}

/// @nodoc
abstract mixin class $SearchCondCopyWith<$Res>  {
  factory $SearchCondCopyWith(SearchCond value, $Res Function(SearchCond) _then) = _$SearchCondCopyWithImpl;
@useResult
$Res call({
 String depID, Direction direction, List<String> arvIDs, TargetDate target, int hourFrom
});




}
/// @nodoc
class _$SearchCondCopyWithImpl<$Res>
    implements $SearchCondCopyWith<$Res> {
  _$SearchCondCopyWithImpl(this._self, this._then);

  final SearchCond _self;
  final $Res Function(SearchCond) _then;

/// Create a copy of SearchCond
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? depID = null,Object? direction = null,Object? arvIDs = null,Object? target = null,Object? hourFrom = null,}) {
  return _then(_self.copyWith(
depID: null == depID ? _self.depID : depID // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,arvIDs: null == arvIDs ? _self.arvIDs : arvIDs // ignore: cast_nullable_to_non_nullable
as List<String>,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TargetDate,hourFrom: null == hourFrom ? _self.hourFrom : hourFrom // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchCond].
extension SearchCondPatterns on SearchCond {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchCond value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchCond() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchCond value)  $default,){
final _that = this;
switch (_that) {
case _SearchCond():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchCond value)?  $default,){
final _that = this;
switch (_that) {
case _SearchCond() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String depID,  Direction direction,  List<String> arvIDs,  TargetDate target,  int hourFrom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchCond() when $default != null:
return $default(_that.depID,_that.direction,_that.arvIDs,_that.target,_that.hourFrom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String depID,  Direction direction,  List<String> arvIDs,  TargetDate target,  int hourFrom)  $default,) {final _that = this;
switch (_that) {
case _SearchCond():
return $default(_that.depID,_that.direction,_that.arvIDs,_that.target,_that.hourFrom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String depID,  Direction direction,  List<String> arvIDs,  TargetDate target,  int hourFrom)?  $default,) {final _that = this;
switch (_that) {
case _SearchCond() when $default != null:
return $default(_that.depID,_that.direction,_that.arvIDs,_that.target,_that.hourFrom);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SearchCond extends SearchCond {
  const _SearchCond({this.depID = "OH01", this.direction = Direction.up, final  List<String> arvIDs = const [], this.target = TargetDate.today, this.hourFrom = -1}): _arvIDs = arvIDs,super._();
  factory _SearchCond.fromJson(Map<String, dynamic> json) => _$SearchCondFromJson(json);

@override@JsonKey() final  String depID;
@override@JsonKey() final  Direction direction;
 final  List<String> _arvIDs;
@override@JsonKey() List<String> get arvIDs {
  if (_arvIDs is EqualUnmodifiableListView) return _arvIDs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arvIDs);
}

@override@JsonKey() final  TargetDate target;
@override@JsonKey() final  int hourFrom;

/// Create a copy of SearchCond
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchCondCopyWith<_SearchCond> get copyWith => __$SearchCondCopyWithImpl<_SearchCond>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SearchCondToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchCond&&(identical(other.depID, depID) || other.depID == depID)&&(identical(other.direction, direction) || other.direction == direction)&&const DeepCollectionEquality().equals(other._arvIDs, _arvIDs)&&(identical(other.target, target) || other.target == target)&&(identical(other.hourFrom, hourFrom) || other.hourFrom == hourFrom));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,depID,direction,const DeepCollectionEquality().hash(_arvIDs),target,hourFrom);

@override
String toString() {
  return 'SearchCond(depID: $depID, direction: $direction, arvIDs: $arvIDs, target: $target, hourFrom: $hourFrom)';
}


}

/// @nodoc
abstract mixin class _$SearchCondCopyWith<$Res> implements $SearchCondCopyWith<$Res> {
  factory _$SearchCondCopyWith(_SearchCond value, $Res Function(_SearchCond) _then) = __$SearchCondCopyWithImpl;
@override @useResult
$Res call({
 String depID, Direction direction, List<String> arvIDs, TargetDate target, int hourFrom
});




}
/// @nodoc
class __$SearchCondCopyWithImpl<$Res>
    implements _$SearchCondCopyWith<$Res> {
  __$SearchCondCopyWithImpl(this._self, this._then);

  final _SearchCond _self;
  final $Res Function(_SearchCond) _then;

/// Create a copy of SearchCond
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? depID = null,Object? direction = null,Object? arvIDs = null,Object? target = null,Object? hourFrom = null,}) {
  return _then(_SearchCond(
depID: null == depID ? _self.depID : depID // ignore: cast_nullable_to_non_nullable
as String,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as Direction,arvIDs: null == arvIDs ? _self._arvIDs : arvIDs // ignore: cast_nullable_to_non_nullable
as List<String>,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as TargetDate,hourFrom: null == hourFrom ? _self.hourFrom : hourFrom // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
