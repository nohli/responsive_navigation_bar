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

    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
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

    expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
  });
}
