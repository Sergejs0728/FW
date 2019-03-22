//
//  FWMenuViewController.m
//  FieldWork
//
//  Created by Samir on 10/28/15.
//
//

#import "FWMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "MFSideMenu.h"
#import "SettingController.h"

@interface FWMenuViewController ()
{
    NSArray *arrayMenu;
    NSArray *imgAray;
}
@end

@implementation FWMenuViewController

+(FWMenuViewController *)initViewController{
    
    FWMenuViewController *controller;
    
    controller = [[FWMenuViewController alloc]initWithNibName:@"FWMenuViewController" bundle:nil];
    
    return controller;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kLOGOUT object:nil];

    self.view.bounds = [UIScreen mainScreen].bounds;

    
    arrayMenu=[NSArray arrayWithObjects:@"Calendar",@"Customer",@"Work Pool",@"Settings", nil];
    imgAray = [NSArray arrayWithObjects:@"ic_calendar.png",@"ic_units.png",@"ic_lineup_with_dot.png",@"ic_service_instructions.png", nil];
    
    
    
    
    
    _appController = [[NewAppointmentViewController alloc]init];
    self.appointmentsNavigationController = [[UINavigationController alloc] initWithRootViewController:_appController];
    [self.appointmentsNavigationController.navigationBar setTranslucent:NO];
    
    
    CustomerListViewController *custController = [CustomerListViewController init];
    self.customersNavigationController = [[UINavigationController alloc] initWithRootViewController:custController];
    [self.customersNavigationController.navigationBar setTranslucent:NO];
    
    WorkPoolViewController *workController = [[WorkPoolViewController alloc]init];
    self.workPoolNavigationController = [[UINavigationController alloc] initWithRootViewController:workController];
    [self.workPoolNavigationController.navigationBar setTranslucent:NO];
    
    SettingController *settController = [SettingController init];
    self.settingsNavigationController = [[UINavigationController alloc] initWithRootViewController:settController];
    [self.settingsNavigationController.navigationBar setTranslucent:NO];
    
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
}

- (void)logout {
//    if (![[AppDelegate appDelegate]isReachable]) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"You cannot logout without internet" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertView show];
//        return;
//    }
    id target = nil;
    target = self.appointmentsNavigationController;
    [self.menuContainerViewController setCenterViewController:target];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.appController logout];
    });
}

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    NSLog(@"Side Menu Closed.");
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];

}


-(void)reachabilityChanged:(NSNotification*)note{
    FWReachability * reach = [FWReachability reachabilityForInternetConnection];
    if(![reach isReachable]){
        _imgInternetStatus.image = [UIImage imageNamed:@"wi-fi_white-op.png"];
        _lblStatusText.alpha = 0.5f;
         _lblStatusText.text = @"You are currently offline";
    }else{
        
        _imgInternetStatus.image = [UIImage imageNamed:@"wi-fi_white.png"];
        _lblStatusText.alpha = 1.0f;
          _lblStatusText.text = @"You are currently online";
       
    }
}
-(void)setNavColor:(UIColor *)navColor forNavControl:(UINavigationController *)navControl{
    [navControl.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : navColor}];
    
    self.navigationController.navigationBar.tintColor =navColor;
}


-(UIColor *)getNavigationColor{
    return [UIColor colorWithRed:231.0/256.0 green:76.0/256.0 blue:58.0/256.0 alpha:1.0];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [arrayMenu count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    static NSString *CellIdentifier = @"SideCell";
    
    SideTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"SideTableViewCell" owner:self options:nil];
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (SideTableViewCell*) currentObject;
            }
        }
        topLevelObject = nil;
    }
    
    
    cell.lblTitle.text = [arrayMenu objectAtIndex:indexPath.row];
    cell.imgView.image = [UIImage imageNamed:[imgAray objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    __block id target = nil;
    BOOL goOn = YES;
    
    switch (indexPath.row)
    {
        case 0:
            //           tempNavController.navigationBar.translucent = NO;
            //            [self setNavColor:[self getNavigationColor] forNavControl:tempNavController];
            target = self.appointmentsNavigationController;
            
            break;
        case 1: {
            goOn = NO;
//            User *user = [User getUser];
//            if (user == nil) {
//                user = [User createNewUser];
//            }
//            [user loadUserWithBlock:^(BOOL success, NSError *error) {
//                if (success) {
                    User *user = [User getUser];
                    if (user.mobile_customers_accessValue) {
                        target = self.customersNavigationController;
                        [self goToController:target];
                    } else {
                        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:@"You have no access to customers data base"  preferredStyle:UIAlertControllerStyleAlert];
                        
                        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                            [alertController dismissViewControllerAnimated:YES completion:nil];
                        }]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
//                }
//            }];
        }
            break;
        case 2:
            target = self.workPoolNavigationController;
            break;
        case 3:
            target = self.settingsNavigationController;
            
            break;
      
    
        default:
            break;
    }
    if (goOn) [self goToController:target];
    
}

- (void)goToController:(id)target {
    [self.menuContainerViewController setCenterViewController:target];
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}

-(void)logoutClicked:(id)sender{
    [self logout];
}


@end
