//
//  WorkPoolMapViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 9/21/15.
//
//

#import "WorkPoolMapViewController.h"

@interface WorkPoolMapViewController ()

@end

@implementation WorkPoolMapViewController
@synthesize mapView;
@synthesize appointmentArray = _appointmentArray;

+ (WorkPoolMapViewController *)initViewController{
    WorkPoolMapViewController * controller = [[WorkPoolMapViewController alloc]initWithNibName:@"WorkPoolMapViewController" bundle:nil];
    controller.title = @"WorkPool Map";
    return controller;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"map.png"] style:UIBarButtonItemStylePlain target:self action:@selector(flipView)];
    self.navigationItem.rightBarButtonItem = barItem;
    
    
    mapView.delegate = self;
    _annotationArray = [[NSMutableArray alloc]init];
    _appointmentArray = [[NSMutableArray alloc]init];
    //26112015
//    _appointmentArray = [[AppointmentList Instance]getAppointmentsIsWorkPool];
    
    [[ActivityIndicator currentIndicator] displayActivity:@"Please Wait..."];
    
    for (int i = 0; i<_appointmentArray.count; i++) {
        Appointment *app = [_appointmentArray objectAtIndex:i];
        
        //26112015
//        [[CustomerList Instance] retriveCustomer:app.customer_id withCompletionBlock:^{
//            [[ActivityIndicator currentIndicator] displayCompleted];
//            Customer *c = [[CustomerList Instance] customerbyId:app.customer_id];
//            
//        
//            CLLocationCoordinate2D location;
//            location.latitude = c.latitude;
//            location.longitude = c.longitude;
//            NSString *title = c.name;
        
        
//            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//            annotation.coordinate = location;
//            annotation.title = title;
//            [_annotationArray addObject:annotation];
//        }];
    }

    [self.mapView addAnnotations:_annotationArray];

    
    
    
    /*
     [_map setShowsUserLocation:YES];
     ServiceLocationInfo *ser_loc = [self.appointment getServiceLocation];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     @try {
     if ([ser_loc hasLocation]) {
     CLLocationCoordinate2D cord = [ser_loc getCoordinate];
     MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
     [point setCoordinate:cord];
     [point setTitle:self.cust.name];
     [point setSubtitle:ser_loc.name];
     dispatch_async(dispatch_get_main_queue(), ^{
     [_map addAnnotation:point];
     });
     
     
     //http://stackoverflow.com/questions/3434020/ios-mkmapview-zoom-to-show-all-markers
     double minLatitude = cord.latitude;
     double minLongitude = cord.longitude;
     
     double maxLatitude = [[Location Instance] currentCoordinates].latitude;
     double maxLongitude = [[Location Instance] currentCoordinates].longitude;
     float MAP_PADDING = 1.5;
     float MINIMUM_VISIBLE_LATITUDE = 0.01;
     
     MKCoordinateRegion region;
     region.center.latitude = (minLatitude + maxLatitude) / 2;
     region.center.longitude = (minLongitude + maxLongitude) / 2;
     
     region.span.latitudeDelta = (maxLatitude - minLatitude) * MAP_PADDING;
     
     region.span.latitudeDelta = (region.span.latitudeDelta < MINIMUM_VISIBLE_LATITUDE)
     ? MINIMUM_VISIBLE_LATITUDE
     : region.span.latitudeDelta;
     
     region.span.longitudeDelta = (maxLongitude - minLongitude) * MAP_PADDING;
     if(region.center.longitude != -180.00000000 && region.center.latitude != -180.00000000){
     dispatch_async(dispatch_get_main_queue(), ^{
     @try {
     //MKCoordinateRegion scaledRegion = [_map regionThatFits:region];
     MKMapPoint a = MKMapPointForCoordinate(CLLocationCoordinate2DMake(
     region.center.latitude + region.span.latitudeDelta / 2,
     region.center.longitude - region.span.longitudeDelta / 2));
     MKMapPoint b = MKMapPointForCoordinate(CLLocationCoordinate2DMake(
     region.center.latitude - region.span.latitudeDelta / 2,
     region.center.longitude + region.span.longitudeDelta / 2));
     
     MKMapRect maprect = MKMapRectMake(MIN(a.x,b.x), MIN(a.y,b.y), ABS(a.x-b.x), ABS(a.y-b.y));
     MKCoordinateRegion region1 = MKCoordinateRegionForMapRect(maprect);
     [_map setRegion:region1 animated:YES];
     
     }
     @catch (NSException *exception) {
     NSLog(@"Exception: %@", exception);
     }
     @finally {
     
     }
     });
     }
     }
     
     }
     @catch (NSException * e) {
     NSLog(@"Exception: %@", e);
     }
     @finally {
     // Added to show finally works as well
     }
     });

     */
    
    // Do any additional setup after loading the view from its nib.
}

- (void)flipView{
    
    int64_t delay = 0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
