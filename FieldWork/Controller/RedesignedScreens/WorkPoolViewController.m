
#import "WorkPoolViewController.h"

#import "MFSideMenu.h"
#import "MKMapView+Extension.h"

NSInteger selectedMonthFinal;
NSMutableArray* totalMonths;
NSString* thisMonth;
NSString* thisYear;
NSString* filterStartDate;
NSString* filterEndDate;
NSString* finalApiStartDate;
NSString *finalApiEndDate;

@interface WorkPoolViewController ()
{
    CLLocationCoordinate2D userCoordinate;
    BOOL didFirstZoom;
}
@end

@implementation WorkPoolViewController
@synthesize mapView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    didFirstZoom = NO;
    
    self.title = @"Work Pool";
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];//[UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
    
    self.mapView.tintColor = [UIColor redColor];
    
    filterDistance = 5000*1.609344;
    
    isToolBarHidden = YES;
    [self selectDistanceButtonPressed:nil];
    
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    self.mapView.delegate = self;
    [self createButtons];
    
    
    monthSelector.delegate = self;
    monthSelector.dataSource = self;
    
    totalMonths = [[NSMutableArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    
    
    NSDate* todayDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM";
    thisMonth = [dateFormatter stringFromDate:todayDate];
    dateFormatter.dateFormat = @"yyyy";
    thisYear = [dateFormatter stringFromDate:todayDate];

    
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:(userLocation.coordinate.latitude - mapView.region.span.latitudeDelta * 0.5) longitude:userLocation.coordinate.longitude];
//    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:(userLocation.coordinate.latitude + mapView.region.span.latitudeDelta * 0.5) longitude:userLocation.coordinate.longitude];
//    CLLocation *loc3 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:(userLocation.coordinate.longitude - mapView.region.span.longitudeDelta * 0.5)];
//    CLLocation *loc4 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:(userLocation.coordinate.longitude + mapView.region.span.longitudeDelta * 0.5)];
//    int metersLongitude = [loc3 distanceFromLocation:loc4];
//    int metersLatitude = [loc1 distanceFromLocation:loc2];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, metersLatitude, metersLongitude);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    userCoordinate = [[[self.mapView userLocation] location] coordinate];
    self.userLocation1 = [[CLLocation alloc] initWithLatitude:userCoordinate.latitude longitude:userCoordinate.longitude];
}


