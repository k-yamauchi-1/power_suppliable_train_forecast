import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/components/bottom_bar.dart';
import 'package:power_suppliable_train_forecast/components/dialogs/app_info_dialog.dart';
import 'package:power_suppliable_train_forecast/components/dialogs/saved_cond_dialog.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('BottomBar', () {
    late SharedPreferences sharedPrefs;

    setUp(() async {
      await LocaleSettings.setLocale(AppLocale.ja);
      SharedPreferences.setMockInitialValues({});
      sharedPrefs = await SharedPreferences.getInstance();
    });

    Widget createWidgetUnderTest() {
      return ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(sharedPrefs)],
        child: const MaterialApp(home: Scaffold(bottomNavigationBar: BottomBar()))
      );
    }

    testWidgets('renders all navigation destinations', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('本アプリについて'), findsOneWidget);
      expect(find.text('保存した検索条件'), findsOneWidget);
      expect(find.text('更新情報\nお問合せ'), findsOneWidget);
    });

    testWidgets('tapping on AppInfo triggers AppInfoDialog', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap '本アプリについて'
      await tester.tap(find.text('本アプリについて'));
      await tester.pumpAndSettle();

      expect(find.byType(AppInfoDialog), findsOneWidget);
    });

    testWidgets('tapping on Records triggers RecordsDialog', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Tap '保存した検索条件'
      await tester.tap(find.text('保存した検索条件'));
      await tester.pumpAndSettle();

      expect(find.byType(RecordsDialog), findsOneWidget);
    });
  });
}
