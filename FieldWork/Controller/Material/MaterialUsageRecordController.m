//
//  MaterialUsageRecordController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MaterialUsageRecordController.h"
#import "ServiceLocation.h"
#import "NewAppointMentsDetailViewController.h"
#import "UnitInspectionViewController.h"

@interface MaterialUsageRecordController () {
    NSNumberFormatter *formatter;
    NSMutableArray *dataLabels;
    MaterialUsageRecord *commonData;
}
@property (nonatomic, retain ,readwrite) NSMutableArray *selectedLocations;
@property (nonatomic, retain ,readwrite) NSMutableArray *selectedTargetPests;
@end


@implementation MaterialUsageRecordController

+ (MaterialUsageRecordController *)viewControllerWithAppointment:(Appointment *)app andMaterialUsage:(MaterialUsage *)musage{
    MaterialUsageRecordController *mu;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        mu = [[MaterialUsageRecordController alloc] initWithNibName:@"MaterialUsageRecordController_IPad" bundle:nil];
    }else{
        mu = [[MaterialUsageRecordController alloc] initWithNibName:@"MaterialUsageRecordController" bundle:nil];
        
    }
    mu.Appointment = app;
    mu.currentMaterialUsage = musage;
    mu.title = @"Material Usage";
    return mu;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.interactivePopGestureRecognizer addTarget:self action:@selector(discardChangesWithGesture:)];
    formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    Material *mat = [Material getById:self.currentMaterialUsage.material_id];
    _materialName.text = mat.name;
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    dataLabels = [[NSMutableArray alloc] initWithArray:@[
                                                         NSLocalizedString(@"Dilution Rate", @""),
                                                         NSLocalizedString(@"Qty", @""),
                                                         NSLocalizedString(@"Unit of Measure", @""),
                                                         NSLocalizedString(@"Device", @""),
                                                         NSLocalizedString(@"Method", @""),
                                                         NSLocalizedString(@"Lot #", @"")
                                                         ]];
    _tblMainData.delegate = self;
    _tblLocationAreas.delegate = self;
    [_tblMainData reloadData];
    if (self.currentMaterialUsage.material_usage_records != nil && self.currentMaterialUsage.material_usage_records.count > 0) {
        commonData = [self.currentMaterialUsage.material_usage_records allObjects].firstObject;
    }else{
        commonData = [MaterialUsageRecord newMaterialUsageRecord];
        NSNumber *default_dilution_rate = mat.default_dilution_rate_id;
        commonData.dilution_rate_id = default_dilution_rate;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        MaterialUsageRecord *record = (MaterialUsageRecord*)evaluatedObject;
        return (record.location_area_id && record.location_area_idValue != 0);
    }];
    NSArray *locationIds = [[[self.currentMaterialUsage.material_usage_records allObjects] filteredArrayUsingPredicate:predicate] valueForKey:@"location_area_id"];
    self.selectedLocations = locationIds.mutableCopy;
    // Show the total qty of all locations.
    if (self.selectedLocations.count > 0) {
        float qty = commonData.amountValue;
        float total_qty = qty * self.selectedLocations.count;
        commonData.amount = @(total_qty);
    }
    
    predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        MaterialUsageRecord *record = (MaterialUsageRecord*)evaluatedObject;
        return (record.location_area_id && record.location_area_idValue != 0);
    }];
    NSArray *pestIds = [[commonData.target_pests allObjects] valueForKey:@"pest_type_id"];
    self.selectedTargetPests = pestIds.mutableCopy;
    
    [_tblLocationAreas reloadData];
    //[self.locationTableExpander expand];
    //[self expandLocationTable];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self expandLocationTable];
    [self createBarButton];
}

-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveMaterialUsage:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

