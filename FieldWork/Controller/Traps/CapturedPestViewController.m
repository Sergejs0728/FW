//
//  CapturedPestViewController.m
//  FieldWork
//
//  Created by Samir Kha on 12/02/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CapturedPestViewController.h"

@implementation CapturedPestViewController
@synthesize CapturedPesttable=_CapturedPesttable;

@synthesize CapturedPestlabel;
@synthesize barcode;

@synthesize inspectionRecord = _inspectionRecord;
@synthesize btnRemovePest = _btnRemovePest;
@synthesize pestEvidenceDelegate = _pestEvidenceDelegate;
@synthesize capturedPestAddedBlock;

+ (CapturedPestViewController*) initWithAppointment:(Appointment *)appt andInspectionRecord:(InspectionRecord *)insp
{
    CapturedPestViewController * capturedView;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        capturedView = [[CapturedPestViewController alloc] initWithNibName:@"CapturedPestViewController_IPad" bundle:nil];        
    }else{
        capturedView = [[CapturedPestViewController alloc] initWithNibName:@"CapturedPestViewController" bundle:nil];
    }
    capturedView.title=@"Captured Pest";
    capturedView.barcode = insp.barcode;
    capturedView.Appointment = appt;
    capturedView.inspectionRecord = insp;
    return capturedView ;
}

#pragma mark - View lifecycle

- (void)viewDidLoad  
{
    [super viewDidLoad];
    _CapturedPesttable.tableFooterView = _buttonHolder;
    [self createBarButton];
    _inspectionPestRecords = [[NSMutableArray alloc] init];
    if ([self.inspectionRecord.pests_recordsSet filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count <= 0) {
        [self addInspectionPestRecord];
    } else{
        [_inspectionPestRecords addObjectsFromArray:[[self.inspectionRecord.pests_recordsSet allObjects] mutableCopy]];
    }
    
    CapturedPestlabel.text  = self.barcode;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTable) name:@"ReloadTable" object:nil];
}

- (BOOL) navigationShouldPopOnBackButton
{
    for (InspectionPest *record in _inspectionPestRecords) {
        [record discard];
    }
    return YES;
}

-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(CapturedPestsavebutn:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void) reloadTable
{
    [_CapturedPesttable reloadData];
}

- (void) addInspectionPestRecord
{
    InspectionPest *record = [InspectionPest newInspectionPest];
    if (record) [_inspectionPestRecords addObject:record];
}

- (void) removeInspectionPestRecord {
    if ([_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count <= 1) {
        return;
    }
    InspectionPest *record = [_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].lastObject;
    if (record.entity_idValue > 0) {
        record.entity_status = c_DELETED;
    } else {
        [_inspectionPestRecords removeLastObject];
        [record MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    }
}

-(IBAction)celladdbtn:(id)sender
{
    [self addInspectionPestRecord];
    [self.CapturedPesttable reloadData];
}

- (void)removePest:(id)sender {
    if ([_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count == 1) {
        return;
    }
    [self.view endEditing:YES];
    [self removeInspectionPestRecord];
    [self.CapturedPesttable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{ 
    return 2;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Details";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }else{
        return 10;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomTableCell *cell = [_CapturedPesttable dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"CustomLableTextCell" owner:self options:nil];
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (CustomTableCell*) currentObject;
            }
        }
    }
    InspectionPest *ipr = [_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.section];
    Pest *p = [Pest pestById:ipr.pest_type_id];
    if (indexPath.row % 2 == 0)
    {
        cell.lbl.text = @"Pest";
        cell.txt.text = p.name;
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.enabled=NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
    }
    if (indexPath.row % 2 != 0)
    {
        cell.lbl.text = @"Qty";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.selected= FALSE;
        cell.txt.delegate = self;
        cell.txt.tag = indexPath.section;
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        if (ipr.count <= 0) {
            cell.txt.placeholder=@"0.00";
            if (ipr.count == 0) {
                cell.txt.text = @"";
            }
            
        }else {
             cell.txt.text = [NSString stringWithFormat:@"%d",[ipr.count intValue]];
        }
        cell.txt.keyboardType = UIKeyboardTypeNumberPad;
        [cell.lbl endEditing:TRUE];
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row % 2 == 0) {
        _last_selected_index = indexPath.section;
        InspectionPest *rec = [_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][indexPath.section];
        PestsListController *pestListController = [PestsListController viewControllerWithAppointment:self.Appointment andInspection:self.inspectionRecord];
        pestListController.pestSelectionDelegate = self;
        pestListController.inspectionPestRecords = _inspectionPestRecords;
        [self.navigationController pushViewController:pestListController animated:YES];
        pestListController = nil;
        rec = nil;
    }
}

-(IBAction)CapturedPestsavebutn:(id)sender
{
    NSString *msg = nil;
    for (InspectionPest *ipr in _inspectionPestRecords) {
        if (ipr.count <= 0) {
            msg = [NSString stringWithFormat:@"Please add quantity for %@", [Pest pestById:ipr.pest_type_id].name];
            break;
        }
        if (ipr.pest_type_idValue <= 0) {
            msg = @"Please choose pest";
            break;
        }
    }
    if (msg) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    for (InspectionPest *record in _inspectionPestRecords) {
        [record.managedObjectContext MR_saveOnlySelfAndWait];
    }
    
    if ([_inspectionRecord.entity_status isEqual:c_UNCHANGED]) {
        _inspectionRecord.entity_status = c_EDITED;
    }
    
    if (self.capturedPestAddedBlock) {
        self.capturedPestAddedBlock(_inspectionPestRecords);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - KeyBoardHelper

- (void)hideKeyboard {
    [self.view endEditing:YES];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    InspectionPest *rec = [_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][textField.tag];
    rec.countValue = [text intValue];
    return YES;
}

#pragma mark - PestSelectionDelegate

- (void)pestRecordSelectedFor:(SelectionFor)selectionFor withTargetPest:(Pest *)targetPest {
    InspectionPest *rec = [_inspectionPestRecords filteredArrayUsingPredicate:NON_DELETED_PREDECATE()][_last_selected_index];
    rec.pest_type_id = targetPest.entity_id;
    if ([rec.entity_status isEqual:c_UNCHANGED]) {
        rec.entity_status = c_EDITED;
    }
    
    [self.CapturedPesttable reloadData];
}

- (void)pestRecordSelectionCanceledFor:(SelectionFor)selectionFor {
    
}

@end
