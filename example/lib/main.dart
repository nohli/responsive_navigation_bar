import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() => runApp(const MyApp());

///
class MyApp extends StatefulWidget {
  ///
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // extendBody: true,
        bottomNavigationBar: ResponsiveNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: changeTab,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          // showActiveButtonText: false,
          // showInactiveButtonText: true, // Show text on inactive buttons
          // borderRadius: 20,
          // buttonBorderRadius: 15,
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          navigationBarButtons: <NavigationBarButton>[
            NavigationBarButton(
              text: 'Tab 1',
              icon: Icons.people,
              backgroundGradient: const LinearGradient(
                colors: [Colors.yellow, Colors.green, Colors.blue],
              ),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            NavigationBarButton(
              text: 'Tab 2',
              icon: Icons.star,
              backgroundGradient: const LinearGradient(
                colors: [Colors.cyan, Colors.teal],
              ),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
            NavigationBarButton(
              text: 'Tab 3',
              icon: Icons.settings,
              backgroundGradient: const LinearGradient(
                colors: [Colors.green, Colors.yellow],
              ),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
