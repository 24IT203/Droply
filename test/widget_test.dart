import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:project_1/main.dart';

void main() {
  testWidgets(
    'Droply app loads correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: DroplyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Orders'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    },
  );
}