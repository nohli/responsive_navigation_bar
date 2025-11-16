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

  testWidgets('Displays text on all tabs with showInactiveButtonText', (
    WidgetTester tester,
  ) async {
    const widget = MyApp();

    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();

    // With showInactiveButtonText: true, all button texts should be visible
    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Tab 2'), findsOneWidget);
    expect(find.text('Tab 3'), findsOneWidget);
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
