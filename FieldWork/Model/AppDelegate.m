
//  AppDelegate.m
//  FieldWork
//
//  Created by Samir Kha on 05/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "DocumentListViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "FWMenuViewController.h"
#import "MFSideMenu.h"
#import "User.h"
#import "SyncManager.h"
#import <Fabric/Fabric.h>
#import "EstimateViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "UIAlertController+Blocks.h"

//@interface AppDelegate ()
//{
//    MFSideMenuContainerViewController *_containerVC;
//}



//@end

@implementation AppDelegate
@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize barcode_object=_barcode_object;
@synthesize working_appointment_id;
@synthesize containerVC=_containerVC;


+(AppDelegate*)appDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

+ (NSInteger)OSVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Fabric with:@[[STPAPIClient class], [Crashlytics class], [Answers class]]];
    
    [self setupCoreDataDB];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"DB Path : %@",[paths objectAtIndex:0]);
    
    [[Location Instance] startLocationManager];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}]; //colorWithRed:22.0/256 green:22.0/256 blue:22.0/256 alpha:1]}];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:231.0/255.0 green:76.0/255.0 blue:58.0/255.0 alpha:1.0]];
    
    [[UIBarButtonItem appearance] setTintColor:RED_COLOR];
    
    FWMenuViewController *sideMenu=[FWMenuViewController initViewController];
    
    _containerVC = [MFSideMenuContainerViewController
                    containerWithCenterViewController:self.navigationController
                    leftMenuViewController:sideMenu
                    rightMenuViewController:nil];
    
    _containerVC.panMode =  MFSideMenuPanModeDefault;
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:_containerVC];
    
    [self.window setRootViewController:nav];
    _lockView = [[UIView alloc] initWithFrame:self.window.bounds];
    _lockView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _lockView.backgroundColor = [UIColor clearColor];
    
    [self.window setBackgroundColor:[UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0]];
    
    if (![PhotoAttachment isTnumbnailsFolderExists]) {
        NSArray *photos = [PhotoAttachment MR_findAll];
        for (PhotoAttachment *pa in photos) {
            [pa createThumbForImage:[pa getImg]];
        }
    }
    
    User *user = [User getUser];
    if ([AccountManager Instance].activeAccount != nil && user != nil) {
        [KitLocateTasker Instance];
        NSString *strip_key = user.stripe_pk;
        //        NSString *strip_key = @"pk_test_6pRNASCoBOKtIshFeQd4XMUh";
        [Stripe setDefaultPublishableKey:strip_key];
        NSArray *photos = [PhotoAttachment getSyncingPhotos];
        if (photos.count) {
            for (PhotoAttachment *photo in photos) {
                [photo setSync_status:c_DIRTY];
            }
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            [[SyncManager Instance] syncPhotos];
            [[SyncManager Instance] syncPlans];
            [[SyncManager Instance] syncPDFAttachments];
        }
        
        
        [[CustomerManager Instance] loadCustomersAllWithBlock:^(id result, NSString *error) {
            //            [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
        }];
    }
    self.internetConnectionReach = [FWReachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    _runningFirstTime = YES;
    [self.internetConnectionReach startNotifier];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)setupCoreDataDB {
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"FWModel.sqlite"];
    [MagicalRecord setLoggingLevel:MagicalRecordLoggingLevelOff];
}

- (void)resetCoreDataDB
{
    [MagicalRecord cleanUp];
    [self deleteFilesInLibraryDirectory];
    [self setupCoreDataDB];
}

- (void)deleteFilesInLibraryDirectory
{
    NSString* folderPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSError *error = nil;
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error])
    {
        [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
        if(error)
        {
            NSLog(@"Delete error: %@", error.description);
        }
    }
}

- (BOOL)isScreenLocked {
    return _lockView.superview != nil;
}

- (void)lockScreen:(BOOL)lock {
    if (lock) {
        [self.window addSubview:_lockView];
    } else {
        [_lockView removeFromSuperview];
    }
}

#pragma mark - Reachability

