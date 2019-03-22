//
//  NewAppointmentViewController.m
//  FieldWork
//
//  Created by Samir on 10/26/15.
//
//

#import "NewAppointmentViewController.h"
#import "NewCustomerTableViewController.h"
#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "PaymentViewController.h"
#import "CustomerManager.h"
#import "EstimateViewController.h"
#import "StaticModelLoader.h"
#import "UIAlertController+Blocks.h"
#import "DeviceManager.h"
#import "DeviceArea.h"
#define REFRESH_LONG_TIMER 20
#define REFRESH_SHORT_TIMER 2

@interface NewAppointmentViewController ()
{
    //
    NSDate *_dateSelected;
    BOOL needRefresh;
}
//@property (nonatomic, strong) User *user;

//@property (nonatomic) BOOL isEstimatesLoaded;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (nonatomic) float headerHeight;
@property (strong, nonatomic) GameTimer *gameTimer;
//@property (strong, nonatomic) NSMutableOrderedSet* dataSet;
@property (strong,nonatomic) NSArray* appointments;
@property (strong,nonatomic) NSArray* estimates;
@end

@implementation NewAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appointments=[NSArray new];
    _estimates=[NSArray new];
    needRefresh=NO;
    [AppDelegate appDelegate].containerVC.panMode =  MFSideMenuPanModeDefault;
    self.title = @"Calendar";
    UISwipeGestureRecognizer *ges_down =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTopToBottom:)];
    [ges_down setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [calendarContentView addGestureRecognizer:ges_down];
    _headerHeight=_headerHeightConstraint.constant;
    UISwipeGestureRecognizer *ges_up =[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeTopToBottom:)];
    [ges_up setDirection:(UISwipeGestureRecognizerDirectionUp)];
    [calendarContentView addGestureRecognizer:ges_up];
    
    self.calendar = [JTCalendarManager new];
    self.calendar.delegate = self;
    self.calendar.settings.weekModeEnabled = YES;
    //self.calendar.settings.pageViewHaveWeekDaysView = YES; // You don't want WeekDaysView in the contentView
    self.calendar.settings.pageViewNumberOfWeeks = 0;
    
    //[self.calendar setMenuView:calendarMenuView];
    [self.calendar setContentView:calendarContentView];
    [self.calendar setDate:[NSDate date2]];
    _dateSelected = [NSDate date2];
    
    NSString *month = [_dateSelected stringWithFormat:@"MMMM"];
    self.navigationItem.title = month;
    
    [self createButtons];
    [self addRefreshControl];
    [[SyncManager Instance] startUpdateTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData) name:kRELOAD_WORKORDERS_TABLE object:nil];
    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadAppointment) name:kFORFULLY_UPDATE_APPOINTMENTS object:nil];
}

- (void) swipeTopToBottom:(UISwipeGestureRecognizer*)swipeGes
{
    CGFloat newHeight = 300;
    if (swipeGes.direction == UISwipeGestureRecognizerDirectionDown) {
        if (self.calendar.settings.weekModeEnabled == YES) {
            self.calendar.settings.weekModeEnabled = NO;
            [self transition];
            _tblAppList.bounces = NO;
            
        }
    } else if (swipeGes.direction == UISwipeGestureRecognizerDirectionUp) {
        if (self.calendar.settings.weekModeEnabled == NO) {
            self.calendar.settings.weekModeEnabled = YES;
            [self transition];
            _tblAppList.bounces = YES;
            newHeight = 70;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self endRefreshing];
    [[AppDelegate appDelegate] lockScreen:NO];
    [AppDelegate appDelegate].working_appointment_id = nil;
    if ([User getUser] == nil) {
        return;
    }
    if ([[AppDelegate appDelegate] isReachable]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadEmptyListsWithCompletion:nil];
        });
        
    } else {
        [self loadTable:NO beetweenDays:NO];
    }
    
    // Load all device area values
    if (![DeviceArea getAllDeviceAreas] || [[DeviceArea getAllDeviceAreas] count] == 0) {
        [[DeviceManager Instance] loadAllDevices:nil];
    }
    
    
    //    if([[AppointmentManager Instance] scanForDirtyAppointments]){
    //    if ([[AppointmentManager Instance] loadedCount] <= 0)
    //    {
    //        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
    //        _isLoading = YES;
    //        __block NewAppointmentViewController *weakself = self;
    //        [[AppointmentManager Instance] refreshAppointmentsWithBlock:^(id result, NSString *error) {
    //
    //            _isLoading = NO;
    //            [weakself loadTable:NO];
    //        }];
    //    }else{
    //        [self loadTable:NO];
    //    }
    //    }
}

