import 'package:flutter_test/flutter_test.dart';
import 'package:nacho_app/main.dart';

void main() {
  testWidgets('App load smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NachoApp());

    // Splash brand mark is present on load (animated in).
    expect(find.text('NACHOONRENT'), findsOneWidget);

    // Let the splash entrance + navigation timer complete and reach Welcome.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('Get Started'), findsOneWidget);
  });
}
