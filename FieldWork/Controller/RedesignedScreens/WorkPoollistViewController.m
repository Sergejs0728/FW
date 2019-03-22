    //
    //  WorkPoollistViewController.m
    //  FieldWork
    //
    //  Created by Samir Khatri on 9/21/15.
    //
    //

#import "WorkPoollistViewController.h"
NSInteger* SELECT_DATE_TAG = 1000;
NSInteger selectedMonthFinal;
NSMutableArray* totalMonths;
NSString* thisMonth;
NSString* thisYear;
NSString* filterStartDate;
NSString* filterEndDate;
NSString* finalApiStartDate;
NSString *finalApiEndDate;

@interface WorkPoollistViewController () 

@end

@implementation WorkPoollistViewController


+ (WorkPoollistViewController *)initViewController{
    WorkPoollistViewController * controller = [[WorkPoollistViewController alloc]initWithNibName:@"WorkPoollistViewController" bundle:nil];
    controller.title = @"Work Pool";
    return controller;
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    if (![[AppDelegate appDelegate]isReachable]) {
//        for (UIBarButtonItem *bitem in self.navigationItem.rightBarButtonItems) {
//            if (bitem != nil) {
//                bitem.enabled = NO;
//            }
//        }
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem * barItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"map.png"] style:UIBarButtonItemStylePlain target:self action:@selector(flipViewToMap)];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshWorkPoolAppointments)];

    self.navigationItem.rightBarButtonItem = barItem;
    self.navigationItem.leftBarButtonItem = rightItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTable) name:kRELOAD_WORKORDERS_TABLE object:nil];

    if ([[AppointmentManager Instance] loadedCount] <= 0)
    {
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        [[AppointmentManager Instance] loadAppointmentsWithBlock:^(id result, NSString *error) {
            if (error) {
                [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
            } else {
                [[ActivityIndicator currentIndicator] displayCompleted];
                [self loadTable];
            }
            
        }];
    } else {
        [self loadTable];
    }
    
    monthSelector.delegate = self;
    monthSelector.dataSource = self;
    
    totalMonths = [[NSMutableArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
     

    NSDate* todayDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM";
    thisMonth = [dateFormatter stringFromDate:todayDate];
    dateFormatter.dateFormat = @"yyyy";
    thisYear = [dateFormatter stringFromDate:todayDate];
}

-(void)reachabilityChanged:(NSNotification*)note
{
    FWReachability * reach = [FWReachability reachabilityForInternetConnection];
    
    if([reach isReachable])
    {
        NSLog(@"INTERNET CONNECTION AVAILABLE");
        
    }
    else
    {
        NSLog(@"INTERNET CONNECTION IS NOT AVAILABLE");
    }
}

-(void)loadTable{
    appointments = [[NSMutableArray alloc]init];
    appointments = [Appointment getWorkPoolAppointmentsByDistance:self.userLocation];
   
    [tblView reloadData];
    
    
}

-(void)flipViewToMap{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)refreshWorkPoolAppointments{
    [[ActivityIndicator currentIndicator]displayActivity:@"Refreshing..."];
    if (![[AppointmentManager Instance] isSync]) {
        [[AppointmentManager Instance] refreshAppointmentsWithBlock:^(id result, NSString *error) {
            if (error) {
                [[ActivityIndicator currentIndicator]displayCompletedWithError:error];
            } else {
                [[ActivityIndicator currentIndicator]displayCompleted];
                [self loadTable];
            }
            
        }];
    }
    selectMonthText.text = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (![[ActivityIndicator currentIndicator] ishidden]) {
        [[ActivityIndicator currentIndicator] displayCompleted];
    }
    [[Location Instance] stopLocationManager];
}
-(void)monthPickerClicked:(id)sender{
    monthSelector = [[UIPickerView alloc]init];
    [self openPickerViewWithTag:SELECT_DATE_TAG andTitle:@"Select Month" forPickerView:monthSelector];
}


#pragma UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([appointments count] == 0){
        return 1;
    }else{
        return appointments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([appointments count] == 0){
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            
            }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"No WorkPool Appointment";
        [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else
        {
        static NSString *CellTableIdentifier = @"CellTableIdentifier";
        
        AppointmentCell *cell = (AppointmentCell*)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        if (cell == nil)
            {
//            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//                {
//                NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppointmentCell_IPad" owner:self options:nil];
//                for(id appcell in topLevelObject)
//                    {
//                    if([appcell isKindOfClass:[UITableViewCell class]])
//                        {
//                        cell = (AppointmentCell*) appcell;
//                        }
//                    }
//                }
//            else
//                {
                NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppointmentCell" owner:self options:nil];
                for(id appcell in topLevelObject)
                    {
                    if([appcell isKindOfClass:[UITableViewCell class]])
                        {
                        cell = (AppointmentCell*) appcell;
                        }
                    }
                }
            
    //        }
        Appointment *app = [appointments objectAtIndex:indexPath.row];
        [cell setAppointmentWorkPool:app];
        
        return cell;
        }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([appointments count] == 0){
        return 44.0;
    }
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (appointments.count <= 0) {
        return;
    }
    
    Appointment *app = [appointments objectAtIndex:indexPath.row];
    NewWorkOrderViewController *controller = [NewWorkOrderViewController viewControllerWithWorkOrder:app];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) openPickerViewWithTag:(int) tag andTitle:(NSString*) title forPickerView:(UIPickerView*) picker
{
    
    [self.view endEditing:YES];
    picker.showsSelectionIndicator=YES;
    picker.dataSource = self;
    picker.delegate = self;
    picker.tag = tag;
    SamcomActionSheet_iPad * action = [SamcomActionSheet_iPad initIPadUIPickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:picker inView:self.view];
    
    action.tag = tag;
    action.isViewOpen= YES;
    [action show];
    [self selectRow:(thisMonth.integerValue - 1) inComponent:0 animated:NO];
}


#pragma mark- UIActionSheet & PickerView Delegate


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     return totalMonths.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [totalMonths objectAtIndex:row];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSInteger select = thisMonth.integerValue - 1;
    if (row < select) {
        NSLog(@"Disable the month");
        [self selectRow:row inComponent:component animated:NO];
    }
    selectedMonthFinal = row + 1;
}

- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated {
    NSInteger select = thisMonth.integerValue - 1;
    [monthSelector selectRow:select inComponent:component animated:NO];
}


#pragma mark - SamcomActionSheetDelegate

- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
    int idx = (int)[actionSheet.pickerView selectedRowInComponent:0];
    selectedMonthFinal = idx+1;
    selectMonthText.text = [totalMonths objectAtIndex:idx];
    [self.view endEditing:YES];
    [self calculateNoOfDays];
}

- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
}

-(void)calculateNoOfDays {
    
    NSLog(@"selectedMonthFinal = %ld", (long)selectedMonthFinal);
    NSInteger days;
    if (selectedMonthFinal == 1 || selectedMonthFinal == 3 || selectedMonthFinal == 5 || selectedMonthFinal == 7 || selectedMonthFinal == 8 || selectedMonthFinal == 10 || selectedMonthFinal == 12) {
        days = 31;
    } else if (selectedMonthFinal == 2) {
        if (thisYear.integerValue % 4 == 0) {
            days = 29;
        } else {
            days = 28;
        }
    } else {
        days = 30;
    }
    
    NSString *temp = [NSString stringWithFormat:@"%ld", (long)selectedMonthFinal];
    if (temp.length == 1) {
        temp = [NSString stringWithFormat:@"0%@",temp];
    }
    finalApiStartDate = [NSString stringWithFormat:@"%@/01/%@", temp, thisYear];
    finalApiEndDate = [NSString stringWithFormat:@"%@/%ld/%@", temp, (long)days, thisYear];
    NSLog(@"finalApiEndDate = %@", finalApiEndDate);
    [self startFilerAppointment];
}

-(void)startFilerAppointment {
    [[AppointmentManager Instance] loadWorkPoolAppointmentsWithBlock:^(id result, NSString *error) {
        if (error) {
            [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
        } else {
            NSLog(@"start = %@ end = %@", finalApiStartDate, finalApiEndDate);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:MMDDYYYY];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            NSDate* start = [dateFormatter dateFromString:finalApiStartDate];
            NSLog(@"start = %@", start);
            NSDate* end = [dateFormatter dateFromString:finalApiEndDate];
            appointments = [[NSMutableArray alloc]init];
            appointments = [Appointment getWorkPoolAppointmentsByDistanceWithDateRange:self.userLocation fromDate:start toDate:end];
            
            [tblView reloadData];
        }
    } andStartDate:finalApiStartDate andEndDate:finalApiEndDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
