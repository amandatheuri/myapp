import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full rewards flow', (tester) async {
    // Launch app
    app.main();
    await tester.pumpAndSettle();

    // Navigate to rewards screen
    await tester.tap(find.text('Rewards'));
    await tester.pumpAndSettle();

    // Verify initial balance
    expect(find.text('0'), findsOneWidget);
  });
}