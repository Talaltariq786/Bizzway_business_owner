import 'package:flutter_test/flutter_test.dart';
import 'package:bizzway_business_owner/apps/business_app.dart';

void main() {
  testWidgets('App launches smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BusinessApp());
    await tester.pump();
  });
}
