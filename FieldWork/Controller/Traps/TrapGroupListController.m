    //
    //  TrapListController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 12/02/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "TrapGroupListController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import "TrapDetailViewController.h"
#import "TrapListController.h"
#import "DeviceArea.h"

@implementation TrapGroupListController
@synthesize Traplisttable=_Traplisttable;
@synthesize segment=_segment;
@synthesize resultImage;
@synthesize isChecked=_isChecked;


+ (TrapGroupListController*) initWithAppointment:(Appointment*) app{
    TrapGroupListController * trap;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        trap = [[TrapGroupListController alloc] initWithNibName:@"TrapListGroupView_IPad" bundle:nil];
    }else{
        trap = [[TrapGroupListController alloc] initWithNibName:@"TrapListGroupView" bundle:nil];
    }
    trap.title = @"Devices";
    trap.Appointment=app;
    return trap;
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadTable];
    [ self.Traplisttable reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTable) name:@"ReloadTrapListTable" object:nil];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadTable {
    areaList = [[NSMutableArray alloc] init];
    
    NSMutableArray *traps = [CustomerDevice devicesByServiceLocationId:self.Appointment.service_location_id];
    NSMutableArray *deviceAreas = [NSMutableArray arrayWithArray:[DeviceArea getAllDeviceAreas]];
    
    for (DeviceArea *area in deviceAreas) {
        BOOL hasArea = NO;
        for (CustomerDevice *checkedDevice in traps) {
            if (checkedDevice.device_area_id == area.entity_id) {
                hasArea = YES;
            }
        }
        
        if (hasArea == YES) {
            [areaList addObject:area];
        }
    }
    
    for (CustomerDevice *checkedDevice in traps) {
        BOOL isNoArea = YES;
        for (DeviceArea *area in deviceAreas) {
            if (checkedDevice.device_area_id == area.entity_id) {
                isNoArea = NO;
            }
        }
        if (isNoArea == YES) {
            NSObject *area = [[NSObject alloc] init];
            [areaList addObject:area];
            break;
        }
    }
    
    [ self.Traplisttable reloadData];
}

- (int) getAreaDeviceCount: (DeviceArea*)deviceArea {
    NSMutableArray *traps = [CustomerDevice devicesByServiceLocationId:self.Appointment.service_location_id];
    int count = 0;
    if (![deviceArea isKindOfClass:[NSManagedObject class]]) {
        NSMutableArray *deviceAreas = [NSMutableArray arrayWithArray:[DeviceArea getAllDeviceAreas]];
        for (CustomerDevice *checkedDevice in traps) {
            BOOL isNoArea = YES;
            for (DeviceArea *area in deviceAreas) {
                if (checkedDevice.device_area_id == area.entity_id) {
                    isNoArea = NO;
                }
            }
            if (isNoArea == YES) {
                count = count + 1;
            }
        }
    } else {
        for (CustomerDevice *checkedDevice in traps) {
            if (deviceArea.entity_id == checkedDevice.device_area_id) {
                count = count + 1;
            }
        }
        
        
    }
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return areaList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.accessoryType = UITableViewCellStyleSubtitle;
    
    DeviceArea* area = [areaList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [area isKindOfClass:[NSManagedObject class]] ? area.name : @"No Area";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [self getAreaDeviceCount: area]];
    
    return cell;
//    static NSString *CellIdentifier = @"Cell";
//
//
//    TrapListTableViewCell *cell = (TrapListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil || cell.tag == -1010)
//        {
//        @autoreleasepool {
//            __weak NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"TrapListTableViewCell" owner:self options:nil];
//
//            for(id materialCurrentObject in topLevelObject)
//                {
//                if([materialCurrentObject isKindOfClass:[UITableViewCell class]])
//                    {
//                    cell = (TrapListTableViewCell*) materialCurrentObject;
//                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                    }
//                }
//        }
//        }
//
//
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        if (self.segment.selectedSegmentIndex == 0) {
//            CustomerDevice *trap = [_searchUnCheckedList objectAtIndex:indexPath.row];
//                //        cell.textLabel.text=trap.barcode;
//            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap.number != nil ? trap.number : @""];
//            cell.lblBarcode.text = trap.barcode;
//            cell.lblFrequency.text = trap.service_frequency != nil ? trap.service_frequency : @"";
//            cell.lblLocationDetails.text = trap.location_details != nil ? trap.location_details : @"";
//        }
//        else
//            {
//            CustomerDevice *trap1 = [_searchCheckedList objectAtIndex:indexPath.row];
//                //        cell.textLabel.text=trap1.barcode;
//            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap1.number != nil ? trap1.number : @""];
//            cell.lblBarcode.text = trap1.barcode;
//            cell.lblFrequency.text = trap1.service_frequency != nil ? trap1.service_frequency : @"";
//            cell.lblLocationDetails.text = trap1.location_details != nil ? trap1.location_details : @"";
//            }
//    }else{
//        if (self.segment.selectedSegmentIndex == 0) {
//            CustomerDevice *trap = [_unCheckedList objectAtIndex:indexPath.row];
//            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap.number != nil ? trap.number : @""];
//            cell.lblBarcode.text = trap.barcode;
//            cell.lblFrequency.text = trap.service_frequency != nil ? trap.service_frequency : @"";
//            cell.lblLocationDetails.text = trap.location_details != nil ? trap.location_details : @"";
//        }
//        else
//            {
//            CustomerDevice *trap1 = [_checkedList objectAtIndex:indexPath.row];
//            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap1.number != nil ? trap1.number : @""];
//            cell.lblBarcode.text = trap1.barcode;
//            cell.lblFrequency.text = trap1.service_frequency != nil ? trap1.service_frequency : @"";
//            cell.lblLocationDetails.text = trap1.location_details != nil ? trap1.location_details : @"";
//            }
//
//    }
    
//    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DeviceArea *deviceArea = nil;
    
    deviceArea = [areaList objectAtIndex:indexPath.row];
    TrapListController *vc = nil;
    if ([deviceArea isKindOfClass:[NSManagedObject class]]) {
        vc = [TrapListController initWithAppointment:self.Appointment deviceAreaId: [deviceArea.entity_id intValue]];
    } else {
        vc = [TrapListController initWithAppointment:self.Appointment deviceAreaId:-1];
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

}

    // Called when we cancel a view (eg. the user clicks the Home button). This is not called when the user clicks the cancel button.
    // If not defined in the delegate, we simulate a click in the cancel button
- (void)alertViewCancel:(UIAlertView *)alertView
{
    
}

#pragma mark -getSortedList

-(NSMutableArray *)getSortedList:(NSMutableArray *)arr{
    
    NSArray *result = [arr sortedArrayUsingComparator: ^(CustomerDevice * obj1, CustomerDevice * obj2) {
        
        if ([[obj1.number class] isEqual:[obj2.number class]]) {
            return (NSComparisonResult)[obj1.number compare:obj2.number];
        }
        
        if ([obj2.number isKindOfClass:[NSNumber class]] && [obj1.number isKindOfClass:[NSString class]]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1.number isKindOfClass:[NSNumber class]] && [obj2.number isKindOfClass:[NSString class]]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        
        return NSOrderedSame;
    }];
    
    return [result mutableCopy];
}
@end
