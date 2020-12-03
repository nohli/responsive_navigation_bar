import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

void main() => runApp(MyApp());

///
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;

  void changeTab() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // extendBody: true,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onTabChange: (int index) {
            selectedIndex = index;
            changeTab();
          },
          // showActiveButtonText: false,
          textStyle:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          navigationBarButtons: <NavigationBarButton>[
            NavigationBarButton(
              text: 'Tab 1',
              icon: Icons.people,
              backgroundGradient: const LinearGradient(
                colors: <Color>[Colors.yellow, Colors.green, Colors.blue],
              ),
            ),
            NavigationBarButton(
              text: 'Tab 2',
              icon: Icons.star,
              backgroundGradient: const LinearGradient(
                colors: <Color>[Colors.cyan, Colors.teal],
              ),
            ),
            NavigationBarButton(
              text: 'Tab 3',
              icon: Icons.settings,
              backgroundGradient: const LinearGradient(
                colors: <Color>[Colors.green, Colors.yellow],
              ),
            )
          ],
        ),
      ),
    );
  }
}