- (void)loadEmptyListsWithCompletion:(void (^)(NSMutableArray* failedList))completion {
    NSMutableArray *emptyLists = [[StaticModelLoader Instance] emptyLists];
    if (emptyLists.count > 0) {
        [[AppDelegate appDelegate] lockScreen:YES];
        [[ActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Loading data...", @"")];
        [[AppDelegate appDelegate] loadLists:emptyLists silent:YES completion:^(NSMutableArray *failedList) {
            
            if (failedList.count) {
                [StaticModelLoader Instance].pathsListQueue = failedList;
                if (![[ActivityIndicator currentIndicator] ishidden]) {
                    [[ActivityIndicator currentIndicator] hide];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIAlertController showAlertInViewController:self
                                                       withTitle:NSLocalizedString(@"Error", @"")
                                                         message:NSLocalizedString(@"Can't load data. Please try again later.", @"")
                                               cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                          destructiveButtonTitle:nil
                                               otherButtonTitles:nil
                                                        tapBlock:nil];
                });
            } else {
                [[AppDelegate appDelegate] lockScreen:NO];
                if (![[ActivityIndicator currentIndicator] ishidden]) {
                    [[ActivityIndicator currentIndicator] displayCompleted];
                }
                [self loadTable:NO beetweenDays:NO];
            }
        }];
    } else {
        [[AppDelegate appDelegate] lockScreen:NO];
        [self loadTable:NO beetweenDays:NO];
    }
}

- (void)endRefreshing {
    [self.refreshControl endRefreshing];
    self.calendar.contentView.userInteractionEnabled = YES;
}

- (void)forceRefresh {
    self.calendar.contentView.userInteractionEnabled = NO;
    BOOL isSync=[[AppointmentManager Instance] isSync]&&[SyncManager Instance].is_sync_running;
    if (/*!_isLoading&&*/!isSync) {
        _isLoading = YES;
        if (![[AppointmentManager Instance] isSync]) {
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
            [self.gameTimer stopTimer];
            self.gameTimer = [[GameTimer alloc]initWithLongInterval:REFRESH_LONG_TIMER andShortInterval:REFRESH_SHORT_TIMER andDelegate:self];
            [self.gameTimer startTimer];
            [[SyncManager Instance] syncPhotos];
            [[SyncManager Instance] syncPlans];
            [[SyncManager Instance] syncPDFAttachments];
            [[SyncManager Instance] startSync];
//            [[AppointmentManager Instance] forcedLoadAppointmentsForDate:_dateSelected block:^(id result, NSString *error) {
//                if (error) {
//                    if (![[ActivityIndicator currentIndicator] ishidden]) {
//                        [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
//                    }
//                } else {
//                    NSMutableArray* tempArray=[Appointment getAppointmentsForDate:_dateSelected];
//                    NSMutableArray *customerIds = [NSMutableArray array];
//                    for (Appointment *appointment in tempArray) {
//                        if (appointment.customer_id) {
//                            [customerIds addObject:appointment.customer_id];
//                        }
//                    }
//                    
//                    //                if(_isEstimatesLoaded){
//                    //                    [dataArray addObjectsFromArray:tempArray];
//                    //                }
//                    //                else{
//                    dataArray=[tempArray mutableCopy] ;
//                    if (customerIds.count==0) {
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.tblAppList reloadData];
//                        });
//                    }
//                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//                    [[CustomerManager Instance] refreshCustomersWithIds:customerIds block:^(id result, NSString *error) {
//                        dataArray=[Appointment getAppointmentsForDate:_dateSelected];
//                        [self showInfo];
//                        if (![[ActivityIndicator currentIndicator] ishidden]) {
//                            [[ActivityIndicator currentIndicator] displayCompleted];
//                        }
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.tblAppList reloadData];
//                        });
//                        
//                    }];
//                    //                _isLoading = NO;
//                
//                }
//            }];
            
            
            
            //            [[AppointmentManager Instance] forcedLoadEstimatesForDate:_dateSelected block:^(id result, NSString *error) {
            //                NSMutableArray* tempArray=[Estimate getEstimatesForDate:_dateSelected];
            //                //                                           getAppointmentsForDate:_dateSelected];
            //                NSMutableArray *customerIds = [NSMutableArray array];
            //                for (Estimate *est in tempArray) {
            //                    if (est.customer_id) {
            //                        [customerIds addObject:est.customer_id];
            //                    }
            //                }
            //                [[SyncManager Instance] syncPhotos];
            //                [[SyncManager Instance] syncPlans];
            //                [[SyncManager Instance] syncPDFAttachments];
            //                //                            if(_isEstimatesLoaded){
            //                [dataArray addObjectsFromArray:tempArray];
            //                //                            }
            //                //                            else{
            //                //                                dataArray=[estimates mutableCopy] ;
            //                //                            }
            //
            //                [[CustomerManager Instance] refreshCustomersWithIds:customerIds block:^(id result, NSString *error) {
            //                    dataArray=[Estimate getEstimatesForDate:_dateSelected];
            //                    [self showInfo];
            //                    if (![[ActivityIndicator currentIndicator] ishidden]) {
            //                        [[ActivityIndicator currentIndicator] displayCompleted];
            //                    }
            //                    dispatch_async(dispatch_get_main_queue(), ^{
            //                        [self.tblAppList reloadData];
            //                    });
            //
            //                }];
            //                _isLoading = NO;
            //            }];
        }
    }
    
    
}


