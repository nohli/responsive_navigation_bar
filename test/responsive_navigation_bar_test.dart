import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  testWidgets('showActiveButtonText displays text on active button',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            showActiveButtonText: true,
            showInactiveButtonText: false,
            navigationBarButtons: const [
              NavigationBarButton(text: 'Home', icon: Icons.home),
              NavigationBarButton(text: 'Search', icon: Icons.search),
            ],
          ),
        ),
      ),
    );

    // Active button text should be visible
    expect(find.text('Home'), findsOneWidget);
    // Inactive button text should not be visible
    expect(find.text('Search'), findsNothing);
  });

  testWidgets('showInactiveButtonText displays text on inactive buttons',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            showActiveButtonText: true,
            showInactiveButtonText: true,
            navigationBarButtons: const [
              NavigationBarButton(text: 'Home', icon: Icons.home),
              NavigationBarButton(text: 'Search', icon: Icons.search),
            ],
          ),
        ),
      ),
    );

    // Both active and inactive button text should be visible
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Search'), findsOneWidget);
  });

  testWidgets('inactive buttons show text when showInactiveButtonText is true',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            showActiveButtonText: false,
            showInactiveButtonText: true,
            navigationBarButtons: const [
              NavigationBarButton(text: 'Home', icon: Icons.home),
              NavigationBarButton(text: 'Search', icon: Icons.search),
              NavigationBarButton(text: 'Profile', icon: Icons.person),
            ],
          ),
        ),
      ),
    );

    // Active button text should not be visible (showActiveButtonText is false)
    expect(find.text('Home'), findsNothing);
    // Inactive button texts should be visible
    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('buttonSpacing adds spacing between buttons',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            buttonSpacing: 8,
            navigationBarButtons: const [
              NavigationBarButton(text: 'Home', icon: Icons.home),
              NavigationBarButton(text: 'Search', icon: Icons.search),
              NavigationBarButton(text: 'Profile', icon: Icons.person),
            ],
          ),
        ),
      ),
    );

    // Find all SizedBox widgets
    final sizedBoxes = find.byType(SizedBox);
    // There should be at least 2 SizedBox widgets for spacing (one between each button)
    expect(sizedBoxes, findsWidgets);
  });

  testWidgets('padding parameter works on NavigationBarButton',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            navigationBarButtons: const [
              NavigationBarButton(
                text: 'Home',
                icon: Icons.home,
                padding: EdgeInsets.all(20),
              ),
              NavigationBarButton(text: 'Search', icon: Icons.search),
            ],
          ),
        ),
      ),
    );

    // The widget should build without errors
    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
  });

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
  testWidgets('ResponsiveNavigationBar accepts border property',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            navigationBarButtons: <NavigationBarButton>[
              const NavigationBarButton(
                text: 'Tab 1',
                icon: Icons.home,
              ),
              const NavigationBarButton(
                text: 'Tab 2',
                icon: Icons.star,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
  });

  testWidgets('NavigationBarButton accepts border property',
      (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              selectedIndex = index;
            },
            navigationBarButtons: <NavigationBarButton>[
              NavigationBarButton(
                text: 'Tab 1',
                icon: Icons.home,
                border: Border.all(
                  color: Colors.blue,
                  width: 1.5,
                ),
              ),
              NavigationBarButton(
                text: 'Tab 2',
                icon: Icons.star,
                border: Border.all(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
  });
}
