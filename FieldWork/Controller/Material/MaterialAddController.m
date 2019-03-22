//
//  MaterialAddController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MaterialAddController.h"
#import "CustomTableCell.h"

@interface MaterialAddController () <UITextFieldDelegate> {
    NSString *materialName;
    NSString *epaNumber;
}

@end

@implementation MaterialAddController

+ (MaterialAddController *)viewControllerWithAppointment:(Appointment *)app {
    
    MaterialAddController *ma;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        ma = [[MaterialAddController alloc] initWithNibName:@"MaterialAddController_IPad" bundle:nil];
    }else{
        ma = [[MaterialAddController alloc] initWithNibName:@"MaterialAddController" bundle:nil];
        
    }
    
    ma.Appointment = app;
    return ma;

}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(addMaterialType:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    //UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:nil];
    self.navigationItem.title = @"Add Material";
   // self.navigationItem.rightBarButtonItem = cancelBtn;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)addMaterialType:(id)sender
{
    NSString *message = nil;
    if ([epaNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0) {
        message = NSLocalizedString(@"Please enter material epa number.", @"");
    }
    if ([materialName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0) {
        message = NSLocalizedString(@"Please enter material name.", @"");
    }
    Material *existing = [Material materialByName:materialName];
    if (existing) {
        message = NSLocalizedString(@"This name has already been taken.", @"");
    }
    if (message) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Material", @"") message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alert addAction:actionOk];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }

    if ([[AppDelegate appDelegate] isReachable]) {
        __block Material *material = [Material newEntity];
        material.name = materialName;
        material.epa_number = epaNumber;
        [[ActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Saving...", @"")];
        [material addNewMaterialOnServerWithBlock:^(id item, BOOL is_success, NSString *error) {
            if (is_success) {
                [[ActivityIndicator currentIndicator] displayCompleted];
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:kMATERIAL_ADDED object:nil];
            } else {
                [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
                return;
            }
        }];
    } else {
        [[ActivityIndicator currentIndicator] displayCompletedWithError:NSLocalizedString(@"No internet connection", @"")];
    }
}

# pragma table method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
       return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
       NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"CustomLableTextCell" owner:self options:nil];
        
          cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (CustomTableCell*) currentObject;
            }
        }
    }
    cell.txt.delegate = self;
    cell.txt.tag = indexPath.row;
    if (indexPath.row == 0) {
            cell.lbl.text = @"Material Name";
    }
    if (indexPath.row == 1) {
        cell.lbl.text = @"EPA#";
    }


  return cell;
}

- (void) ListItemAddedSuccessfully{
    [[ActivityIndicator currentIndicator] displayCompleted];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_MaterialAdded" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self postNotificationForDirty];
}

- (void) ListItemAdditionFailedWithError:(NSString*) error{
    [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Fail"];
    
}
- (void) ListItemDeletedSuccessfully{}
- (void) ListItemDeletionFailedWithError:(NSString*) error{}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    switch (textField.tag) {
        case 0:
            materialName = text;
            break;
            
        case 1:
            epaNumber = text;
            break;
            
        default:
            break;
    }
    return YES;
}

@end
