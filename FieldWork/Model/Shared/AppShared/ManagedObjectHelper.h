//
//  ManagedObjectHelper.h
//  FWModel
//
//  Created by SamirMAC on 11/21/15.
//  Copyright (c) 2015 SamirMAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ManagedObjectHelper : NSObject


+ (ManagedObjectHelper*) Instance;

- (void) objectContextWillSave: (NSNotification*) notification;

@end