-(void)reachabilityChanged:(NSNotification*)note
{
    //    FWReachability * reach = [note object];
    self.internetConnectionReach = [FWReachability reachabilityForInternetConnection];
    
    if (_runningFirstTime == YES) {
        _runningFirstTime = NO;
        return;
    }
    
    if([self.internetConnectionReach isReachable])
    {
        NSLog(@"INTERNET CONNECTION AVAILABLE");
        //26112015
        
//        [self loadAllLists];
        [[SyncManager Instance] syncPhotos];
        [[SyncManager Instance] syncPlans];
        [[SyncManager Instance] syncPDFAttachments];
        [[SyncManager Instance] startSync];

    }
    else
    {
        NSLog(@"INTERNET CONNECTION IS NOT AVAILABLE");
        
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [[SyncManager Instance] stopTimer];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    
    NSLog(@"applicationWillEnterForeground");
    
}

- (void)loadAllListsSilent:(BOOL)silent completion:(void (^)(NSMutableArray* failedList))completion {
    [self loadLists:nil silent:silent completion:completion];
}

- (void)loadLists:(NSArray*)lists silent:(BOOL)silent completion:(void (^)(NSMutableArray* failedList))completion {
    if ([[AppDelegate appDelegate] isReachable]) {
        [[StaticModelLoader Instance] loadStatuses];
        [[StaticModelLoader Instance] loadLists:lists completion:^(NSMutableArray *failedList) {
            if (failedList.count) {
                if (silent) {
                    [self loadLists:failedList silent:silent completion:completion];
                } else {
                    if (![[ActivityIndicator currentIndicator] ishidden]) {
                        [[ActivityIndicator currentIndicator] hide];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        BOOL wasLocked = [self isScreenLocked];
                        [self lockScreen:NO];
                        [UIAlertController showAlertInViewController:self.window.rootViewController
                                                           withTitle:NSLocalizedString(@"Error", @"")
                                                             message:NSLocalizedString(@"Some important data wasn't loaded. Please try again.", @"")
                                                   cancelButtonTitle:NSLocalizedString(@"Cancel", @"") destructiveButtonTitle:NSLocalizedString(@"Reload", @"")
                                                   otherButtonTitles:nil
                                                            tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                                                                [self lockScreen:wasLocked];
                                                                if (buttonIndex == controller.destructiveButtonIndex) {
                                                                    [[ActivityIndicator currentIndicator]displayActivity:@"Loading data..."];
                                                                    [self loadLists:failedList silent:silent completion:completion];
                                                                } else {
                                                                    if (completion) {
                                                                        completion(failedList);
                                                                    }
                                                                }
                                                            }];
                    });
                }
            } else {
                if (completion) {
                    completion(failedList);
                }
            }
        }];
    } else {
        if (completion) {
            completion([[StaticModelLoader Instance] emptyLists]);
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    NSLog(@"applicationDidBecomeActive");
    //    if ([AppointmentList Instance].Appointments.count <= 0) {
    //        DataSaver *saver = [[DataSaver alloc] init];
    //        [saver reloadAppointmentFromSaved];
    //    }
    User *user = [User getUser];
    if ([AccountManager Instance].activeAccount == nil || user == nil) {
        [self showLogin:NO];
    }else{
        //[KitLocateTasker Instance];
        if ([self isReachable]) {
            if (user) {
                [user loadUserWithBlock:^(BOOL success, NSError *error) {
                    if (success) {
                        User *user = [User getUser];
                        NSString *strip_key = user.stripe_pk;
                        //                    NSString *strip_key = @"pk_test_6pRNASCoBOKtIshFeQd4XMUh";
                        [Stripe setDefaultPublishableKey:strip_key];
                    }
                }];
                [[SyncManager Instance] startTimer];
            }
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    NSLog(@"Application will terminate");
    
}

- (BOOL)isReachable {
    //    BOOL isOfflineMode = [UserSetting getOfflineMode];
    //    if (isOfflineMode == NO) {
    //        FWReachability *reach =[FWReachability reachabilityWithHostname:@"app.fieldworkhq.com"];
    //        return [reach isReachable];
    //    }else{
    //        return NO;
    //    }
    FWReachability *reach =[FWReachability reachabilityWithHostname:@"app.fieldworkhq.com"];
    
    return [reach isReachable];
}

#pragma Custom Methods

- (void)showLogin:(BOOL)animated{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"UserName"]) {
        _username = [userDefaults objectForKey:@"UserName"];
    }
    LoginController *login = [LoginController loginViewControllerWithUsername:_username];
    login.delegate = self;
    
    
    
    UINavigationController *navControl = [[UINavigationController alloc] initWithRootViewController:login];
    [navControl.navigationBar setTintColor:[UIColor colorWithRed:53.0/255 green:152.0/255.0 blue:219.0/255.0 alpha:1.0]];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}]; //colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1]}];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
    [navControl.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1]}];
    
    navControl.navigationBar.tintColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
    
    [navControl.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    //    navControl.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    navControl.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    
    
    int64_t delay = 0; // In seconds
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^(void){
        [self.navigationController presentViewController:navControl animated:YES completion:^{
            
        }];
    });
}

