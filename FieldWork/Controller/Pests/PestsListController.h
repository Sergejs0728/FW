//
//  PestsListController.h
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PestsAddController.h"
#import "CommonAppointmentViewController.h"
#import "Appointment.h"
#import "Pest.h"
#import "InspectionPest.h"
#import "ListItemDelegate.h"
#import "InspectionRecord.h"
#import "PestSelectionDelegate.h"


@interface PestsListController : CommonAppointmentViewController<ListItemDelegate,UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSMutableArray *_pestList;
    IBOutlet UITableView *table;
    InspectionRecord *_inspectionRecord;
    
    BOOL _IsFromInspection;
    
    id<PestSelectionDelegate> _pestSelectionDelegate;
}

@property (nonatomic, retain, readwrite) NSMutableArray *pestList;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, readwrite, retain)     InspectionRecord *inspectionRecord;
@property (nonatomic, retain, readwrite) NSMutableArray *inspectionPestRecords;
@property (nonatomic, assign) BOOL isFromInspection;
@property (nonatomic, retain, readwrite) id<PestSelectionDelegate> pestSelectionDelegate;


+ (PestsListController*) viewControllerWithAppointment:(Appointment*) app;

+ (PestsListController*) viewControllerWithAppointment:(Appointment *)app andInspection:(InspectionRecord*) ins;

@end

