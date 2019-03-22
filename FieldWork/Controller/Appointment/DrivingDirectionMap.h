//
//  DrivingDirectionMap.h
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegexKitLite.h"
#import "Appointment.h"
#import "CommonAppointmentViewController.h"
#import "Customer.h"
#import "Place.h"
#import "MapView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"
#import "SVGeocoder.h"
#import "SVPlacemark.h"


@interface DrivingDirectionMap : CommonAppointmentViewController <LocationUpdater>
{
    Place *home;
    Place *office;
    MapView *mapView;
    Location *location;
}



+ (DrivingDirectionMap*) controllerWithAppointment:(Appointment*) app;

- (void) drawRoute:(SVPlacemark*) destination;

@end