- (void) logoutWithNav:(UINavigationController *)nctr{
//    NSArray *photos = [PhotoAttachment MR_findAll];
//    for (PhotoAttachment *pa in photos) {
//        [pa clearImages];
//    }
//    [PhotoAttachment clearThumbnailsFolder];
//    [[AppointmentManager Instance]clearAllAppointments];
//    [[CustomerManager Instance]clearAllCustomerandDevices];
//    [[StaticModelLoader Instance]deleteAll];
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
    self.navigationController = nctr;
    [nctr popToRootViewControllerAnimated:NO];
    //26112015
    //    BOOL isOfflineMode = [UserSettings getOfflineMode];
    //    if (isOfflineMode == YES) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"You can not logout in Offline Mode." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    //        [alert show];
    //        return;
    //    }
    //26112015
    //    BOOL isSyncing = [[SyncHelper Instance] isSyncing];
    //    if (isSyncing == YES) {
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"You can not logout while syncing." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    //        [alert show];
    //        return;
    //    }
    
    //    [_containerVC.navigationController dismissViewControllerAnimated:YES completion:nil];
//    [AccountManager Instance].activeAccount = nil;
    //26112015
    //    [AppointmentList Instance].Appointments = [[NSMutableArray alloc] init];
    //    [CustomerList Instance].Customers = [[NSMutableArray alloc] init];
    [User MR_truncateAll];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [[SyncManager Instance] stopTimer];
    
    [self showLogin:TRUE];
}

#pragma LoginControllerDelegate

- (void)userDidLoginWithAccount:(FieldWorkAccount *)account {
    BOOL theSameUser = [account.api_key isEqual:[AccountManager Instance].activeAccount.api_key];
    [AccountManager Instance].activeAccount = account;
    User *user = [User getUser];
    if (user == nil) {
        user = [User createNewUser];
//        [self loadAllListsWithCompletion:^(NSMutableArray *failedList) {
//            if (failedList.count == 0) {
//                if (![[ActivityIndicator currentIndicator] ishidden]) {
//                    [[ActivityIndicator currentIndicator] displayCompleted];
//                }
//                [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
//            }
//        }];
    } else {
        [[StaticModelLoader Instance] loadStatuses];
    }
    [Appointment MR_truncateAll];
    [Customer MR_truncateAll];
    if (!theSameUser) {
        NSArray *photos = [PhotoAttachment MR_findAll];
        for (PhotoAttachment *pa in photos) {
            [pa clearImages];
        }
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
    [user loadUserWithBlock:^(BOOL success, NSError *error) {
        if (success) {
            User *user = [User getUser];
            NSString *strip_key = user.stripe_pk;
            [Stripe setDefaultPublishableKey:strip_key];
            
//            [[StaticModelLoader Instance] loadStatuses];
//            [[SyncManager Instance] syncPhotos];
//            [[SyncManager Instance] syncPlans];
//            [[SyncManager Instance] syncPDFAttachments];
            [[SyncManager Instance] startUpdateTimer];
            NSLog(@"%@",[User getUser].stripe_pk);
            [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [KitLocateTasker Instance];
                [[SyncManager Instance] startTimer];
                [[CustomerManager Instance] loadCustomersAllWithBlock:^(id result, NSString *error) {
                    
                }];
            }];
            
        }
    }];

}

#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"FWModel.sqlite"]];
    
    NSError *error = nil;
    NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}