-(void)createButtons{
    
    UIImage* image1 = [UIImage imageNamed:@"icon_with_dots.png"];
    CGRect frameimg1 = CGRectMake(15,5, 25,25);
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:frameimg1];
    [rightButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(toggleListMapButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [rightButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:addButton,nil];
    
    UIImage* image2 = [UIImage imageNamed:@"menuOrange.png"];
    CGRect frameimg2 = CGRectMake(15,5, 25,25);
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:frameimg2];
    [leftButton setBackgroundImage:image2 forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftMenuButtonPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [leftButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *menuButton =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = menuButton;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[AppointmentManager Instance] workPoolLoadedCount] <= 0)
    {
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        [[AppointmentManager Instance] loadAppointmentsWithBlock:^(id result, NSString *error) {
            if (error) {
                [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
            } else {
                [[ActivityIndicator currentIndicator] displayCompleted];
                [self appointmentsDidLoad];
            }
        }];
    }else{
        [self appointmentsDidLoad];
    }
    
    
    
    [locationManager requestWhenInUseAuthorization];
    
    [locationManager startUpdatingHeading];
    [locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [locationManager stopUpdatingHeading];
    [locationManager stopUpdatingLocation];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSaveTime:(NSNotification*)notification
{
    NSLog(@"appointment didSaveTime notification received");
    NSDictionary *userInfo = notification.userInfo;
    
    
    [self appointmentsDidLoad];
}

- (void)appointmentsDidLoad
{
    NSLog(@"appointments didLoad notification received");
    
    //  appointments = [NSMutableArray arrayWithArray:[AppointmentsManager manager].workPool];
    [self createPinArray];
    if (customLocation)
    {
        [self filterAppointmentsForCoordinate:customLocation.coordinate];
    }
    else
    {
        [self filterAppointmentsForCoordinate:locationManager.location.coordinate];
    }
}

- (void)createPinArray
{
//    NSMutableArray * appointments = [[NSMutableArray alloc]init];
    appointments = [Appointment getWorkPoolAppointments];
    appointmentPins = [NSMutableArray array];
    for (Appointment * apps in appointments) {
        
        MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
        ServiceLocation * sl = [apps getServiceLocation];
        
        CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(sl.latValue, sl.lngValue);
        point.coordinate = cord;
        point.title = [NSString stringWithFormat:@"%@",apps.report_number];
        [appointmentPins addObject:point];
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:cord radius:filterDistance];
        [mapView addOverlay:circle];
    }
    
    [mapView addAnnotations:appointmentPins];
    
    //    [mapView reloadInputViews];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways)
    {
        mapView.showsUserLocation = YES;
        [mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        

        if (mapView.userLocation.location) {
            userCoordinate = mapView.userLocation.location.coordinate;
            [self zoomToLocation:userCoordinate size:MKMapSizeMake(filterDistance*2, filterDistance*2)];
        }
        
        [mapView removeAnnotations:mapView.annotations];
        
        [self createPinArray];
        [self filterAppointmentsForCoordinate:manager.location.coordinate];
    }
    else
    {
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    static int counter = 0;
    counter++;
    
    if (!(counter % 5))
    {
        if (customLocation)
        {
            [self drawCircleAtLocation:customLocation.coordinate];
            [self filterAppointmentsForCoordinate:customLocation.coordinate];
        }
        else
        {
            [self drawCircleAtLocation:manager.location.coordinate];
            [self filterAppointmentsForCoordinate:manager.location.coordinate];
        }
        
        counter = 0;
    }
    if (!didFirstZoom) {
        didFirstZoom = YES;
//        CLLocation *userLocation = manager.location;
//        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:(userLocation.coordinate.latitude - mapView.region.span.latitudeDelta * 0.5) longitude:userLocation.coordinate.longitude];
//        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:(userLocation.coordinate.latitude + mapView.region.span.latitudeDelta * 0.5) longitude:userLocation.coordinate.longitude];
//        CLLocation *loc3 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:(userLocation.coordinate.longitude - mapView.region.span.longitudeDelta * 0.5)];
//        CLLocation *loc4 = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:(userLocation.coordinate.longitude + mapView.region.span.longitudeDelta * 0.5)];
//        int metersLongitude = [loc3 distanceFromLocation:loc4];
//        int metersLatitude = [loc1 distanceFromLocation:loc2];
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, metersLatitude, metersLongitude);
//        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        
        [self zoomToLocationWithSize:MKMapSizeMake(filterDistance*2, filterDistance*2)];
    }
}

- (IBAction)leftMenuButtonPressed:(id)sender
{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)selectDistanceButtonPressed:(id)sender
{
    
    [UIView animateWithDuration:0.5 animations:^
     {
         [self.navigationController setToolbarHidden:isToolBarHidden animated:YES];
     } completion:^(BOOL finished)
     {
         
     }];
    isToolBarHidden = !isToolBarHidden;
}

- (IBAction)toggleListMapButton:(id)sender{
    WorkPoollistViewController * controller = [WorkPoollistViewController initViewController];
    controller.userLocation = self.userLocation1;
    UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:controller];
    navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentViewController:navController animated:YES completion:^{
        
    }];
}


- (IBAction)distanceChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            filterDistance = 5000;
            break;
        case 1:
            filterDistance = 10000;
            break;
        case 2:
            filterDistance = 15000;
            break;
        case 3:
            filterDistance = 500000;
            break;
        default:
            break;
    }
    filterDistance *= 1.609344;
    [self zoomToLocationWithSize:MKMapSizeMake(filterDistance*2, filterDistance*2)];
}

- (void) filterAppointmentsForCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSMutableArray *suitableAppointments = [NSMutableArray array];
    CLLocation *staticLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    for (MKPointAnnotation *annotation in appointmentPins)
    {
        CLLocation *appointmentLocation = [[CLLocation alloc] initWithLatitude:annotation.coordinate.latitude longitude:annotation.coordinate.longitude];
        
        double distance = [staticLocation distanceFromLocation:appointmentLocation];
        if (distance <= filterDistance)
        {
            [suitableAppointments addObject:annotation];
        }
    }
    
    if (suitableAppointments.count == 0)
    {
        suitableAppointments = [NSMutableArray arrayWithArray:appointmentPins];
    }
    
    [mapView removeAnnotations:mapView.annotations];
    [mapView addAnnotations:suitableAppointments];
}

