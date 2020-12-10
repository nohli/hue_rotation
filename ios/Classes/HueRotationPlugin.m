#import "HueRotationPlugin.h"
#if __has_include(<hue_rotation/hue_rotation-Swift.h>)
#import <hue_rotation/hue_rotation-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "hue_rotation-Swift.h"
#endif

@implementation HueRotationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftHueRotationPlugin registerWithRegistrar:registrar];
}
@end
