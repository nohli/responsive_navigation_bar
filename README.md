## Getting Started

https://pub.dev/packages/responsive_navigation_bar/install

https://pub.dev/packages/responsive_navigation_bar/example

## Features

* Very easy to set up, beginner friendly
* Everything is documented + you will be asked to add required values - the rest is optional (no surprising null exceptions)
* By default, fontSize, icon size and padding are responsive (change size with screen size)
* Optional: Beautiful gradient for navigation bar and/or buttons (or solid colors)
* Optional: Change the opacity of the menu bar
* Optional: Blurred background from the top of the navigation bar to the bottom of the screen
* By default shows text on selected button (and resizes all buttons), this can simply be disabled via: showActiveButtonText = false
* Only StatelessWidgets
* Compatible with Flutter for iOS, Android, Web and macOS
* How to make the `BottomBar` float above the body:
```
Scaffold(
  extendBody: true,
  body: // <- SafeArea(bottom: false, ...)
  bottomNavigationBar: ...
  ...
)
```

* Colors in the example GIFs below:
```
// backgroundColor:
    MediaQuery.of(context).platformBrightness == Brightness.dark
        ? const Color(0xff3c3c3c)
        : const Color(0xffbebebe);
```
```
// inactiveIconColor
MediaQuery.of(context).platformBrightness == Brightness.dark
        ? const Color(0xffaaaaaa)
        : const Color(0xff969696);
```


## NavigationBar in Action

![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/example/assets/darkmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/example/assets/darkmode-without-text.gif)
\
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/example/assets/lightmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/example/assets/lightmode-without-text.gif)

## Todo

* Add feature requests
* Merge your pull requests
* Add Linux and Windows support