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
  FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"plugins.flutter.io/package_info"
                                  binaryMessenger:[registrar messenger]];
  ResponsiveNavigationBarPlugin* instance = [[ResponsiveNavigationBarPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([call.method isEqualToString:@"getAll"]) {
    result(@{
      @"appName" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
          ?: [NSNull null],
      @"packageName" : [[NSBundle mainBundle] bundleIdentifier] ?: [NSNull null],
      @"version" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
          ?: [NSNull null],
      @"buildNumber" : [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
          ?: [NSNull null],
    });
  } else {
    result(FlutterMethodNotImplemented);
  }
}
@end