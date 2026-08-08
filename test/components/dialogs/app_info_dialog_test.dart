import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import 'package:power_suppliable_train_forecast/components/dialogs/app_info_dialog.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

class MockUrlLauncher extends UrlLauncherPlatform with MockPlatformInterfaceMixin {
  String? launchedUrl;

  @override
  LinkDelegate? get linkDelegate => null;

  @override
  Future<bool> canLaunch(String url) async => true;

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    launchedUrl = url;
    return true;
  }
}

void main() {
  group('AppInfoDialog', () {
    late SharedPreferences sharedPrefs;
    late MockUrlLauncher mockUrlLauncher;

    setUp(() async {
      await LocaleSettings.setLocale(AppLocale.ja);
      mockUrlLauncher = MockUrlLauncher();
      UrlLauncherPlatform.instance = mockUrlLauncher;
    });

    Widget createWidgetUnderTest(SharedPreferences prefs) {
      return ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: MaterialApp(home: Scaffold(body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => const AppInfoDialog(),
            ),
            child: const Text('Show'),
          )
        )))
      );
    }

    testWidgets('uninitialized state: checkbox is unchecked, "利用開始" button is disabled until checked', (tester) async {
      SharedPreferences.setMockInitialValues({}); // uninitialized
      sharedPrefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(createWidgetUnderTest(sharedPrefs));
      await tester.pumpAndSettle();
      final container =
          ProviderScope.containerOf(tester.element(find.byType(Scaffold)));

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Checkbox should be present
      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text('免責事項・利用規約に同意して'), findsOneWidget);

      // Button "利用開始" should be present
      final startButtonFinder = find.widgetWithText(FilledButton, '利用開始');
      expect(startButtonFinder, findsOneWidget);

      // Button is disabled, so tapping it does nothing (cannot be pressed)
      expect(
        (tester.element(startButtonFinder).widget as FilledButton).enabled,
        isFalse
      );

      // Tap Checkbox to check
      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      // Check enabled status now
      expect(tester.widget<FilledButton>(startButtonFinder).enabled, isTrue);

      // Tap "利用開始"
      await tester.tap(startButtonFinder);
      await tester.pumpAndSettle();

      // Dialog should be dismissed, and storage initialized
      expect(find.byType(AppInfoDialog), findsNothing);

      expect(container.read(localStorageProvider.notifier).initialized, isTrue);
    });

    testWidgets('initialized state: checkbox is missing, "OK" button is active immediately', (tester) async {
      SharedPreferences.setMockInitialValues({'init': 0}); // already initialized
      sharedPrefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(createWidgetUnderTest(sharedPrefs));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Checkbox should be missing
      expect(find.byType(Checkbox), findsNothing);

      // OK button instead of "利用開始"
      final okButtonFinder = find.widgetWithText(FilledButton, 'OK');
      expect(okButtonFinder, findsOneWidget);
      expect(tester.widget<FilledButton>(okButtonFinder).enabled, isTrue);

      // Tap "OK" closes dialog
      await tester.tap(okButtonFinder);
      await tester.pumpAndSettle();

      expect(find.byType(AppInfoDialog), findsNothing);
    });

    testWidgets('external links are clickable and invoke correct URLs', (tester) async {
      await LocaleSettings.setLocale(AppLocale.ja);
      SharedPreferences.setMockInitialValues({'init': 0}); // already initialized
      sharedPrefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(createWidgetUnderTest(sharedPrefs));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      // Click Terms URL (ja)
      await tester.tap(find.text(t.termAndPolicy));
      await tester.pumpAndSettle();
      expect(mockUrlLauncher.launchedUrl, 'https://pwr-suppliable-train-forecast.web.app');

      // Click Release Info URL. The expected destination depends on
      // defaultTargetPlatform, which flutter test always runs as android.
      await tester.tap(find.text('リリース情報'));
      await tester.pumpAndSettle();
      expect(
        mockUrlLauncher.launchedUrl,
        switch (defaultTargetPlatform) {
          TargetPlatform.android =>
            'https://play.google.com/store/apps/details?id=com.k26yamauchi.power_suppliable_train_forecast',
          TargetPlatform.iOS => 'https://apps.apple.com/jp/app/id6788913050',
          _ => 'https://example.com/'
        },
      );
    });

    testWidgets('Terms URL points to index_en.html for non-ja locales', (tester) async {
      await LocaleSettings.setLocale(AppLocale.en);
      SharedPreferences.setMockInitialValues({'init': 0});
      sharedPrefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(createWidgetUnderTest(sharedPrefs));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show'));
      await tester.pumpAndSettle();

      await tester.tap(find.text(t.termAndPolicy));
      await tester.pumpAndSettle();
      expect(mockUrlLauncher.launchedUrl, 'https://pwr-suppliable-train-forecast.web.app/index_en.html');

      await LocaleSettings.setLocale(AppLocale.ja);
    });
  });
}
