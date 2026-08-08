import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_suppliable_train_forecast/components/error_info.dart';
import 'package:power_suppliable_train_forecast/i18n/strings.g.dart';

void main() {
  group('ErrInfoWidget', () {
    setUp(() async => await LocaleSettings.setLocale(AppLocale.ja));

    Widget createWidgetUnderTest({String? message, String? detail}) => MaterialApp(
      home: Scaffold(body: ErrInfoWidget(message: message, detail: detail))
    );

    testWidgets(
      'renders the generic maintenance message when message is null',
      (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        expect(find.byIcon(Icons.error), findsOneWidget);
        expect(
          find.textContaining('ただいまサービスの提供を停止しております'),
          findsOneWidget
        );
        expect(find.byType(SelectableText), findsNothing);
      }
    );

    testWidgets('renders the error message when message is provided', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(message: 'Exception: boom'));

      expect(find.text('エラー: Exception: boom'), findsOneWidget);
    });

    testWidgets('renders selectable detail text when detail is non-empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        message: 'Exception: boom', detail: 'stack trace detail'
      ));

      expect(
        tester.widget<SelectableText>(find.byType(SelectableText)).data,
        'stack trace detail'
      );
    });

    testWidgets('hides detail text when detail is empty', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest(
        message: 'Exception: boom', detail: ''
      ));

      expect(find.byType(SelectableText), findsNothing);
    });
  });
}
