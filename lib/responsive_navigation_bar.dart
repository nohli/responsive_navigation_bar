import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///
class ResponsiveNavigationBar extends StatelessWidget {
  /// Put this in [Scaffold]'s [bottomNavigationBar]
  const ResponsiveNavigationBar({
    required this.navigationBarButtons,
    required this.onTabChange,
    this.backgroundColor,
    this.backgroundGradient,
    this.backgroundOpacity = 0.5,
    this.backgroundBlur = 2.5,
    this.borderRadius = 80,
    this.padding = const EdgeInsets.all(6),
    this.outerPadding = const EdgeInsets.fromLTRB(8, 0, 8, 5),
    this.selectedIndex = 0,
    this.fontSize,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.activeIconColor = Colors.white,
    this.inactiveIconColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 250),
    this.showActiveButtonText = true,
    this.activeButtonFlexFactor = 160,
    this.inactiveButtonsFlexFactor = 60,
    this.debugPaint = false,
    Key? key,
  }) : super(key: key);

  /// List of buttons.
  ///
  /// [ NavigationBarButton(...), NavigationBarButton(...), ... ]
  final List<NavigationBarButton> navigationBarButtons;

  /// Function to call when onTap of button is triggered.
  ///
  /// The tab and button will NOT update unless you manage the state and update
  /// [selectedIndex] with the parameter of this function:
  ///
  /// ```
  ///  onTabChange: (int index) {
  ///    selectedIndex = index;
  ///    ... ;
  ///  },
  /// ```
  final void Function(int) onTabChange;

  /// Color of the whole bar.
  ///
  /// Gets overridden by [backgroundGradient]!
  final Color? backgroundColor;

  /// Color(s) of the whole bar.
  ///
  /// Overrides [backgroundColor]!
  final Gradient? backgroundGradient;

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

  /// Blur factor, from the [ResponsiveNavigationBar]'s top
  /// to the bottom of the screen.
  ///
  /// Defaults to 2.5
  final double backgroundBlur;

  /// BorderRadius of all elements
  final double borderRadius;

  /// Padding of the bar inside [backgroundColor]
  final EdgeInsetsGeometry padding;

  /// Padding of the bar outside [backgroundColor]
  final EdgeInsetsGeometry outerPadding;

  /// The selected tab.
  /// Pass your int value here.
  final int selectedIndex;

  /// Size of text and icons.
  ///
  /// The textScaleFactor is 1, so the text will NOT be scaled dynamically
  /// with the user's device settings.
  ///
  /// That means, you can use the largest fontSize that does not overflow.
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
  /// If you specify your own [fontSize], it will NOT be responsive any more
  /// - unless you pass something like above.
  final double? fontSize;

  /// TextStyle for all buttons.
  ///
  /// The [TextStyle]'s [fontSize] value is always overridden by [fontSize].
  final TextStyle textStyle;

  /// Icon color of the selected button.
  final Color activeIconColor;

  /// Icon color of unselected buttons.
  final Color inactiveIconColor;

  /// Duration of the animation when switching tabs.
  final Duration animationDuration;

  /// This overrides [activeButtonFlexFactor] and [inactiveButtonsFlexFactor]
  /// and sets each to 1 - so that active and inactive buttons
  /// have the same size.
  ///
  /// Also, this overrides individual [text] parameters of
  /// [NavigationBarButton]s (since the [text] will not be shown).
  final bool showActiveButtonText;

  /// Flex factor.
  ///
  /// Only set this combined with [inactiveButtonsFlexFactor]!
  ///
  /// By default, it is 160 : 60.
  ///
  /// (this is a great package, so the flex is naturally pretty high)
  ///
  /// Play around with these values, so that the text of all buttons and all
  /// icons are visible and there is no overflow - ideally on all screen sizes.
  final int activeButtonFlexFactor;

  /// Flex factor.
  ///
  /// Only set this combined with [activeButtonFlexFactor]!
  ///
  /// By default, it is 160 : 60.
  ///
  /// (this is a great package, so the flex is naturally pretty high)
  ///
  /// Play around with these values, so that the text of all buttons and all
  /// icons are visible and there is no overflow - ideally on all screen sizes.
  final int inactiveButtonsFlexFactor;

  /// This only affects debug builds.
  ///
  /// Paints green/red background color for each button.
  final bool debugPaint;

  @override
  Widget build(BuildContext context) {
    // [points] from:
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    final deviceWidth = MediaQuery.of(context).size.width;
    final buttonFontSize = fontSize ??
        (deviceWidth >= 650
            ? 33
            : deviceWidth >= 375
                ? 20
                : 18);

    final buttons = <Widget>[];
    for (final button in navigationBarButtons) {
      final index = navigationBarButtons.indexOf(button);
      buttons.add(
        _Button(
          index: index,
          active: selectedIndex == index,
          text: button.text,
          textColor: button.textColor ?? textStyle.color,
          textStyle: textStyle.copyWith(
              color: button.textColor, fontSize: buttonFontSize),
          icon: button.icon,
          iconSize: buttonFontSize,
          activeIconColor: activeIconColor,
          inactiveIconColor: inactiveIconColor,
          animationDuration: animationDuration,
          borderRadius: borderRadius,
          padding: button.padding ??
              (deviceWidth >= 650
                  ? const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 8, vertical: 10)),
          backgroundColor: button.backgroundColor,
          backgroundGradient: button.backgroundGradient,
          activeFlexFactor: showActiveButtonText ? activeButtonFlexFactor : 1,
          inactiveFlexFactor:
              showActiveButtonText ? inactiveButtonsFlexFactor : 1,
          showActiveButtonText: showActiveButtonText,
          debugPaint: debugPaint,
          onTap: () => onTabChange(index),
        ),
      );
    }

    return ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: backgroundBlur,
            sigmaY: backgroundBlur,
          ),
          child: SafeArea(
            child: Padding(
              padding: outerPadding,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: backgroundGradient == null
                      ? (backgroundColor ?? const Color(0x7d8c8c8c))
                          .withOpacity(backgroundOpacity)
                      : null,
                  gradient: backgroundGradient,
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                ),
                child: Padding(
                  padding: padding,
                  child: Row(children: buttons),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///
class NavigationBarButton {
  /// Put this in [ResponsiveNavigationBar]'s [navigationBarButtons]
  ///
  /// [ NavigationBarButton(...), NavigationBarButton(...), ... ]
  const NavigationBarButton({
    this.text = '',
    this.icon = Icons.hourglass_empty,
    this.padding,
    this.backgroundColor = Colors.grey,
    this.backgroundGradient,
    this.textColor,
  });

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
  ///    : const EdgeInsets.symmetric(horizontal: 8, vertical: 10)
  /// ```
  ///
  /// If you specify your own [padding], it will NOT be responsive any more
  /// - unless you pass something like above.
  final EdgeInsetsGeometry? padding;

  /// Color of the button.
  ///
  /// Gets overridden by [backgroundGradient]!
  final Color backgroundColor;

  /// Color(s) of the button.
  ///
  /// Overrides [backgroundColor]!
  final Gradient? backgroundGradient;

  /// Color of the text.
  ///
  /// If null, the button uses the color of the
  /// [ResponsiveNavigationBar]'s [textStyle].
  final Color? textColor;
}

class _Button extends StatelessWidget {
  const _Button({
    required this.index,
    required this.active,
    required this.text,
    required this.textColor,
    required this.textStyle,
    required this.icon,
    required this.iconSize,
    required this.activeIconColor,
    required this.inactiveIconColor,
    required this.animationDuration,
    required this.borderRadius,
    required this.padding,
    required this.backgroundColor,
    required this.backgroundGradient,
    required this.activeFlexFactor,
    required this.inactiveFlexFactor,
    required this.showActiveButtonText,
    required this.debugPaint,
    required this.onTap,
  });

  final int index;
  final bool active;
  final String text;
  final Color? textColor;
  final TextStyle textStyle;
  final IconData icon;
  final double iconSize;
  final Color activeIconColor;
  final Color inactiveIconColor;
  final Duration animationDuration;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final int activeFlexFactor;
  final int inactiveFlexFactor;
  final bool showActiveButtonText;
  final bool debugPaint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showText = active && showActiveButtonText && text != '';

    return TweenAnimationBuilder<int>(
      duration: animationDuration,
      tween: IntTween(
        end: active ? activeFlexFactor : inactiveFlexFactor,
      ),
      builder: (context, flex, child) {
        return Flexible(
          flex: flex,
          child: child!,
        );
      },
      child: ColoredBox(
        color: kDebugMode && debugPaint
            ? index.remainder(2) == 0
                ? Colors.green.withOpacity(0.3)
                : Colors.red.withOpacity(0.3)
            : Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: TweenAnimationBuilder<Color?>(
            duration: animationDuration,
            tween: ColorTween(
              end: active ? backgroundColor : Colors.transparent,
            ),
            builder: (context, color, _) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(borderRadius),
                  ),
                  gradient: backgroundGradient,
                  color: color,
                ),
                child: Padding(
                  padding: padding,
                  child: SizedBox(
                    height: 29,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: TweenAnimationBuilder<Color?>(
                          duration: animationDuration,
                          tween: ColorTween(
                            end: active ? activeIconColor : inactiveIconColor,
                          ),
                          builder: (context, color, _) {
                            return Icon(
                              icon,
                              size: iconSize,
                              color: color,
                            );
                          },
                        ),
                      ),
                      if (showText) ...[
                        const SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            text,
                            style: textStyle,
                            textScaleFactor: 1,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(),
                      ],
                    ],
                  ),
                ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
