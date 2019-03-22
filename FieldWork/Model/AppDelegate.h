//
//  AppDelegate.h
//  FieldWork
//
//  Created by Samir Kha on 05/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//


////
#import <UIKit/UIKit.h>
#import "LoginController.h"
#import "AccountManager.h"
#import "Constants.h"
#import "Pest.h"
#import "Material.h"
#import "DilutionRates.h"
#import "StaticModelLoader.h"
#import "Customer.h"
#import "FWReachability.h"
//#import "CDHelper.h"
//#import "UIColor+UITableViewBackground.h"
#import <KitLocate/KitLocate.h>
#import "KitLocateTasker.h"
#import <Stripe/Stripe.h>
@class MFSideMenuContainerViewController;

#define RECHABILITY_CHECK_URL @"app.fieldworkhq.com"

#define IPAD     UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AppDelegate : UIResponder <UIApplicationDelegate, UINavigationControllerDelegate, LoginControllerDelegate>{
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSString * _barcode_object;
    NSString *_username;
    BOOL MYGlobalVariable;
    UINavigationController * _navigation;
    
    BOOL _runningFirstTime;
    
    UINavigationController *appObjNav;
    
}

@property (strong, nonatomic) UIView *lockView;
@property (retain, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic ,retain) MFSideMenuContainerViewController *containerVC;

@property (strong, nonatomic) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,retain)NSString * barcode_object;
@property (nonatomic ,retain) UINavigationController * navigation;
@property (strong, nonatomic) KitLocateTasker *kitLocateTasker;
@property(strong) FWReachability * internetConnectionReach;
@property (strong, nonatomic) IBOutlet UINavigationController *fwListController;

@property (nonatomic, retain, readwrite) NSNumber *working_appointment_id;


+ (AppDelegate*)appDelegate;

- (void)showLogin:(BOOL)animated;

- (NSString *)applicationDocumentsDirectory;

- (BOOL) saveManageObjectContext;

- (void) logoutWithNav:(UINavigationController *)nctr;

- (void)loadAllListsSilent:(BOOL)silent completion:(void (^)(NSMutableArray* failedList))completion;

- (void)loadLists:(NSArray*)lists silent:(BOOL)silent completion:(void (^)(NSMutableArray* failedList))completion;

- (BOOL) isReachable;

- (void)lockScreen:(BOOL)lock;

- (BOOL)isScreenLocked;

+ (NSInteger)OSVersion;

- (void)reachabilityChanged:(NSNotification*)note;

- (void)resetCoreDataDB;

@end
