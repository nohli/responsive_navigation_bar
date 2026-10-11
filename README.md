# responsive_navigation_bar

Requires Flutter 3.41 or newer. Provide button `text` for screen-reader labels, including icon-only layouts. Selection is controlled by your app: update `selectedIndex` inside `setState` when `onTabChange` fires.

```dart
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

// In your State's build method, with `int selectedIndex = 0` as a field:
return Scaffold(
  body: Center(child: Text('Tab $selectedIndex')),
  bottomNavigationBar: ResponsiveNavigationBar(
    selectedIndex: selectedIndex,
    onTabChange: (index) => setState(() => selectedIndex = index),
    navigationBarButtons: const [
      NavigationBarButton(text: 'Home', icon: Icons.home),
      NavigationBarButton(text: 'Settings', icon: Icons.settings),
    ],
  ),
);
```

## Getting Started

[Installation](https://pub.dev/packages/responsive_navigation_bar/install)

Upgrading to 7.0.0: update Flutter to 3.41 or newer. The widget API is unchanged;
applications using older Flutter can continue with 6.2.1. The checked-in native
example requires Flutter 3.47 or newer.

[Example Code](https://pub.dev/packages/responsive_navigation_bar/example)

## Features

* Very easy to set up, beginner friendly
* Everything is documented + you will be asked to add required values - the rest is optional (with sound null safety)
* By default, text size, icon size and button padding are responsive (change size with screen size)
* Set `iconSize` to control icon size independently (defaults to `fontSize` if not specified)
* Optional: Beautiful gradient (`backgroundGradient`) for navigation bar and/or buttons (or solid colors)
* Optional: Colored borders (`border`) for navigation bar and/or buttons
* Optional: Change the opacity (`backgroundOpacity`) of the bar's solid background or gradient
* Optional: Blurred background (`backgroundBlur`) from the top of the navigation bar to the bottom of the screen
* Optional: Separate border radius controls (`borderRadius`, `buttonBorderRadius`)
* Optional: Control button spacing (`buttonSpacing`)
* By default shows text on selected button, optionally show on inactive buttons too (`showInactiveButtonText`)
* Only StatelessWidgets

* How to make the `bottomNavigationBar` float above the `Scaffold`'s body:
```
Scaffold(
  extendBody: true,
  body: SafeArea(bottom: false, ...),
  bottomNavigationBar: ...
  ...
)
```

* Colors in the example GIFs below:
```
backgroundColor:
    Theme.of(context).brightness == Brightness.dark
        ? const Color(0xff3c3c3c)
        : const Color(0xffbebebe),
inactiveIconColor:
    Theme.of(context).brightness == Brightness.dark
        ? const Color(0xffaaaaaa)
        : const Color(0xff969696),
```


## ResponsiveNavigationBar in Action

### With animation

![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/animation-darkmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/animation-darkmode-without-text.gif)
\
![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/animation-lightmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/animation-lightmode-without-text.gif)

### Without animation

![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/darkmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/darkmode-without-text.gif)
\
![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/lightmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/responsive_navigation_bar/main/assets/lightmode-without-text.gif)

## Todo

* Add feature requests
* Merge your pull requests
