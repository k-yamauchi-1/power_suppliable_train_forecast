import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:power_suppliable_train_forecast/components/app_icons/app_icon_base.dart';
import 'package:power_suppliable_train_forecast/components/app_icons/splash_icon.dart';

void main() {
  group('SplashIcon', () {
    testWidgets(
      'renders an AppIconBase with correct size, background color, double bolt, and train painting',
      (tester) async {
        const size = 108.0;
        await tester.pumpWidget(const MaterialApp(
          home: Scaffold(body: SplashIcon(size: size)),
        ));

        expect(find.byType(AppIconBase), findsOneWidget);
        final appIconBase = tester.widget<AppIconBase>(find.byType(AppIconBase));
        expect(appIconBase.size, size);
        expect(appIconBase.bgColor, const Color(0xFFF05322));
        expect(appIconBase.boltIconDouble, isTrue);

        // Two bolt icons (double) plus the train silhouette painted via CustomPaint.
        expect(find.byIcon(Icons.bolt), findsNWidgets(2));
        expect(find.byType(CustomPaint), findsWidgets);
      }
    );
  });
}
