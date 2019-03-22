    //
    //  TrapListController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 12/02/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "TrapListController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import "TrapDetailViewController.h"
#import "DeviceArea.h"
#import "DeviceManager.h"

@implementation TrapListController
@synthesize Traplisttable=_Traplisttable;
@synthesize segment=_segment;
@synthesize resultImage;
@synthesize isChecked=_isChecked;


+ (TrapListController*) initWithAppointment:(Appointment*) app {
    TrapListController * trap;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        trap = [[TrapListController alloc] initWithNibName:@"TrapListView_IPad" bundle:nil];
    }else{
        trap = [[TrapListController alloc] initWithNibName:@"TrapListView" bundle:nil];
    }
    trap.title = @"Devices";
    trap.Appointment = app;
    trap.selectedArea = nil;
    return trap;
}

+ (TrapListController*) initWithAppointment:(Appointment*) app deviceAreaId:(int)deviceAreaId {
    TrapListController * trap;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        trap = [[TrapListController alloc] initWithNibName:@"TrapListView_IPad" bundle:nil];
    }else{
        trap = [[TrapListController alloc] initWithNibName:@"TrapListView" bundle:nil];
    }
    trap.title = @"Devices";
    trap.Appointment = app;
    if (deviceAreaId != -1) {
        trap.selectedArea = [DeviceArea deviceAreaById:deviceAreaId];
    }
    trap.selectedAreaId = deviceAreaId;
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
    
    _checkedList = [[NSMutableArray alloc] init];
    _unCheckedList = [[NSMutableArray alloc] init];
    
    NSMutableArray *traps = [CustomerDevice devicesByServiceLocationId:self.Appointment.service_location_id];
    NSMutableArray *deviceAreas = [NSMutableArray arrayWithArray:[DeviceArea getAllDeviceAreas]];
    
    for (CustomerDevice *device in traps) {
        BOOL is_checked = NO;
        BOOL isInArea = YES;
        
        if (self.selectedAreaId == -1) {
            for (DeviceArea *deviceArea in deviceAreas) {
                if (deviceArea.entity_id == device.device_area_id) {
                    isInArea = NO;
                }
            }
            
        } else {
            if (self.selectedArea != nil && self.selectedArea.entity_id == device.device_area_id) {
                isInArea = YES;
            } else if (self.selectedArea == nil) {
                isInArea = YES;
            } else {
                isInArea = NO;
            }
        }
        
        for (InspectionRecord *ir in self.Appointment.inspection_records) {
            if ([ir.barcode isEqualToString:device.barcode]) {
                NSLog(@"Device ID : %@ --- Barcode : %@", device.entity_id, ir.barcode);
                is_checked = YES;
                break;
            }
        }
        
        if (is_checked && isInArea) {
            [_checkedList addObject:device];
        }else if (isInArea) {
            [_unCheckedList addObject:device];
        }
    }
    _unCheckedList = [self getSortedList:_unCheckedList];
    [ self.Traplisttable reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (self.segment.selectedSegmentIndex == 0) {
            return _searchUnCheckedList.count;
        }else{
            return _searchCheckedList.count;
        }
    }else{
        if (self.segment.selectedSegmentIndex == 0) {
            return _unCheckedList.count;
        }else{
            return _checkedList.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TrapListTableViewCell *cell = (TrapListTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil || cell.tag == -1010)
        {
        @autoreleasepool {
            __weak NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"TrapListTableViewCell" owner:self options:nil];
            
            for(id materialCurrentObject in topLevelObject)
                {
                if([materialCurrentObject isKindOfClass:[UITableViewCell class]])
                    {
                    cell = (TrapListTableViewCell*) materialCurrentObject;
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                }
        }
        }
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (self.segment.selectedSegmentIndex == 0) {
            CustomerDevice *trap = [_searchUnCheckedList objectAtIndex:indexPath.row];
                //        cell.textLabel.text=trap.barcode;
            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap.number != nil ? trap.number : @""];
            cell.lblBarcode.text = trap.barcode;
            cell.lblFrequency.text = trap.service_frequency != nil ? trap.service_frequency : @"";
            cell.lblLocationDetails.text = trap.location_details != nil ? trap.location_details : @"";
        }
        else
            {
            CustomerDevice *trap1 = [_searchCheckedList objectAtIndex:indexPath.row];
                //        cell.textLabel.text=trap1.barcode;
            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap1.number != nil ? trap1.number : @""];
            cell.lblBarcode.text = trap1.barcode;
            cell.lblFrequency.text = trap1.service_frequency != nil ? trap1.service_frequency : @"";
            cell.lblLocationDetails.text = trap1.location_details != nil ? trap1.location_details : @"";
            }
    }else{
        if (self.segment.selectedSegmentIndex == 0) {
            CustomerDevice *trap = [_unCheckedList objectAtIndex:indexPath.row];
            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap.number != nil ? trap.number : @""];
            cell.lblBarcode.text = trap.barcode;
            cell.lblFrequency.text = trap.service_frequency != nil ? trap.service_frequency : @"";
            cell.lblLocationDetails.text = trap.location_details != nil ? trap.location_details : @"";
        }
        else
            {
            CustomerDevice *trap1 = [_checkedList objectAtIndex:indexPath.row];
            cell.lblId.text = [NSString stringWithFormat:@"ID# %@", trap1.number != nil ? trap1.number : @""];
            cell.lblBarcode.text = trap1.barcode;
            cell.lblFrequency.text = trap1.service_frequency != nil ? trap1.service_frequency : @"";
            cell.lblLocationDetails.text = trap1.location_details != nil ? trap1.location_details : @"";
            }
        
    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomerDevice *ctrap = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (self.segment.selectedSegmentIndex == 0) {
            ctrap = [_searchUnCheckedList objectAtIndex:indexPath.row];
        }else{
            ctrap = [_searchCheckedList objectAtIndex:indexPath.row];
        }
    }else{
        if (self.segment.selectedSegmentIndex == 0) {
            ctrap = [_unCheckedList objectAtIndex:indexPath.row];
        }else{
            ctrap = [_checkedList objectAtIndex:indexPath.row];
        }
    }
    if (self.segment.selectedSegmentIndex == 0) {
        _isChecked=YES;
        TrapDetailViewController *vc = [TrapDetailViewController initWithAppointment:self.Appointment withCustomerTrap:ctrap];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        InspectionRecord *record = [InspectionRecord inspectionWithBarcode:ctrap.barcode appointment:self.Appointment];
        if (record) {
            TrapInspectionViewController *vc = [TrapInspectionViewController initWithAppointment:self.Appointment withInspection:record];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}

- (IBAction) scanButtonTapped
{
    _reader = [[BarcodeScanerViewController alloc] init];
    _reader.delegate = self;
    [self presentViewController:_reader animated:YES completion:^{
        
    }];
}

#pragma mark - BarcodeScanerViewControllerDelegate
- (void)barcodeScanerViewControllerDidScan:(NSString *)barcode {
    [_reader dismissViewControllerAnimated:YES completion:^{
        CustomerDevice * trap = [CustomerDevice deviceByBarcode:barcode andService_location:self.Appointment.service_location_id];
        
        if (trap == nil) {
            trap = [CustomerDevice newDeviceForCustomer:self.Appointment.customer_id forServiceLocaiton:self.Appointment.service_location_id];
            [trap setBarcode:barcode];
            TrapAddController * trapadd = [TrapAddController initWithAppointment:self.Appointment withCustomerTrap:(CustomerDevice*) trap];
            [self.navigationController pushViewController:trapadd animated:YES];
            
        }else{
            _customerTrap = trap;
            
            if (_checkedList) {
                for (CustomerDevice *trp in _checkedList) {
                    if ([_customerTrap.barcode isEqualToString:trp.barcode]) {
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork"
                                                                         message:@"That device has already been inspected."
                                                                        delegate:nil
                                                               cancelButtonTitle:@"Ok"
                                                               otherButtonTitles:nil];
                        [alert show];
                        return;
                    }
                }
            }
            TrapInspectionViewController *vc = [TrapInspectionViewController initWithAppointment:self.Appointment withTrap:trap];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
}

#pragma mark -

-(IBAction) segmentedControlIndexChanged
{
    switch (self.segment.selectedSegmentIndex) {
        case 0:
            
            _unCheckedList = [self getSortedList:_unCheckedList];
            
            [self.Traplisttable reloadData];
            break;
        case 1:
            _checkedList = [self getSortedList:_checkedList];
            [self.Traplisttable reloadData];
            break;
        default:
            break;
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if (self.segment.selectedSegmentIndex == 0) {
        
        _searchUnCheckedList = [[NSMutableArray alloc]init];
        NSPredicate *predicate = nil;
        predicate = [NSPredicate predicateWithFormat:@"number contains[cd] %@ OR barcode contains[cd] %@", searchText,searchText];
        _searchUnCheckedList = [[_unCheckedList filteredArrayUsingPredicate:predicate]mutableCopy];
    }else{
        _searchCheckedList = [[NSMutableArray alloc]init];
        
        NSPredicate *predicate = nil;
        predicate = [NSPredicate predicateWithFormat:@"number contains[cd] %@ OR barcode contains[cd] %@", searchText,searchText];
        _searchCheckedList = [[_checkedList filteredArrayUsingPredicate:predicate]mutableCopy];
        
    }
    [_Traplisttable reloadData];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
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
