import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/dialogs/saved_cond_dialog.dart';
import 'package:power_suppliable_train_forecast/components/inputs/saved_cond_list_button.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('SavedCondListButton', () {
    late SharedPreferences sharedPrefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();
    });

    Widget createWidgetUnderTest() => ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
      child: const MaterialApp(home: Scaffold(body: SavedCondListButton()))
    );

    testWidgets(
      'renders button with bookmarks icon and opens RecordsDialog on tap',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byType(SavedCondListButton), findsOneWidget);
        expect(find.byIcon(Icons.bookmarks), findsOneWidget);

        await tester.tap(find.byType(SavedCondListButton));
        await tester.pumpAndSettle();

        expect(find.byType(RecordsDialog), findsOneWidget);
      }
    );
  });
}
