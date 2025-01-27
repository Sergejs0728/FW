//
//  CommonAppointmentViewController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CommonAppointmentViewController.h"
#import "AppDelegate.h"
#import "MFSideMenuContainerViewController.h"

@implementation CommonAppointmentViewController

@synthesize Appointment=_Appointment;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [AppDelegate appDelegate].containerVC.panMode =  MFSideMenuPanModeDefault;
    //self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)postNotificationForDirty {
    NSDictionary* userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.Appointment.entity_id, @"APP", nil];
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:kMAKE_DIRTY_NOTIFICATION object:self userInfo:userInfo];
}

- (void)removeViewControllerFromNavigationStack:(Class)cls {
    NSUInteger index = NSNotFound;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        
        if ([viewController isKindOfClass:cls] ) {
            index = [self.navigationController.viewControllers indexOfObject:viewController];
            break;
        }
    }
    
    if (index != NSNotFound ) {
        NSMutableArray *temp = [self.navigationController.viewControllers mutableCopy];
        [temp removeObjectAtIndex:index];
        self.navigationController.viewControllers = temp;
    }
}

@end
