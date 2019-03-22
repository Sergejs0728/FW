//
//  TrapInspectionViewController.m
//  FieldWork
//
//  Created by Alex on 30.06.17.
//
//

#import "TrapInspectionViewController.h"
#import "UIPlaceHolderTextView.h"
#import "DataTableViewController.h"
#import "MaterialListController.h"
#import "CapturedPestViewController.h"
#import "EvidenceListController.h"
#import "MaterialUsageCell.h"
#import "MaterialusetablelistCell.h"
#import "Pest.h"
#import "InspectionPest.h"
#import "Evidences.h"
#import "TrapAddController.h"
#import "TrapDetailViewController.h"

enum {
    TrapInspectionSectionTop = 0,
    TrapInspectionSectionMaterial,
    TrapInspectionSectionPest,
    TrapInspectionSectionEvidence
};

enum {
    TrapInspectionSectionTopTrapCondition = 0,
    TrapInspectionSectionTopBaitCondition,
    TrapInspectionSectionTopRemoved
};

@interface TrapInspectionViewController () <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate, DataSelectionDelegate, MaterialUsageSelectionDelegate> {
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *activityView;
@property (strong, nonatomic) IBOutlet UIView *notesView;
@property (weak, nonatomic) IBOutlet UILabel *lblTrapNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblBarcode;
@property (weak, nonatomic) IBOutlet UILabel *lblScannedTime;
@property (weak, nonatomic) IBOutlet UIImageView *ivActivity;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *tvNotes;

@property (nonatomic, readwrite, retain) NSMutableArray *selectedMaterialUsage;

@end

@implementation TrapInspectionViewController


+ (TrapInspectionViewController*) initWithAppointment:(Appointment*)app withInspection:(InspectionRecord*)record
{
    TrapInspectionViewController *vc = [[TrapInspectionViewController alloc] initWithNibName:@"TrapInspectionViewController" bundle:nil];
    
    vc.title = NSLocalizedString(@"Device Inspection", @"");
    vc.Appointment = app;
    vc.inspectionRecord = record;
    return vc;
}

+ (TrapInspectionViewController*) initWithAppointment:(Appointment*)app withTrap:(CustomerDevice*)trap
{
    TrapInspectionViewController *vc = [[TrapInspectionViewController alloc] initWithNibName:@"TrapInspectionViewController" bundle:nil];
    
    vc.title = NSLocalizedString(@"Device Inspection", @"");
    vc.Appointment = app;
    vc.trap = trap;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.inspectionRecord == nil) {
        [self createInspection];
    }
    [_tvNotes setPlaceholder:@"Note (200) characters"];
    _tvNotes.secondDelegate = self;
    _tvNotes.text = _inspectionRecord.notes;
    [self createBarButton];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm a";
    NSString *scannedOnString = [formatter stringFromDate:_inspectionRecord.scanned_on];
    _lblScannedTime.text = scannedOnString;
    _lblBarcode.text = _inspectionRecord.barcode;
    _lblTrapNumber.text = _inspectionRecord.trap_number;
    _tableView.tableHeaderView = _headerView;
    _ivActivity.hidden = !_inspectionRecord.is_cleanValue;
    [_tableView registerNib:[UINib nibWithNibName:@"MaterialUsageCell" bundle:nil] forCellReuseIdentifier:@"CellData"];
    [_tableView registerNib:[UINib nibWithNibName:@"MaterialuselistCell" bundle:nil] forCellReuseIdentifier:@"CellMaterialUsage"];
    self.selectedMaterialUsage = [self.inspectionRecord.material_usages allObjects].mutableCopy;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) navigationShouldPopOnBackButton
{
    [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You have not saved this record, would you like to save before proceeding?"
                               delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
    return NO;
}

#pragma mark -
-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)back {
    NSUInteger index = NSNotFound;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TrapAddController class]] || [viewController isKindOfClass:[TrapDetailViewController class]]) {
            index = [self.navigationController.viewControllers indexOfObject:viewController];
            break;
        }
    }
    
    if (index != NSNotFound && index - 1 < self.navigationController.viewControllers.count) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index - 1] animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createInspection {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        InspectionRecord *record = [InspectionRecord newInspectionWithBarcode:_trap.barcode inContext:localContext];
        Appointment *app = [self.Appointment MR_inContext:localContext];
        record.trap_number = _trap.number;
        record.trap_type_id = _trap.trap_type_id;
        record.appointment = app;
        record.building = _trap.building;
        record.floor = _trap.floor;
        record.trap_number = _trap.number;
        record.trap_id = _trap.entity_id;
        record.location_details = _trap.location_details;
        
        if (_notes) {
            record.notes = _notes;
        } else {
            record.notes = _trap.notes;
        }
        record.exception = _exception;
        if (_scannedDate) {
            record.scanned_on = _scannedDate;
        } else {
            record.scanned_on = [NSDate systemDate];
        }
        
        if ([record.entity_status isEqual:c_UNCHANGED]) {
            record.entity_status = c_EDITED;
        }
        if (![app.inspection_records containsObject:record]) {
            [app.inspection_recordsSet addObject:record];
        }
    }];
    _inspectionRecord = [InspectionRecord inspectionWithBarcode:_trap.barcode appointment:self.Appointment];
}

