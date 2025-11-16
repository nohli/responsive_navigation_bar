import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
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
