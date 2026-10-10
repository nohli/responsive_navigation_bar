import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A responsive navigation bar with caller-managed selection.
class ResponsiveNavigationBar extends StatelessWidget {
  /// Use this as [Scaffold.bottomNavigationBar].
  const ResponsiveNavigationBar({
    required this.navigationBarButtons,
    required this.onTabChange,
    this.backgroundColor,
    this.backgroundGradient,
    this.backgroundOpacity = 0.5,
    this.backgroundBlur = 2.5,
    this.borderRadius = 80,
    this.buttonBorderRadius,
    this.border,
    this.padding = const EdgeInsets.all(6),
    this.outerPadding = const EdgeInsets.fromLTRB(8, 0, 8, 5),
    this.buttonSpacing = 0,
    this.selectedIndex = 0,
    this.fontSize,
    this.iconSize,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold),
    this.activeIconColor = Colors.white,
    this.inactiveIconColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 220),
    this.showActiveButtonText = true,
    this.showInactiveButtonText = false,
    this.activeButtonFlexFactor = 160,
    this.inactiveButtonsFlexFactor = 60,
    this.debugPaint = false,
    super.key,
  });

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

  /// Color of the whole bar, with opacity [backgroundOpacity].
  ///
  /// Gets overridden by [backgroundGradient]!
  final Color? backgroundColor;

  /// Color(s) of the whole bar.
  ///
  /// Overrides [backgroundColor]!
  final Gradient? backgroundGradient;

  /// Alpha of [backgroundColor], or a multiplier for [backgroundGradient] colors.
  ///
  /// ```
  /// 0 = invisible
  /// ```
  ///
  /// ```
  /// 1 = opaque solid background, or the gradient's original opacity
  /// ```
  final double backgroundOpacity;

  /// Blur factor, from the [ResponsiveNavigationBar]'s top
  /// to the bottom of the screen.
  ///
  /// Defaults to 2.5
  final double backgroundBlur;

  /// BorderRadius of the navigation bar container
  final double borderRadius;

  /// BorderRadius of navigation bar buttons
  ///
  /// If null, defaults to [borderRadius] for backward compatibility
  final double? buttonBorderRadius;

  /// Border of the navigation bar.
  ///
  /// Example: `Border.all(color: Colors.white, width: 2)`
  ///
  /// Also supports gradient borders via third-party packages.
  final BoxBorder? border;

  /// Padding of the bar inside [backgroundColor]
  final EdgeInsetsGeometry padding;

  /// Padding of the bar outside [backgroundColor]
  final EdgeInsetsGeometry outerPadding;

  /// Spacing between navigation buttons.
  ///
  /// Defaults to 0 (no spacing).
  final double buttonSpacing;

  /// The selected tab.
  /// Pass your int value here.
  final int selectedIndex;

  /// Size of text.
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

  /// Size of icons.
  ///
  /// If null, defaults to [fontSize] value for backward compatibility.
  ///
  /// This allows you to set icon size independently from text size.
  final double? iconSize;

  /// TextStyle for all buttons.
  ///
  /// The [TextStyle]'s [fontSize] value is always overridden by [fontSize].
  final TextStyle textStyle;

  /// Icon color of the selected button.
  final Color activeIconColor;

  /// Icon color of unselected buttons.
  final Color inactiveIconColor;

  /// Duration of the transition animations when switching tabs.
  ///
  /// Use [Duration.zero] to disable animations.
  final Duration animationDuration;

  /// Whether to show text on the selected button.
  ///
  /// When both this and [showInactiveButtonText] are false, all buttons use
  /// equal flex, overriding [activeButtonFlexFactor] and [inactiveButtonsFlexFactor].
  final bool showActiveButtonText;

  /// Whether to show text on inactive buttons.
  ///
  /// When true, text will be displayed on all inactive buttons.
  /// This works independently from [showActiveButtonText].
  final bool showInactiveButtonText;

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

  static Gradient _scaleGradient(Gradient gradient, double opacity) {
    final scaled = gradient.scale(opacity);
    // Flutter 3.29 drops transforms in built-in Gradient.scale implementations.
    if (scaled is LinearGradient && gradient is LinearGradient) {
      return LinearGradient(
        begin: scaled.begin,
        end: scaled.end,
        colors: scaled.colors,
        stops: scaled.stops,
        tileMode: scaled.tileMode,
        transform: gradient.transform,
      );
    }
    if (scaled is RadialGradient && gradient is RadialGradient) {
      return RadialGradient(
        center: scaled.center,
        radius: scaled.radius,
        focal: scaled.focal,
        focalRadius: scaled.focalRadius,
        colors: scaled.colors,
        stops: scaled.stops,
        tileMode: scaled.tileMode,
        transform: gradient.transform,
      );
    }
    if (scaled is SweepGradient && gradient is SweepGradient) {
      return SweepGradient(
        center: scaled.center,
        startAngle: scaled.startAngle,
        endAngle: scaled.endAngle,
        colors: scaled.colors,
        stops: scaled.stops,
        tileMode: scaled.tileMode,
        transform: gradient.transform,
      );
    }
    return scaled;
  }

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
    final buttonIconSize = iconSize ?? buttonFontSize;

    final buttons = <Widget>[];
    for (var index = 0; index < navigationBarButtons.length; index++) {
      final button = navigationBarButtons[index];

      // Add spacing before button (except for the first one)
      if (index > 0 && buttonSpacing > 0) {
        buttons.add(SizedBox(width: buttonSpacing));
      }

      buttons.add(
        _Button(
          index: index,
          active: selectedIndex == index,
          text: button.text,
          textColor: button.textColor ?? textStyle.color,
          textStyle: textStyle.copyWith(color: button.textColor, fontSize: buttonFontSize),
          icon: button.icon,
          iconSize: buttonIconSize,
          activeIconColor: activeIconColor,
          inactiveIconColor: inactiveIconColor,
          animationDuration: animationDuration,
          borderRadius: buttonBorderRadius ?? borderRadius,
          border: button.border,
          padding: button.padding ??
              (deviceWidth >= 650
                  ? const EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                  : const EdgeInsets.symmetric(horizontal: 8, vertical: 10)),
          backgroundColor: button.backgroundColor,
          backgroundGradient: button.backgroundGradient,
          activeFlexFactor: (showActiveButtonText || showInactiveButtonText) ? activeButtonFlexFactor : 1,
          inactiveFlexFactor: (showActiveButtonText || showInactiveButtonText) ? inactiveButtonsFlexFactor : 1,
          showActiveButtonText: showActiveButtonText,
          showInactiveButtonText: showInactiveButtonText,
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
                      ? (backgroundColor ?? const Color(0x7d8c8c8c)).withValues(alpha: backgroundOpacity)
                      : null,
                  gradient: backgroundGradient == null ? null : _scaleGradient(backgroundGradient!, backgroundOpacity),
                  border: border,
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

/// Appearance and content of a navigation button.
class NavigationBarButton {
  /// Add this to [ResponsiveNavigationBar.navigationBarButtons].
  ///
  /// [ NavigationBarButton(...), NavigationBarButton(...), ... ]
  const NavigationBarButton({
    this.text = '',
    this.icon = Icons.hourglass_empty,
    this.padding,
    this.backgroundColor = Colors.grey,
    this.backgroundGradient,
    this.border,
    this.textColor,
  });

  /// Text shown according to the bar's visibility settings.
  /// Also provides its screen-reader label, even when the text is hidden.
  final String text;

  /// Icon of the button.
  final IconData icon;

  /// Inner padding of the button (padding inside the button's background).
  ///
  /// This controls the space between the button's content (icon and text)
  /// and the button's edges.
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

  /// Border of the button.
  ///
  /// Example: `Border.all(color: Colors.white, width: 2)`
  ///
  /// Also supports gradient borders via third-party packages.
  final BoxBorder? border;

  /// Color of the text.
  ///
  /// If null, the button uses the color of the
  /// [ResponsiveNavigationBar.textStyle].
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
    required this.border,
    required this.padding,
    required this.backgroundColor,
    required this.backgroundGradient,
    required this.activeFlexFactor,
    required this.inactiveFlexFactor,
    required this.showActiveButtonText,
    required this.showInactiveButtonText,
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
  final BoxBorder? border;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Gradient? backgroundGradient;
  final int activeFlexFactor;
  final int inactiveFlexFactor;
  final bool showActiveButtonText;
  final bool showInactiveButtonText;
  final bool debugPaint;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final showText = ((active && showActiveButtonText) || (!active && showInactiveButtonText)) && text != '';

    // To align the button-height of non-text buttons
    // Use the larger of text height or icon size to ensure proper vertical
    // centering
    final textHeight = (textStyle.fontSize ?? 14) * 1.44;
    final buttonHeight = textHeight > iconSize ? textHeight : iconSize;

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
      child: Semantics(
        container: true,
        button: true,
        selected: active,
        label: text,
        onTap: onTap,
        excludeSemantics: true,
        child: ColoredBox(
          color: kDebugMode && debugPaint
              ? index.remainder(2) == 0
                  ? Colors.green.withValues(alpha: 0.3)
                  : Colors.red.withValues(alpha: 0.3)
              : Colors.transparent,
          child: GestureDetector(
            onTap: onTap,
            excludeFromSemantics: true,
            child: TweenAnimationBuilder<Color?>(
              duration: animationDuration,
              tween: ColorTween(
                end: active ? backgroundColor : Colors.transparent,
              ),
              builder: (context, color, child) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                    gradient: backgroundGradient,
                    color: color,
                    border: border,
                  ),
                  child: child!,
                );
              },
              child: Padding(
                padding: padding,
                child: SizedBox(
                  height: buttonHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (showText) const SizedBox(width: 5),
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
                        Expanded(
                          flex: 6,
                          child: Text(
                            text,
                            style: textStyle,
                            textAlign: TextAlign.center,
                            textScaler: TextScaler.noScaling,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