- (void)save {
    // ensure that inspectionRecord is in persistent store to fetch it correctly in local context
    [self.inspectionRecord.managedObjectContext MR_saveOnlySelfAndWait];
    if (self.inspectionRecord.is_cleanValue) {
        // ensure that related objects are in persistent store to fetch them correctly in local context and then send to server for deleting
        for (InspectionPest *record in self.inspectionRecord.pests_records) {
            if (record.entity_idValue > 0) {
                record.entity_status = c_DELETED;
                [record.managedObjectContext MR_saveOnlySelfAndWait];
            }
        }
        // delete all records except of marked as deleted
        [[NSManagedObjectContext MR_defaultContext] MR_deleteObjects:[self.inspectionRecord.pests_records filteredSetUsingPredicate:NON_DELETED_PREDECATE()]];
        self.inspectionRecord.evidence_ids = [[NSArray alloc] init];
    } else {
        // ensure that related objects are in persistent store to fetch them correctly in local context
        for (MaterialUsage *mu in _selectedMaterialUsage) {
            [mu.managedObjectContext MR_saveOnlySelfAndWait];
        }
        for (InspectionPest *ip in self.inspectionRecord.pests_records) {
            [ip.managedObjectContext MR_saveOnlySelfAndWait];
        }
    }
    // save other data
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        InspectionRecord *record = [self.inspectionRecord MR_inContext:localContext];
        [record setMaterial_usages:[NSSet set]];
        for (MaterialUsage *mu in _selectedMaterialUsage) {
            [record.material_usagesSet addObject:[mu MR_inContext:localContext]];
        }
        Appointment *app = [self.Appointment MR_inContext:localContext];
        record.appointment = app;
        record.appointment.entity_status = c_EDITED;
        if ([record.entity_status isEqual:c_UNCHANGED]) {
            record.entity_status = c_EDITED;
        }
        if (![app.inspection_records containsObject:record]) {
            [app.inspection_recordsSet addObject:record];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_DEVICES object:nil];
    [self back];
}

#pragma mark - IBActions
- (IBAction)onActivityTap:(UIButton *)sender {
    _ivActivity.hidden = !_ivActivity.hidden;
    self.inspectionRecord.is_cleanValue = !_ivActivity.hidden;
    [_tableView reloadData];
}

