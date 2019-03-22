    //
    //  SettingController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 16/02/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "SettingController.h"
#import "AppDelegate.h"
#import "MFSideMenu.h"
#import "AppointmentManager.h"

@interface SettingController ()
@property (nonatomic) BOOL isLoading;
@end

@implementation SettingController
@synthesize iplabel,printlabel;
@synthesize table=_table;

+ (SettingController *)init {
    SettingController *sc = [[SettingController alloc] initWithNibName:@"SettingView" bundle:nil];
    sc.title = @"Settings";
    sc.isLoading = NO;
    return sc;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
  
}
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setNavItemsColor];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self createbarButton];
}

-(void)createbarButton{
    UIImage* image2 = [UIImage imageNamed:@"menuOrange.png"];
    CGRect frameimg2 = CGRectMake(15,5, 25,25);
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:frameimg2];
    [leftButton setBackgroundImage:image2 forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(menuClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [leftButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *menuButton =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(settingsaveclicked:)];
   
    self.navigationItem.rightBarButtonItem = saveBtn;

    
    [self dynamicTableHeight];
}


-(void)setNavItemsColor{
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)menuClicked:(id)sender{
    if (_isLoading) {
        return;
    }
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}

- (void)dynamicTableHeight{
    //26112015
    if ([UserSetting getPrintOnOff]) {
        _table.frame = CGRectMake(_table.frame.origin.x,_table.frame.origin.y, _table.frame.size.width,132.0);
    }else{
        //[UserSettings SaveAirPrintOnOff:NO];
        _table.frame = CGRectMake(_table.frame.origin.x,_table.frame.origin.y,_table.frame.size.width,88.0);
    }
   
}
-(IBAction)settingsaveclicked:(id)sender{
    if (_isLoading) {
        return;
    }
    CustomTableCell * cell=(CustomTableCell*)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    
    NSString * ip = cell.txt.text;
    
    [UserSetting SaveIpAddress:ip];
    
    cell=(CustomTableCell*)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UISwitch * switchs=(UISwitch*)cell.accessoryView;
    
    BOOL switchbool=switchs.isOn;
    
    [UserSetting SavePrintOnOff:switchbool];
    
    if ([UIAlertController class]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ALERT_TITLE message:@"Your changes have been saved" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Your changes have been saved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    if(switchs.isOn == YES){
        cell=(CustomTableCell*)[_table cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        UISwitch * switchs2=(UISwitch*)cell.accessoryView;
        BOOL switch2Bool  =switchs2.isOn;
        
        [UserSetting SaveAirPrintOnOff:switch2Bool];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([UserSetting getPrintOnOff] == NO){
        return 2;
    }else{
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomTableCell *cell = [_table dequeueReusableCellWithIdentifier:CellIdentifier];
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
    cell.lbl.frame = CGRectMake(cell.lbl.frame.origin.x + 5, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    if (indexPath.row == 0) {
        cell.lbl.text = @"IP";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        cell.txt.text=[UserSetting getIpAddress];
    }
    if (indexPath.row == 1) {
        cell.lbl.text = @"Print";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        CGRect frameSwitch = CGRectMake(215.0, 10.0, 94.0, 27.0);
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:frameSwitch];
        cell.accessoryView = switchView;
        switchView.tag = indexPath.row;
        [switchView setOn:[UserSetting getPrintOnOff] animated:NO];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.txt.enabled=NO;
    }

    if (indexPath.row == 2 && [UserSetting getPrintOnOff] == YES) {
        cell.lbl.text = @"Use AirPrint";
        cell.lbl.font = [UIFont fontWithName:@"Arial Black" size:50.0];
        CGRect frameSwitch = CGRectMake(215.0, 10.0, 94.0, 27.0);
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:frameSwitch];
        switchView.tag = 1001;
        cell.accessoryView = switchView;
        [switchView setOn:[UserSetting getAirPrintOnOff] animated:NO];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        cell.txt.enabled=NO;
    }else{
        [UserSetting SaveAirPrintOnOff:NO];
    }
//    if (indexPath.row == 3 || (indexPath.row == 2 && [UserSetting getPrintOnOff] == NO)) {
//        UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCellStyleSubtitle"];
//            //cell1.textLabel.text= @"Auto Sync";
//        cell1.textLabel.text= @"Offline Mode";
//        cell1.textLabel.font = [UIFont fontWithName:@"Arial Black" size:50.0];
//        CGRect frameSwitch = CGRectMake(215.0, 10.0, 94.0, 27.0);
//        UISwitch *switchView = [[UISwitch alloc] initWithFrame:frameSwitch];
//        switchView.tag = 1002;
//        cell1.accessoryView = switchView;
//        [switchView setOn:[UserSetting getOfflineMode] animated:NO];
//        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
//            //cell.txt.enabled=NO;
//        NSString *msg = @"Manual sync will store your data locally and let you sync at a time of your choosing.";
//        if ([UserSetting getOfflineMode] == YES) {
//            msg = @"Auto sync will sync data automatically when network is available.";
//        }
//            //        cell1.detailTextLabel.text = @"";
//            //        //[cell addSubview:info];
//            //        cell1.detailTextLabel.numberOfLines = 0;
//            //        cell1.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        return cell1;
//    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //26112015
//    if (indexPath.row == 3 || (indexPath.row == 2 && [UserSettings getPrintOnOff] == NO)) {
//            //        return 80;
//        return 44;
//    }
    return 44;
}

- (void) switchChanged:(id)sender {
    UISwitch* switchControl = (UISwitch*)sender;

    if (switchControl.on) {
        switchControl.on = YES;
    }
    if (switchControl.tag == 1) {
        [UserSetting SavePrintOnOff:switchControl.on];
        if (switchControl.on) {
            _table.frame = CGRectMake(_table.frame.origin.x, _table.frame.origin.y, _table.frame.size.width, 132.0);
        }else{
            
              _table.frame = CGRectMake(_table.frame.origin.x, _table.frame.origin.y, _table.frame.size.width, 88.0);
        }
        
        [_table reloadData];
    }else if(switchControl.tag == 1001){
        [UserSetting SaveAirPrintOnOff:switchControl.on];
    }
}

- (void)refreshClicked:(id)sender {
    if (_isLoading) {
        return;
    }
     BOOL isDirtyAppointmentsFound = [[AppointmentManager Instance] scanForDirtyAppointments];
    if (isDirtyAppointmentsFound) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"There are still Appointments which needs to be sync.Please try again later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"This will download your entire customer database.  We strongly suggest that you perform this over a WIFI connection to save on time and cellular usage.  Depending on the size of your database this will take several minutes." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        alert.tag = 2020;
        [alert show];
    }
   
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2020) {
        if(buttonIndex > 0){
            _isLoading = YES;
            [[AppDelegate appDelegate] lockScreen:YES];
            [[ActivityIndicator currentIndicator]displayActivity:@"Loading data..."];
            [[AppDelegate appDelegate] loadAllListsSilent:NO completion:^(NSMutableArray *failedList) {
                if (failedList.count == 0) {
                    if (![[AppointmentManager Instance] isSync]) {
                        [[ActivityIndicator currentIndicator]displayActivity:@"Loading work orders..."];
                        [[AppointmentManager Instance] forcefullyRefreshAppointmentsWithBlock:^(id result, NSString *error) {
                            if (error) {
                                [[AppDelegate appDelegate] lockScreen:NO];
                                [[ActivityIndicator currentIndicator]displayCompletedWithError:error];
                            } else {
                                [[ActivityIndicator currentIndicator]displayActivity:@"Loading customers..."];
                                [[CustomerManager Instance] refreshCustomersWithBlock:^(id result, NSString *error) {
                                    [[AppDelegate appDelegate] lockScreen:NO];
                                    if (error) {
                                        [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
                                        _isLoading = NO;
                                    } else {
                                        if ([CustomerManager Instance].objectsCount == [Customer getCustomers].count) {
                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"CUSTOMER_LIST_LOADED" object:nil];
                                            [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
                                            _isLoading = NO;
                                            [[ActivityIndicator currentIndicator]displayCompleted];
                                        }
                                    }
                                }];
                            }
                        }];
                    }
                } else {
                    [[AppDelegate appDelegate] lockScreen:NO];
                    _isLoading = NO;
                    [[ActivityIndicator currentIndicator]displayCompletedWithError:NSLocalizedString(@"Some data didn't load. Please try again.", @"")];
                }
                
            }];
        }
    }
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