-(void)createButtons{
    
    UIImage* image1 = [UIImage imageNamed:@"ic_new_appointments.png"];
    CGRect frameimg1 = CGRectMake(15,5, 25,25);
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:frameimg1];
    [rightButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addNewWorkOrder)
          forControlEvents:UIControlEventTouchUpInside];
    [rightButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIImage* image2 = [UIImage imageNamed:@"menuOrange.png"];
    CGRect frameimg2 = CGRectMake(15,5, 25,25);
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:frameimg2];
    [leftButton setBackgroundImage:image2 forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(menuClicked:)
         forControlEvents:UIControlEventTouchUpInside];
    [leftButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *menuButton =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = menuButton;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addNewWorkOrder {
    if (![[AppDelegate appDelegate] isReachable]) {
        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"No internet connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        return;
    }
    if (self.refreshControl.isRefreshing || [StaticModelLoader Instance].isLoading) {
        if ([[ActivityIndicator currentIndicator] ishidden]) {
            [[ActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Data is still loading. Please wait...", @"")];
        }
        return;
    }
    User *user = [User getUser];
    if (user.mobile_customers_accessValue) {
        Appointment * app = [Appointment newEntity];
        NewWorkOrderViewController *controller = [NewWorkOrderViewController viewControllerWithWorkOrder:app];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:@"You have no access to customers data base"  preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(void)menuClicked:(id)sender{
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}


-(void)addRefreshControl{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(forceRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tblAppList addSubview:self.refreshControl];
}

//need fix
- (void)reloadAppointment {
    BOOL isSync=[[AppointmentManager Instance] isSync]&&[SyncManager Instance].is_sync_running;
    if ([[AppDelegate appDelegate] isReachable]&&!isSync) {
        //        if ([[ActivityIndicator currentIndicator] ishidden]) {
        //            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        _isLoading=YES;
        //        }
        NSMutableArray *appointmentsWithErrors = [[Appointment MR_findAllSortedBy:@"last_sync_date"
                                                                        ascending:YES
                                                                    withPredicate:[NSPredicate predicateWithFormat:@"error_sync_message.length > 0"]
                                                                        inContext:[NSManagedObjectContext MR_defaultContext]]
                                                  mutableCopy];
        if(appointmentsWithErrors.count==0){
            [[SyncManager Instance] startSync];
            _isLoading = YES;
            BOOL isSync=[[AppointmentManager Instance] isSync]&&[SyncManager Instance].is_sync_running;
            if (!isSync) {
                //                [[AppointmentManager Instance] refreshAppointmentsWithBlock:^(id result, NSString *error) {
                //                    _isLoading = NO;
                //                    if (![[ActivityIndicator currentIndicator] ishidden]) {
                //                        [[ActivityIndicator currentIndicator] displayCompleted];
                //                        [self.refreshControl endRefreshing];
                //                    }
                //                    [self.tblAppList reloadData];
                //
                //                    //                        if (!error) {
                //                    //                            [self loadTable:YES];
                //                    //                        }
                //                }];
            }
            else{
                [[ActivityIndicator currentIndicator] displayCompleted];
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Can not refresh"  message:@"Synchronization in progress" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            [self loadAppointments];
//                        [self.gameTimer stopTimer];
//                        self.gameTimer = [[GameTimer alloc]initWithLongInterval:REFRESH_LONG_TIMER andShortInterval:REFRESH_SHORT_TIMER andDelegate:self];
//                        [self.gameTimer startTimer];
        }
        else{
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:@"Some appointments has errors, reloading destroys your not uploaded changes!"  preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Resync" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[SyncManager Instance] startSync];
                [self loadAppointments];
                //                [self.gameTimer stopTimer];
                //                self.gameTimer = [[GameTimer alloc]initWithLongInterval:REFRESH_LONG_TIMER andShortInterval:REFRESH_SHORT_TIMER andDelegate:self];
                //                [self.gameTimer startTimer];
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } else {
        needRefresh=YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshEnded:) name:@"RefreshEnded" object:nil];
    }
}

-(void)tableViewReloadData{
    [self.tblAppList reloadData];
    [self showInfo];
}

-(void)logout{
    dataArray=nil;
    [[AppDelegate appDelegate] logoutWithNav:self.navigationController];
}

- (void)showInfo {
    //    User *user = [User getUser];
    //    if(appointmentArray.count>0 && user.is_adminValue) {
    //    if{
    //        _headerHeightConstraint.constant=0;
    //        _lblTotalApp.hidden=YES;
    //        _lblTotalAmount.hidden=YES;
    //    }
    //    else{
    if((dataArray.count>0)&&(([[User getUser].is_admin boolValue]))){
        _lblTotalApp.hidden=NO;
        _lblTotalAmount.hidden=NO;
        NSString *jobString = @"";
        if (dataArray.count <= 1) {
            jobString = @"";
        }
        _lblTotalApp.text = [NSString stringWithFormat:@"%lu %@",(unsigned long)dataArray.count, jobString];
        [_lblTotalAmount setTextColor:[UIColor blackColor]];
        float total = 0;
        for (id item in dataArray) {
            if ([item isKindOfClass:[Appointment class]]) {
                Appointment* ap=item;
                NSLog(@"balance %@",ap.balance_forward);
//                [ap calculateTaxAmount];
                total = total + [ap getTotalServicePrice];
            }
            if ([item isKindOfClass:[Estimate class]]) {
                Estimate* est=item;
//                [est calculateTaxAmount];
                total = total + [est getFinalTotalDue];
            }
        }
        
        
        _lblTotalAmount.text = [NSString stringWithFormat:@"$%.02f", total];
        [_lblTotalAmount setTextColor:[UIColor blackColor]];
        _lblTotalAmount.font = _lblTotalApp.font = [UIFont systemFontOfSize:18.0];
        dispatch_async(dispatch_get_main_queue(), ^{
            _headerHeightConstraint.constant=_headerHeight;
        });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            _headerHeightConstraint.constant=0;
        });
        _lblTotalApp.hidden=YES;
        _lblTotalAmount.hidden=YES;
    }
    //    }
}


- (void)loadTable:(BOOL)refresh beetweenDays:(BOOL)beetweenValue{
    dataArray = [[NSMutableArray alloc] init];
    User *user = [User getUser];
    if (user == nil) {
        return;
    }
    if (refresh){
        if (!beetweenValue) {
            [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        _isLoading=YES;
        //        _isEstimatesLoaded = NO;
        [[AppointmentManager Instance] loadAppointmentsForDate:_dateSelected block:^(id result, NSString *error) {
            if (error) {
                [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
                [self endRefreshing];
            } else {
                NSArray* appointments=[Appointment getAppointmentsForDate:_dateSelected];
                NSMutableArray *customerIds = [NSMutableArray array];
                for (id item in appointments) {
                    if ([item isKindOfClass:[Appointment class]]) {
                        Appointment *appointment=item;
                        if (appointment.customer_id) {
                            [customerIds addObject:appointment.customer_id];
                        }
                    }
                }
                //            if(_isEstimatesLoaded){
                //                [dataArray addObjectsFromArray:appointments];
                //            }
                //            else{
                dataArray=[appointments mutableCopy] ;
                //            }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tblAppList reloadData];
                });
                [self showInfo];
                
                [[CustomerManager Instance] refreshCustomersWithIds:customerIds block:^(id result, NSString *error) {
                    if (![[ActivityIndicator currentIndicator] ishidden]) {
                        [[ActivityIndicator currentIndicator] displayCompleted];
                    }
                    [self endRefreshing];
                    [self showInfo];
                    //                if(_isEstimatesLoaded){
                    //                    [dataArray addObjectsFromArray:appointments];
                    //                }
                    //                else{
//                    dataArray=[appointments mutableCopy] ;
                    //                }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tblAppList reloadData];
                    });
                }];
            }
            
            
        }];
//                [[AppointmentManager Instance] loadEstimatesForDate:_dateSelected block:^(id result, NSString *error) {
//                    NSArray* estimates=[Estimate getEstimatesForDate:_dateSelected ];
//                    if(_isEstimatesLoaded){
//                        [dataArray addObjectsFromArray:estimates];
//                    }
//                    else{
//                        dataArray=[estimates mutableCopy] ;
//                    }
//                    _isEstimatesLoaded = YES;
//                    [self showInfo];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self.tblAppList reloadData];
//                    });
//                    NSMutableArray *customerIds = [NSMutableArray array];
//                    for (id item in estimates) {
//                        if ([item isKindOfClass:[Estimate class]]) {
//                            Estimate *estimate=item;
//                            if (estimate.customer_id) {
//                                [customerIds addObject:estimate.customer_id];
//                            }
//                        }
//                    }
//                    [[CustomerManager Instance] refreshCustomersWithIds:customerIds block:^(id result, NSString *error) {
//                        if (![[ActivityIndicator currentIndicator] ishidden]) {
//                            [[ActivityIndicator currentIndicator] displayCompleted];
//                        }
//                        [self showInfo];
//                        if(_isEstimatesLoaded){
//                            [dataArray addObjectsFromArray:estimates];
//                        }
//                        else{
//                            dataArray=[estimates mutableCopy] ;
//                        }
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [self.tblAppList reloadData];
//                        });
//                    }];
//                }];
    }
    else{
        dataArray= [Appointment getAppointmentsForDate:_dateSelected];
        //        NSArray* estimates=[Estimate getEstimatesForDate:_dateSelected];
        //        [dataArray addObjectsFromArray:estimates];
        if (dataArray.count>0) {
            [self showInfo];
            [self.tblAppList reloadData];
        }else{
            if([[AppDelegate appDelegate] isReachable]){
                [self loadTable:YES beetweenDays:beetweenValue];
            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tblAppList reloadData];
                });
            }
        }
    }
    
    
}


