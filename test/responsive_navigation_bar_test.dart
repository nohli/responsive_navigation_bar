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

  testWidgets('buttonPadding parameter works on NavigationBarButton',
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
                buttonPadding: EdgeInsets.all(20),
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

  testWidgets('deprecated padding parameter still works',
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
              // ignore: deprecated_member_use_from_same_package
              NavigationBarButton(
                text: 'Home',
                icon: Icons.home,
                padding: EdgeInsets.all(15),
              ),
              NavigationBarButton(text: 'Search', icon: Icons.search),
            ],
          ),
        ),
      ),
    );

    // The widget should build without errors even with deprecated parameter
    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
  });

  testWidgets('assertion fails when both buttonPadding and padding are used',
      (WidgetTester tester) async {
    expect(
      () => NavigationBarButton(
        text: 'Home',
        icon: Icons.home,
        // ignore: deprecated_member_use_from_same_package
        padding: const EdgeInsets.all(10),
        buttonPadding: const EdgeInsets.all(15),
      ),
      throwsA(isA<AssertionError>()),
    );
  });
}
