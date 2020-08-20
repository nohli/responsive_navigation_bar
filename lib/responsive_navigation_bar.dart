import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  /// List of buttons.
  ///
  /// [ NavigationBarButton(...), NavigationBarButton(...), ... ]
  final List<NavigationBarButton> navigationBarButtons;

  /// Function to call when onTap of button is triggered.
  ///
  /// The tab and button will NOT update unless you manage the state and update [selectedIndex] with the parameter of this function:
  ///
  /// ```
  ///  onTabChange: (int index) {
  ///    selectedIndex = index;
  ///    ... ;
  ///  },
  /// ```
  final Function onTabChange;

  /// Experimental - set this to true if you do not use the NavigationBar as [bottomNavigationBar] in your Scaffold,
  /// but for example in the [body] in a Stack.
  final bool floating;

  /// Color of the whole bar.
  ///
  /// Gets overridden by [backgroundGradient]!
  final Color backgroundColor;

  /// Color(s) of the whole bar.
  ///
  /// Overrides [backgroundColor]!
  final Gradient backgroundGradient;

  /// Opacity of [backgroundColor]/[backGroundGradient].
  ///
  /// ```
  /// 0 = invisible
  /// ```
  ///
  /// ```
  /// 1 = fully visible
  /// ```
  final double backgroundOpacity;

  /// Padding of the bar inside [backgroundColor]
  final EdgeInsetsGeometry padding;

  /// Padding of the bar outside [backgroundColor]
  final EdgeInsetsGeometry outerPadding;

  /// The selected tab.
  /// Pass your int value here.
  final int selectedIndex;

  /// Size of text and icons.
  ///
  /// If null, defaults to:
  ///
  /// ```
  ///  MediaQuery.of(context).size.width >= 650
  ///    ? 33
  ///    : MediaQuery.of(context).size.width >= 375
  ///      ? 20
  ///      : 18
  /// ```
  ///
  /// If you specify your own [fontSize], it will NOT be responsive any more - unless you pass something like above.
  final double fontSize;

  /// TextStyle for all buttons.
  ///
  /// The [TextStyle]'s [fontSize] value is always overridden by [fontSize].
  ///
  /// The textScaleFactor is 1, so the text will NOT be scaled dynamically with the user's device settings.
  ///
  /// That means, you can use the largest fontSize that does not overflow.
  final TextStyle textStyle;

  /// Icon color of the selected button.
  final Color activeIconColor;

  /// Icon colors of unselected buttons.
  final Color inactiveIconColor;

  /// Flex factor.
  ///
  /// Only set this combined with [inactiveButtonsFlexFactor]!
  ///
  /// By default, it is 160 : 60.
  ///
  /// (this is a great package, so the flex is naturally pretty high)
  ///
  /// Play around with these values, so that the text of all buttons and all icons are visible and there is no overflow - ideally on all screen sizes.
  final int activeButtonFlexFactor;

  /// Flex factor.
  ///
  /// Only set this combined with [activeButtonFlexFactor]!
  ///
  /// By default, it is 160 : 60.
  ///
  /// (this is a great package, so the flex is naturally pretty high)
  ///
  /// Play around with these values, so that the text of all buttons and all icons are visible and there is no overflow - ideally on all screen sizes.
  final int inactiveButtonsFlexFactor;

  /// This only affects debug builds.
  ///
  /// Paints green/red background color for each button.
  final bool debugPaint;

  const NavigationBar(
      {@required this.navigationBarButtons,
      @required this.onTabChange,
      this.floating = false,
      this.backgroundColor,
      this.backgroundGradient,
      this.backgroundOpacity = 0.5,
      this.padding = const EdgeInsets.all(6),
      this.outerPadding = const EdgeInsets.fromLTRB(8, 0, 8, 5),
      this.selectedIndex = 0,
      this.fontSize,
      this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
      this.activeIconColor = Colors.white,
      this.inactiveIconColor = Colors.white,
      this.activeButtonFlexFactor = 160,
      this.inactiveButtonsFlexFactor = 60,
      this.debugPaint = false});

  @override
  Widget build(BuildContext context) {
    // [points] from:
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    final double deviceWidth = MediaQuery.of(context).size.width ?? 320;
    final double buttonFontSize =
        fontSize ?? (deviceWidth >= 650 ? 33 : deviceWidth >= 375 ? 20 : 18);

    final List<Widget> buttons = <Widget>[];
    for (final NavigationBarButton button in navigationBarButtons) {
      final index = navigationBarButtons.indexOf(button);
      buttons.add(
        Button(
          index: index,
          active: selectedIndex == index,
          text: button.text,
          textColor: button.textColor ?? textStyle.color,
          textStyle: textStyle.copyWith(fontSize: buttonFontSize),
          icon: button.icon,
          iconSize: buttonFontSize ?? textStyle.fontSize,
          activeIconColor: activeIconColor,
          inactiveIconColor: inactiveIconColor,
          padding: button.padding ??
              (deviceWidth >= 650
                  ? const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 8, vertical: 5)),
          backgroundColor: button.backgroundColor,
          backgroundGradient: button.backgroundGradient,
          activeFlexFactor: activeButtonFlexFactor,
          inactiveFlexFactor: inactiveButtonsFlexFactor,
          debugPaint: debugPaint,
          onTap: () => onTabChange(index),
        ),
      );
    }

    final Widget child = Padding(
        padding: outerPadding,
        child: Container(
            decoration: BoxDecoration(
              color: (backgroundGradient != null
                      ? Colors.white
                      : backgroundColor ?? const Color(0x7d8c8c8c))
                  .withOpacity(backgroundOpacity),
              gradient: backgroundGradient,
              borderRadius: const BorderRadius.all(Radius.circular(80)),
            ),
            padding: padding,
            child: Row(children: buttons)));

    return SafeArea(
      child: floating
          ? Align(alignment: Alignment.bottomCenter, child: child)
          : child,
    );
  }
}