#pragma mark UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count == 0) {
        return 180;
    }else{
        return 117;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(dataArray.count>0){
        return [dataArray count];
    }
    else{
        [self showInfo];
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    if(dataArray.count == 0)
    {
        static NSString *CellIdentifier = @"Cell";
        NoAppointmentTableViewCell *cell = (NoAppointmentTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"NoAppointmentTableViewCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (NoAppointmentTableViewCell*) appcell;
                }
            }
            
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
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
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppointmentCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppointmentCell*) appcell;
                }
            }
        }
        
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        id item=dataArray[indexPath.row];
        if ([item isKindOfClass:[Appointment class]]) {
            Appointment *app = item;
            [cell setAppointment:app];
            cell.lblSyncErrorAction = ^ (NSInteger tag) {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:app.error_sync_message  preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"Resync" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [app setEntity_status:c_EDITED];
                    [app saveAppointmentOnLocal];
                    if ([[AppDelegate appDelegate] isReachable]) {
                        [[SyncManager Instance] stopTimer];
                        __block NewAppointmentViewController *weakself = self;
                        [app saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [weakself.tblAppList reloadData];
                            });
                            //                            [weakself.tblAppList reloadData];
                            [[SyncManager Instance] startTimer];
                        }];
                    } else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You are offline. The order will synced when you are online." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alert show];
                    }
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            };
        }
        if ([item isKindOfClass:[Estimate class]]) {
            Estimate *est = item;
            [cell setEstimate:est];
            //                    cell.lblSyncErrorAction = ^ (NSInteger tag) {
            //                        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:est.error_sync_message  preferredStyle:UIAlertControllerStyleAlert];
            //                        [alertController addAction:[UIAlertAction actionWithTitle:@"Resync" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //                            [app setEntity_status:c_EDITED];
            //                            [app saveAppointmentOnLocal];
            //                            if ([[AppDelegate appDelegate] isReachable]) {
            //                                [[SyncManager Instance] stopTimer];
            //                                __weak NewAppointmentViewController *weakself = self;
            //                                [app saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
            //                                    [weakself.tblAppList reloadData];
            //                                    [[SyncManager Instance] startTimer];
            //                                }];
            //                            } else {
            //                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You are offline. The order will synced when you are online." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //                                [alert show];
            //                            }
            //                        }]];
            //                        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //                            [alertController dismissViewControllerAnimated:YES completion:nil];
            //                        }]];
            //                        [self presentViewController:alertController animated:YES completion:nil];
            //                    };
            
        }
        cell.hideCustomerInfo= [User getUser].hide_customer_details;
        return cell;
    }
}

