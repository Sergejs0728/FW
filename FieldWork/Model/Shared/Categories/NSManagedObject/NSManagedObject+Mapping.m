//
//  NSManagedObject+Mapping.m
//  FWModel
//
//  Created by SamirMAC on 11/12/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "NSManagedObject+Mapping.h"
#import "NSDate+Extentsion.h"

@implementation NSManagedObject (Mapping)

+ (FEMAttribute*) floatAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithFloat:[value floatValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%.02f", [value floatValue]];
    }];
    return attr;
}

+ (FEMAttribute*) doubleAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            //NSLog(@"Narendra %f",[value doubleValue]);
            return [NSNumber numberWithDouble:[value doubleValue]];
        }
        return value;
    } reverseMap:^id(id value) {
          //NSLog(@"Narendra %f",[value doubleValue]);
        return [NSString stringWithFormat:@"%.02f", [value doubleValue]];
    }];
    return attr;
}

+ (FEMAttribute*) intAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithInt:[value floatValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%d", [value intValue]];
    }];
    return attr;
}

+ (FEMAttribute*) boolAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSNumber numberWithBool:[value boolValue]];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%d", [value boolValue]];
    }];
    return attr;
}

+ (FEMAttribute*) dateTimeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSDate getDateFromJSONString:value];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}

+ (FEMAttribute*) dateTimeGMT0AttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSDate dateJSONTransformer:value];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}
            
+ (FEMAttribute*) dateAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            return [NSDate getDateWithFormat:@"MM-dd-yyyy" JSONString:value];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}

+ (FEMAttribute*) stringAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
       
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}


+ (FEMAttribute*) timeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath
{
    return [self timeAttributeFor:property andKeyPath:keyPath format:@"HH:mm"];
}

+ (FEMAttribute*) timeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath format:(NSString *)format
{
    FEMAttribute *attr = [[FEMAttribute alloc] initWithProperty:property keyPath:keyPath map:^id(id value) {
        if ([value isKindOfClass:[NSString class]]) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            
            NSDate *dt = [formatter dateFromString:value];
            [formatter setDateFormat:@"hh:mm a"];
            return [formatter stringFromDate:dt];
        }
        return value;
    } reverseMap:^id(id value) {
        return [NSString stringWithFormat:@"%@", value];
    }];
    return attr;
}


@end
