#import "UserSetting.h"

@interface UserSetting ()

// Private interface goes here.

@end

@implementation UserSetting

+ (UserSetting*) getUserSetting
{
    UserSetting *settings = [UserSetting MR_findFirst];
    if (settings == nil) {
        settings = [UserSetting MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    }
    return settings;
}

+ (void) SaveIpAddress:(NSString*) ip
{
    UserSetting *settings = [UserSetting getUserSetting];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [settings setPrinter_ip:ip];
    }];
}
+ (NSString*) getIpAddress
{
    NSString * ip=@"169.254.100.1";
    UserSetting *settings = [UserSetting getUserSetting];
    if (settings.printer_ip != nil && settings.printer_ip.length > 0) {
        ip = settings.printer_ip;
    }
    return ip;
}
+ (void) SavePrintOnOff:(BOOL)switchs
{
    UserSetting *settings = [UserSetting getUserSetting];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [settings setPrint_on_offValue:switchs];
    }];
}
+ (BOOL) getPrintOnOff
{
    BOOL switchs= true;
    UserSetting *settings = [UserSetting getUserSetting];
    switchs = settings.print_on_offValue;
    return switchs;
}

#define Air Print

+ (void) SaveAirPrintOnOff:(BOOL)switchs
{
    UserSetting *settings = [UserSetting getUserSetting];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [settings setAir_print_on_offValue:switchs];
    }];
}
+ (BOOL) getAirPrintOnOff
{
    BOOL switchs=YES;
    UserSetting *settings = [UserSetting getUserSetting];
    switchs = settings.air_print_on_offValue;
    return switchs;
}

@end
