//
//  TrapListController.h
//  FieldWork
//
//  Created by Samir Kha on 12/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CommonAppointmentViewController.h"
//26112015
//#import "CustomerTrapList.h"
#import "Customer.h"
#import "TrapAddController.h"
#import "TrapListTableViewCell.h"
#import "BarcodeScanerViewController.h"

@interface TrapGroupListController : CommonAppointmentViewController<UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
   
    UITableView * _Traplisttable;
    NSMutableArray *barcodeArray;
    UISegmentedControl * _segment;
    UIImageView *resultImage;
    NSString *BarcodeType ;
    
    NSMutableArray *areaList;
   
    CustomerDevice *_customerTrap;
     BOOL _isChecked;
    
    
    
    NSMutableArray * _searchCheckedList;
    NSMutableArray * _searchUnCheckedList;
    
}

@property (nonatomic, retain) IBOutlet UIImageView * resultImage;
@property (nonatomic, retain) IBOutlet UITableView * Traplisttable;
@property (nonatomic, retain) IBOutlet UISegmentedControl * segment;
@property (nonatomic,readwrite,assign) BOOL isChecked;


-(IBAction) segmentedControlIndexChanged;

- (void) loadTable;

+ (TrapGroupListController*) initWithAppointment:(Appointment*) app;

-(NSMutableArray *)getSortedList:(NSMutableArray *)arr;

@end
