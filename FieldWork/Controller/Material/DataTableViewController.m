//
//  DataTableViewController.m
//  FieldWork
//
//  Created by Samir Kha on 29/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DataTableViewController.h"
#import "Constants.h"
#import "DataTableViewCell.h"
#import "UnitStatus.h"
#import "Payment.h"
#import "PestsAddController.h"

@implementation DataTableViewController
@synthesize table;

@synthesize type = _type;
@synthesize delegate = _delegate;
@synthesize materialUsage;
@synthesize location_type_id;
@synthesize Appointment;
@synthesize dataArray = _dataArray;
@synthesize is_multiple_choice_enable = _is_multiple_choice_enable;
@synthesize existing_items = _existing_items;
@synthesize customer_id;

+ (DataTableViewController *)tableWithDataType:(DataType)type andDelegate:(id<DataSelectionDelegate>)del {
    return [DataTableViewController tableWithDataType:type andDelegate:del withMultipleChoices:NO];
}

+ (DataTableViewController *)tableWithDataType:(DataType)type andDelegate:(id<DataSelectionDelegate>)del withMultipleChoices:(BOOL)chioices {
    DataTableViewController *dt = [[DataTableViewController alloc] initWithNibName:@"DataTableView" bundle:nil];
    dt.delegate = del;
    dt.type = type;
    dt.is_multiple_choice_enable = chioices;
    return dt;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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

    UINib* cellNib = [UINib nibWithNibName:@"DataTableViewCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"Cell"];

    self.dataArray = [[NSMutableArray alloc] init];
    BOOL loadingNeeded = NO;
    if (self.type == DilutionRate) {
        self.dataArray = [[[DilutionRates fetchAll] sortUsingKey:@"name"] mutableCopy];
        self.navigationItem.title = @"Dilution rates";
    } else if (self.type == AppMethod) {
        self.dataArray = [[[ApplicationMethods fetchAll] sortUsingKey:@"methodName"] mutableCopy];
        self.navigationItem.title = @"Methods";
    }else if (self.type == UnitType) {
        self.dataArray = [[[Measurements fetchAll] sortUsingKey:@"measurement"] mutableCopy];
        self.navigationItem.title = @"Measurements";
    }else if(self.type == LocationEnum){
        
        self.dataArray = [[[LocationType getLocationAreasByLocationTypeId:self.location_type_id] sortUsingKey:@"location_area_name" ] mutableCopy];
        [self printLog];
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewLocationArea)];        
        self.navigationItem.rightBarButtonItem = addBtn;
        self.navigationItem.title = @"Location Areas";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadLocationAreaList) name:@"Notification_LocationAdded" object:nil];
    }else if (self.type == TargetPestEnum){
        self.dataArray = [[[Pest fetchAll] sortUsingKey:@"name"] mutableCopy];
        UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTargetPests)];
        self.navigationItem.rightBarButtonItem = addBtn;
        self.navigationItem.title = @"Pest Types";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPestsList) name:@"Notification_PestAdded" object:nil];
    } else  if (self.type == FlatTypesList){
        self.dataArray = [[[FlatType fetchAll] sortUsingKey:@"name"] mutableCopy];
        self.navigationItem.title = @"Unit Types";
    } else if (self.type == DeviceTypeEnum){
        self.dataArray = [[[DeviceTypes fetchAll] sortUsingKey:@"device_name"] mutableCopy];
        self.navigationItem.title = @"Device Types";
    } else if (self.type == TrapTypeEnum){
        self.dataArray = [[[TrapTypes fetchAll] sortUsingKey:@"trap_type_name"] mutableCopy];
        self.navigationItem.title = @"Trap Types";
    } else if (self.type == TrapConditionEnum){
        self.dataArray = [[[TrapConditions fetchAll] sortUsingKey:@"trap_condition_name"] mutableCopy];
        self.navigationItem.title = @"Trap Conditions";
    } else if (self.type == BaitConditionEnum){
        self.dataArray = [[[BaitConditions fetchAll] sortUsingKey:@"bait_condition_name"] mutableCopy];
        self.navigationItem.title = @"Bait Conditions";
    } else if (self.type == AddLineItem){
         [self.dataArray addObject:@"Service"];
         [self.dataArray addObject:@"Material"];
         [self.dataArray addObject:@"Other"];
        self.navigationItem.title = @"Add Line Item";
    } else if (self.type == LineItemServices){
        self.dataArray = [[[Services fetchAll] sortUsingKey:@"service_description"] mutableCopy];
        self.navigationItem.title = @"Services";
    } else if (self.type == ServiceRoutesList){
        self.dataArray = [[[ServiceRoutes fetchAll] sortUsingKey:@"service_route_name"] mutableCopy];
        self.navigationItem.title = @"Service Routes";
    } else if (self.type == WindDirection) {
        self.dataArray = [WIND_DIRECTIONS mutableCopy] ;
        self.navigationItem.title = @"Wind Direction";
    } else if (self.type == RecommendationsList){
        self.dataArray = [[[Recommendations fetchAll] sortUsingKey:@"name"] mutableCopy];
        self.navigationItem.title = @"Recommendations";
    } else if (self.type == UnitStatusList){
        self.dataArray = [[[UnitStatus fetchAll] sortUsingKey:@"name"] mutableCopy];
        self.navigationItem.title = @"Unit Statuses";
    } else if (self.type == FlatConditionsList){
        self.dataArray = [[[FlatConditions fetchAll] sortUsingKey:@"name"] mutableCopy];
        self.navigationItem.title = @"Unit Conditions";
    } else if (self.type == ConditionsList){
        self.dataArray = [[[Conditions fetchAll] sortUsingKey:@"name"] mutableCopy];
        self.navigationItem.title = @"Conditions";
    } else if (self.type == PaymentMethod) {
        NSAssert(self.customer_id != nil, @"Customer ID can not be nil");
        loadingNeeded = YES;
        __block Customer *customer = [Customer getById:self.customer_id];
        if (customer) {
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
            [customer loadPaymentMethods:^(id result, NSString *error) {
                [[ActivityIndicator currentIndicator] displayCompleted];
                self.dataArray = [[customer.payment_methods sortUsingKey:@"name" ] mutableCopy];
                [self initData];
                [self.tableView reloadData];
            }];
            
        }
        self.navigationItem.title = @"Payment Methods";
    }
    
    if (self.is_multiple_choice_enable == YES) {
        _selected_items = [[NSMutableArray alloc] init];
        NSMutableArray *items = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(multipleChoiceDoneClicked)];
        //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(multipleChoiceDoneClicked)];
        [items insertObject:rightButton atIndex:0];
        self.navigationItem.rightBarButtonItems=items;
    }
    
    [super viewDidLoad];
    if (!loadingNeeded) {
        [self initData];
    }
