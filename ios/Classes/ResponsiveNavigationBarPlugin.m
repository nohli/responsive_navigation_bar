#import "ResponsiveNavigationBarPlugin.h"
#if __has_include(<responsive_navigation_bar/responsive_navigation_bar-Swift.h>)
#import <responsive_navigation_bar/responsive_navigation_bar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "responsive_navigation_bar-Swift.h"
#endif

@implementation ResponsiveNavigationBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftResponsiveNavigationBarPlugin registerWithRegistrar:registrar];
}
@end
