//
//  Location.h
//  TREKhunters
//
//  Created by Samir Kha on 11/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define FORCEFUL_UPDATE_LOCATION 30

@protocol LocationUpdater <NSObject>

- (void) updateCurrentLocation:(CLLocationCoordinate2D) currentLocation;

@end

@interface Location : NSObject<CLLocationManagerDelegate>{

    
        CLGeocoder *reverseGeocoder;
        // CLGeocoder *reverseGeocoder;
       

    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentCoordinates;
    NSString *CurLocation;
    id<LocationUpdater> _locationUpdaterDelegate;
    NSTimer *__update_location_timer;
     NSDate *lastUpdateDateForLocation;

}


    //@property (nonatomic, retain)  MKReverseGeocoder *reverseGeocoder;
@property (nonatomic, retain)  CLGeocoder *reverseGeocoder;
@property (nonatomic, assign) CLLocationCoordinate2D currentCoordinates;

@property (nonatomic, retain)  NSString *CurLocation;
@property (nonatomic, retain) id<LocationUpdater> locationUpdaterDelegate;

+ (id) Instance;
- (void) startLocationManager;
- (void) stopLocationManager;
-(CLLocationCoordinate2D)getCurrentCoordinates;
-(void)startLocationManager:(id<LocationUpdater>)locDel;
- (void) updateLocationInMainThread:(CLLocationCoordinate2D) curLocation;
-(CLLocationCoordinate2D)getCurrentCoordinates;


@end
