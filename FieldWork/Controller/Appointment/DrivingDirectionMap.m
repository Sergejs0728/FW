//
//  DrivingDirectionMap.m
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DrivingDirectionMap.h"

//http://stackoverflow.com/questions/1140404/forward-geocoding-from-the-iphone

@implementation DrivingDirectionMap


+ (DrivingDirectionMap *)controllerWithAppointment:(Appointment *)app {
    DrivingDirectionMap *controller = [[DrivingDirectionMap alloc] initWithNibName:@"DrivingDirectionMap" bundle:nil];
   
    controller.Appointment = app;
    controller.title = @"Direction";
    return controller;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
       
//    location = [[Location alloc] init];
//    location.locationUpdaterDelegate = self;
//    [location startLocationManager];
    
    self.navigationItem.title = @"Driving Direction";

    mapView = [[MapView alloc] initWithFrame:
               CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:mapView];
    
    Customer *cust = [self.Appointment getCustomer];
    [[ActivityIndicator currentIndicator] displayActivity:@"Fetching Customer Location..."];
    //26112015
//    NSLog(@"Customer Address : %@", [cust getBillingFullAddress]);
//    [SVGeocoder geocode:[cust getBillingFullAddress]
//             completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
//                 if (placemarks.count > 0) {
//                     SVPlacemark *place = [placemarks objectAtIndex:0];
//                     [self drawRoute:place];
//                 }
//                 [[ActivityIndicator currentIndicator] displayCompleted];
//             }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [location startLocationManager];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [location stopLocationManager];
    location = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)drawRoute:(SVPlacemark *)destination {
    Customer *cust =  [self.Appointment getCustomer];
    
    
    home = [[Place alloc] init];
    office = [[Place alloc] init];
    
    CLLocationCoordinate2D currentLocation = mapView.getMapView.userLocation.coordinate;
    
    if (currentLocation.latitude == NSNotFound) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork"
                                                         message:@"Can not find current location."
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
        [alert show];
        [location stopLocationManager];
        return;
    }
    
    home.name = @"Current Location";
    home.latitude = currentLocation.latitude;
    home.longitude = currentLocation.longitude;
    
    if (destination.location.coordinate.latitude == NSNotFound || destination.location.coordinate.longitude == NSNotFound) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork"
                                                         message:@"Can not find customer location."
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil];
        [alert show];
        [location stopLocationManager];
        return;
    }
    //26112015
//    office.name = [cust getDisplayName];
    
    office.latitude = destination.location.coordinate.latitude;
    office.longitude = destination.location.coordinate.longitude;
    
    [mapView showRouteFrom:home to:office];
}

#pragma LocationUpdater

- (void)updateCurrentLocation:(CLLocationCoordinate2D)currentLocation {
       
}

@end
