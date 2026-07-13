import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_suppliable_train_forecast/components/app_icons/app_icon_base.dart';

void main() {
  group('AppIconBase', () {
    testWidgets('renders default properties correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppIconBase()))
      );

      // Default size is 48.0
      final Container container = tester.widget(find.byType(Container).first);
      expect(container.constraints?.minWidth, 48.0);
      expect(container.constraints?.minHeight, 48.0);

      // Single bolt icon by default
      expect(find.byIcon(Icons.bolt), findsOneWidget);

      // Electrical services background icon
      expect(find.byIcon(Icons.electrical_services), findsOneWidget);
    });

    testWidgets('renders custom properties and child correctly', (tester) async {
      const customSize = 100.0;
      const customBgColor = Colors.blue;
      const customChildText = 'Test Child';

      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: AppIconBase(
          size: customSize, bgColor: customBgColor, overlayOpacity: 0.3,
          boltIconDouble: true, child: Text(customChildText)
        )
      )));

      // Size check
      final Container container = tester.widget(find.byType(Container).first);
      expect(container.constraints?.minWidth, customSize);
      expect(container.constraints?.minHeight, customSize);

      // Double bolt icon
      expect(find.byIcon(Icons.bolt), findsNWidgets(2));

      // Electrical services icon
      expect(find.byIcon(Icons.electrical_services), findsOneWidget);

      // Custom child is rendered
      expect(find.text(customChildText), findsOneWidget);
    });
  });
}
