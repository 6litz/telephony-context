import 'package:flutter_test/flutter_test.dart';

import 'package:telephony_context_example/main.dart';

void main() {
  testWidgets('Load button is present', (WidgetTester tester) async {
    await tester.pumpWidget(const TelephonyExampleApp());
    expect(find.textContaining('Load telephony context'), findsOneWidget);
  });
}
