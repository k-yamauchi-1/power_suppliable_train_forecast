import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:power_suppliable_train_forecast/main.dart';
import 'package:power_suppliable_train_forecast/models/service.dart';
import 'package:power_suppliable_train_forecast/providers/local_storage.dart';

void main() {
  group('PowerSupliableTrainApp', () {
    testWidgets('renders PowerSupliableTrainApp with MaterialApp and MainScreen', (tester) async {
      // already initialized to prevent AppInfoDialog from blocking
      SharedPreferences.setMockInitialValues({'init': 0});
      await tester.pumpWidget(ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(
            await SharedPreferences.getInstance()
          ),
          serviceProvider.overrideWith((ref) => Future.value(Service(
            id: 'romancecar', service: 'ロマンスカー',
            companyName: '小田急', companyShortName: '小田急',
            stations: {}, facilities: {}, trains: {}
          )))
        ],
        child: const PowerSupliableTrainApp()
      ));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(PowerSupliableTrainApp), findsOneWidget);
    });
  });
}
