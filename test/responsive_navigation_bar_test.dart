import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  testWidgets('ResponsiveNavigationBar accepts buttonBorderRadius parameter',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            navigationBarButtons: const [
              NavigationBarButton(
                text: 'Tab 1',
                icon: Icons.home,
                backgroundColor: Colors.blue,
              ),
              NavigationBarButton(
                text: 'Tab 2',
                icon: Icons.star,
                backgroundColor: Colors.red,
              ),
            ],
            onTabChange: (index) {
              selectedIndex = index;
            },
            selectedIndex: selectedIndex,
            borderRadius: 80,
            buttonBorderRadius: 20,
          ),
        ),
      ),
    );

    // Verify the widget is created
    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);

    // Verify the buttonBorderRadius parameter is set correctly
    final navBar = tester.widget<ResponsiveNavigationBar>(
      find.byType(ResponsiveNavigationBar),
    );
    expect(navBar.buttonBorderRadius, 20);
    expect(navBar.borderRadius, 80);

    // Verify that buttons use the buttonBorderRadius value
    // Find all DecoratedBox widgets (buttons have DecoratedBox with border radius)
    await tester.pumpAndSettle();
    final decoratedBoxes = tester.widgetList<DecoratedBox>(
      find.descendant(
        of: find.byType(ResponsiveNavigationBar),
        matching: find.byType(DecoratedBox),
      ),
    );

    // Check that button DecoratedBoxes use buttonBorderRadius (20)
    // Only check DecoratedBoxes that have a borderRadius and a color matching button backgrounds
    var buttonDecoratedBoxFound = false;
    for (final box in decoratedBoxes) {
      final decoration = box.decoration as BoxDecoration?;
      if (decoration?.borderRadius != null &&
          (decoration?.color == Colors.blue ||
              decoration?.color == Colors.red)) {
        final radius = decoration!.borderRadius as BorderRadius;
        // Button border radius should be 20
        expect(radius.topLeft.x, 20);
        buttonDecoratedBoxFound = true;
        break;
      }
    }
    expect(buttonDecoratedBoxFound, true,
        reason: 'Should find at least one button with border radius');
  });

  testWidgets(
      'ResponsiveNavigationBar buttonBorderRadius defaults to borderRadius',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            navigationBarButtons: const [
              NavigationBarButton(
                text: 'Tab 1',
                icon: Icons.home,
                backgroundColor: Colors.blue,
              ),
              NavigationBarButton(
                text: 'Tab 2',
                icon: Icons.star,
                backgroundColor: Colors.red,
              ),
            ],
            onTabChange: (index) {
              selectedIndex = index;
            },
            selectedIndex: selectedIndex,
            borderRadius: 40,
          ),
        ),
      ),
    );

    // Verify the widget is created
    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);

    // Verify the buttonBorderRadius is null (not set)
    final navBar = tester.widget<ResponsiveNavigationBar>(
      find.byType(ResponsiveNavigationBar),
    );
    expect(navBar.buttonBorderRadius, isNull);
    expect(navBar.borderRadius, 40);

    // Verify that buttons default to using borderRadius value (40)
    await tester.pumpAndSettle();
    final decoratedBoxes = tester.widgetList<DecoratedBox>(
      find.descendant(
        of: find.byType(ResponsiveNavigationBar),
        matching: find.byType(DecoratedBox),
      ),
    );

    // Check that button DecoratedBoxes use borderRadius (40) as fallback
    var buttonDecoratedBoxFound = false;
    for (final box in decoratedBoxes) {
      final decoration = box.decoration as BoxDecoration?;
      // Only check DecoratedBoxes that have a borderRadius and a color matching button backgrounds
      if (decoration?.borderRadius != null &&
          (decoration?.color == Colors.blue ||
              decoration?.color == Colors.red)) {
        final radius = decoration!.borderRadius as BorderRadius;
        // Button border radius should default to borderRadius (40)
        expect(radius.topLeft.x, 40);
        buttonDecoratedBoxFound = true;
        break;
      }
    }
    expect(buttonDecoratedBoxFound, true,
        reason: 'Should find at least one button with border radius');
  });
}
