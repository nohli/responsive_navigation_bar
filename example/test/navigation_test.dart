import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar_example/main.dart';

void main() {
  testWidgets('each navigation destination updates the example content', (tester) async {
    await tester.pumpWidget(const MyApp());
    final icons = [Icons.people, Icons.star, Icons.settings];
    for (var index = 0; index < icons.length; index++) {
      await tester.tap(find.byIcon(icons[index]));
      await tester.pumpAndSettle();
      expect(find.text('Selected tab ${index + 1}'), findsOneWidget);
    }
  });
}
