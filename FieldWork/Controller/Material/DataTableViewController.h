//
//  DataTableViewController.h
//  FieldWork
//
//  Created by Samir Kha on 29/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialUsageRecord.h"
#import "DilutionRates.h"
#import "Measurements.h"
#import "ApplicationMethods.h"
#import "LocationArea.h"
#import "AddLocationAreaController.h"
#import "CommonAppointmentViewController.h"
#import "DeviceTypes.h"
#import "TrapTypes.h"
#import "TrapConditions.h"
#import "BaitConditions.h"
#import "Services.h"
#import "Recommendations.h"
#import "Conditions.h"
#import "FlatType.h"
#import "FlatConditions.h"

typedef enum _DataType {
    DilutionRate = 0,
    UnitType = 1,
    AppMethod = 2,
    LocationEnum = 3,
    TargetPestEnum = 4,
    DeviceTypeEnum = 5,
    TrapTypeEnum = 6,
    TrapConditionEnum = 7,
    BaitConditionEnum = 8,
    AddLineItem =9,
    LineItemServices = 10,
    ServiceRoutesList = 11,
    WindDirection = 12,
    RecommendationsList = 13,
    ConditionsList = 14,
    PaymentMethod = 15,
    FlatTypesList = 16,
    UnitStatusList = 17,
    FlatConditionsList = 18
    } DataType;

@protocol DataSelectionDelegate <NSObject>

- (void) DataSelectedForData:(id) data andType:(DataType) type;

@end


@interface DataTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate>
{
    id<DataSelectionDelegate> _delegate;
    DataType _type;
    NSMutableArray *_dataArray;
    IBOutlet UITableView * table;
    BOOL _is_multiple_choice_enable;

    NSMutableArray *_selected_items;
    NSMutableArray *_existing_items;
}

@property (nonatomic, readwrite, retain) id<DataSelectionDelegate> delegate;
@property (nonatomic, readwrite, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *filteredListContent;
@property (nonatomic,assign) BOOL searchWasActive;
@property (nonatomic, strong) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic, assign) DataType type;
@property (nonatomic, retain, readwrite) MaterialUsage *materialUsage;
@property (nonatomic, assign) int location_type_id;
@property (nonatomic, retain, readwrite) Appointment *Appointment;
@property (nonatomic, retain, readwrite) NSNumber *customer_id;
@property (nonatomic, assign) BOOL is_multiple_choice_enable;

@property (nonatomic ,retain) UITableView * table;
@property (nonatomic, retain, readwrite) NSMutableArray *existing_items;

@property (nonatomic, copy) DataSelectionOrAddedBlock dataSelectionBlock;

+ (DataTableViewController*) tableWithDataType:(DataType) type andDelegate:(id<DataSelectionDelegate>) del;

+ (DataTableViewController*) tableWithDataType:(DataType) type andDelegate:(id<DataSelectionDelegate>) del withMultipleChoices:(BOOL) chioices;

- (void) multipleChoiceDoneClicked;

@end
