    //
    //  TrapAddController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 22/02/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "TrapAddController.h"


@implementation TrapAddController
@synthesize TrapAddTable=_TrapAddTable;
@synthesize barcode=_barcode;
@synthesize customerTrap = _customerTrap;
@synthesize addscrollview=_addscrollview;



+ (TrapAddController*) initWithAppointment:(Appointment*) app withCustomerTrap:(CustomerDevice *)ctrap
{
    TrapAddController * trap_detail;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        trap_detail = [[TrapAddController alloc] initWithNibName:@"TrapAddController_IPad" bundle:nil];
    }else{
        trap_detail = [[TrapAddController alloc] initWithNibName:@"TrapAddController" bundle:nil];
    }
    
    trap_detail.title=@"Add Device";
    trap_detail.barcode = ctrap.barcode;
    trap_detail.customerTrap = ctrap;
    trap_detail.Appointment = app;
    return trap_detail;
}


+ (TrapAddController*) initWithEstimate:(Estimate*) est withCustomerTrap:(CustomerDevice *)ctrap
{
    TrapAddController * trap_detail;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        trap_detail = [[TrapAddController alloc] initWithNibName:@"TrapAddController_IPad" bundle:nil];
    }else{
        trap_detail = [[TrapAddController alloc] initWithNibName:@"TrapAddController" bundle:nil];
    }
    
    trap_detail.title=@"Add Device";
    trap_detail.barcode = ctrap.barcode;
    trap_detail.customerTrap = ctrap;
    trap_detail.estimate = est;
    return trap_detail;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarButton];
    _TrapAddTable.delegate = self;
    _TrapAddTable.dataSource = self;
}
-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(SaveTrapAdd:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(IBAction)SaveTrapAdd:(id)sender{
    
    CustomTableCell *cell = (CustomTableCell*)[_TrapAddTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    if (cell) {
        self.customerTrap.building = [cell.txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    }
    cell = (CustomTableCell*)[_TrapAddTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (cell) {
        self.customerTrap.floor = [cell.txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    }
    cell = (CustomTableCell*)[_TrapAddTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell) {
        self.customerTrap.location_details = [cell.txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    }
    cell = (CustomTableCell*)[_TrapAddTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    if (cell) {
        self.customerTrap.number = [cell.txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
    }
    [self.customerTrap saveCustomerDevicetOnLocal];
    TrapInspectionViewController *vc = [TrapInspectionViewController initWithAppointment:self.Appointment withTrap:self.customerTrap];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Add Device";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomTableCell *cell = [_TrapAddTable dequeueReusableCellWithIdentifier:CellIdentifier];
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
    cell.txt.delegate = self;
    cell.txt.tag = indexPath.row;
    if (indexPath.row == 0)
        {
        cell.lbl.text = @"Barcode";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.text = self.barcode;
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.txt.userInteractionEnabled=NO;
        cell.txt.delegate = nil;
        }
    if (indexPath.row == 1)
        {
        cell.lbl.text = @"Building";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.userInteractionEnabled=YES;
        
        cell.txt.text = self.customerTrap.building;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (indexPath.row == 2)
        {
        cell.lbl.text = @"Floor";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        
        cell.txt.text = self.customerTrap.floor;
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.userInteractionEnabled=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (indexPath.row == 3)
        {
        cell.lbl.text = @"Location";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        
        cell.txt.text = self.customerTrap.location_details;
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.userInteractionEnabled=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (indexPath.row == 4)
        {
        cell.lbl.text = @"Trap #";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        
        cell.txt.text = self.customerTrap.number;
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.userInteractionEnabled=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    if (indexPath.row == 5)
        {
        cell.lbl.text = @"Trap Type";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.userInteractionEnabled=YES;
        cell.txt.enabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
            {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
            }
#endif
        if ([self.customerTrap.trap_type_id intValue] > 0) {
            TrapTypes *tt = [TrapTypes trapTypesById:self.customerTrap.trap_type_id];
            if (tt) {
                cell.txt.text = tt.trap_type_name;
            }
        }
        cell.txt.delegate = nil;
        
        }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 5) {
        DataTableViewController *dt = [DataTableViewController tableWithDataType:TrapTypeEnum andDelegate:self];
        
        [self.navigationController pushViewController:dt animated:YES];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    self.customerTrap.trap_type_id = [NSNumber numberWithInt:[data intValue]];
    [self.TrapAddTable reloadData];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 1){
        self.customerTrap.building = textField.text;
    } else if (textField.tag == 2){
        self.customerTrap.floor = textField.text;
    } else if (textField.tag == 3){
        self.customerTrap.location_details = textField.text;
    } else if (textField.tag == 4){
        self.customerTrap.number = textField.text;
    }
}

#pragma mark - ListItemDelegate
- (void)ListItemAddedSuccessfully {
    InspectionRecord *record = [InspectionRecord inspectionWithBarcode:_customerTrap.barcode appointment:self.Appointment];
    if (record) {
        TrapInspectionViewController *vc = [TrapInspectionViewController initWithAppointment:self.Appointment withInspection:record];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)ListItemAdditionFailedWithError:(NSString *)error {
    
    [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Fail"];
}
- (void) ListItemDeletionFailedWithError:(NSString*) error{}
- (void) ListItemDeletedSuccessfully{}


@end
