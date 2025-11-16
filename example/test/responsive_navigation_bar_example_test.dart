import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  testWidgets('Displays text only on active tab (default behavior)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pumpAndSettle();

    // By default (showInactiveButtonText: false), only active tab text
    // should be visible
    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Tab 2'), findsNothing);
    expect(find.text('Tab 3'), findsNothing);
  });

  testWidgets('Displays text on all tabs when showInactiveButtonText is true', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildTestApp(showInactiveButtonText: true));
    await tester.pumpAndSettle();

    // With showInactiveButtonText: true, all button texts should be visible
    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Tab 2'), findsOneWidget);
    expect(find.text('Tab 3'), findsOneWidget);
  });

  testWidgets('Button tap changes tab', (WidgetTester tester) async {
    await tester.pumpWidget(_buildTestApp());
    await tester.pumpAndSettle();

    // Initially Tab 1 is selected
    expect(find.text('Tab 1'), findsOneWidget);
    expect(find.text('Tab 3'), findsNothing);

    // Tap Tab 3 button
    final button = find.byIcon(Icons.settings);
    await tester.tap(button);
    await tester.pumpAndSettle();

    // Now Tab 3 should be visible, Tab 1 should not
    expect(find.text('Tab 1'), findsNothing);
    expect(find.text('Tab 3'), findsOneWidget);
  });
}

Widget _buildTestApp({bool showInactiveButtonText = false}) {
  return MaterialApp(
    home: _TestNavigationBar(showInactiveButtonText: showInactiveButtonText),
  );
}

class _TestNavigationBar extends StatefulWidget {
  const _TestNavigationBar({required this.showInactiveButtonText});

  final bool showInactiveButtonText;

  @override
  State<_TestNavigationBar> createState() => _TestNavigationBarState();
}

class _TestNavigationBarState extends State<_TestNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsiveNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        showInactiveButtonText: widget.showInactiveButtonText,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        navigationBarButtons: const <NavigationBarButton>[
          NavigationBarButton(
            text: 'Tab 1',
            icon: Icons.people,
            backgroundGradient: LinearGradient(
              colors: [Colors.yellow, Colors.green, Colors.blue],
            ),
          ),
          NavigationBarButton(
            text: 'Tab 2',
            icon: Icons.star,
            backgroundGradient: LinearGradient(
              colors: [Colors.cyan, Colors.teal],
            ),
          ),
          NavigationBarButton(
            text: 'Tab 3',
            icon: Icons.settings,
            backgroundGradient: LinearGradient(
              colors: [Colors.green, Colors.yellow],
            ),
          ),
        ],
      ),
    );
  }
}
