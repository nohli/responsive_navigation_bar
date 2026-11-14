import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  for (final gradient in <Gradient>[
    const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.2, 0.8],
      colors: [Color(0xffff0000), Color(0x990000ff)],
      tileMode: TileMode.mirror,
      transform: GradientRotation(1),
    ),
    const RadialGradient(
      center: Alignment.topRight,
      radius: 0.7,
      focal: Alignment.centerLeft,
      focalRadius: 0.1,
      stops: [0.2, 0.8],
      colors: [Color(0xffff0000), Color(0x990000ff)],
      tileMode: TileMode.mirror,
      transform: GradientRotation(1),
    ),
    const SweepGradient(
      center: Alignment.bottomLeft,
      startAngle: 0.2,
      endAngle: 4.5,
      stops: [0.2, 0.8],
      colors: [Color(0xffff0000), Color(0x990000ff)],
      tileMode: TileMode.mirror,
      transform: GradientRotation(1),
    ),
  ]) {
    testWidgets('${gradient.runtimeType} retains its supplied appearance by default', (tester) async {
      await _expectOriginalGradient(
        tester,
        ResponsiveNavigationBar(
          navigationBarButtons: const [NavigationBarButton()],
          onTabChange: (_) {},
          backgroundGradient: gradient,
        ),
      );
    });

    for (final opacity in [0.0, 0.4, 1.0]) {
      testWidgets('${gradient.runtimeType} retains its supplied appearance at backgroundOpacity $opacity', (
        tester,
      ) async {
        await _expectOriginalGradient(
          tester,
          ResponsiveNavigationBar(
            navigationBarButtons: const [NavigationBarButton()],
            onTabChange: (_) {},
            backgroundGradient: gradient,
            backgroundOpacity: opacity,
          ),
        );
      });
    }
  }

  testWidgets('repeated button instances retain their list positions', (tester) async {
    const button = NavigationBarButton(icon: Icons.home);
    final taps = <int>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          bottomNavigationBar: ResponsiveNavigationBar(
            navigationBarButtons: const [button, button, button],
            onTabChange: taps.add,
            showActiveButtonText: false,
            buttonSpacing: 8,
          ),
        ),
      ),
    );
    final buttons = find.descendant(of: find.byType(ResponsiveNavigationBar), matching: find.byType(GestureDetector));
    for (var index = 0; index < 3; index++) {
      await tester.tap(buttons.at(index));
    }
    expect(taps, [0, 1, 2]);
    final gaps = tester.widgetList<SizedBox>(
      find.descendant(of: find.byType(ResponsiveNavigationBar), matching: find.byType(SizedBox)),
    );
    expect(gaps.where((box) => box.width == 8), hasLength(2));
  });

  for (final opacity in [0.0, 0.4, 0.5, 1.0]) {
    testWidgets('backgroundOpacity $opacity still sets solid-background alpha', (tester) async {
      const color = Color(0x99ff0000);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ResponsiveNavigationBar(
              navigationBarButtons: const [NavigationBarButton()],
              onTabChange: (_) {},
              backgroundColor: color,
              backgroundOpacity: opacity,
            ),
          ),
        ),
      );
      final decoration = _barDecoration(tester);
      expect(decoration.gradient, isNull);
      expect(decoration.color, color.withValues(alpha: opacity));
    });
  }
}

Future<void> _expectOriginalGradient(WidgetTester tester, ResponsiveNavigationBar bar) async {
  await tester.pumpWidget(MaterialApp(home: Scaffold(bottomNavigationBar: bar)));
  final decoration = _barDecoration(tester);

  // Published 6.2.1 passes the supplied gradient through without changing it
  expect(decoration.gradient, same(bar.backgroundGradient));
  expect(decoration.color, isNull);
}

BoxDecoration _barDecoration(WidgetTester tester) {
  return tester
          .widget<DecoratedBox>(
            find.descendant(of: find.byType(ResponsiveNavigationBar), matching: find.byType(DecoratedBox)).first,
          )
          .decoration
      as BoxDecoration;
}
