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
