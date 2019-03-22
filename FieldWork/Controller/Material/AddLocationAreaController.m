//
//  AddLocationAreaController.m
//  FieldWork
//
//  Created by Samir Kha on 31/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AddLocationAreaController.h"


@implementation AddLocationAreaController

+ (AddLocationAreaController *)viewControllerWithAppointment:(Appointment *)app {
     AddLocationAreaController *addlocation;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      addlocation = [[AddLocationAreaController alloc] initWithNibName:@"AddLocationAreaView" bundle:nil];
    }else{
      addlocation  = [[AddLocationAreaController alloc] initWithNibName:@"AddLocationAreaController" bundle:nil];
        
    }
     
    addlocation.Appointment = app;
    return addlocation;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarButton];
}

-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(addLocationArea:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addLocationArea:(id)sender {
    CustomTableCell *cell = (CustomTableCell*)[_mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell) {
        
        NSString *locationAreaName = [cell.txt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(locationAreaName.length<=0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Location area cannot be blank."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }else{
            ServiceLocation *ser_loc = [self.Appointment getServiceLocation];
            __block LocationType *type = [LocationType getLocationTypeById:ser_loc.location_type_idValue];
            if (type) {
                [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
                [type addLocationArea:locationAreaName block:^(id result, NSString *error) {
                    if (error) {
                        [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
                    } else {
                        [self goBack];
                    }
                }];
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Could not find location type."
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

# pragma mark - table method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
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
    
    cell.lbl.text = @"Location Area";
    
    return cell;
}

- (void) goBack
{
    [[ActivityIndicator currentIndicator] displayCompleted];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LocationAdded" object:nil];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma ListItemDelegate

- (void) ListItemAddedSuccessfully{
    //[[ActivityIndicator currentIndicator] displayCompleted];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_LocationAdded" object:nil];
    
    
    //[self.navigationController popViewControllerAnimated:YES];
    [self performSelector:@selector(goBack) withObject:nil afterDelay:4.0];
    [self postNotificationForDirty];
    
}

- (void) ListItemAdditionFailedWithError:(NSString*) error{
    [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Fail"];
    
}
- (void) ListItemDeletionFailedWithError:(NSString*) error{}
- (void) ListItemDeletedSuccessfully{}

@end
