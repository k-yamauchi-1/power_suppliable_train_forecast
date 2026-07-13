import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/providers/facility_forecast.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('Forecast', () {
    late ProviderContainer container;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer(overrides: [
        sharedPreferencesProvider
            .overrideWithValue(await SharedPreferences.getInstance())
      ]);
    });

    test('returns an empty map when the target date is null (weekday/holiday)', () async {
      container.read(condProvider.notifier).updateProp(target: TargetDate.weekday);
      expect(await container.read(forecastProvider.future), isEmpty);
    });

    test('returns an empty map when no Firebase app is initialized', () async {
      container.read(condProvider.notifier).updateProp(target: TargetDate.today);

      // No Firebase.initializeApp() has been called in the test environment,
      // so Firebase.apps is empty and the Firestore query is skipped entirely.
      expect(await container.read(forecastProvider.future), isEmpty);
    });
  });
}
