//
//  NSArray+Extension.m
//  FieldWork
//
//  Created by SamirMAC on 3/4/16.
//
//

#import "NSArray+Extension.h"

@implementation NSArray (Extension)

- (NSArray *)sortUsingKey:(NSString *)key {
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

@end
