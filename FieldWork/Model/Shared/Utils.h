//
//  Utils.h
//  FWModel
//
//  Created by SamirMAC on 11/13/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject


+ (NSString*) getTimeString:(int)minutes;

+ (int)RandomId;

+ (int)RandomIdPlus;

+ (NSString *) addSuffixToNumber:(int) number;

+ (NSString*) getNonmilitaryTime:(NSString*) str; // with AP/PM

+ (NSString*) getMilitaryTime:(NSString*) str; // with 24 hors

//26112015
+(BOOL)validateEmailWithString:(NSString*)email;

+ (NSDate*)dateJSONTransformer:(NSString*)dateString;

+ (NSInteger) timezoneDifferenceInDestinationTimeZone;

+ (NSString *)getHeaderVersion;

+(NSString *)dateFormatMMddyyyy:(NSDate *)date;

+(NSString *)dateFormathhmma:(NSDate *)date;

+ (NSDate*) dateFrom:(NSString*)date;

+ (NSString *)getCurrencyStringFromAmount:(float)amount;

+ (NSString *)getCurrencyStringFromAmountString:(NSString *)amount;

+ (NSString *)getCorrectDateFormathhmmaa:(NSDate *)date;

+ (NSDateFormatter*)getDateFormatterWithFormatString:(NSString*)format;

+(BOOL)isPastDate:(NSDate *)pastdate;

+(float)getValueFromCurrencyStyleString:(NSString *)str;

NSPredicate* DELETED_PREDECATE(void);

NSPredicate* NON_DELETED_PREDECATE(void);

NSPredicate* DIRTY_PREDECATE(void);

CGRect TEXT_SIZE(NSString* str, int font_size);

CGRect TEXT_SIZE_BORDERS(NSString* str, int font_size, int borderLeft, int borderRight, int top, int bot);

@end