class NavigationBarButton {
  /// Text of the button (if active).
  final String text;

  /// Icon of the button.
  final IconData icon;

  /// Padding of the button.
  ///
  /// If null, defaults to:
  ///
  /// ```
  ///  MediaQuery.of(context).size.width >= 650
  ///    ? const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
  ///    : const EdgeInsets.symmetric(horizontal: 8, vertical: 5)
  /// ```
  ///
  /// If you specify your own [padding], it will NOT be responsive any more - unless you pass something like above.
  final EdgeInsetsGeometry padding;

  /// Color of the button.
  ///
  /// Gets overridden by [backgroundGradient]!
  final Color backgroundColor;

  /// Color(s) of the button.
  ///
  /// Overrides [backgroundColor]!
  final Gradient backgroundGradient;

  /// Color of the text.
  ///
  /// If null, the button uses the color of the [NavigationBar]'s [textStyle].
  final Color textColor;

  const NavigationBarButton(
      {@required this.text,
      this.icon = Icons.hourglass_empty,
      this.padding = const EdgeInsets.all(8),
      this.backgroundColor = Colors.transparent,
      this.backgroundGradient,
      this.textColor});
}

class Button extends StatelessWidget {
  final int index;
  final bool active;
  final String text;
  final Color textColor;
  final TextStyle textStyle;
  final IconData icon;
  final double iconSize;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Gradient backgroundGradient;
  final int activeFlexFactor;
  final int inactiveFlexFactor;
  final bool debugPaint;
  final Function onTap;

  const Button(
      {this.index,
      this.active,
      this.text,
      this.textColor,
      this.textStyle,
      this.icon,
      this.iconSize,
      this.activeIconColor,
      this.inactiveIconColor,
      this.padding,
      this.backgroundColor,
      this.backgroundGradient,
      this.activeFlexFactor,
      this.inactiveFlexFactor,
      this.debugPaint,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: active ? activeFlexFactor : inactiveFlexFactor,
      child: Container(
        color: kDebugMode && debugPaint
            ? index.remainder(2) == 0
                ? Colors.green.withOpacity(0.3)
                : Colors.red.withOpacity(0.3)
            : Colors.transparent,
        child: GestureDetector(
          onTap: () => onTap(),
          child: Container(
            decoration: BoxDecoration(
                gradient: backgroundGradient,
                color: active
                    ? backgroundGradient != null
                        ? Colors.white
                        : backgroundColor
                    : Colors.transparent,
                borderRadius: const BorderRadius.all(Radius.circular(80))),
            child: Padding(
              padding: padding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                      child: Icon(icon,
                          size: iconSize,
                          color: active ? activeIconColor : inactiveIconColor)),
                  if (active) const Padding(padding: EdgeInsets.only(left: 5)),
                  if (active) Text(text, style: textStyle, textScaleFactor: 1),
                  if (active) const Padding(padding: EdgeInsets.zero),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
