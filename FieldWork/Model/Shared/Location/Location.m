//
//  Location.m
//  TREKhunters
//
//  Created by Samir Kha on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Location.h"
#import "AppDelegate.h"
#import "User.h"

static Location *sharedObject=nil;
@implementation Location
@synthesize reverseGeocoder,CurLocation, locationUpdaterDelegate = _locationUpdaterDelegate;
@synthesize currentCoordinates;

+ (id)Instance
{
    
    if (sharedObject==nil)
    {
        sharedObject = [[super allocWithZone:NULL] init];
    }
    
    return sharedObject;
}

-(void)startLocationManager:(id<LocationUpdater>)locDel{
    lastUpdateDateForLocation = [NSDate date];

    locationManager = [[CLLocationManager alloc] init];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    if (locationManager && [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
          [locationManager startUpdatingLocation];
    }
    
#endif
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    
    [locationManager startUpdatingLocation];
    
}

-(void)startLocationManager{
    lastUpdateDateForLocation = [NSDate date];

    locationManager = [[CLLocationManager alloc] init];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    
    if (locationManager && [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
        [locationManager requestAlwaysAuthorization];
        [locationManager startUpdatingLocation];
    }
    
#endif
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    
    [locationManager startUpdatingLocation];
    
}

- (void)stopLocationManager {
    [locationManager stopUpdatingLocation];
}

-(CLLocationCoordinate2D)getCurrentCoordinates{
    return currentCoordinates;
}

- (void) updateLocationInMainThread:(CLLocationCoordinate2D) curLocation{
    if(self.locationUpdaterDelegate){
        
        [self.locationUpdaterDelegate updateCurrentLocation:currentCoordinates];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
    currentCoordinates = newLocation.coordinate;
    [self updateLocationInMainThread:currentCoordinates];
    NSTimeInterval elapsedTime = -[lastUpdateDateForLocation timeIntervalSinceNow];
    if (elapsedTime >= FORCEFUL_UPDATE_LOCATION) {
        lastUpdateDateForLocation = [NSDate date];
        [self startUpdateTimer];
    }
    
    //NSLog(@"%f, %f", currentCoordinates.latitude, currentCoordinates.longitude);
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    currentCoordinates.longitude = currentCoordinates.latitude = NSNotFound;
}


- (NSDate *)lastUpdateDateForLocation {
    lastUpdateDateForLocation = [[NSUserDefaults standardUserDefaults] valueForKey:@"lastUpdateDateForLocation"];
    return lastUpdateDateForLocation;
}

- (void)setLastUpdateDate:(NSDate *)lastUpdateDate {
    lastUpdateDateForLocation = lastUpdateDate;
    [[NSUserDefaults standardUserDefaults] setValue:lastUpdateDate forKey:@"lastUpdateDateForLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self stopUpdateTimer];
    [self startUpdateTimer];
}

- (void) startUpdateTimer
{
    [self stopUpdateTimer];
        __update_location_timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(onUpdateTimerLocationCalled:) userInfo:nil repeats:NO];
}

- (void) stopUpdateTimer
{
    if (__update_location_timer != nil) {
        [__update_location_timer invalidate];
        __update_location_timer = nil;
    }
}

- (void)onUpdateTimerLocationCalled:(NSTimer *)timer
{
    DLog(@"Update location Timer Called");
    if (CLLocationCoordinate2DIsValid(currentCoordinates)) {
        if (currentCoordinates.latitude != 0 && currentCoordinates.longitude != 0) {
            [[User getUser] updateUserLocationKitlocate:currentCoordinates];
        }
    }
}

@end