- (void) drawCircleAtLocation:(CLLocationCoordinate2D)location
{
    [mapView removeOverlays:mapView.overlays];
    
    
    MKCircle *circle = [MKCircle circleWithCenterCoordinate:location radius:filterDistance];
    [mapView addOverlay:circle];
}

- (void)zoomToLocation:(CLLocationCoordinate2D)location size:(MKMapSize)size
{
    
    
    MKCoordinateRegion regionForZoom = MKCoordinateRegionMakeWithDistance(location, size.width, size.height);
    
    [mapView setRegion:regionForZoom animated:YES];
    
    [self drawCircleAtLocation:location];
}

- (void)zoomToLocationWithSize:(MKMapSize)size
{
    CLLocationCoordinate2D location;
    if (customLocation)
    {
        location = customLocation.coordinate;
    }
    else
    {
        location = locationManager.location.coordinate;
    }
    
    MKCoordinateRegion regionForZoom = MKCoordinateRegionMakeWithDistance(location, size.width, size.height);
    [mapView setRegion:regionForZoom animated:YES];
    
    [self drawCircleAtLocation:location];
}




- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKCircle class]])
    {
        float r = 231.0;
        float g = 76.0;
        float b = 58.0;
        
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        renderer.strokeColor = [UIColor colorWithRed:r/256 green:g/256 blue:b/256 alpha:0.5];
        renderer.fillColor = [UIColor colorWithRed:r/256 green:g/256 blue:b/256 alpha:0.07];
        renderer.lineWidth = 1.0f;
        
        return renderer;
    }
    return nil;
}


- (void)mapView:(MKMapView *)_mapView didSelectAnnotationView:(nonnull MKAnnotationView *)view
{
    NSString *strTitle = [NSString stringWithFormat:@"%@",view.annotation.title];
    if (![strTitle isEqualToString:@"Current Location"]) {
        NSMutableArray * appointments = [[NSMutableArray alloc]init];
        appointments = [Appointment getWorkPoolAppointments];
        appointmentPins = [NSMutableArray array];
        for (Appointment * apps in appointments) {
            NSString *strRepNo = [NSString stringWithFormat:@"%@",apps.report_number];
            if ([strRepNo isEqualToString:strTitle]) {
                NewWorkOrderViewController *controller = [NewWorkOrderViewController viewControllerWithWorkOrder:apps];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
    }
}


- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    for (aV in views) {
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            MKAnnotationView* annotationView = aV;
            annotationView.canShowCallout = NO;
//            [self zoomToLocation:userCoordinate];
        }
    }
}

- (IBAction)longTap:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"long tap");
        CGPoint pointInView = [sender locationInView:mapView];
        
        CLLocationCoordinate2D coordinate = [mapView convertPoint:pointInView toCoordinateFromView:mapView];
        CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        
        if (customLocation)
        {
            double distance = [customLocation distanceFromLocation:newLocation];
            if (distance < filterDistance)
            {
                customLocation = nil;
                [self filterAppointmentsForCoordinate:locationManager.location.coordinate];
                //                [self drawCircleAtLocation:locationManager.location.coordinate];
            }
            else
            {
                customLocation = newLocation;
                [self filterAppointmentsForCoordinate:coordinate];
                //                [self drawCircleAtLocation:coordinate];
            }
        }
        else
        {
            customLocation = newLocation;
            [self filterAppointmentsForCoordinate:coordinate];
            //            [self drawCircleAtLocation:coordinate];
        }
        [self zoomToLocationWithSize:MKMapSizeMake(filterDistance*2, filterDistance*2)];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


