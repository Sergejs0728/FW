//
//  CDHelper.m
//  FWModel
//
//  Created by SamirMAC on 11/6/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import "CDHelper.h"

@implementation CDHelper

+ (NSDictionary*) mappingForClass:(Class)cls
{
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Mapping" ofType:@"plist"]];
    NSDictionary *keys = [dictRoot objectForKey:NSStringFromClass(cls)];
    return keys;
}

@end
