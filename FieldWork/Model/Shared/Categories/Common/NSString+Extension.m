//
//  NSString+Extension.m
//  FieldWork
//
//  Created by SamirMAC on 1/22/16.
//
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)URLStringByAppendingQueryString:(NSString *)queryString {
    if (![queryString length]) {
        return self;
    }
    return [NSString stringWithFormat:@"%@%@%@", self,
            [self rangeOfString:@"?"].length > 0 ? @"&" : @"?", queryString];
}

@end