//Commet
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row >= dataArray.count) {
        return;
    }
    if (self.refreshControl.isRefreshing || [StaticModelLoader Instance].isLoading) {
        if ([[ActivityIndicator currentIndicator] ishidden]) {
            [[ActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Data is still loading. Please wait...", @"")];
        }
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id data=[dataArray objectAtIndex:indexPath.row];
    
    if([data isKindOfClass:[Appointment class]]){
        Appointment *app =data;
        if ([app.is_sync boolValue]) {
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Warning!"  message:@"Apppointment is synchronizing" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            if (!app.getServiceLocation) {
                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Warning!"  message:@"Apppointment has no service location" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    _isLoading=YES;
//                    [self loadTable:YES beetweenDays:NO];
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    //                    if (!error) {
                    //                        [self loadTable:YES];
                    //                    }
                    
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else{
                [AppDelegate appDelegate].working_appointment_id = app.entity_id;
//                Appointment *fresh_object = [Appointment getById:app.entity_id];
                if ([Utils isPastDate:_dateSelected]) {
                    if ([app.status isEqual:wo_STATUS_COMPLETE]) {
                        NewAppointMentsDetailViewController *controller = [NewAppointMentsDetailViewController initViewControllerAppointment:app];
                        [self.navigationController pushViewController:controller animated:YES];
                        return;
                    }
                }
                if (app.started_at_time) {
                    NewAppointMentsDetailViewController *controller = [NewAppointMentsDetailViewController initViewControllerAppointment:app];
                    [self.navigationController pushViewController:controller animated:YES];
                } else {
                    StartWorkOrderViewController *controller = [StartWorkOrderViewController initViewControllerWithAppointment:app];
                    [self.navigationController pushViewController:controller animated:YES];
                }
            }
        }
    }
    if([data isKindOfClass:[Estimate class]]){
        Estimate* est=data;
        if (!est.getServiceLocation) {
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Warning!"  message:@"Apppointment has no service location" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            [AppDelegate appDelegate].working_appointment_id = est.entity_id;
            Estimate *fresh_object = [Estimate getById:est.entity_id];
            EstimateViewController *controller = [EstimateViewController initViewControllerEstimate:fresh_object];
            [self.navigationController pushViewController:controller animated:YES];
            
            //            if ([Utils isPastDate:_dateSelected]) {
            //                if ([est.status isEqual:wo_STATUS_COMPLETE]) {
            //                    NewAppointMentsDetailViewController *controller = [NewAppointMentsDetailViewController initViewControllerAppointment:fresh_object];
            //                    [self.navigationController pushViewController:controller animated:YES];
            //                    return;
            //                }
            //            }
            //            if (fresh_object.starts_at) {
            //                NewAppointMentsDetailViewController *controller = [NewAppointMentsDetailViewController initViewControllerAppointment:fresh_object];
            //                [self.navigationController pushViewController:controller animated:YES];
            //            } else {
            //                StartWorkOrderViewController *controller = [StartWorkOrderViewController initViewControllerWithAppointment:fresh_object];
            //                [self.navigationController pushViewController:controller animated:YES];
            //            }
        }
        
    }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (dataArray.count <= 0) {
        return NO;
    }
    //    Appointment *app = [appointmentArray objectAtIndex:indexPath.row];
    //    if ([app.status isEqualToString:wo_STATUS_COMPLETE]  || [app.status isEqualToString:wo_STATUS_MISSED]) {
    //        return NO;
    //    }
    return YES;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArray.count <= 0) {
        return @[];
    }
    id item = [dataArray objectAtIndex:indexPath.row];
    if([item isKindOfClass:[Appointment class]]){
        Appointment *app=item;
        NSString* rowActionTitle=@"Change Status";
        UITableViewRowActionStyle* style=UITableViewRowActionStyleNormal;
        style=UITableViewRowActionStyleNormal;
        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:style title:rowActionTitle handler:^(UITableViewRowAction *  action, NSIndexPath *  indexPath) {
            if(![app.status isEqualToString:@"Complete"]){
                NSArray* statuses=[Statuses MR_findAllSortedBy:@"status_name" ascending:YES];
                if (statuses) {
                    UIAlertController * alertController = [UIAlertController
                                                           alertControllerWithTitle:@"Change Status"
                                                           message:nil
                                                           preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancelAction = [UIAlertAction
                                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                                   style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction *action)
                                                   {
                                                       NSLog(@"Cancel action");
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                   }];
                    [alertController addAction:cancelAction];
                    for (Statuses* status in statuses) {
                        NSString* statusName=status.status_name;
                        if(![statusName isEqualToString:@"Complete"]){
                            UIAlertAction *statusAction = [UIAlertAction
                                                           actionWithTitle:statusName
                                                           style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action)
                                                           {
                                                               //                                                   [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
                                                               _isLoading = YES;
                                                               [app setStatus:status.status_value];
                                                               if ([[AppDelegate appDelegate] isReachable]) {
                                                                   [app saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                                                                       [app saveAppointmentOnLocal];
                                                                       //                                                       if (![[ActivityIndicator currentIndicator] ishidden]) {
                                                                       //                                                           [[ActivityIndicator currentIndicator] displayCompleted];
                                                                       //                                                       }
                                                                   }];
                                                                   [tableView endEditing:YES];
                                                                   [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                                               }
                                                               [alertController dismissViewControllerAnimated:YES completion:nil];
                                                           }];
                            [alertController addAction:statusAction];
                        }
                    }
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            else{
                UIAlertController *    alertController = [UIAlertController
                                                          alertControllerWithTitle:@"Warning!"
                                                          message:@"Status of Completed order can't be changed"
                                                          preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction
                                               actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                               style:UIAlertActionStyleCancel
                                               handler:^(UIAlertAction *action)
                                               {
                                                   NSLog(@"Cancel action");
                                                   [alertController dismissViewControllerAnimated:YES completion:nil];
                                               }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
        [action setBackgroundColor:[UIColor colorWithRed:(101.0/255.0) green:(107.0/255.0) blue:(124.0/255.0) alpha:1]];
        return @[action];
    }
    return @[];
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark Calendar


#pragma mark - CalendarManager delegate

// Exemple of implementation of prepareDayView method
// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    // Today
    if([self.calendar.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor lightGrayColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Selected date
    else if(_dateSelected && [self.calendar.dateHelper date:_dateSelected isTheSameDayThan:[dayView.date changeTimeZoneToLocal]]){
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    // Other month
    else if(![self.calendar.dateHelper date:calendarContentView.date isTheSameMonthThan:dayView.date]){
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another day of the current month
    else{
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }
    
    //    if([self haveEventForDay:dayView.date]){
    //        dayView.dotView.hidden = NO;
    //    }
    //    else{
    //        dayView.dotView.hidden = YES;
    //    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    //    BOOL isSync=[[AppointmentManager Instance] isSync]&&[SyncManager Instance].is_sync_running;
    //    BOOL isLoading=[[StaticModelLoader Instance] isLoading];
    //    if (isLoading) {
    _dateSelected = [ dayView.date changeTimeZoneToLocal];
    [self loadTable:NO beetweenDays:YES];
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [self.calendar reload];
                    } completion:nil];
    
    
    // Load the previous or next page if touch a day from another month
    
    if(![self.calendar.dateHelper date:calendarContentView.date isTheSameMonthThan:_dateSelected]){
        if([calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            //            [calendarContentView loadNextPageWithAnimation];
        }
        else{
            //            [calendarContentView loadPreviousPageWithAnimation];
        }
    }
    //    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}
#pragma mark - CalendarManager delegate - Page mangement

// Used to limit the date for the calendar, optional
- (BOOL)calendar:(JTCalendarManager *)calendar canDisplayPageWithDate:(NSDate *)date
{
    
    return YES;
    //return [self.calendar.dateHelper date:date isEqualOrAfter:_minDate andEqualOrBefore:_maxDate];
}

- (void)calendarDidLoadNextPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Next page loaded");
    NSString *month = [calendar.date stringWithFormat:@"MMMM"];
    self.navigationItem.title = month;
}

- (void)calendarDidLoadPreviousPage:(JTCalendarManager *)calendar
{
    //    NSLog(@"Previous page loaded");
    NSString *month = [calendar.date stringWithFormat:@"MMMM"];
    self.navigationItem.title = month;
}

- (void)transition
{
    [self.view bringSubviewToFront:calendarContentView];
    
    CGFloat newHeight = 300;
    if(self.calendar.settings.weekModeEnabled){
        newHeight = 70.;
    }
    
    CGRect frame = calendarContentView.frame;
    frame.size.height = newHeight;
    
    [self.calendar reload];
    
    _calendarHeightContraint.constant = newHeight;
    
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
    
}


#pragma mark - GameTimer delegate methods

-(void)longTimerExpired:(GameTimer *)gameTimer{
    //     _isLoading = NO;
    //    [self loadTable];
//        [self.refreshControl endRefreshing];
}

-(void) loadAppointments{
    BOOL isDirtyAppointmentsFound = [[AppointmentManager Instance] scanForDirtyAppointments];
    if (!isDirtyAppointmentsFound) {
        //        [self.gameTimer stopTimer];
        //        self.gameTimer = nil;
        _isLoading = YES;
        BOOL isSync=[[AppointmentManager Instance] isSync]&&[SyncManager Instance].is_sync_running;
        if (!isSync) {
            [self loadTable:YES beetweenDays:NO];
            
            //            [[AppointmentManager Instance] refreshAppointmentsWithBlock:^(id result, NSString *error) {
            //                _isLoading = NO;
            //                dispatch_async(dispatch_get_main_queue(), ^{
            //                    if (![[ActivityIndicator currentIndicator] ishidden]) {
            //                        [[ActivityIndicator currentIndicator] displayCompleted];
            //                        [self.refreshControl endRefreshing];
            //                    }
            //                    if (!error) {
            //                    }
            //                });
            //            }];
        }
        else{
            [[ActivityIndicator currentIndicator] displayCompleted];
            [self endRefreshing];
            UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Can not refresh"  message:@"Synchronization in progress" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

                [alertController dismissViewControllerAnimated:YES completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
}

-(void)shortTimerExpired:(GameTimer *)gameTimer time:(float)time longInterval:(float)longInterval{
    if (![[AppointmentManager Instance] scanForDirtyAppointments]) {
        [self.gameTimer stopTimer];
        self.gameTimer = nil;
        [[AppointmentManager Instance] forcedLoadAppointmentsForDate:_dateSelected block:^(id result, NSString *error) {
            if (error) {
                if (![[ActivityIndicator currentIndicator] ishidden]) {
                    [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
                }
                [self endRefreshing];
            } else {
                NSMutableArray* tempArray=[Appointment getAppointmentsForDate:_dateSelected];
                NSMutableArray *customerIds = [NSMutableArray array];
                for (Appointment *appointment in tempArray) {
                    if (appointment.customer_id) {
                        [customerIds addObject:appointment.customer_id];
                    }
                }
                
                //                if(_isEstimatesLoaded){
                //                    [dataArray addObjectsFromArray:tempArray];
                //                }
                //                else{
                dataArray=[tempArray mutableCopy] ;
                if (customerIds.count==0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tblAppList reloadData];
                    });
                }
                [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                [[CustomerManager Instance] refreshCustomersWithIds:customerIds block:^(id result, NSString *error) {
                    dataArray=[Appointment getAppointmentsForDate:_dateSelected];
                    [self showInfo];
                    if (![[ActivityIndicator currentIndicator] ishidden]) {
                        [[ActivityIndicator currentIndicator] displayCompleted];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self endRefreshing];
                        [self.tblAppList reloadData];
                    });
                    
                }];
                //                _isLoading = NO;
                
            }
        }];
    }
//        BOOL isDirtyAppointmentsFound = [[AppointmentManager Instance] scanForDirtyAppointments];
//        if (isDirtyAppointmentsFound) {
//
//        }else{
//            [self.gameTimer stopTimer];
//            self.gameTimer = nil;
//            _isLoading = YES;
//            BOOL isSync=[[AppointmentManager Instance] isSync]&&[SyncManager Instance].is_sync_running;
//            if (!isSync) {
//                [[AppointmentManager Instance] refreshAppointmentsWithBlock:^(id result, NSString *error) {
//                    _isLoading = NO;
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (![[ActivityIndicator currentIndicator] ishidden]) {
//                            [[ActivityIndicator currentIndicator] displayCompleted];
//                            [self.refreshControl endRefreshing];
//                        }
//                        if (!error) {
//                            [self loadTable:YES beetweenDays:NO];
//                        }
//                    });
//                }];
//            }
//            else{
//                [[ActivityIndicator currentIndicator] displayCompleted];
//                [self.refreshControl endRefreshing];
//                UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"Can not refresh"  message:@"Synchronization in progress" preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//                    [alertController dismissViewControllerAnimated:YES completion:nil];
//                }]];
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//
//        }
}

-(IBAction)PaymentClick:(id)sender
{
    
}

//-(BOOL) array:(NSArray*)array containsArray:(NSArray*) anotherArray{
//    for (id item in anotherArray) {
//        NSNumber* entity_id=@0;
//        if ([item isKindOfClass:[Appointment class]]) {
//            Appointment* app=item;
//            entity_id=app.entity_id;
//        }
//        if ([item isKindOfClass:[Estimate class]]) {
//            Estimate* est=item;
//            entity_id=est.entity_id;
//        }
//        NSUInteger index = [array indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
//            if ([item isKindOfClass:[Appointment class]]) {
//                Appointment* app=item;
//                return entity_id==app.entity_id;
//            }
//            if ([item isKindOfClass:[Estimate class]]) {
//                Estimate* est=item;
//                return entity_id==est.entity_id;
//            }
//            return NO;
//        }];
//        return (index!=NSNotFound);
//    }
//  
////    if (index != NSNotFound) {
////        cell = validCells[index];
////    }
////    NSMutableSet *set = [[NSMutableSet alloc] initWithArray:array] ;
////    NSMutableSet *anotherSet = [[NSMutableSet alloc] initWithArray:anotherArray];
////    [set intersectSet:anotherSet];
////    return ([set allObjects].count>0);
//}

-(BOOL) appointmentArray:(NSArray*)array containsArray:(NSArray*) anotherArray{
    BOOL contains=NO;
    for(Appointment* appOne in array){
        for(Appointment* appTwo in anotherArray){
            if([appOne.entity_id isEqualToNumber:appTwo.entity_id]){
                contains=YES;
            }
        }
    }
    return YES;
}

-(void) refreshEnded:(NSNotification*) notification {
    //    if ([notification.name isEqualToString:@"RefreshEnded"]) {
    //        if (needRefresh) {
    //            [self forceRefresh];
    //            needRefresh=NO;
    //        }
    //        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshEnded" object:nil];
    //
    //    }
}

@end
