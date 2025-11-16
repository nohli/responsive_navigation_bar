import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  group('ResponsiveNavigationBar', () {
    testWidgets('renders with default parameters', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 0,
              onTabChange: (_) {},
              navigationBarButtons: const [
                NavigationBarButton(text: 'Tab 1', icon: Icons.home),
                NavigationBarButton(text: 'Tab 2', icon: Icons.search),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(ResponsiveNavigationBar), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('shows active button text by default', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 0,
              onTabChange: (_) {},
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
      // Inactive button text should not be visible by default
      expect(find.text('Search'), findsNothing);
    });

    testWidgets('hides active button text when showActiveButtonText is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 0,
              onTabChange: (_) {},
              showActiveButtonText: false,
              navigationBarButtons: const [
                NavigationBarButton(text: 'Home', icon: Icons.home),
                NavigationBarButton(text: 'Search', icon: Icons.search),
              ],
            ),
          ),
        ),
      );

      // No text should be visible
      expect(find.text('Home'), findsNothing);
      expect(find.text('Search'), findsNothing);
      // But icons should still be visible
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets(
      'shows inactive button text when showInactiveButtonText is true',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              bottomNavigationBar: ResponsiveNavigationBar(
                selectedIndex: 0,
                onTabChange: (_) {},
                showInactiveButtonText: true,
                navigationBarButtons: const [
                  NavigationBarButton(text: 'Home', icon: Icons.home),
                  NavigationBarButton(text: 'Search', icon: Icons.search),
                  NavigationBarButton(text: 'Settings', icon: Icons.settings),
                ],
              ),
            ),
          ),
        );

        // Active button text should be visible
        expect(find.text('Home'), findsOneWidget);
        // Inactive button texts should also be visible
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Settings'), findsOneWidget);
      },
    );

    testWidgets('shows all button text when both showActiveButtonText and '
        'showInactiveButtonText are true', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 1,
              onTabChange: (_) {},
              showActiveButtonText: true,
              showInactiveButtonText: true,
              navigationBarButtons: const [
                NavigationBarButton(text: 'Home', icon: Icons.home),
                NavigationBarButton(text: 'Search', icon: Icons.search),
                NavigationBarButton(text: 'Settings', icon: Icons.settings),
              ],
            ),
          ),
        ),
      );

      // All button texts should be visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('hides all button text when both flags are false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 0,
              onTabChange: (_) {},
              showActiveButtonText: false,
              showInactiveButtonText: false,
              navigationBarButtons: const [
                NavigationBarButton(text: 'Home', icon: Icons.home),
                NavigationBarButton(text: 'Search', icon: Icons.search),
              ],
            ),
          ),
        ),
      );

      // No text should be visible
      expect(find.text('Home'), findsNothing);
      expect(find.text('Search'), findsNothing);
      // But icons should still be visible
      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('calls onTabChange when button is tapped', (
      WidgetTester tester,
    ) async {
      int? tappedIndex;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 0,
              onTabChange: (index) {
                tappedIndex = index;
              },
              navigationBarButtons: const [
                NavigationBarButton(text: 'Home', icon: Icons.home),
                NavigationBarButton(text: 'Search', icon: Icons.search),
              ],
            ),
          ),
        ),
      );

      // Tap the second button
      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();

      expect(tappedIndex, 1);
    });

    testWidgets('does not show text for empty text strings', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              selectedIndex: 0,
              onTabChange: (_) {},
              showInactiveButtonText: true,
              navigationBarButtons: const [
                NavigationBarButton(text: '', icon: Icons.home),
                NavigationBarButton(text: 'Search', icon: Icons.search),
              ],
            ),
          ),
        ),
      );

      // Empty text should not be rendered even with showInactiveButtonText
      expect(find.text(''), findsNothing);
      // Non-empty text should be visible
      expect(find.text('Search'), findsOneWidget);
    });

    testWidgets('updates text visibility when selectedIndex changes', (
      WidgetTester tester,
    ) async {
      int selectedIndex = 0;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                bottomNavigationBar: ResponsiveNavigationBar(
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  showInactiveButtonText: false,
                  navigationBarButtons: const [
                    NavigationBarButton(text: 'Home', icon: Icons.home),
                    NavigationBarButton(text: 'Search', icon: Icons.search),
                  ],
                ),
              ),
            );
          },
        ),
      );

      // Initially, only Home text should be visible
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsNothing);

      // Tap Search button
      await tester.tap(find.byIcon(Icons.search));
      await tester.pumpAndSettle();

      // Now only Search text should be visible
      expect(find.text('Home'), findsNothing);
      expect(find.text('Search'), findsOneWidget);
    });
  });

  group('NavigationBarButton', () {
    test('can be created with required parameters', () {
      const button = NavigationBarButton(text: 'Test', icon: Icons.home);

      expect(button.text, 'Test');
      expect(button.icon, Icons.home);
    });

    test('accepts optional parameters', () {
      const button = NavigationBarButton(
        text: 'Test',
        icon: Icons.home,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );

      expect(button.backgroundColor, Colors.blue);
      expect(button.textColor, Colors.white);
    });
  });
}
