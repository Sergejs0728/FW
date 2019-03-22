//
//  KitLocateTasker.m
//  Periodic-Example-iPhone
//
//  Created by KitLocate on 06/03/13.
//  Copyright (c) 2013 KitLocate. All rights reserved.
//
//  The class which implements the CallBack functions of KitLocate
//

#import "KitLocateTasker.h"
#import <KitLocate/KitLocate.h>
#import "AccountManager.h"
#import "User.h"

static KitLocateTasker *sharedObject=nil;

@implementation KitLocateTasker
@synthesize currentCordinates = _currentCordinates;

+ (id)Instance
{
    if (sharedObject==nil)
    {
        sharedObject = [[super alloc] init];
       // a2fd652b-7914-446d-a233-2b1131adf76c
        //7f11e8f8-ec58-47ce-a519-f7c12c889da3
        [KitLocate initKitLocateWithDelegate:sharedObject APIKey:@"a2fd652b-7914-446d-a233-2b1131adf76c"];
        [KitLocate registerForLocalNotifications];

    }
    
    return sharedObject;
}

-(void) gotBackgroundLocation{
}
// This delegate method will fired each time we got a location
- (void)gotPeriodicLocation:(KLLocationValue*)location{


    // EXAMPLE - we will give local push notification (Application must be in background to get the notification)
    NSLog(@"gotPeriodicLocation");
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake([location fLatitude], [location fLongitude]);
    if (CLLocationCoordinate2DIsValid(cord)) {
        if (cord.latitude != 0 && cord.longitude != 0) {
            _currentCordinates = cord;
            [[User getUser] updateUserLocationKitlocate:cord];
        }
    }
    
    NSString *strText = [NSString stringWithFormat:@"Location Lat: %f Lon: %f Acc: %f",[location fLatitude], [location fLongitude], [location fAccuracy]];
    //NSLog(@"Location : %@", strText );
  
}

- (CLLocationCoordinate2D)getCurrentCordinates {
    return _currentCordinates;
}

// This method is invoked after initKitLocate is finished successfully
-(void)didSuccessInitKitLocate:(int)status
{
    NSLog(@"didSuccessInitKitLocate - status: %d",status);
    [KLLocation registerPeriodicLocation];
    [KLLocation setPeriodicMinimumTimeInterval:1];
    //[KLLocation setPeriodicMinimumDistance:100];
}

// This method is invoked if initKitLocate fails
-(void)didFailInitKitLocate:(int)error
{
    NSLog(@"didFailInitKitLocate - error: %d",error);
}

@end
