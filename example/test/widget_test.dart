import 'package:flutter_test/flutter_test.dart';

import 'package:responsive_navigation_bar_example/main.dart';

void main() {
  testWidgets('Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
  });
}
