import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:telephony_context/telephony_context.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('getContext returns a TelephonyContext', (WidgetTester tester) async {
    final TelephonyContext ctx = await TelephonyContextPlugin.getContext();
    expect(ctx.toJson(), isA<Map<String, dynamic>>());
  });
}