- (BOOL)saveManageObjectContext {
    NSError *error;
    if (![managedObjectContext save:&error]) {
        return NO;
    }
    return YES;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSMutableArray*) getSplittedComponentsFromString:(NSString*)str withSaperator:(NSString*)sep
{
    NSMutableArray *arr = [[str componentsSeparatedByString:sep] mutableCopy];
    if (arr.count > 0) {
        NSString *last_part = [arr lastObject];
        if ([last_part rangeOfString:@"("].location != NSNotFound) {
            NSMutableArray *temp = [self getSplittedComponentsFromString:last_part withSaperator:@"("];
            if (temp.count > 0) {
                [arr removeObject:[arr lastObject]];
                [arr addObject:[temp objectAtIndex:0]];
            }
        }
    }
    return arr;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSString *__error = nil;
    NSString *file_name = [url lastPathComponent];
    BOOL is_form=NO;
    
    NSMutableArray *components = [self getSplittedComponentsFromString:file_name withSaperator:@"-"];
    NSString* prefix=[components objectAtIndex:0];
    
    BOOL is_existing_attachement = NO;
    for (NSString *someString in components) {
        if ([someString isEqualToString:@"att"]||[someString isEqualToString:@"att.pdf"]) {
            is_existing_attachement = YES;
            [components removeObject:someString];
            break;
        }
    }
    
    for (NSString *someString in components) {
        if ([someString isEqualToString:@"form.pdf"]||[someString isEqualToString:@"form"]) {
            is_form = YES;
            [components removeObject:someString];
            break;
        }
    }
    
    // if file name is like att_343_343, that means it is opened from existing attachments.
    
    // the file name always contains first entityId and second appointmentId. Now in components array the first object is entity_id and second object is appointment_id
    // Now if it is opened from existing attachment, we will replace that file with new file, otherwise add new file for the attachment.
    
    // at this point components must have atleast 2 objects
    
    
    
    
    if (is_existing_attachement||is_form) {
        if(is_existing_attachement) {
            NSRange rangeFirst = [file_name rangeOfString:@"#"];
            //            NSString* substr=[file_name substringWithRange:rangeFirst];
            NSRange rangeSecond = [file_name rangeOfString:@" "];
            
            NSRange newRange=NSMakeRange(rangeFirst.location+1,rangeSecond.location-rangeFirst.location);
            NSString* appointment_id_str=[file_name substringWithRange:newRange];
            NSNumber *appointment_id = [NSNumber numberWithInt:[appointment_id_str intValue]];
            NSString* pdfFormStr=@"";
            for (NSString* component in components) {
                if ([component containsString:@"["]&&[component containsString:@"]"]) {
                    NSString* tmp_component=[component substringFromIndex:1];
                    pdfFormStr=[tmp_component substringToIndex:tmp_component.length-1];
                }
            }
            
            NSNumber *pdf_form_id = [NSNumber numberWithInt:[pdfFormStr intValue]];
            // now we first find appointmen
            Estimate* est;
            Appointment *appt;
            if([prefix isEqualToString:@"est"]){
                est=[Estimate MR_findFirstByAttribute:@"entity_id" withValue:appointment_id];
            }
            else{
                appt = [Appointment MR_findFirstByAttribute:@"entity_id" withValue:appointment_id];
            }
            if (appt||est) {
                if (appt) {
                    [appt setEntity_status:c_EDITED];
                }
                else{
                    [est setEntity_status:c_EDITED];
                }
                
                // Now loop the attachments and verify whether the ID we got from file is exist or not ?
                NSSet *filtered;
                if (appt) {
                    filtered = [appt.attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  evaluatedObject, NSDictionary * bindings) {
                        PDFAttachment *pdf_att = (PDFAttachment*) evaluatedObject;
                        if ([pdf_att.pdf_form_id isEqualToNumber:pdf_form_id]) {
                            return YES;
                        }
                        return NO;
                    }]];
                }
                else{
                    if (est) {
                        filtered = [est.attachments filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  evaluatedObject, NSDictionary * bindings) {
                            PDFAttachment *pdf_att = (PDFAttachment*) evaluatedObject;
                            if ([pdf_att.pdf_form_id isEqualToNumber:pdf_form_id]) {
                                return YES;
                            }
                            return NO;
                        }]];
                    }
                }
                // Now we should get atleast one record for the attachment
                if (filtered.count > 0) {
                    // get the first object from the set
                    PDFAttachment *pdf_attachment = [[filtered allObjects] objectAtIndex:0];
                    // Now overwrite the existing file withe the same name. But first delete the existing file.
                    [pdf_attachment setAttachment_file_name:file_name];
                    if (pdf_attachment.attached_pdf_form_file_name==NULL) {
                        [pdf_attachment setAttached_pdf_form_file_name: file_name];
                    }
                    NSString *existing_file_path = [pdf_attachment pdfFilePath];
                    if ([[NSFileManager defaultManager] isDeletableFileAtPath:existing_file_path]) {
                        NSError *error = nil;
                        BOOL success = [[NSFileManager defaultManager] removeItemAtPath:existing_file_path error:&error];
                        if (!success) {
                            NSLog(@"Error removing file at path: %@", error.localizedDescription);
                        }
                    }
                    NSData *datapdf = [NSData dataWithContentsOfURL:url];
                    if(datapdf){
                        [datapdf writeToFile:[pdf_attachment pdfFilePath] atomically:YES];
                        if (![pdf_attachment.entity_status isEqualToNumber:c_ADDED]) {
                            [pdf_attachment setEntity_status:c_EDITED];
                        }
                        if(appt){
                            [appt setEntity_status:c_EDITED];
                        }
                        else{
                            if (est) {
                                [est setEntity_status:c_EDITED];
                            }
                        }
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    } else {
                        __error = @"Error occured in writing PDF file. Please try again.";
                    }
                } else {
                    __error = @"Could not find existing attachment.";
                }
            } else {
                __error = @"Could not find appointment based on the file.";
            }
        } else {
            NSRange rangeFirst = [file_name rangeOfString:@"#"];
            NSRange rangeSecond = [file_name rangeOfString:@" "];
            NSRange newRange=NSMakeRange(rangeFirst.location+1,rangeSecond.location-rangeFirst.location);
            NSString* appointment_id_str=[file_name substringWithRange:newRange];
            NSNumber *appointment_id = [NSNumber numberWithInt:[appointment_id_str intValue]];
            NSString* pdfFormStr=@"";
            for (NSString* component in components) {
                if ([component containsString:@"["]&&[component containsString:@"]"]) {
                    NSString* tmp_component=[component substringFromIndex:1];
                    pdfFormStr=[tmp_component substringToIndex:tmp_component.length-1];
                }
            }
            NSNumber *pdf_form_id = [NSNumber numberWithInt:[pdfFormStr intValue]];
            
            Estimate* est;
            Appointment *appt;
            if([prefix isEqualToString:@"est"]){
                est=[Estimate MR_findFirstByAttribute:@"entity_id" withValue:appointment_id];
            }
            else{
                appt = [Appointment MR_findFirstByAttribute:@"entity_id" withValue:appointment_id];
            }
            if (appt||est) {
                NSSet *filtered;
                if(appt){
                    filtered = [appt.pdf_forms filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  evaluatedObject, NSDictionary * bindings) {
                        PDFAttachment *pdf_form = (PDFAttachment*) evaluatedObject;
                        if ([pdf_form.entity_id isEqualToNumber:pdf_form_id]) {
                            return YES;
                        }
                        return NO;
                    }]];
                }
                else{
                    if (est) {
                        filtered = [est.pdf_forms filteredSetUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  evaluatedObject, NSDictionary * bindings) {
                            PDFAttachment *pdf_form = (PDFAttachment*) evaluatedObject;
                            if ([pdf_form.entity_id isEqualToNumber:pdf_form_id]) {
                                return YES;
                            }
                            return NO;
                        }]];
                    }
                }
                // We should get atleast one object of FWPDFForm.
                if (filtered.count > 0) {
                    // Now create PDFAttachment object and add into appointment.
                    FWPDFForm *form = [[filtered allObjects] objectAtIndex:0];
                    PDFAttachment *attachment = [form getRelatedAttachmentForAppointId:appt.entity_id];
                    if (attachment == nil) {
                        attachment = [PDFAttachment newPDFAttachmentWithAppointmentId:appointment_id andPDFForm:form];
                        [attachment setAttached_pdf_form_file_name:form.name];
                        [attachment setAttachment_file_name:file_name];
                        [attachment setAttached_pdf_form_content_type:form.document_content_type];
                        [attachment setAttachment_content_type:form.document_content_type];
                        if (appt) {
                            [appt addAttachmentsObject:attachment];
                            [attachment setAppointment:appt];
                        }
                        else{
                            if (est) {
                                [est addAttachmentsObject:attachment];
                                [attachment setEstimate:est];
                                
                            }
                        }
                        [attachment setPdf_form:form];
                        [attachment setPdf_form_id:form.entity_id];
                    }
                    
                    NSData *datapdf = [NSData dataWithContentsOfURL:url];
                    if(datapdf){
                        [datapdf writeToFile:[attachment pdfFilePath] atomically:YES];
                        if (appt) {
                            [appt setEntity_status:c_EDITED];
                        }
                        else{
                            if(est){
                                [est setEntity_status:c_EDITED];
                            }
                        }
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                    } else {
                        __error = @"Could not write the file, please try again.";
                    }
                } else {
                    __error = @"Could not find PDFForm which you have opened.";
                }
            } else {
                __error = @"Could not find appointment related to this file.";
            }
        }
        
    } else {
        __error = @"It is wrong file, please open correct PDF file.";
    }
    
    if (__error != nil && __error.length > 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork"
                                                         message:__error
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles: nil];
        [alert show];
    } else {
        if (self.navigationController) {
            if (self.navigationController.viewControllers && self.navigationController.viewControllers.count > 0) {
                for (UIViewController *v in self.navigationController.viewControllers) {
                    if ([v isKindOfClass:[NewAppointMentsDetailViewController class]]) {
                        NewAppointMentsDetailViewController *doc = (NewAppointMentsDetailViewController*)v;
                        if (doc) {
                            [doc reloadSection:FWPDFForms];
                        }
                    }
                }
            }
        }
    }
    return YES;
}


@end
