#import "NavigationBarPlugin.h"
#if __has_include(<navigation_bar/navigation_bar-Swift.h>)
#import <navigation_bar/navigation_bar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "navigation_bar-Swift.h"
#endif

@implementation NavigationBarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNavigationBarPlugin registerWithRegistrar:registrar];
}
@end
