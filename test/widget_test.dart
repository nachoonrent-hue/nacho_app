import 'package:flutter_test/flutter_test.dart';
import 'package:nacho_app/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NachoApp());
    expect(find.text('NACHOONRENT'), findsOneWidget);
  });
}
