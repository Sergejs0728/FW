#import "_UserSetting.h"

@interface UserSetting : _UserSetting {}
// Custom logic goes here.


+ (UserSetting*) getUserSetting;
+ (void) SaveIpAddress:(NSString*) ip;
+ (NSString*) getIpAddress;
+ (void) SavePrintOnOff:(BOOL)switchs;
+ (BOOL) getPrintOnOff;
+ (void) SaveAirPrintOnOff:(BOOL)switchs;
+ (BOOL) getAirPrintOnOff;

@end