-(BOOL) navigationShouldPopOnBackButton
{
	[[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You have not saved this record, would you like to save before proceeding?"
							   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
	return NO;
}


- (void) expandLocationTable
{
    int ipadMargine = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        ipadMargine = 20;
    }
    
    constraintMainDataViewHeight.constant = 20 + (44 * 7) + ipadMargine;
    
//    _mainDataView.frame = CGRectMake(_mainDataView.frame.origin.x, _mainDataView.frame.origin.y, _mainDataView.frame.size.width, _tblMainData.frame.origin.y + _tblMainData.frame.size.height + 20);
    
    float table_height = 120;
    //float table_height = 120;
    //float location_table_y = _mainDataView.frame.origin.y + _mainDataView.frame.size.height + 30;
    table_height = table_height + (44 * ( self.selectedLocations.count == 0 ? 1 :  self.selectedLocations.count + 1)) + (44 * ( self.selectedTargetPests.count == 0 ? 1 :  self.selectedTargetPests.count + 1));
    //Customer *cust = [self.Appointment getCustomer];
    ServiceLocation *service_location = [self.Appointment getServiceLocation];
    constraintTableLocationAreasHeight.constant = table_height;
    _tblLocationAreas.scrollEnabled = NO;
    if (service_location.location_type_id <= 0) {
        //_tblLocationAreas.hidden = YES;
        
        //_tblLocationAreas.frame = CGRectMake(_tblLocationAreas.frame.origin.x, _tblLocationAreas.frame.origin.y, 0, 0);
        constraintTableLocationAreasHeight.constant = table_height;
//        _tblLocationAreas.frame = CGRectMake(_tblLocationAreas.frame.origin.x, _mainDataView.frame.origin.y + _mainDataView.frame.size.height - 50, [UIScreen mainScreen].bounds.size.width, table_height);
    }else{
        _tblLocationAreas.hidden = NO;
//        _tblLocationAreas.frame = CGRectMake(_tblLocationAreas.frame.origin.x, _mainDataView.frame.origin.y + _mainDataView.frame.size.height - 50, [UIScreen mainScreen].bounds.size.width, table_height);
    }
    
//    float save_button_y = _tblLocationAreas.frame.origin.y + _tblLocationAreas.frame.size.height-40;//10
//    btnSave.frame = CGRectMake(btnSave.frame.origin.x, save_button_y, btnSave.frame.size.width, btnSave.frame.size.height);
    
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width, _tblLocationAreas.frame.origin.y + _tblLocationAreas.frame.size.height + 30);
    [self.view layoutIfNeeded];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (MaterialUsageRecord*)createRecordWithCommonValuesInContext:(NSManagedObjectContext*)context {
    if (context == nil) {
        context = [NSManagedObjectContext MR_defaultContext];
    }
    // We need to devide the Qty per location.
    
    MaterialUsageRecord *new_record = [MaterialUsageRecord newMaterialUsageRecordInContext:context];
    new_record.dilution_rate_id = commonData.dilution_rate_id;
    float total_qty = commonData.amountValue;
    if (self.selectedLocations.count > 0) {
        float qty_per_location = total_qty / self.selectedLocations.count;
        new_record.amount = @(qty_per_location);
    } else {
        new_record.amount = @(total_qty);
    }
    new_record.measurement = commonData.measurement;
    new_record.device = commonData.device;
    new_record.application_method = commonData.application_method;
    new_record.application_device_type_id = commonData.application_device_type_id;
    new_record.application_method_id = commonData.application_method_id;
    new_record.lot_number = commonData.lot_number;
    for (NSNumber *pestId in self.selectedTargetPests) {
        TargetPest *new_tp = [TargetPest newTargetPestWithPestId:pestId inContext:context];
        [new_record addTarget_pestsObject:new_tp];
    }
    return new_record;
}

- (void)saveMaterialUsage:(id)sender {
    if (commonData.application_method.length <= 0 || commonData.measurement.length <= 0 || commonData.dilution_rate_idValue <= 0 || commonData.amountValue <=0 ) {//|| commonData.device_type_id <= 0
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"Please enter data to save Material Usage" delegate:nil cancelButtonTitle:@"Ok"                                      otherButtonTitles:nil];
        [alert show];
        return;
    }

    
    
    [self.currentMaterialUsage.managedObjectContext MR_saveOnlySelfAndWait];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *appointmentArray = [[NSMutableArray alloc] init ];
//    appointmentArray = [defaults mutableArrayValueForKey:@"appointmentList"];
//
//    [appointmentArray addObject:(self.Appointment.entity_id)];
//    //        [appointmentArray insertObject:self.Appointment.entity_id atIndex:appointmentArray.count];
//    [defaults setObject:appointmentArray forKey:@"appointmentList"];
////
//    NSMutableArray *materialList = [[NSMutableArray alloc] init ];
//
//    materialList = [defaults mutableArrayValueForKey:@"materialList"];
//
//    [materialList addObject:(self.currentMaterialUsage.material_id)];
//    [defaults setObject:materialList forKey:@"materialList"];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *appointmentArray;
//    appointmentArray = [defaults stringForKey:@"appointmentList"];
    
//    [appointmentArray addObject:(self.Appointment.entity_id)];
    //        [appointmentArray insertObject:self.Appointment.entity_id atIndex:appointmentArray.count];
    [defaults setObject:self.Appointment.entity_id forKey:@"appointmentList"];
    
    
    NSString *materialList;
//    materialList = [defaults stringForKey:@"materialList"];
    
    //    [appointmentArray addObject:(self.Appointment.entity_id)];
    //        [appointmentArray insertObject:self.Appointment.entity_id atIndex:appointmentArray.count];
    [defaults setObject:_currentMaterialUsage.material_id forKey:@"materialList"];
    
    //
    
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        MaterialUsage *usage = [self.currentMaterialUsage MR_inContext:localContext];
        usage.material_usage_records = [NSSet set];
        if (self.selectedLocations.count > 0) {
            for (NSNumber *la in  self.selectedLocations) {
                MaterialUsageRecord *new_record = [self createRecordWithCommonValuesInContext:localContext];
                new_record.location_area_id = la;
//                new_record.is_favorite = true;
                [usage addMaterial_usage_recordsObject:new_record];

            }
        } else {
            MaterialUsageRecord *new_record = [self createRecordWithCommonValuesInContext:localContext];
            new_record.location_area_id = @(0);
//            new_record.is_favorite = true;
            [usage addMaterial_usage_recordsObject:new_record];
        }
        
        if ([usage.entity_status isEqualToNumber:c_UNCHANGED]) {
            usage.entity_status = c_EDITED;
        }
        [[usage.appointment MR_inContext:localContext] setEntity_status:c_EDITED];

    }];
    [commonData MR_deleteEntity];
    
    if (self.materialUsageSelectionDelegate && [self.materialUsageSelectionDelegate respondsToSelector:@selector(materialUsageSelectedWithMaterialUsage:)]) {
        [self.materialUsageSelectionDelegate materialUsageSelectedWithMaterialUsage:self.currentMaterialUsage];
    }
    
    /*
     [self.currentMaterialUsage removeMaterial_usage_records:self.currentMaterialUsage.material_usage_records];
    commonData.target_pests = [NSSet setWithArray:self.selectedTargetPests];
    
    if ( self.selectedLocations.count > 0) {
        
        // We need to devide the Qty per location.
        float total_qty = commonData.amountValue;
        float qty_per_location = total_qty / self.selectedLocations.count;
        [commonData setAmount:[NSNumber numberWithFloat:qty_per_location]];
        
        [commonData setLocation_area_id:[self.selectedLocations objectAtIndex:0]];
        [self.currentMaterialUsage addMaterial_usage_recordsObject:commonData];
        [self.selectedLocations removeObjectAtIndex:0];
        for (NSNumber *la in  self.selectedLocations) {
            
            MaterialUsageRecord *new_record = [MaterialUsageRecord newMaterialUsageRecord];
            [new_record setDilution_rate_id:commonData.dilution_rate_id];
            [new_record setAmount:commonData.amount];
            [new_record setMeasurement:commonData.measurement];
            [new_record setDevice:commonData.device];
            [new_record setApplication_method:commonData.application_method];
            [new_record setApplication_device_type_id:commonData.application_device_type_id];
            [new_record setApplication_method_id:commonData.application_method_id];
            [new_record setLot_number:commonData.lot_number];
            [new_record setLocation_area_id:la];
            
            for (TargetPest *tp in self.selectedTargetPests) {
                TargetPest *new_tp = [TargetPest targetPestWithPestId:tp.pest_type_id];
                [new_record addTarget_pestsObject:new_tp];
            }
            [self.currentMaterialUsage addMaterial_usage_recordsObject:new_record];
        }
    } else {
        [commonData setLocation_area_id:[NSNumber numberWithInt:0]];
        [self.currentMaterialUsage addMaterial_usage_recordsObject:commonData];
    }
    
    
    if (self.materialUsageSelectionDelegate && [self.materialUsageSelectionDelegate respondsToSelector:@selector(materialUsageSelectedFor:withMaterialUsage:)]) {
        [self.currentMaterialUsage saveMaterialUsage];
        [self.materialUsageSelectionDelegate materialUsageSelectedFor:TrapSelection withMaterialUsage:self.currentMaterialUsage];
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            if ([viewController isKindOfClass:[TrapDetailView class]] ) {
                
                TrapDetailView *trapDetailViewController = (TrapDetailView*)viewController;
                [self.navigationController popToViewController:trapDetailViewController animated:YES];
                return;
            } else if ([viewController isKindOfClass:[UnitInspectionViewController class]] ) {
                
                UnitInspectionViewController *vc = (UnitInspectionViewController*)viewController;
                [self.navigationController popToViewController:vc animated:YES];
                return;
            }
        }
    }else{
        if (![self.Appointment.material_usagesSet containsObject:self.currentMaterialUsage]) {
            [self.Appointment addMaterial_usagesObject:self.currentMaterialUsage];
        }
        [self.currentMaterialUsage saveMaterialUsage];
        for (UIViewController* viewController in self.navigationController.viewControllers) {
            
            if ([viewController isKindOfClass:[NewAppointMentsDetailViewController class]] ) {
                NewAppointMentsDetailViewController *materialUseListController = (NewAppointMentsDetailViewController*)viewController;
                [self.navigationController popToViewController:materialUseListController animated:YES];
                
            }
        }
        if (self.materialUsageAddedBlock) {
            self.materialUsageAddedBlock();
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:@{@"section":@(FWMaterialUse)}];
     */
}

