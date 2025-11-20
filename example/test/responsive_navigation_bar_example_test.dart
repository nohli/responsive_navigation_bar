import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar_example/main.dart';

void main() {
  testWidgets('Displays text on first tab', (WidgetTester tester) async {
    const widget = MyApp();
    const text = 'Tab 1';

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.text(text), findsOneWidget);
  });

  testWidgets('Does not display text on second tab', (WidgetTester tester) async {
    const widget = MyApp();
    const text = 'Tab 2';

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    expect(find.text(text), findsNothing);
  });

  testWidgets('Button tap changes tab', (WidgetTester tester) async {
    const widget = MyApp();
    const text = 'Tab 3';

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    final button = find.byIcon(Icons.settings);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text(text), findsOneWidget);
  });
}
