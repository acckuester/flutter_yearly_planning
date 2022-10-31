#import "YearlyPlanningPlugin.h"
#if __has_include(<yearly_planning/yearly_planning-Swift.h>)
#import <yearly_planning/yearly_planning-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "yearly_planning-Swift.h"
#endif

@implementation YearlyPlanningPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftYearlyPlanningPlugin registerWithRegistrar:registrar];
}
@end
