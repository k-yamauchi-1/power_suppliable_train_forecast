import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/providers/local_storage.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';

void main() {
  late SharedPreferences prefs;
  late ProviderContainer container;

  Future<void> setUpWithInitialValues(Map<String, Object> initValues) async {
    SharedPreferences.setMockInitialValues(initValues);
    prefs = await SharedPreferences.getInstance();
    container = ProviderContainer
        .test(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)]);
  }

  test('initializes and reads stored values from SharedPreferences', () async {
    final initialCond = const SearchCond(depID: 'OH02', hourFrom: 9);
    await setUpWithInitialValues({
      'saved_conditions': jsonEncode({'123456789': initialCond.toJson()}),
      'init': 123456789
    });

    final repo = container.read(localStorageProvider.notifier);
    expect(repo.initialized, isTrue);
    expect(repo.initCond.depID, 'OH02');
    expect(repo.initCond.hourFrom, 9);

    final loaded = repo.loadCond(123456789);
    expect(loaded, isNotNull);
    expect(loaded!.depID, 'OH02');
  });

  test('initializes with default values when SharedPreferences is empty', () async {
    await setUpWithInitialValues({});

    final repo = container.read(localStorageProvider.notifier);
    expect(repo.initialized, isFalse);
    expect(repo.initCond.depID, 'OH01'); // Falls back to default SearchCond()
  });

  test('setInit updates initKey and saves to SharedPreferences', () async {
    await setUpWithInitialValues({});

    final repo = container.read(localStorageProvider.notifier);
    repo.setInit(999);

    expect(repo.state.initKey, 999);
    expect(prefs.getInt('init'), 999);
  });

  test('addCond inserts new condition and saves to SharedPreferences', () async {
    await setUpWithInitialValues({});

    final repo = container.read(localStorageProvider.notifier);
    expect(repo.state.conds, isEmpty);

    repo.addCond(const SearchCond(depID: 'OH10', hourFrom: 12));
    expect(repo.state.conds.length, 1);

    final newKey = repo.state.conds.keys.first;
    expect(repo.state.conds[newKey]!.depID, 'OH10');

    // Check SharedPreferences update
    final savedStr = prefs.getString('saved_conditions');
    expect(savedStr, isNotNull);

    final decoded = jsonDecode(savedStr!) as Map;
    expect(decoded.length, 1);
    expect(decoded[newKey.toString()]['depID'], 'OH10');
  });

  test('deleteCond removes condition and saves to SharedPreferences', () async {
    await setUpWithInitialValues({
      'saved_conditions': jsonEncode({
        '111': const SearchCond(depID: 'OH02').toJson(),
        '222': const SearchCond(depID: 'OH03').toJson()
      }),
      'init': 111
    });

    final repo = container.read(localStorageProvider.notifier);
    expect(repo.state.conds.length, 2);

    repo.deleteCond(111);
    expect(repo.state.conds.length, 1);
    expect(repo.state.conds.containsKey(111), isFalse);
    expect(repo.state.conds.containsKey(222), isTrue);

    final decoded = jsonDecode(prefs.getString('saved_conditions')!) as Map;
    expect(decoded.containsKey('111'), isFalse);
    expect(decoded.containsKey('222'), isTrue);
  });
}
