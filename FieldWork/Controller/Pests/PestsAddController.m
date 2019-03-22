//
//  PestsAddController.m
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PestsAddController.h"
#import "CustomTableCell.h"

@interface PestsAddController () <UITextFieldDelegate> {
    NSString *pestType;
}

@end

@implementation PestsAddController
- (void) ListItemDeletedSuccessfully{}
+ (PestsAddController *)viewControllerWithAppointment:(Appointment *)app {
    PestsAddController *mc;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        mc = [[PestsAddController alloc] initWithNibName:@"PestsAddController_IPad" bundle:nil];
    }else{
        mc = [[PestsAddController alloc] initWithNibName:@"PestsAddController" bundle:nil];
        
    }
    mc.Appointment = app;
    return mc;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createBarButton];
    self.navigationItem.title = @"Pest Type";
    
}

-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(addPestType:)];
    self.navigationItem.rightBarButtonItem = saveButton;
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

- (void)addPestType:(id)sender {
    NSString *message = nil;
    if ([pestType stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length <= 0) {
        message = NSLocalizedString(@"Please enter pest type to add in the list.", @"");
    }
    Pest *existing = [Pest pestByName:pestType];
    if (existing) {
        message = NSLocalizedString(@"This name has already been taken.", @"");
    }
    if (message) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Pest", @"") message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alert addAction:actionOk];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([[AppDelegate appDelegate] isReachable]) {
        __block Pest *pt = [Pest MR_createEntity];
        pt.name = pestType;
        [[ActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Saving...", @"")];
        [pt postPest:^(NSNumber *entity_id, NSString *error) {
            if (error) {
                [pt.managedObjectContext rollback];
                [pt.managedObjectContext refreshObject:pt mergeChanges:NO];
                [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
            } else {
                pt.entity_id=entity_id;
                [pt.managedObjectContext MR_saveOnlySelfAndWait];
                [[ActivityIndicator currentIndicator] displayCompleted];
                [self.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_PestAdded" object:nil];
            }
            
        }];
    } else {
        [[ActivityIndicator currentIndicator] displayCompletedWithError:NSLocalizedString(@"No internet connection", @"")];
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
    cell.txt.delegate = self;
    cell.lbl.text = @"Pest Name";
    
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    pestType = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return YES;
}

#pragma ListItemDelegate

- (void) ListItemAddedSuccessfully{
    [[ActivityIndicator currentIndicator] displayCompleted];
    // [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_PestAdded" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self postNotificationForDirty];
}

- (void) ListItemAdditionFailedWithError:(NSString*) error{
    [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Fail"];
    
}

- (void) ListItemDeletionFailedWithError:(NSString*) error{}



@end
