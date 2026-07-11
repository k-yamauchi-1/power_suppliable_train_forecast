// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facility_forecast.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Forecast)
final forecastProvider = ForecastProvider._();

final class ForecastProvider
    extends $AsyncNotifierProvider<Forecast, Map<String, Facility>> {
  ForecastProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forecastProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forecastHash();

  @$internal
  @override
  Forecast create() => Forecast();
}

String _$forecastHash() => r'a9b1d78597f003bf7d1611973fe9b38e86379f0d';

abstract class _$Forecast extends $AsyncNotifier<Map<String, Facility>> {
  FutureOr<Map<String, Facility>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, Facility>>, Map<String, Facility>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, Facility>>,
                Map<String, Facility>
              >,
              AsyncValue<Map<String, Facility>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
