//
//  NSDictionary+Extension.m
//  FWModel
//
//  Created by SamirMAC on 11/21/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (NSDictionary *)dictionaryByRemovingId{
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: self];
    
    for (NSString *key in self) {
        const id object = [self objectForKey: key];
        if ([object isKindOfClass:[NSDictionary class]]) {
            [replaced setObject:[(NSDictionary*)object dictionaryByRemovingId] forKey:key];
        } else if ([key isEqualToString:@"id"]){
            [replaced removeObjectForKey:key];
        } else if ([object isKindOfClass:[NSArray class]]){
            if (object && [(NSArray*)object count] > 0) {
                id temp = [(NSArray*)object objectAtIndex:0];
                if (![temp isKindOfClass:[NSDictionary class]]) {
                    continue;
                }
            }
            NSMutableArray *arr_temp = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in object) {
                NSDictionary *temp = [dict dictionaryByRemovingId];
                [arr_temp addObject:temp];
            }
            [replaced setObject:arr_temp forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:replaced];
}

- (NSMutableDictionary*)replaceKeyName:(NSString *)old_key with:(NSString *)new_key {
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary: self];
    NSMutableArray *keys = [[dict allKeys] mutableCopy];
    for (NSString *key in keys) {
        if ([key isEqualToString:old_key]) {
            id val = [self objectForKey:key];
            [dict removeObjectForKey:key];
            [dict setValue:val forKey:new_key];
            return dict;
        } else {
            const id object = [dict objectForKey: key];
            if ([object isKindOfClass:[NSDictionary class]]) {
                [dict setObject:[dict replaceKeyName:old_key with:new_key] forKey:key];
            } else if ([object isKindOfClass:[NSArray class]]){
                if (object && [(NSArray*)object count] > 0) {
                    NSMutableArray *arr_temp = [[NSMutableArray alloc] init];
                    for (id temp in object) {
                        if ([temp isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *temp_dict = [temp replaceKeyName:old_key with:new_key];
                            [arr_temp addObject:temp_dict];
                        } else {
                            [arr_temp addObject:temp];
                        }
                        
                    }
                    [dict setValue:arr_temp forKey:key];
                }
            }
        }
    }
    return dict;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"
- (id) initWithDestroy:(id)entity_id
{
    self = [[NSDictionary alloc] initWithObjectsAndKeys:entity_id, @"id",[NSNumber numberWithBool:YES], @"_destroy", nil];
    return self;
}
#pragma clang diagnostic pop



@end