-(void)discardChangesWithGesture:(UIGestureRecognizer *)gesture {
    if (gesture) {
        if (gesture.state == UIGestureRecognizerStateEnded) {
            //            [self.currentMaterialUsage discard];
            [self discard];
        }
        return;
    }
    //    [self.currentMaterialUsage discard];
    [self discard];
}

- (void)discard {
    [self.currentMaterialUsage discard];
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tblMainData) {
        return 1;
    }else{
        ServiceLocation *service_location = [self.Appointment getServiceLocation];
        if (service_location.location_type_id <= 0) {
            return 1;
        }
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tblMainData) {
        return 6;//5;//6
    }else{
        if (section == 0) {
            return self.selectedTargetPests.count + 1;
        }else{
            return self.selectedLocations.count + 1;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == _tblMainData) {
        
        
        return @"Details";
    }else{
        if (section == 0) {
            return @"Target Pests";
        }else{
            return @"Locations Used";
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"Section : %ld -- Row : %ld", (long)indexPath.section, (long)indexPath.row);
    
    if (tableView == _tblMainData) {
        static NSString *CellIdentifier = @"CellData";
        
        MaterialUsageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"MaterialUsageCell" owner:self options:nil];
            
            for(id currentObject in topLevelObject)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (MaterialUsageCell*) currentObject;
                    
                    [[KeyboardAccessoryHelper getInstance] createInputAccessoryFor:cell.txtDataText inView:self.view andDelegate:self];
                }
            }
            topLevelObject = nil;
        }
        
        NSString *lbl = dataLabels[indexPath.row];
        cell.lblMainLable.textColor= [UIColor colorWithRed:70.0/255.0 green:70.0/255.0 blue:70.0/255.0 alpha:1.0];
        [cell.lblMainLable setFont:[UIFont systemFontOfSize:15.0]];
        cell.lblMainLable.text = lbl;
        if (indexPath.row != 1 && indexPath.row != 5) {
            cell.txtDataText.enabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            if (indexPath.row == 1) {
                cell.txtDataText.keyboardType = UIKeyboardTypeDecimalPad;
            }else{
                cell.txtDataText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            }
            cell.txtDataText.enabled = YES;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        cell.txtDataText.textColor= [UIColor colorWithRed:60.0/255.0 green:60.0/255.0 blue:60.0/255.0 alpha:1.0];
        
        if (indexPath.row == 0) {
            if (commonData.dilution_rate_id != 0) {
                DilutionRates *dd = [DilutionRates dilutionRateById:commonData.dilution_rate_id];
                
                cell.txtDataText.text = dd.name;
                dd = nil;
            }else{
                Material *mat = [Material getById:self.currentMaterialUsage.material_id];
                commonData.dilution_rate_id  = mat.default_dilution_rate_id;
                DilutionRates *default_d = [DilutionRates dilutionRateById:commonData.dilution_rate_id];
                if(default_d){
                    cell.txtDataText.text = default_d.name;
                }
                default_d = nil;
                mat = nil;
            }
        }else if(indexPath.row == 1){
            if (commonData.amountValue <= 0) {
                cell.txtDataText.placeholder = @"0.00";
                cell.txtDataText.keyboardType = UIKeyboardTypeDecimalPad;
                //  cell.txtDataText.textAlignment = NSTextAlignmentCenter;
                //                cell.txtDataText.frame =CGRectMake(60,cell.txtDataText.frame.origin.y, cell.txtDataText.frame.size.width, cell.txtDataText.frame.size.height);
            }else{
                if (commonData.amountValue == 0) {
                    cell.txtDataText.text = @"";
                }else{
             
                    NSString *numberString = [formatter stringFromNumber:commonData.amount];

                    cell.txtDataText.text = numberString;
                }
                
            }
            cell.txtDataText.tag = 1001;
            
            cell.txtDataText.delegate = self;
        } else if(indexPath.row == 2){
            
            cell.txtDataText.text = commonData.measurement;
        }else if (indexPath.row == 3){
            DeviceTypes *device = [DeviceTypes deviceTypeById:commonData.application_device_type_id];
            if (device) {
                cell.txtDataText.text = device.device_name;
            }
        }else if (indexPath.row == 4){
            
            cell.txtDataText.text = commonData.application_method;
        }
        else if (indexPath.row == 5){
            if (commonData.lot_number) {
                cell.txtDataText.text = [NSString stringWithFormat:@"%@", commonData.lot_number];
            }else{
                cell.txtDataText.placeholder = @"Lot #";
            }
            cell.txtDataText.delegate = self;
            cell.txtDataText.tag = 1002;

        }
        
        return cell;
    }
    else{
        // Location Section
        
        if (indexPath.section == 0) {
            static NSString *CellIdentifier = @"CellTargetPest";
            
            UITableViewCell *cell = [_tblLocationAreas dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            if (indexPath.row == self.selectedTargetPests.count) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"Add Target Pest";
            }else{
                Pest *p = [Pest pestById:self.selectedTargetPests[indexPath.row]];
                if (p) {
                    cell.textLabel.text = p.name;
                }
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"CellLocation";
            
            UITableViewCell *cell = [_tblLocationAreas dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            if (indexPath.row ==  self.selectedLocations.count) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"Add a Location";
            }else{
                int l_id = [[self.selectedLocations objectAtIndex:indexPath.row] intValue];
                LocationArea *locationArea = [LocationArea locationAreaById:l_id];
                NSLog(@"locations = %@", locationArea.location_area_name);
                cell.textLabel.text = locationArea.location_area_name;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            return cell;
        }
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (tableView == _tblMainData) {
        if (indexPath.row == 1 ) {
            // Qty Enter Keyboard Open
            MaterialUsageCell *cell = (MaterialUsageCell*)[ _tblMainData cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
            cell.txtDataText.keyboardType = UIKeyboardTypeDecimalPad;
            [cell.txtDataText becomeFirstResponder];
            
        }
    }
    
    if (tableView == _tblMainData && indexPath.row != 1 && indexPath.row != 5) {
        DataType dType = DilutionRate;
        
        if (indexPath.row == 0) {
            dType = DilutionRate;
        } else if(indexPath.row == 2){
            dType = UnitType;
        }else if (indexPath.row == 3){
            dType = DeviceTypeEnum;
        }else if(indexPath.row == 4){
            dType = AppMethod;
        }
        /**/
        DataTableViewController *dt = [DataTableViewController tableWithDataType:dType andDelegate:self];
        dt.materialUsage = self.currentMaterialUsage;
        
        [self.navigationController pushViewController:dt animated:YES];
        dt = nil;
    }else if (tableView == _tblLocationAreas) {
        if (indexPath.section == 0) {
            if (indexPath.row == self.selectedTargetPests.count) {
                DataTableViewController *dt = [DataTableViewController tableWithDataType:TargetPestEnum andDelegate:self withMultipleChoices:YES];
                dt.materialUsage = self.currentMaterialUsage;
                dt.Appointment = self.Appointment;
                [dt setExisting_items:self.selectedTargetPests];
                [self.navigationController pushViewController:dt animated:YES];
                dt = nil;
            }
        }else{
            if (indexPath.row ==  self.selectedLocations.count) {
                DataTableViewController *dt = [DataTableViewController tableWithDataType:LocationEnum andDelegate:self withMultipleChoices:YES];
                dt.materialUsage = self.currentMaterialUsage;
                
                
                ServiceLocation *ser_loc = [self.Appointment getServiceLocation];
                dt.location_type_id = [ser_loc.location_type_id intValue];
                dt.Appointment = self.Appointment;
                [dt setExisting_items:self.selectedLocations];
                [self.navigationController pushViewController:dt animated:YES];
                dt = nil;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblLocationAreas) {
        if (indexPath.section == 0) {
            if (indexPath.row != self.selectedTargetPests.count) {
                [ self.selectedTargetPests removeObjectAtIndex:indexPath.row];
                [_tblLocationAreas reloadData];
                [self expandLocationTable];
            }
        }else{
            if (indexPath.row != self.selectedLocations.count) {
                [ self.selectedLocations removeObjectAtIndex:indexPath.row];
                [_tblLocationAreas reloadData];
                [self expandLocationTable];
            }
        }
    }
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblLocationAreas) {
        if (indexPath.section == 0) {
            if (indexPath.row != self.selectedTargetPests.count) {
                return UITableViewCellEditingStyleDelete;
            }
        }else{
            if (indexPath.row != self.selectedLocations.count) {
                return UITableViewCellEditingStyleDelete;
            }
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceLocation *sinfo = [self.Appointment getServiceLocation];
    if (tableView == _tblLocationAreas && sinfo.location_type_id <= 0) {
        //return 0;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    ServiceLocation *sinfo = [self.Appointment getServiceLocation];
    if (tableView == _tblLocationAreas && sinfo.location_type_id <= 0) {
        //return 0;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    ServiceLocation *sinfo = [self.Appointment getServiceLocation];
    if (tableView == _tblLocationAreas && sinfo.location_type_id <= 0) {
        //return 0;
    }
    return 10;
}

#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    if (type == DilutionRate) {
        commonData.dilution_rate_id = data;
        [_tblMainData reloadData];
    } else if(type == AppMethod){
        ApplicationMethods *ap = (ApplicationMethods*)data;
        commonData.application_method = ap.methodName;
        //26112015
        commonData.application_method_id = ap.entity_id;
        [_tblMainData reloadData];
    }else if(type == UnitType){
        commonData.measurement = [NSString stringWithFormat:@"%@", data];
        [_tblMainData reloadData];
    }else if (type == LocationEnum){
        if (data && [data isKindOfClass:[NSArray class]]) {
            NSArray *arr = data;
            self.selectedLocations = [[NSMutableArray alloc] init];
            for (NSNumber *num in arr) {
                if([ self.selectedLocations containsObject:num]){
                    continue;
                }
                [ self.selectedLocations addObject:num];
            }
        }
        
        [_tblLocationAreas reloadData];
        [self expandLocationTable];
    }else if (type == TargetPestEnum){
        if (data && [data isKindOfClass:[NSArray class]]) {
            NSArray *arr = data;
            self.selectedTargetPests = arr.mutableCopy;
            [_tblLocationAreas reloadData];
            [self expandLocationTable];
        }
    }else if (type == DeviceTypeEnum){
        if (data) {
            //26112015
            [commonData setApplication_device_type_id:data];
            [_tblMainData reloadData];
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==1) {
        [self saveMaterialUsage:nil];
	}else{
        [self discardChangesWithGesture:nil];
        [super removeViewControllerFromNavigationStack:[MaterialListController class]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - KeyBoardHelper

- (void)hideKeyboard {
    [self.view endEditing:TRUE];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == 1001) {
        commonData.amount = [formatter numberFromString:text];
    }else if (textField.tag == 1002){
        commonData.lot_number = text;
    }
    return YES;
}


@end
