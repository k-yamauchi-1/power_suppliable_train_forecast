// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchCond _$SearchCondFromJson(Map<String, dynamic> json) => _SearchCond(
  depID: json['depID'] as String? ?? "OH01",
  direction:
      $enumDecodeNullable(_$DirectionEnumMap, json['direction']) ??
      Direction.up,
  arvIDs:
      (json['arvIDs'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  target:
      $enumDecodeNullable(_$TargetDateEnumMap, json['target']) ??
      TargetDate.today,
  hourFrom: (json['hourFrom'] as num?)?.toInt() ?? -1,
);

Map<String, dynamic> _$SearchCondToJson(_SearchCond instance) =>
    <String, dynamic>{
      'depID': instance.depID,
      'direction': _$DirectionEnumMap[instance.direction]!,
      'arvIDs': instance.arvIDs,
      'target': _$TargetDateEnumMap[instance.target]!,
      'hourFrom': instance.hourFrom,
    };

const _$DirectionEnumMap = {Direction.up: 'up', Direction.down: 'down'};

const _$TargetDateEnumMap = {
  TargetDate.today: 'today',
  TargetDate.nextDay: 'nextDay',
  TargetDate.weekday: 'weekday',
  TargetDate.holiday: 'holiday',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Cond)
final condProvider = CondProvider._();

final class CondProvider extends $NotifierProvider<Cond, SearchCond> {
  CondProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'condProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$condHash();

  @$internal
  @override
  Cond create() => Cond();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchCond value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchCond>(value),
    );
  }
}

String _$condHash() => r'821a982c78a5cc8e1456520a55074a801690fc07';

abstract class _$Cond extends $Notifier<SearchCond> {
  SearchCond build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SearchCond, SearchCond>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SearchCond, SearchCond>,
              SearchCond,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
