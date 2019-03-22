//
//  WOHistoryDetailController.m
//  FieldWork
//
//  Created by Mac4 on 21/11/14.
//
//

#import "WOHistoryDetailController.h"

@interface WOHistoryDetailController ()

@end

@implementation WOHistoryDetailController

+ (WOHistoryDetailController *)viewControllerWithWorkOrder:(Appointment *)app {
    WOHistoryDetailController *appoint;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        appoint = [[WOHistoryDetailController alloc] initWithNibName:@"WOHistoryDetailController" bundle:nil];
    }else{
        appoint = [[WOHistoryDetailController alloc] initWithNibName:@"WOHistoryDetailController" bundle:nil];
    }
    
    appoint.Appointment = app;
    return appoint;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lblWONumber.text = [NSString stringWithFormat:@"WO # %@", self.Appointment.report_number];
    self.title = _lblWONumber.text;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    NSString *datestring = [dateFormatter stringFromDate:self.Appointment.starts_at];
    _lblDate.text = datestring;
    _txtNotes.placeholder = @"No notes added";
    _txtNotes.text = self.Appointment.notes;
    //if (self.Appointment.starts_at_time) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"hh:mm a"];
        //26112015
        NSInteger *diff = [Utils timezoneDifferenceInDestinationTimeZone];
        [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:diff]];
        _lblTime.text = [NSString stringWithFormat:@"%@ - %@", self.Appointment.starts_at_time, self.Appointment.ends_at_time];
    //}
    
//    if(self.Appointment.started_at_time){
//        _lblTime.text = [NSString stringWithFormat:@"%@ - %@", [Utils getNonmilitaryTime:self.Appointment.started_at_time], [Utils getNonmilitaryTime:self.Appointment.finished_at_time]];
//    }
    
    _vStatusView.layer.cornerRadius = 15.0;
    _vStatusView.layer.masksToBounds = YES;
    
    if (self.Appointment.status && [self.Appointment.status rangeOfString:@"Schedule"].location != NSNotFound) {
        _vStatusView.backgroundColor = [UIColor colorWithRed:255.0 green:204.0/255.0 blue:51.0/255.0 alpha:1.0];
        _lblStatus.text = @"S";
    } else if (self.Appointment.status && [self.Appointment.status rangeOfString:@"Miss"].location != NSNotFound){
        _vStatusView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        _lblStatus.text = @"M";
    } else if(self.Appointment.status && [self.Appointment.status rangeOfString:@"Complete"].location != NSNotFound){
        _vStatusView.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:153.0/255.0 blue:51.0/255.0 alpha:1.0];
        _lblStatus.text = @"C";
    }else{
    }
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[UIScreen mainScreen] bounds].size.height
    
    int totalTableHeight = 0;
    totalTableHeight = _tblMain.frame.origin.y + _tblMain.frame.size.height;
    if ([[UIScreen mainScreen] bounds].size.height < totalTableHeight) {
        int diff = totalTableHeight - [[UIScreen mainScreen] bounds].size.height;
        _tblMain.frame = CGRectMake(_tblMain.frame.origin.x, _tblMain.frame.origin.y, _tblMain.frame.size.width, _tblMain.frame.size.height - diff - 40);
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"Chemical Use";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //26112015
        return [[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects].count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.section == 0) {
        
        MaterialusetablelistCell *cell = (MaterialusetablelistCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil || cell.tag == -1010)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"MaterialuselistCell" owner:self options:nil];
            
            for(id materialCurrentObject in topLevelObject)
            {
                if([materialCurrentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (MaterialusetablelistCell*) materialCurrentObject;
                }
            }
        }
     //26112015   
//       [cell setMaterilUsage:[self.Appointment.materialUsageList.MaterialUsages objectAtIndex:indexPath.row]];
         [cell setMaterilUsage:[[[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:indexPath.row]];
        
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
