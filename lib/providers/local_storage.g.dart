// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = SharedPreferencesProvider._();

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          SharedPreferences,
          SharedPreferences,
          SharedPreferences
        >
    with $Provider<SharedPreferences> {
  SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $ProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferences create(Ref ref) {
    return sharedPreferences(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferences value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferences>(value),
    );
  }
}

String _$sharedPreferencesHash() => r'f5f9b3d62bcebdd6a46bfd28b413b83308d6db16';

@ProviderFor(LocalStorage)
final localStorageProvider = LocalStorageProvider._();

final class LocalStorageProvider
    extends
        $NotifierProvider<LocalStorage, ({SavedConds conds, int? initKey})> {
  LocalStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localStorageHash();

  @$internal
  @override
  LocalStorage create() => LocalStorage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({SavedConds conds, int? initKey}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({SavedConds conds, int? initKey})>(
        value,
      ),
    );
  }
}

String _$localStorageHash() => r'2468c5ce76b8be8d53641e69c98637b728cfeae0';

abstract class _$LocalStorage
    extends $Notifier<({SavedConds conds, int? initKey})> {
  ({SavedConds conds, int? initKey}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({SavedConds conds, int? initKey}),
              ({SavedConds conds, int? initKey})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({SavedConds conds, int? initKey}),
                ({SavedConds conds, int? initKey})
              >,
              ({SavedConds conds, int? initKey}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
