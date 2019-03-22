//
//  Utils.m
//  FWModel
//
//  Created by SamirMAC on 11/13/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getTimeString:(int)minutes {
    NSTimeInterval duration = (double)(minutes*60);
    NSInteger hours = floor(duration/(60*60));
    NSInteger mins = floor((duration/60) - hours * 60);
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)hours,(long)mins];
}

+ (int)RandomId {
    int r = arc4random_uniform(100000);
    r = r * -1;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NEED_BACKUP_NOTIFICATION" object:nil];
    
    return r;
}

+ (int)RandomIdPlus {
    int r = arc4random_uniform(100000);
    
    return r;
}

+ (NSString*) getNonmilitaryTime:(NSString*) str{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSDate *dt = [formatter dateFromString:str];
    [formatter setDateFormat:@"h:mm a"];
    return [formatter stringFromDate:dt];
}

+ (NSString*) getMilitaryTime:(NSString*) str{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    
    NSDate *dt = [formatter dateFromString:str];
    [formatter setDateFormat:@"HH:mm"];
    return [formatter stringFromDate:dt];
}

+ (NSString *) addSuffixToNumber:(int) number
{
    NSString *suffix;
    int ones = number % 10;
    int temp = floor(number/10.0);
    int tens = temp%10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    NSString *completeAsString = [NSString stringWithFormat:@"%d%@",number,suffix];
    return completeAsString;
}

+ (NSDateFormatter*)getDateFormatterWithFormatString:(NSString*)format
{
    static NSDateFormatter* formatter = nil;
    if (!formatter)
        {
        formatter = [[NSDateFormatter alloc] init];
        }
    [formatter setDateFormat:format];
    return formatter;
}


+(NSString *)dateFormatMMddyyyy:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *dateformat = [formatter stringFromDate:date];
    return dateformat;
}







+(NSString *)dateFormathhmma:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSString *timeformat = [formatter stringFromDate:date];
    return timeformat;
}

+(NSString *)getCorrectDateFormathhmmaa:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [formatter setTimeZone:timeZone];
    NSString *timeformat = [formatter stringFromDate:date];
    return timeformat;
}


//26112015
+(BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isPastDate:(NSDate *)pastdate{
    NSDate *today = [NSDate date]; // it will give you current date
    NSComparisonResult result;
    //has three possible values: NSOrderedSame,NSOrderedDescending, NSOrderedAscending
    
    result = [today compare:pastdate]; // comparing two dates
    
    if(result==NSOrderedAscending){
        return false;
    }
    else if(result==NSOrderedDescending){
        return true;
    }
    else{
        return false;
    }
}

+ (NSInteger) timezoneDifferenceInDestinationTimeZone
{
    
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:[NSDate date2]];
    return destinationGMTOffset;
}
+ (NSString *)getHeaderVersion{
    
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSString * build = [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
    NSString * iOSVersion =[UIDevice currentDevice].systemName;
    NSString * ver= [NSString stringWithFormat:@"iOS %@ %@ %@",version,build,iOSVersion];
    return ver;
    
}

+ (NSDate*)dateJSONTransformer:(NSString*)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd'T'HH:mm:ssZZZ"];
    return [dateFormatter dateFromString:dateString];
}

+ (NSDate*) dateFrom:(NSString*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSDate *dt = [formatter dateFromString:[NSString stringWithFormat:@"%@", date]];
    return dt;
    
}
+ (NSString *)getCurrencyStringFromAmount:(float)amount {
    float rounded_up_amount = ceilf(amount * 1000) / 1000;
    
    printf("*****************");
    NSLog(@"%f", rounded_up_amount);
    
    if((int)(amount*10000)%100<49){
        amount = (int)(amount*10000) - (int)(amount*10000)%100;
    }else{
        amount = (int)(amount*10000) - (int)(amount*10000)%100 + 100;
    }
    
    NSString *aamount = [NSString stringWithFormat:@"%0.2f",amount/10000];
    
    
    return aamount;
}

+ (NSString *)getCurrencyStringFromAmountString:(NSString *)amount {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    NSLocale *american = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:american];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setLenient:YES];
    [formatter setGeneratesDecimalNumbers:NO];
    NSDecimalNumber *number = (NSDecimalNumber*) [formatter numberFromString:amount];
    return [formatter stringFromNumber:number];
}

+(float)getValueFromCurrencyStyleString:(NSString *)str{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    NSLocale *american = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [nf setLocale:american];
    [nf setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *number = [nf numberFromString:str];
    return [number floatValue];
}

NSPredicate* DELETED_PREDECATE(void)
{
    return [NSPredicate predicateWithFormat:@"entity_status == %@", c_DELETED];
}

NSPredicate* NON_DELETED_PREDECATE(void)
{
    return [NSPredicate predicateWithFormat:@"entity_status != %@", c_DELETED];
}

NSPredicate* DIRTY_PREDECATE(void)
{
    return [NSPredicate predicateWithFormat:@"sync_status != %@", c_DIRTY];
}

CGRect TEXT_SIZE(NSString* str, int font_size)
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect size = [str boundingRectWithSize:CGSizeMake(screenRect.size.width, screenRect.size.height)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font_size]}
                                    context:nil];
    return size;
}

CGRect TEXT_SIZE_BORDERS(NSString* str, int font_size, int borderLeft, int borderRight,int top, int bot)
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect size = [str boundingRectWithSize:CGSizeMake(screenRect.size.width-borderLeft-borderRight, screenRect.size.height-top-bot)
                       options:NSStringDrawingUsesLineFragmentOrigin
                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font_size]}
                       context:nil];
    size.size.height+=top+bot;
    return size;
}

//+(NSArray *) sortArrrayWithKey:(NSString *)keyString  {
//
//
//}


@end
