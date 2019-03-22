//
//  WorkPoolMapViewController.h
//  FieldWork
//
//  Created by Samir Khatri on 9/21/15.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//26112015
//#import "AppointmentList.h"
#import "Appointment.h"
//26112015
//#import "CustomerList.h"

@interface WorkPoolMapViewController : UIViewController<MKMapViewDelegate>


@property (nonatomic,retain)NSMutableArray *appointmentArray;
@property (nonatomic,retain)NSMutableArray *annotationArray;

+ (WorkPoolMapViewController *)initViewController;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
+(AccountManager*)Instance;
@end