//    [self.filteredListContent addObjectsFromArray:self.dataArray];
//    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.dataArray count]];
//    if (self.savedSearchTerm)
//    {
//        [self.searchDisplayController setActive:self.searchWasActive];
//        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
//        [self.searchDisplayController.searchBar setText:_savedSearchTerm];
//        
//        self.savedSearchTerm = nil;
//    }
//    if (self.type == RecommendationsList || self.type == TargetPestEnum || self.type == LocationEnum) {
//        _selected_items = [_existing_items mutableCopy];
//    }
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    

}

- (void)initData {
    [self.filteredListContent addObjectsFromArray:self.dataArray];
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.dataArray count]];
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:_savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    if (self.type == RecommendationsList || self.type == TargetPestEnum || self.type == LocationEnum) {
        _selected_items = [_existing_items mutableCopy];
    }
    

}

-(void)printLog{
    for (LocationArea *typ in self.dataArray) {
        NSLog(@"Entity Id %@",typ.entity_id);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self isMovingToParentViewController]) {
        self.dataArray = nil;
        self.type = nil;
        self.view = nil;
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)multipleChoiceDoneClicked {
    if (self.delegate) {
        [self.delegate DataSelectedForData:_selected_items andType:self.type];
    }
    if (self.dataSelectionBlock)
    {
        self.dataSelectionBlock(_selected_items);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadLocationAreaList{
   
     self.dataArray = [[LocationType getLocationAreasByLocationTypeId:self.location_type_id] mutableCopy];
    
     [self.tableView reloadData];
}

- (void) loadPestsList{
    
    self.dataArray = [[[Pest fetchAll] sortUsingKey:@"name"] mutableCopy];
    
    [self.tableView reloadData];
}

- (void) addNewLocationArea{
    AddLocationAreaController *al = [AddLocationAreaController viewControllerWithAppointment:self.Appointment];
    [self.navigationController pushViewController:al animated:YES];
}

-(void)addTargetPests
{
    PestsAddController *pa = [PestsAddController viewControllerWithAppointment:self.Appointment];
    [self.navigationController pushViewController:pa animated:YES];
    pa = nil;
}

- (BOOL) isExistInExistingList:(id) item
{
    if (_is_multiple_choice_enable == YES) {
        if (self.existing_items) {
            if (self.type == ServiceRoutesList) {
                
                ServiceRoutes *ex_item = (ServiceRoutes*)item;
                for (ServiceRoutes *sr in _existing_items) {
                    if ([sr.service_route_name isEqualToString:ex_item.service_route_name]) {
                        return YES;
                    }
                }
            }else if (self.type == RecommendationsList) {
                Recommendations *rec = (Recommendations*)item;
                for (Recommendations *rr in _existing_items) {
                    if ([rec.entity_id isEqualToNumber:rr.entity_id]) {
                        return YES;
                    }
                }
            } else if (self.type == ConditionsList) {
                Conditions *rec = (Conditions*)item;
                for (Conditions *rr in _existing_items) {
                    if ([rec.entity_id isEqualToNumber:rr.entity_id]) {
                        return YES;
                    }
                }
            } else if (self.type == TargetPestEnum) {
                Pest *p = (Pest*)item;
                for (NSNumber *num in _existing_items) {
                    if ([p.entity_id isEqualToNumber:num]) {
                        return YES;
                    }
                }
            } else if (self.type == LocationEnum) {
                LocationArea *la = (LocationArea*)item;
                for (NSNumber *num in _existing_items) {
                    if ([la.entity_id isEqualToNumber:num]) {
                        return YES;
                    }
                }
            }
        }
    }
    return NO;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{       // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
         return [self.filteredListContent count];
    }else{
         return [self.dataArray count];
    }
    // Return the number of rows in the section.
   // return self.dataArray.count;
   

}

- (DataTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     //self.dataArray = [LocationType getLocationAreasByLocationTypeId:self.location_type_id];
    
    static NSString *CellIdentifier = @"Cell";
    
    
    DataTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DataTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (self.type == DilutionRate) {
            DilutionRates *dr = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = dr.name;
            if ([_selected_items containsObject:dr.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == AppMethod) {
            ApplicationMethods *am = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = am.methodName;
            if ([_selected_items containsObject:am]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
        }else if (self.type == UnitType) {
            Measurements *m = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = m.measurement;
            if ([_selected_items containsObject:m.measurement]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }else if(self.type == LocationEnum){
            LocationArea *laa = [self.filteredListContent objectAtIndex:[indexPath row]];
            //NSLog(@"Data :%@      %@",laa.location_area_id,laa.location_area_name);
            cell.label.text = laa.location_area_name;
//            if ([self isExistInExistingList:laa] == YES) {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                [_selected_items addObject:laa];
//            }else{
                if ([_selected_items containsObject:laa.entity_id]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
           // }
        }else if (self.type == TargetPestEnum){
            Pest *tp = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = tp.name;
//            if ([self isExistInExistingList:tp] == YES) {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                [_selected_items addObject:tp];
//            }else{
                if ([_selected_items containsObject:tp.entity_id]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
           // }
        }else if (self.type == DeviceTypeEnum){
            DeviceTypes *device = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = device.device_name;
            if ([_selected_items containsObject:device.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == TrapTypeEnum){
            TrapTypes *tt = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = tt.trap_type_name;
            if ([_selected_items containsObject:tt.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == TrapConditionEnum){
            TrapConditions *tc = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = tc.trap_condition_name;
            if ([_selected_items containsObject:tc.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == BaitConditionEnum){
            BaitConditions *bc = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = bc.bait_condition_name;
            if ([_selected_items containsObject:bc.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == AddLineItem){
            NSString *str = [_filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = str;
            if ([_selected_items containsObject:str]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == LineItemServices){
            Services *service = [_filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = service.service_description;
            if ([_selected_items containsObject:service]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == ServiceRoutesList){
            ServiceRoutes *sr = [_filteredListContent objectAtIndex:indexPath.row];
            NSLog(@"service_route_name : %@",sr.service_route_name);
            cell.label.text = sr.service_route_name;
            if ([self isExistInExistingList:sr] == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [_selected_items addObject:sr];
            }else{
                if ([_selected_items containsObject:sr]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        } else if (self.type == WindDirection){
            NSString *direction = [_filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = direction;
            if ([_selected_items containsObject:direction]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        } else if (self.type == RecommendationsList){
            Recommendations *rec = [_filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = rec.name;
//            if ([self isExistInExistingList:rec] == YES) {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                [_selected_items addObject:rec];
//            }else{
                if ([_selected_items containsObject:rec]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
          //  }
        } else if (self.type == ConditionsList){
            Conditions *obj = [_filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = obj.name;
            if ([self isExistInExistingList:obj] == YES) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [_selected_items addObject:obj];
            }else{
                if ([_selected_items containsObject:obj]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
            }
        } else if (self.type == PaymentMethod) {
            NSDictionary *dict = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = [dict objectForKey:@"name"];
            if ([_selected_items containsObject:dict]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
        }
        else if (self.type == FlatTypesList) {
            FlatType *obj = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = obj.name;
            if ([_selected_items containsObject:obj]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else if (self.type == UnitStatusList) {
            UnitStatus *obj = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = obj.name;
            if ([_selected_items containsObject:obj]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        else if (self.type == FlatConditionsList) {
            Conditions *obj = [self.filteredListContent objectAtIndex:indexPath.row];
            cell.label.text = obj.name;
            if ([_selected_items containsObject:obj]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
        

    }else
    // Configure the cell...
    if (self.type == DilutionRate) {
        DilutionRates *dr = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = dr.name;
        if ([_selected_items containsObject:dr.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else  if (self.type == FlatTypesList) {
        FlatType *dr = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = dr.name;
        if ([_selected_items containsObject:dr.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else  if (self.type == UnitStatusList) {
        UnitStatus *dr = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = dr.name;
        if ([_selected_items containsObject:dr.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    } else  if (self.type == FlatConditionsList) {
        FlatConditions *dr = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = dr.name;
        if ([_selected_items containsObject:dr.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    } else if (self.type == AppMethod) {
        ApplicationMethods *am = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = am.methodName;
        if ([_selected_items containsObject:am]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
       
    }else if (self.type == UnitType) {
        Measurements *m = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = m.measurement;
        if ([_selected_items containsObject:m.measurement]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else if(self.type == LocationEnum){
        LocationArea *laa = [self.dataArray objectAtIndex:[indexPath row]];
        //NSLog(@"Data :%@      %@",laa.location_area_id,laa.location_area_name);
        cell.label.text = laa.location_area_name;
//        if ([self isExistInExistingList:laa] == YES) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            [_selected_items addObject:laa];
//        }else{
            if ([_selected_items containsObject:laa.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
    //    }
    }else if (self.type == TargetPestEnum){
        Pest *tp = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = tp.name;
//        if ([self isExistInExistingList:tp] == YES) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            [_selected_items addObject:tp];
//        }else{
            if ([_selected_items containsObject:tp.entity_id]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
       // }
    }else if (self.type == DeviceTypeEnum){
        DeviceTypes *device = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = device.device_name;
        if ([_selected_items containsObject:device.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (self.type == TrapTypeEnum){
        TrapTypes *tt = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = tt.trap_type_name;
        if ([_selected_items containsObject:tt.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (self.type == TrapConditionEnum){
        TrapConditions *tc = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = tc.trap_condition_name;
        if ([_selected_items containsObject:tc.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

    } else if (self.type == BaitConditionEnum){
        BaitConditions *bc = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = bc.bait_condition_name;
        if ([_selected_items containsObject:bc.entity_id]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (self.type == AddLineItem){
        NSString *str = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = str;
        if ([_selected_items containsObject:str]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (self.type == LineItemServices){
        Services *service = [_dataArray objectAtIndex:indexPath.row];
        cell.label.text = service.service_description;
        if ([_selected_items containsObject:service]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (self.type == ServiceRoutesList){
        ServiceRoutes *sr = [_dataArray objectAtIndex:indexPath.row];
        NSLog(@"service_route_name : %@",sr.service_route_name);
        cell.label.text = sr.service_route_name;
        if ([self isExistInExistingList:sr] == YES) {
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if (![_selected_items containsObject:sr]) {
                [_selected_items addObject:sr];
            }

        }else{
            if ([_selected_items containsObject:sr]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    } else if (self.type == WindDirection){
        NSString *direction = [_dataArray objectAtIndex:indexPath.row];
        cell.label.text = direction;
        if ([_selected_items containsObject:direction]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if (self.type == RecommendationsList){
        Recommendations *rec = [_dataArray objectAtIndex:indexPath.row];
        cell.label.text = rec.name;
//        if ([self isExistInExistingList:rec] == YES) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            [_selected_items addObject:rec];
//        }else{
            if ([_selected_items containsObject:rec]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
       // }
    } else if (self.type == ConditionsList){
        
        Conditions *rec = [_dataArray objectAtIndex:indexPath.row];
        cell.label.text = rec.name;
        if ([self isExistInExistingList:rec] == YES) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            if (![_selected_items containsObject:rec]) {
                [_selected_items addObject:rec];
            }
            
        }else{
                if ([_selected_items containsObject:rec]) {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
        }
    } else if (self.type == PaymentMethod) {
        NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
        cell.label.text = [dict objectForKey:@"name"];
        if ([_selected_items containsObject:dict]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell) {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    
    id data = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (self.type == DilutionRate) {
            DilutionRates *dr = [self.filteredListContent objectAtIndex:indexPath.row];
            data = dr.entity_id;
            
        } else if (self.type == AppMethod) {
            ApplicationMethods *am = [self.filteredListContent objectAtIndex:indexPath.row];
            data = am;
        }else if (self.type == UnitType) {
            Measurements *m = [self.filteredListContent objectAtIndex:indexPath.row];
            data = m.measurement;
        } else if(self.type == LocationEnum){
            LocationArea *la = [self.filteredListContent objectAtIndex:indexPath.row];
            data = la.entity_id;
        } else if (self.type == TargetPestEnum){
            Pest *tp = [self.filteredListContent objectAtIndex:indexPath.row];
            NSLog(@"list = %@", tp.entity_id);
            data = tp.entity_id;
        } else if (self.type == DeviceTypeEnum){
            DeviceTypes *device = [self.dataArray objectAtIndex:indexPath.row];
            data = device.entity_id;
        } else if (self.type == TrapTypeEnum){
            TrapTypes *tt = [self.filteredListContent objectAtIndex:indexPath.row];
            data = tt.entity_id;
        } else if (self.type == TrapConditionEnum){
            TrapConditions *tc = [self.filteredListContent objectAtIndex:indexPath.row];
            data = tc.entity_id;
        } else if (self.type == BaitConditionEnum){
            BaitConditions *bc = [self.filteredListContent objectAtIndex:indexPath.row];
            data = bc.entity_id;
        } else if (self.type == AddLineItem){
            data = [_filteredListContent objectAtIndex:indexPath.row];
        } else if (self.type == LineItemServices){
            data = [_filteredListContent objectAtIndex:indexPath.row];
        } else if (self.type == ServiceRoutesList){
            data = [_filteredListContent objectAtIndex:indexPath.row];
        } else if (self.type == WindDirection){
            data = [_filteredListContent objectAtIndex:indexPath.row];
        } else if (self.type == RecommendationsList){
            data = [_filteredListContent objectAtIndex:indexPath.row];
        } else if (self.type == ConditionsList){
            data = [_filteredListContent objectAtIndex:indexPath.row];
        } else if (self.type == PaymentMethod) {
            data = [_filteredListContent objectAtIndex:indexPath.row];
        }
    }else{
    if (self.type == DilutionRate) {
        DilutionRates *dr = [self.dataArray objectAtIndex:indexPath.row];
        data = dr.entity_id;
        
    } else if (self.type == AppMethod) {
        ApplicationMethods *am = [self.dataArray objectAtIndex:indexPath.row];
        data = am;
    }else if (self.type == UnitType) {
        Measurements *m = [self.dataArray objectAtIndex:indexPath.row];
        data = m.measurement;
    } else if(self.type == LocationEnum){
        LocationArea *la = [self.dataArray objectAtIndex:indexPath.row];
        data = la.entity_id;
    } else if (self.type == TargetPestEnum){
        Pest *tp = [self.dataArray objectAtIndex:indexPath.row];
        data = tp.entity_id;
    } else if (self.type == DeviceTypeEnum){
        DeviceTypes *device = [self.dataArray objectAtIndex:indexPath.row];
        data = device.entity_id;
    } else if (self.type == TrapTypeEnum){
        TrapTypes *tt = [self.dataArray objectAtIndex:indexPath.row];
        data = tt.entity_id;
    } else if (self.type == TrapConditionEnum){
        TrapConditions *tc = [self.dataArray objectAtIndex:indexPath.row];
        data = tc.entity_id;
    } else if (self.type == BaitConditionEnum){
        BaitConditions *bc = [self.dataArray objectAtIndex:indexPath.row];
        data = bc.entity_id;
    } else if (self.type == AddLineItem){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == LineItemServices){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == ServiceRoutesList){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == WindDirection){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == RecommendationsList){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == ConditionsList){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == PaymentMethod) {
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == FlatTypesList){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == UnitStatusList){
        data = [_dataArray objectAtIndex:indexPath.row];
    } else if (self.type == FlatConditionsList){
        data = [_dataArray objectAtIndex:indexPath.row];
    }
    }
    if (self.is_multiple_choice_enable == YES) {
        
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            if (data) [_selected_items addObject:data];
            
            [self setBarButtonTitle];
            
        }else{
            [_selected_items removeObject:data];
            [self setBarButtonTitle];
        }

    }else{
        if (self.delegate) {
            [self.delegate DataSelectedForData:data andType:self.type];
        }
        if (self.dataSelectionBlock)
        {
            self.dataSelectionBlock(data);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void) setBarButtonTitle {
    UIButton *cancelButton;
    UIView *topView = self.searchDisplayController.searchBar.subviews[0];
    for (UIView *subView in topView.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) {
            cancelButton = (UIButton*)subView;
        }
    }
    if (cancelButton) {
        if (_selected_items.count > 0) {
            [cancelButton setTitle:@"Done" forState:UIControlStateNormal];
        } else {
            [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        }
        
    }
}

#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    if (searchString.length > 0) {
        [self filterContentForSearchText:searchString scope:
         [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    }
    
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    [self searchByText:searchText];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row=indexPath.row;
    NSString* item=nil;
    if (self.type==RecommendationsList) {
        Recommendations* rec=[_dataArray objectAtIndex:row];
        item=rec.name;
    }
    else{
        if(self.type==ConditionsList){
            Conditions* con=[_dataArray objectAtIndex:row];
            item=con.name;
        }
        else
            return 44;
    }
    CGRect rect = TEXT_SIZE_BORDERS(item, 18,20,50,10,10);
    if (rect.size.height < 44) {
        return 44;
    }
    return rect.size.height+20;
}

-(void)searchByText:(NSString *)searchText{
    NSPredicate *predicate;
    if (self.type == DilutionRate) {
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == AppMethod) {
        predicate = [NSPredicate predicateWithFormat:@"methodName BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    }else if (self.type == UnitType) {
        predicate = [NSPredicate predicateWithFormat:@"measurement BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if(self.type == LocationEnum){
        predicate = [NSPredicate predicateWithFormat:@"location_area_name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == TargetPestEnum){
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == DeviceTypeEnum){
        predicate = [NSPredicate predicateWithFormat:@"device_name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == TrapTypeEnum){
        predicate = [NSPredicate predicateWithFormat:@"trap_type_name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == TrapConditionEnum){
        predicate = [NSPredicate predicateWithFormat:@"trap_condition_name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    }else if (self.type == BaitConditionEnum){
        predicate = [NSPredicate predicateWithFormat:@"bait_condition_name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == AddLineItem){
        predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    }else if (self.type == LineItemServices){
        predicate = [NSPredicate predicateWithFormat:@"service_description BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == ServiceRoutesList){
        predicate = [NSPredicate predicateWithFormat:@"service_route_name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == WindDirection){
        predicate = [NSPredicate predicateWithFormat:@"self BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == RecommendationsList){
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == ConditionsList){
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == PaymentMethod) {
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == FlatTypesList) {
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    } else if (self.type == UnitStatusList) {
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    }else if (self.type == FlatConditionsList) {
        predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
        self.filteredListContent  = [NSMutableArray arrayWithArray:[_dataArray filteredArrayUsingPredicate:predicate]];
    }


    
}

@end
