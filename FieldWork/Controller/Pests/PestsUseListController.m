//
//  PestsUseListController.m
//  FieldWork
//
//  Created by Samir Kha on 15/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PestsUseListController.h"
#import "MaterialusetablelistCell.h"
#import "PestsListController.h"

@implementation PestsUseListController
- (void) ListItemAddedSuccessfully{}
- (void) ListItemAdditionFailedWithError:(NSString*) error{}
@synthesize targetpestList=_targetpestList;
@synthesize table=_table;

@synthesize targetPestSelectionDelegate = _targetPestSelectionDelegate;


+ (PestsUseListController *)viewControllerWithAppointment:(Appointment *)app {
    PestsUseListController *mc = [[PestsUseListController alloc] initWithNibName:@"PestsUseListController" bundle:nil];
    mc.Appointment = app;
    return mc;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewTargetPests)];
    self.navigationItem.rightBarButtonItem = addBtn;

    self.navigationItem.title=@"Target Pests";
        //self.targetpestList = [self.Appointment.targetPestList gettargetPestArray];
        //[table reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadList) name:TARGET_PEST_LOAD_NOTIFICATION object:nil];
    [_table reloadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.targetpestList = [self.Appointment.targetPestList gettargetPestArray];
    [_table reloadData];
}

- (void) loadList{
    [self.Appointment.targetPestList refreshWithDelegate:self];
}

-(void)addNewTargetPests
{
    PestsListController *pest = [PestsListController viewControllerWithAppointment:self.Appointment];
    [self.navigationController pushViewController:pest animated:YES];
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma TargetPestListDelegate

- (void)TargetPestListLoaded {
    self.targetpestList = [self.Appointment.targetPestList gettargetPestArray];
    [_table reloadData];
}

- (void)TargetPestListLoadFailed:(NSString *)error{
    
}


# pragma table method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.targetpestList count]==0){
        return 1;
    }else{
        return [self.targetpestList count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.targetpestList count] == 0 && indexPath.row == 0) {
        return 80;
    }
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if([self.targetpestList count] == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.tag = -1010;
        cell.textLabel.text = @"To add a pest to the target pest list please touch the plus button in the upper right hand corner";

        [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil || cell.tag == -1010)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
        TargetPest *targetpest = [self.targetpestList objectAtIndex:indexPath.row];
        
        Pest *pt = [[PestList Instance] getPestById:targetpest.pestTypeId];
        
        cell.textLabel.text = pt.name;
        
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.editingAccessoryView.frame=CGRectMake(0, 0, 60, 30);
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TargetPest * tp = [self.targetpestList objectAtIndex:indexPath.row];
        [self.Appointment.targetPestList deleteTargetPest:tp andDelegate:self];
        
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.targetPestSelectionDelegate && [self.targetPestSelectionDelegate respondsToSelector:@selector(TargetPestSelected:)]) {
        TargetPest *tp = [self.targetpestList objectAtIndex:indexPath.row];
        [self.targetPestSelectionDelegate TargetPestSelected:tp];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - ListItemDelegate

- (void)ListItemDeletedSuccessfully {
    [[ActivityIndicator currentIndicator] displayCompleted];
    [self.Appointment.targetPestList refreshWithDelegate:self];
    [_table reloadData];
}
- (void) ListItemDeletionFailedWithError:(NSString*) error
{
    [[ActivityIndicator currentIndicator] displayCompleted];    
}


@end