- (void)removedSwitchChanged:(id)sender {
    UISwitch *swch = (UISwitch*) sender;
    if (swch.on) {
        self.inspectionRecord.removed = @(YES);
    }else{
        self.inspectionRecord.removed = @(NO);
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) {
        [self save];
    }else{
        if (_trap) {
            if ([self.Appointment.inspection_records containsObject:_inspectionRecord]) {
                [self.Appointment.inspection_recordsSet removeObject:_inspectionRecord];
            }
            [_inspectionRecord MR_deleteEntity];            
        } else {
            [self.inspectionRecord discard];
        }
        
        [self back];
    }
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_inspectionRecord.is_cleanValue) {
        return 2;
    } else {
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case TrapInspectionSectionTop: {
            return 3;
        }
        case TrapInspectionSectionMaterial: {
            return self.selectedMaterialUsage == nil ? 1 : [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count + 1;
        }
        case TrapInspectionSectionPest: {
            return [_inspectionRecord.pests_records filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count + 1;
        }
        case TrapInspectionSectionEvidence: {
            return ((NSArray*)_inspectionRecord.evidence_ids).count + 1;
        }
        default:
            return 0;
    }
    
}

    
    
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    switch (section) {
        case TrapInspectionSectionMaterial: {
            return NSLocalizedString(@"Material Usages", @"");
        }
        case TrapInspectionSectionPest: {
            return NSLocalizedString(@"Pest Captured", @"");
        }
        case TrapInspectionSectionEvidence: {
            return NSLocalizedString(@"Evidence", @"");
        }
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    switch (indexPath.section) {
        case TrapInspectionSectionTop: {
            static NSString *CellIdentifier = @"CellData";
            MaterialUsageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.txtDataText.enabled = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.lblMainLable.font = [UIFont fontWithName:@"Helvetica" size:16];
            switch (row) {
                case TrapInspectionSectionTopTrapCondition: {
                    cell.lblMainLable.text = NSLocalizedString(@"Trap Condition", @"");
                    if (self.inspectionRecord.trap_condition_id > 0) {
                        TrapConditions *tc = [TrapConditions trapConditionById:self.inspectionRecord.trap_condition_id];
                        cell.txtDataText.text = tc.trap_condition_name;
                    }
                }
                    break;
                case TrapInspectionSectionTopBaitCondition: {
                    cell.lblMainLable.text = NSLocalizedString(@"Bait Condition", @"");
                    if (self.inspectionRecord.bait_condition_id > 0) {
                        BaitConditions *bc = [BaitConditions baitConditionById:self.inspectionRecord.bait_condition_id];
                        cell.txtDataText.text = bc.bait_condition_name;
                    }
                }
                    break;
                case TrapInspectionSectionTopRemoved: {
                    UISwitch *swch = [[UISwitch alloc] initWithFrame:CGRectMake(10, 3, 94, 40)];
                    swch.on = self.inspectionRecord.removedValue;
                    [swch addTarget:self action:@selector(removedSwitchChanged:) forControlEvents:UIControlEventValueChanged];
                    cell.accessoryView = swch;
                    cell.lblMainLable.text = NSLocalizedString(@"Removed", @"");
                }
                    break;
                    
                default:
                    break;
            }
            return cell;
        }
            break;
        case TrapInspectionSectionMaterial: {
            if (indexPath.row == [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                static NSString *CellIdentifier = @"CellAddMaterialUsage";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = NSLocalizedString(@"Add Material Usage", @"");
                return cell;
            } else {
                static NSString *CellIdentifier = @"CellMaterialUsage";
                MaterialusetablelistCell *cell = (MaterialusetablelistCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
                [cell setMaterilUsage:[self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row]];
                return cell;
            }
        }
            break;
        case TrapInspectionSectionPest: {
            if (indexPath.row == [self.inspectionRecord.pests_recordsSet filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count) {
                static NSString *CellIdentifier = @"CellAddPestCaptured";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = NSLocalizedString(@"Captured", @"");
                
                return cell;
            }else{
                static NSString *CellIdentifier = @"CellPestCaptured";
                
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont systemFontOfSize:15.0];
                InspectionPest *pestRecord = [[self.inspectionRecord.pests_records allObjects] filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
                Pest *p = [Pest pestById:pestRecord.pest_type_id];
                cell.textLabel.text = p.name;
                cell.textLabel.textColor = [UIColor grayColor];
                UILabel *lblQty = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 60, 40)];
                lblQty.textColor = [UIColor grayColor];
                lblQty.backgroundColor = [UIColor clearColor];
                lblQty.font = [UIFont systemFontOfSize:15.0];
                lblQty.text = [NSString stringWithFormat:@"%d", pestRecord.countValue];
                cell.accessoryView = lblQty;
                
                return cell;
            }

        }
            break;
        case TrapInspectionSectionEvidence: {
            if (((NSArray*)self.inspectionRecord.evidence_ids).count == indexPath.row) {
                static NSString *CellIdentifier = @"Cell";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = NSLocalizedString(@"Evidence", @"");
                return cell;
            }else{
                static NSString *CellIdentifier = @"CellEvidence";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.font = [UIFont systemFontOfSize:15.0];
                cell.textLabel.textColor = [UIColor grayColor];
                NSNumber *evidence_id = ((NSArray*)self.inspectionRecord.evidence_ids)[row];
                Evidences *evidence = [Evidences evidenceById:evidence_id];
                cell.textLabel.text = evidence.name;
                return cell;
            }

        }
            break;
        default:
            return nil;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case TrapInspectionSectionTop: {
            DataTableViewController *dataController = nil;
            switch (indexPath.row) {
                case TrapInspectionSectionTopTrapCondition: {
                    // Trap Condition
                    dataController = [DataTableViewController tableWithDataType:TrapConditionEnum andDelegate:self];
                }
                    break;
                case TrapInspectionSectionTopBaitCondition: {
                    // Bait Condition
                    dataController = [DataTableViewController tableWithDataType:BaitConditionEnum andDelegate:self];
                }
                    break;
                default:
                    break;
            }
            if (dataController) {
                [self.navigationController pushViewController:dataController animated:YES];
            }
        }
            break;
        case TrapInspectionSectionMaterial: {
            if (indexPath.row == [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                MaterialListController *controller = [MaterialListController viewControllerWithAppointment:self.Appointment];
                controller.materialUsageSelectionDelegate = self;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
            break;
        case TrapInspectionSectionPest: {
            if(indexPath.row == [self.inspectionRecord.pests_recordsSet filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count)
            {
                CapturedPestViewController *vc = [CapturedPestViewController initWithAppointment:self.Appointment andInspectionRecord:_inspectionRecord];
                vc.capturedPestAddedBlock = ^(NSMutableArray *array){
                    [self.inspectionRecord removePests_records:_inspectionRecord.pests_records];
                    [self.inspectionRecord addPests_records:[NSSet setWithArray:array]];
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case TrapInspectionSectionEvidence: {
            if(indexPath.row == ((NSArray*)self.inspectionRecord.evidence_ids).count)
            {
                EvidenceListController *evidence = [EvidenceListController initWithAppointment:self.Appointment andInspectionRecord:_inspectionRecord];
                evidence.evidenceSelectionBlock = ^(id result) {
                    [tableView reloadData];
                };
                [self.navigationController pushViewController:evidence animated:YES];
            }
            
        }
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case TrapInspectionSectionTop: {
            return 150;
        }
        case TrapInspectionSectionMaterial: {
            return 100;
        }
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case TrapInspectionSectionMaterial:
        case TrapInspectionSectionPest:
        case TrapInspectionSectionEvidence: {
            return 30;
        }
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case TrapInspectionSectionMaterial: {
            if (indexPath.row != [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                return 60;
            }
        }
        default:
            return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    switch (section) {
        case TrapInspectionSectionTop: {
            return _notesView;
        }
        case TrapInspectionSectionMaterial: {
            return _activityView;
        }
        default:
            return nil;
    }
}


- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case TrapInspectionSectionMaterial: {
            if (indexPath.row != [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                return UITableViewCellEditingStyleDelete;
            }
        }
        case TrapInspectionSectionPest: {
            if (indexPath.row != [self.inspectionRecord.pests_records filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count) {
                return UITableViewCellEditingStyleDelete;
            }
        }
        case TrapInspectionSectionEvidence: {
            if (indexPath.row != [((NSArray*)self.inspectionRecord.evidence_ids) count]) {
                return UITableViewCellEditingStyleDelete;
            }
        }
        default:
            return UITableViewCellEditingStyleNone;
    }
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case TrapInspectionSectionMaterial: {
            if (indexPath.row != [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                MaterialUsage *record = [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
                if (record.entity_idValue > 0) {
                    record.entity_status = c_DELETED;
                } else {
                    [ self.selectedMaterialUsage removeObject:record];
                    [record MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tableView reloadData];
                });
            }
        }
            break;
        case TrapInspectionSectionPest: {
            InspectionPest *record = [[self.inspectionRecord.pests_records allObjects] filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
            if (record.entity_idValue > 0) {
                record.entity_status = c_DELETED;
            } else {
                [self.inspectionRecord.pests_recordsSet removeObject:record];
                [record MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });
        }
            break;
        case TrapInspectionSectionEvidence: {
            NSMutableArray *temp = [(NSArray*) self.inspectionRecord.evidence_ids mutableCopy];
            [temp removeObjectAtIndex:indexPath.row];
            self.inspectionRecord.evidence_ids = [NSArray arrayWithArray:temp];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableView reloadData];
            });
        }
            break;
        default:
            break;
    }
    
}

#pragma mark -
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MaterialUsageSelectionDelegate

- (void)materialUsageSelectedWithMaterialUsage:(MaterialUsage *)materialUsage{
    if (materialUsage && ![self.selectedMaterialUsage containsObject:materialUsage]) {
        [self.selectedMaterialUsage addObject:materialUsage];
        [_tableView reloadData];
    }
    [self.navigationController popToViewController:self animated:YES];
}

- (void)materialUsageSelectionCanceled {
    
}


#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    if (type == TrapConditionEnum) {
        self.inspectionRecord.trap_condition_id = data;
    }
    if (type == BaitConditionEnum) {
        self.inspectionRecord.bait_condition_id = data;
    }
    [_tableView reloadData];
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView == _tvNotes) {
        if([text isEqualToString:@"\n"]) {
            _inspectionRecord.notes = [NSString stringWithFormat:@"%@   ",textView.text];
        } else if(![text isEqualToString:@""]){
            _inspectionRecord.notes = [NSString stringWithFormat:@"%@%@",textView.text,text];
        } else{
            if (textView.text.length) {
                _inspectionRecord.notes = [textView.text substringToIndex:textView.text.length - 1];
            }
        }
    }
    
    return YES;
}


@end
