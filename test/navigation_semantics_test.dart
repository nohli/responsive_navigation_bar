import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() {
  testWidgets('icon-only tabs expose labels, actions, and selected state', (tester) async {
    final semantics = tester.ensureSemantics();
    try {
      var selectedIndex = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              return Scaffold(
                bottomNavigationBar: ResponsiveNavigationBar(
                  selectedIndex: selectedIndex,
                  onTabChange: (index) => setState(() => selectedIndex = index),
                  showActiveButtonText: false,
                  navigationBarButtons: const [
                    NavigationBarButton(text: 'Home', icon: Icons.home),
                    NavigationBarButton(text: 'Settings', icon: Icons.settings),
                  ],
                ),
              );
            },
          ),
        ),
      );
      final inactive = tester.getSemantics(find.byIcon(Icons.settings)).getSemanticsData();
      expect(inactive.label, 'Settings');
      // ignore: deprecated_member_use
      expect(inactive.hasFlag(ui.SemanticsFlag.isButton), isTrue);
      // ignore: deprecated_member_use
      expect(inactive.hasFlag(ui.SemanticsFlag.isSelected), isFalse);
      expect(inactive.hasAction(ui.SemanticsAction.tap), isTrue);
      await tester.tap(find.byIcon(Icons.settings));
      await tester.pumpAndSettle();
      final active = tester.getSemantics(find.byIcon(Icons.settings)).getSemanticsData();
      expect(active.label, 'Settings');
      // ignore: deprecated_member_use
      expect(active.hasFlag(ui.SemanticsFlag.isSelected), isTrue);
      expect(active.hasAction(ui.SemanticsAction.tap), isTrue);
    } finally {
      semantics.dispose();
    }
  });
}
