//
//  UnitInspectionViewController.m
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import "UnitInspectionViewController.h"
#import "UIExpandableTableView.h"
#import "AddUnitFieldCell.h"
#import "AddUnitCell.h"
#import "AddUnitTextViewCell.h"
#import "UnitDateCell.h"
#import "AddUnitCell.h"
#import "UnitStatus.h"
#import "FlatConditions.h"
#import "DataTableViewController.h"
#import "MaterialListController.h"
#import "AppChemicalCell.h"
#import "TableSignatureCell.h"
#import "UnitInspection.h"
#import "PestActivityCell.h"

@interface UnitInspectionViewController ()<UITableViewDataSource,UITableViewDelegate,DataSelectionDelegate,UITextViewDelegate,MaterialUsageSelectionDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTableViewConstraint;
@property (weak, nonatomic) IBOutlet UIExpandableTableView *tableView;
@property (nonatomic, readwrite, retain) NSMutableArray *selectedMaterialUsage;
@property (nonatomic, retain ,readwrite) NSMutableArray *selectedPestActivities;
@property (nonatomic, strong) UnitInspection *inspectionRecord;
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation UnitInspectionViewController{
    NSString* serviceTime;
    NSString* signature;
    NSString* notes;
    UnitStatus *status;
    FlatConditions *conditions;
}

+(UnitInspectionViewController *)initWithUnit:(Unit *)unit andAppointment:(Appointment*) appointment{
    UnitInspectionViewController * vc;
    vc =[[UnitInspectionViewController alloc]initWithNibName:@"UnitInspectionViewController" bundle:nil];
    vc.appointment=appointment;
    vc.unit = unit;
    [vc initData];
    vc.title =[NSString stringWithFormat:NSLocalizedString(@"Inspection #%@", @""),unit.unit_number];
    
    return vc;
}

