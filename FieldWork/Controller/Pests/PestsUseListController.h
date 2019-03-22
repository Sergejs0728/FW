//
//  PestsUseListController.h
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialusetablelistCell.h"
#import "PestsListController.h"
#import "CommonAppointmentViewController.h"
#import "Appointment.h"
#import "AppDelegate.h"
#import "ListItemDelegate.h"


@protocol TargetPestSelectionDelegate <NSObject>

- (void) TargetPestSelected:(TargetPest*) targetPest;

@end

@interface PestsUseListController : CommonAppointmentViewController<TargetPestListDelegate, ListItemDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_targetpestList;
    IBOutlet UITableView *_table;
    
    id<TargetPestSelectionDelegate> _targetPestSelectionDelegate;
}
@property (nonatomic, retain, readwrite) NSMutableArray *targetpestList;
@property (nonatomic, retain) UITableView *table;
@property (nonatomic, readwrite, retain) id<TargetPestSelectionDelegate> targetPestSelectionDelegate;

+ (PestsUseListController*) viewControllerWithAppointment:(Appointment*) app;
-(void)addNewTargetPests;

@end
