//
//  WorkPoolViewController.h
//  FieldWork
//
//  Created by Павел Шереметов on 31.08.15.
//  Copyright (c) 2015 Павел Шереметов. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "WorkPoollistViewController.h"


@interface WorkPoolViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,iPadSamcomActionSheetDelegate>{
    
    
    CLLocationManager *locationManager;
    
    BOOL isToolBarHidden;
    
    int filterDistance;
    
    NSMutableArray *appointmentPins;
    
    CLLocation *customLocation;
    
    UIPickerView *monthSelector;
    IBOutlet UIView *datesView;
    
    __weak IBOutlet UITextField *selectMonthText;
    NSMutableArray *appointments;


}

- (IBAction)monthSelectorClicketd:(id)sender;

@property (nonatomic, retain)IBOutlet MKMapView *mapView;
@property (nonatomic, retain)CLLocation* userLocation1;
@property (nonatomic, retain) MKPointAnnotation* point;
@end