-(BOOL) navigationShouldPopOnBackButton
{
    [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You have not saved this record, would you like to save before proceeding?"
                               delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
    return NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _formatter = [[NSDateFormatter alloc] init];
    [_formatter setDateFormat:@" h:mm a"];
    UIBarButtonItem *btnSave = [UIBarButtonItem barButtonWithTitle:NSLocalizedString(@"Save", @"") andBlock:^{
        [self saveUnitInspection];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:@{@"section":@(FWUnits)}];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    UIBarButtonItem *btnDelete = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete"] style:UIBarButtonItemStylePlain target:self action:@selector(deleteTapped:)];
    if (_inspectionRecord) {
        [self.navigationItem setRightBarButtonItems:@[btnSave,btnDelete]];
    } else {
        [self.navigationItem setRightBarButtonItems:@[btnSave]];
    }
    [self registerNibs:@[@"AddUnitFieldCell",
                         @"AddUnitCell",
                         @"AddUnitTextViewCell",
                         @"UnitDateCell",
                         @"PestActivityCell",
                         @"AppChemicalCell",
                         @"TableSignatureCell"]];
    _tableView.delegate=self;
    _tableView.dataSource=self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark -
-(void)registerNibs:(NSArray*)keys{
    for (NSString* key in keys) {
        UINib *cellNib = [UINib nibWithNibName:key bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:key];
    }
}

- (void)initData {
    _inspectionRecord = [UnitInspection unitInspectionWithAppointmentId:_appointment.entity_id unitNumber:_unit.unit_number deleted:NO];
    
//    _inspectionRecord = [UnitInspection getFavoriteunitInspection:_appointment.entity_id deleted:NO][0];
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *appointmentArray= [defaults mutableArrayValueForKey:@"appointmentList"];
//    if(appointmentArray == nil){
//        appointmentArray = [[NSMutableArray alloc] init ];
//    }
//
//
//    NSMutableArray *materialList= [defaults mutableArrayValueForKey:@"materialList"];
//
//    if(materialList == nil){
//        materialList = [[NSMutableArray alloc] init ];
//    }
    
    
    
    _selectedMaterialUsage = [NSMutableArray array];
    _selectedPestActivities = [NSMutableArray array];
    notes = _unit.notes;
    if (_inspectionRecord) {
        serviceTime = _inspectionRecord.service_time;
        status = [UnitStatus unitStatusById:_inspectionRecord.unit_status_id];
        conditions = [FlatConditions flatConditionsById:_inspectionRecord.flat_condition_id];
        notes = _inspectionRecord.notes;
        if (_inspectionRecord.material_usages) {
            _selectedMaterialUsage = [NSMutableArray arrayWithArray:[_inspectionRecord.material_usages allObjects]];
        }
        if (_inspectionRecord.pests_activities) {
            _selectedPestActivities = [NSMutableArray arrayWithArray:[_inspectionRecord.pests_activities allObjects]];
        }
        signature = _inspectionRecord.tenant_signature;
        status = [UnitStatus unitStatusById:_inspectionRecord.unit_status_id];
        conditions = [FlatConditions flatConditionsById:_inspectionRecord.flat_condition_id];
    }
}

- (void)agjustContentSize:(BOOL)grow notification:(NSNotification *)n {
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (grow) {
        _bottomTableViewConstraint.constant = keyboardSize.height;
    } else {
        _bottomTableViewConstraint.constant = 0;
    }
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    [self agjustContentSize:NO notification:n];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    [self agjustContentSize:YES notification:n];
}

- (IBAction)deleteTapped:(UIButton *)sender {
    UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Do you want to delete inspection?", @"")
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okDeleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action) {
                                                               if ([_inspectionRecord.entity_status isEqualToNumber:c_ADDED]) {
                                                                   [self.appointment.unit_recordsSet removeObject:_inspectionRecord];
                                                                   [_inspectionRecord MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                                                                   
                                                               }else{
                                                                   [_inspectionRecord setEntity_status:c_DELETED];
                                                               }
                                                               [_inspectionRecord save];
                                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                                   [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:@{@"section":@(FWUnits)}];
                                                                   [self.navigationController popViewControllerAnimated:YES];
                                                               });
                                                           }];
    [alertDelete addAction:okDeleteAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alertDelete addAction:cancelAction];
    [self presentViewController:alertDelete animated:YES completion:nil];
}

- (void)saveUnitInspection {
    NSString *message = nil;
    if (serviceTime == nil) {
        message = NSLocalizedString(@"Service time is reqired", @"");
        
    }
    for (PestActivity *pestActivity in self.selectedPestActivities) {
        if ([pestActivity getActivityLevel] == nil) {
            message = NSLocalizedString(@"Pests activities activity level can't be blank", @"");
        }
        if ([pestActivity getPest] == nil) {
            message = NSLocalizedString(@"Can't find pest", @"");
        }
    }
    if (message) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Unit Inspection", @"")
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alert addAction:actionOk];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (_inspectionRecord == nil) {
        _inspectionRecord = [UnitInspection newInspectionWithUnit:_unit];
    }
    
    // ensure that inspectionRecord is in persistent store to fetch it correctly in local context
    [self.inspectionRecord.managedObjectContext MR_saveOnlySelfAndWait];
    // ensure that related objects are in persistent store to fetch them correctly in local context
    for (MaterialUsage *mu in _selectedMaterialUsage) {
        [mu.managedObjectContext MR_saveOnlySelfAndWait];
    }
    for (PestActivity *pa in _selectedPestActivities) {
        [pa.managedObjectContext MR_saveOnlySelfAndWait];
    }
    // save other data
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
        UnitInspection *record = [_inspectionRecord MR_inContext:localContext];
        record.tenant_name = _unit.tenant_name;
        record.appointment_occurrence_id = _appointment.entity_id;
        record.service_time = serviceTime;
        record.unit_status_id = status.entity_id;
        record.notes = notes;
        record.tenant_signature = signature;
        record.flat_type_id = _unit.flat_type_id;
        record.flat_condition_id = conditions.entity_id;
        [record setMaterial_usages:[NSSet set]];
        for (MaterialUsage *mu in _selectedMaterialUsage) {
            [record.material_usagesSet addObject:[mu MR_inContext:localContext]];
        }
        [record setPests_activities:[NSSet set]];
        for (PestActivity *pa in _selectedPestActivities) {
            [record.pests_activitiesSet addObject:[pa MR_inContext:localContext]];
        }
        record.appointment_occurrence_id = _appointment.entity_id;
        record.appointment = [_appointment MR_inContext:localContext];
        record.appointment.entity_status = c_EDITED;
        if ([record.entity_status isEqual:c_UNCHANGED]) {
            record.entity_status = c_EDITED;
        }
    }];
}

