//
//  NSManagedObject+Mapping.h
//  FWModel
//
//  Created by SamirMAC on 11/12/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "NSObject+Properties.h"
#import <objc/runtime.h>

@interface NSManagedObject (Mapping)

+ (FEMAttribute*) floatAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) doubleAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) intAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) boolAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) dateTimeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) dateTimeGMT0AttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) dateAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) timeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

+ (FEMAttribute*) timeAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath format:(NSString *)format;

+ (FEMAttribute*) stringAttributeFor:(NSString*)property andKeyPath:(NSString*)keyPath;

@end
