#import "Basispaysdkv2Plugin.h"
#if __has_include(<basispaysdkv2/basispaysdkv2-Swift.h>)
#import <basispaysdkv2/basispaysdkv2-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "basispaysdkv2-Swift.h"
#endif

@implementation Basispaysdkv2Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBasispaysdkv2Plugin registerWithRegistrar:registrar];
}
@end