-(void)discardChangesWithGesture:(UIGestureRecognizer *)gesture {
    if (gesture) {
        if (gesture.state == UIGestureRecognizerStateEnded) {
            [self discard];
        }
        return;
    }
    [self discard];
}

- (void)discard {
    [self.inspectionRecord discard];
    for (MaterialUsage *mu in _selectedMaterialUsage) {
        [mu discard];
    }
    for (PestActivity *pa in _selectedPestActivities) {
        [pa discard];
    }
}

- (HeaderView*) createHeaderViewForSection:(NSInteger)section withTitle:(NSString*)title andButtonBlock:(void(^)())block
{
    HeaderView *view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title];
    
    view.headerOpenBlock = ^(NSInteger section) {
        [self.tableView reloadData];
        [_tableView headerViewOpen:section];
    };
    
    view.headerCloseBlock = ^(NSInteger section) {
        [self.tableView reloadData];
        [_tableView headerViewClose:section];
    };
    
    if (block) {
        [view addRightButtonWithTitle:@"+ Add" andBlock:block];
    }
    return view;
}


- (UITableViewCell*) noItemCell:(NSString*)msg
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = msg;
    return cell;
}


#pragma mark - UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == InsSecTop) {
        return 4;
    }
    if (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section) {
        switch (section) {
            case InsSecMaterials:
                if (self.selectedMaterialUsage) {
                    if ([[self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()] count] > 0) {
                        return [[self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()] count];
                    }
                }
                return 1;
            case InsSecSignature:
                return 1;
            case InsSecPests:
                if (self.selectedPestActivities) {
                    if ([[self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()] count] > 0) {
                        return [[self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()] count];
                    }
                }
                return 1;
                
            default:
                return 0;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    switch (section) {
        case InsSecTop:
            switch (row) {
                case InsServiceTime:{
                    UnitDateCell* cell=[tableView dequeueReusableCellWithIdentifier:@"UnitDateCell"forIndexPath:indexPath];
                    cell.doneBlock = ^(NSDate *date) {
                        serviceTime= [_formatter stringFromDate:date];
                    };
                    [cell setTime:serviceTime];
                    return cell;
                }
                    break;
                case InsStatus:{
                    AddUnitCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitCell"forIndexPath:indexPath];
                    [cell.cellLabel setText:@"Status"];
                    if (status) {
                        [cell.valueLabel setText:status.name];
                    }
                    else{
                        [cell.valueLabel setText:@""];
                    }
                    return cell;
                }
                    break;
                case InsUnitContition:{
                    AddUnitCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitCell"forIndexPath:indexPath];
                    [cell.cellLabel setText:@"Unit condition"];
                    if (conditions) {
                        [cell.valueLabel setText:conditions.name];
                    }
                    else{
                        [cell.valueLabel setText:@""];
                    }
                    return cell;
                }
                    break;
                case InsNotes:{
                    AddUnitTextViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitTextViewCell"forIndexPath:indexPath];
                    [cell.cellLabel setText:@"Notes"];
                    cell.textView.text = notes;
                    cell.blockDidChange = ^(NSString *value) {
                        notes=value;
                    };
                    return cell;
                }
                    break;
                default:
                    break;
            }

        case InsSecMaterials: {
            if ([self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 0)
            {
                UITableViewCell *cell = [self noItemCell:NSLocalizedString(@"No Material Usage added.", nil)];
                return cell;
            }
            AppChemicalCell *cell = (AppChemicalCell*) [_tableView dequeueReusableCellWithIdentifier:@"AppChemicalCell" forIndexPath:indexPath];
            if (indexPath.row < [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                [cell setMaterialUsage:[self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row]];
            }
            
            return cell;
        }
        case InsSecSignature: {
            TableSignatureCell *cell = (TableSignatureCell*) [_tableView dequeueReusableCellWithIdentifier:@"TableSignatureCell" forIndexPath:indexPath];
            [cell setSignature:signature title:NSLocalizedString(@"Signature", nil)];
            __weak UnitInspectionViewController* weakSelf= self;
            [cell setBlock:^{
                CaptureSignatureController *vc = [CaptureSignatureController viewControllerWithPDFAttachment:nil andBlock:^(id result) {
                    signature = result;
                    [weakSelf.tableView reloadData];
                }];
                vc.closeBlock=^(){

                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }];
            return cell;
            
        }
        case InsSecPests: {
            if ([self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 0)
            {
                UITableViewCell *cell = [self noItemCell:NSLocalizedString(@"No Pest Activity added.", nil)];
                return cell;
            }
            PestActivityCell *cell = (PestActivityCell*) [_tableView dequeueReusableCellWithIdentifier:@"PestActivityCell" forIndexPath:indexPath];
            if (indexPath.row < [self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count) {
                __block PestActivity *pestActivity = [self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
                cell.pestActivity = pestActivity;
                cell.doneBlock = ^(NSNumber *activityLevelId) {
                    pestActivity.activity_level_id = activityLevelId;
                    pestActivity.entity_status = c_EDITED;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [tableView reloadData];
                    });
                };
            }
            
            return cell;
        }
    }
    return [self noItemCell:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    switch (section) {
        case InsSecTop:
            switch (row) {
                case InsStatus:{
                    DataTableViewController* viewController=[DataTableViewController tableWithDataType:UnitStatusList andDelegate:self];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                case InsUnitContition:{
                    DataTableViewController* viewController=[DataTableViewController tableWithDataType:FlatConditionsList andDelegate:self];
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                    break;
                default:
                    break;
            }
            break;
        case InsSecMaterials: {
            if ([self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count > 0) {
                MaterialUsage *mur = [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
                MaterialUsageRecordController *murController = [MaterialUsageRecordController viewControllerWithAppointment:self.appointment andMaterialUsage:mur];
                murController.materialUsageSelectionDelegate = self;
                [self.navigationController pushViewController:murController animated:YES];
            }
            break;
        }
            
        case InsSecSignature: {
            
        }
            break;
        case InsSecPests: {
            if ([self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count > 0) {
                DataTableViewController *viewController = [DataTableViewController tableWithDataType:TargetPestEnum andDelegate:self];
                __weak typeof(self) weakSelf = self;
                viewController.dataSelectionBlock = ^(id result) {
                    NSNumber *pestTypeId = result;
                    PestActivity *pestActivity = weakSelf.selectedPestActivities[row];
                    pestActivity.pest_type_id = pestTypeId;
                    pestActivity.entity_status = c_EDITED;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                    });
                    
                };
                [self.navigationController pushViewController:viewController animated:YES];

            }
            break;
        }


    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case InsSecTop:
            if ((indexPath.row==InsNotes)&&(indexPath.section==InsSecTop)) {
                return 320;
            }
            return 40;
        case InsSecMaterials:
            if ([self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 0) {
                return 44;
            }
            return 61;
        case InsSecSignature:
            return 180;
        case InsSecPests:
            if ([self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 0) {
                return 44;
            }
            return 47;
            
        default:
            return 44;
    }

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case InsSecMaterials: {
            __weak __typeof(self) weakSelf = self;
            return     [self createHeaderViewForSection:section withTitle:@"MATERIAL USE" andButtonBlock:^{
                MaterialListController *controller = [MaterialListController viewControllerWithAppointment:weakSelf.appointment];
                controller.materialUsageSelectionDelegate = weakSelf;
                [weakSelf.navigationController pushViewController:controller animated:YES];
            }];
        }
        case InsSecSignature: {
            return     [self createHeaderViewForSection:section withTitle:@"SIGNATURE" andButtonBlock:nil];
        }
        case InsSecPests: {
            __weak __typeof(self) weakSelf = self;
            return     [self createHeaderViewForSection:section withTitle:@"PEST ACTIVITY" andButtonBlock:^{
                DataTableViewController *viewController = [DataTableViewController tableWithDataType:TargetPestEnum andDelegate:self];
                viewController.dataSelectionBlock = ^(id result) {
                    NSNumber *pestTypeId = result;
                    PestActivity *pestActivity = [PestActivity newPestActivityWithPestId:pestTypeId unitRecordId:_inspectionRecord.entity_id];
                    [_selectedPestActivities addObject:pestActivity];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                    });
                };
                [weakSelf.navigationController pushViewController:viewController animated:YES];
            }];
        }
        default:
            return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    switch (section) {
        case InsSecMaterials:
        case InsSecSignature:
        case InsSecPests:
            return     1;
        default:
            return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    switch (section) {
        case InsSecMaterials:
        case InsSecSignature:
        case InsSecPests: {
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
            [footer setBackgroundColor:[UIColor clearColor]];
            return footer;
        }
        default:
            return nil;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case InsSecMaterials:
        case InsSecSignature:
        case InsSecPests:
            return     38;
        default:
            return 0;
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case InsSecMaterials: {
            if ([self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 0) {
                return NO;
            }
            return YES;
        }
        case InsSecPests:
            if ([self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 0) {
                return NO;
            }
            return YES;
        default:
            return NO;
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case InsSecMaterials: {
            if ([self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count > 0) {
                return UITableViewCellEditingStyleDelete;
            }
        }
            break;
        case InsSecPests:
            if ([self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count > 0) {
                return UITableViewCellEditingStyleDelete;
            }
            break;
        default:
            return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        switch (indexPath.section) {
            case InsSecMaterials: {
                MaterialUsage *material_usage = [self.selectedMaterialUsage filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
                if (material_usage.entity_idValue <= 0) {
                    [self.selectedMaterialUsage removeObject:material_usage];
                    [material_usage MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                }else {
                    [material_usage setEntity_status:c_DELETED];
                }
                [tableView reloadData];
            }
                break;
            case InsSecPests: {
                PestActivity *pestActivity = [self.selectedPestActivities filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.row];
                if (pestActivity.entity_idValue <= 0) {
                    [self.selectedPestActivities removeObject:pestActivity];
                    [pestActivity MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                }else {
                    [pestActivity setEntity_status:c_DELETED];
                }
                [tableView reloadData];
            }
            default:
                break;
        }
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) {
        [self saveUnitInspection];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:@{@"section":@(FWUnits)}];
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else{
        [self discardChangesWithGesture:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - DataSelectedDelegate
-(void)DataSelectedForData:(id)data andType:(DataType)type{
    switch (type) {
        case UnitStatusList: {
            UnitStatus *unitStatus = data;
            status = unitStatus;
            [self.tableView reloadData];
        }
            break;
        case FlatConditionsList: {
            FlatConditions *flatCondition = data;
            conditions = flatCondition;
            [self.tableView reloadData];
        }
            break;
            
            
        default:
            break;
    }
    
}

#pragma mark - MaterialUsageSelectionDelegate

- (void)materialUsageSelectedWithMaterialUsage:(MaterialUsage *)materialUsage{
    if (materialUsage && ![self.selectedMaterialUsage containsObject:materialUsage]) {
        [self.selectedMaterialUsage addObject:materialUsage];
    }
    [_tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
}

- (void)materialUsageSelectionCanceled {
    
}

@end
