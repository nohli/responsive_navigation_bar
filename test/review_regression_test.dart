import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  testWidgets('repeated button instances retain their list positions', (tester) async {
    const button = NavigationBarButton(icon: Icons.home);
    final taps = <int>[];
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        bottomNavigationBar: ResponsiveNavigationBar(
          navigationBarButtons: const [button, button, button],
          onTabChange: taps.add,
          showActiveButtonText: false,
          buttonSpacing: 8,
        ),
      ),
    ));
    final buttons = find.descendant(
      of: find.byType(ResponsiveNavigationBar),
      matching: find.byType(GestureDetector),
    );
    for (var index = 0; index < 3; index++) {
      await tester.tap(buttons.at(index));
    }
    expect(taps, [0, 1, 2]);
    final gaps = tester.widgetList<SizedBox>(find.descendant(
      of: find.byType(ResponsiveNavigationBar),
      matching: find.byType(SizedBox),
    ));
    expect(gaps.where((box) => box.width == 8), hasLength(2));
  });

  for (final opacity in [0.0, 0.4, 1.0]) {
    testWidgets('backgroundOpacity $opacity scales gradient alpha', (tester) async {
      const gradient = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.2, 0.8],
        colors: [Color(0xccff0000), Color(0x990000ff)],
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            navigationBarButtons: const [NavigationBarButton()],
            onTabChange: (_) {},
            backgroundGradient: gradient,
            backgroundOpacity: opacity,
          ),
        ),
      ));
      final decoration = tester
          .widget<DecoratedBox>(find
              .descendant(
                of: find.byType(ResponsiveNavigationBar),
                matching: find.byType(DecoratedBox),
              )
              .first)
          .decoration as BoxDecoration;
      final actual = decoration.gradient! as LinearGradient;
      expect(actual.begin, gradient.begin);
      expect(actual.end, gradient.end);
      expect(actual.stops, gradient.stops);
      for (var index = 0; index < actual.colors.length; index++) {
        expect(actual.colors[index].a, closeTo(gradient.colors[index].a * opacity, 0.005));
      }
    });
  }
}
