## Getting Started

[Installation](https://pub.dev/packages/responsive_navigation_bar/install)

[Example Code](https://pub.dev/packages/responsive_navigation_bar/example)

## Features

* Very easy to set up, beginner friendly
* Everything is documented + you will be asked to add required values - the rest is optional (with sound null safety)
* By default, `fontSize`, `iconSize` and `padding` are responsive (change size with screen size)
* Optional: Beautiful gradient (`backgroundGradient`) for navigation bar and/or buttons (or solid colors)
* Optional: Change the opacity (`backgroundOpacity`) of the menu bar
* Optional: Blurred background (`backgroundBlur`) from the top of the navigation bar to the bottom of the screen
* By default shows text on selected button (and resizes all buttons), this can simply be disabled via: `showActiveButtonText = false`
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

![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/animation-darkmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/animation-darkmode-without-text.gif)
\
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/animation-lightmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/animation-lightmode-without-text.gif)

### Without animation

![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/darkmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/darkmode-without-text.gif)
\
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/lightmode-with-text.gif)
![Screenrecording](https://raw.githubusercontent.com/nohli/navigation_bar/master/assets/lightmode-without-text.gif)

## Todo

* Add feature requests
* Merge your pull requests