- (void) openPickerViewWithTag:(int) tag andTitle:(NSString*) title forPickerView:(UIPickerView*) picker
{
    
    [self.view endEditing:YES];
    picker.showsSelectionIndicator=YES;
    picker.dataSource = self;
    picker.delegate = self;
    picker.tag = tag;
    SamcomActionSheet_iPad * action = [SamcomActionSheet_iPad initIPadUIPickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:picker inView:self.view];
    
    action.tag = tag;
    action.isViewOpen= YES;
    [action show];
    [self selectRow:(thisMonth.integerValue - 1) inComponent:0 animated:NO];
}


#pragma mark- UIActionSheet & PickerView Delegate


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return totalMonths.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [totalMonths objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger select = thisMonth.integerValue - 1;
    if (row < select) {
        NSLog(@"Disable the month");
        [self selectRow:row inComponent:component animated:NO];
    }
    selectedMonthFinal = row + 1;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    NSInteger select = thisMonth.integerValue - 1;
    [monthSelector selectRow:select inComponent:component animated:NO];
}


#pragma mark - SamcomActionSheetDelegate

- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
    int idx = (int)[actionSheet.pickerView selectedRowInComponent:0];
    selectMonthText.text = [totalMonths objectAtIndex:idx];
    [self.view endEditing:YES];
    [self calculateNoOfDays];
}

- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
}

-(void)calculateNoOfDays {
    
    NSLog(@"selectedMonthFinal = %ld", (long)selectedMonthFinal);
    NSInteger days;
    if (selectedMonthFinal == 1 || selectedMonthFinal == 3 || selectedMonthFinal == 5 || selectedMonthFinal == 7 || selectedMonthFinal == 8 || selectedMonthFinal == 10 || selectedMonthFinal == 12) {
        days = 31;
    } else if (selectedMonthFinal == 2) {
        if (thisYear.integerValue % 4 == 0) {
            days = 29;
        } else {
            days = 28;
        }
    } else {
        days = 30;
    }
    
    NSString *temp = [NSString stringWithFormat:@"%ld", (long)selectedMonthFinal];
    if (temp.length == 1) {
        temp = [NSString stringWithFormat:@"0%@",temp];
    }
    finalApiStartDate = [NSString stringWithFormat:@"%@/01/%@", temp, thisYear];
    finalApiEndDate = [NSString stringWithFormat:@"%@/%ld/%@", temp, (long)days, thisYear];
    NSLog(@"finalApiEndDate = %@", finalApiEndDate);
    [self startFilerAppointment];
}

-(void)startFilerAppointment {
    [[AppointmentManager Instance] loadWorkPoolAppointmentsWithBlock:^(id result, NSString *error) {
        if (error) {
            [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
        } else {
            NSLog(@"start = %@ end = %@", finalApiStartDate, finalApiEndDate);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = MMDDYYYY;
            NSDate* start = [dateFormatter dateFromString:finalApiStartDate];
            NSLog(@"start = %@", start);
            NSDate* end = [dateFormatter dateFromString:finalApiEndDate];
            appointments = [[NSMutableArray alloc]init];
            appointments = [Appointment getWorkPoolAppointmentsByDistanceWithDateRange:self.userLocation1 fromDate:start toDate:end];
            
            //        [self createPinArray];
            
            //        NSMutableArray * appointments = [[NSMutableArray alloc]init];
            appointmentPins = [NSMutableArray array];
            for (Appointment * apps in appointments) {
                
                MKPointAnnotation* point = [[MKPointAnnotation alloc] init];
                ServiceLocation * sl = [apps getServiceLocation];
                
                CLLocationCoordinate2D cord = CLLocationCoordinate2DMake(sl.latValue, sl.lngValue);
                point.coordinate = cord;
                point.title = [NSString stringWithFormat:@"%@",apps.report_number];
                [appointmentPins addObject:point];
                MKCircle *circle = [MKCircle circleWithCenterCoordinate:cord radius:filterDistance];
                [mapView addOverlay:circle];
            }
            
            [mapView addAnnotations:appointmentPins];
            
            [mapView reloadInputViews];
        }
    } andStartDate:finalApiStartDate andEndDate:finalApiEndDate];
}


- (IBAction)monthSelectorClicketd:(id)sender {
    monthSelector = [[UIPickerView alloc]init];
    [self openPickerViewWithTag:1000 andTitle:@"Select Month" forPickerView:monthSelector];

}

@end
