import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/inputs/time_selector.dart';
import 'package:power_suppliable_train_forecast/models/search_condition.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

class MockCond extends Cond {
  @override
  SearchCond build() {
    return const SearchCond(target: TargetDate.weekday, hourFrom: -1);
  }
}

void main() {
  group('TimeSelector', () {
    late SharedPreferences sharedPrefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
          // Use weekday target so that all hours (6 to 23) are statically available of any execution time
          condProvider.overrideWith(MockCond.new),
        ],
        child: const MaterialApp(home: Scaffold(body: TimeSelector()))
      );
    }

    testWidgets('renders DropdownButton with fromHours and allows selection', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pumpAndSettle();

      // Default selection should be "始発" (since target is weekday)
      expect(find.text('始発'), findsOneWidget);

      // Tap on dropdown to open menu
      await tester.tap(find.byType(DropdownButton<int>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('7時').last);
      await tester.pumpAndSettle();

      // The selection should have changed to '7時'
      expect(find.text('7時'), findsWidgets);
    });
  });
}
