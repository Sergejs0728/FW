//
//  EvidenceListController.m
//  FieldWork
//
//  Created by Samir Khatri on 2/20/13.
//
//

#import "EvidenceListController.h"

@interface EvidenceListController ()

@end

@implementation EvidenceListController

@synthesize inspectionRecord = _inspectionRecord;
@synthesize evidenceSelectionBlock;


+ (EvidenceListController *)initWithAppointment:(Appointment *)appt andInspectionRecord:(InspectionRecord *)ir {
    EvidenceListController * evidence = [[EvidenceListController alloc] initWithNibName:@"EvidenceListController" bundle:nil];
    evidence.Appointment = appt;
    evidence.inspectionRecord = ir;
    evidence.title = @"Pest Evidence";
    return evidence;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveClicked:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    _evidenceArray = [[NSMutableArray alloc] init];
    _evidenceArray = [Evidences fetchAll];
    
    self.evidenceItems = [[NSMutableArray alloc] init];
    
    if (self.inspectionRecord.evidence_ids  != nil) {
        for (NSNumber *eid in self.inspectionRecord.evidence_ids) {
            Evidences *e = [Evidences evidenceById:eid];
            if (e) [self.evidenceItems addObject:e];
        }
    }
}

-(BOOL) navigationShouldPopOnBackButton
{
    [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You have not saved this record, would you like to save before proceeding?"
                               delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
    return NO;
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) {
        
        [self saveClicked:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)saveClicked:(id)sender {
    NSMutableArray *irArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < _evidenceArray.count; i++) {
        UITableViewCell *cell = [_mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell) {
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                Evidences *info = [_evidenceArray objectAtIndex:i];
                [irArr addObject:info.entity_id];
            }
        }
    }
    
    [self.inspectionRecord setEvidence_ids:irArr];
    if (self.evidenceSelectionBlock) {
        self.evidenceSelectionBlock(nil);
    }

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _evidenceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
    {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Evidences *info = [_evidenceArray objectAtIndex:indexPath.row];
    NSString *str = info.name;
    cell.textLabel.text = str;
    
    for (Evidences *evidenceObj in self.evidenceItems) {
        if ([evidenceObj.name isEqualToString:str]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
    if (cell1.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell1.accessoryType = UITableViewCellAccessoryNone;
    }else{
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

@end
