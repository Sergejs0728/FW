//
//  NSMutableArray+SSArrayOfArrays.m
//  FieldWork
//
//  Created by Samir Kha on 09/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "NSMutableArray+SSArrayOfArrays.h"

@implementation NSMutableArray (SSArrayOfArrays)

- (void)addObject:(id)anObject toSubarrayAtIndex:(NSUInteger)idx
{
    while ([self count] <= idx) {
        [self addObject:[NSMutableArray array]];
    }
    
    [[self objectAtIndex:idx] addObject:anObject];
}


@end


@implementation NSArray (SSArrayOfArrays)

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self objectAtIndex:[indexPath section]] objectAtIndex:[indexPath row]];
}
@end