//
//  MaterialUseListController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MaterialUseListController.h"
#import "MaterialusetablelistCell.h"

@implementation MaterialUseListController

@synthesize tableView=_mainTable;
@synthesize materialUseagList=_materialUseagList;
//@synthesize usageSelectionDelegate = _usageSelectionDelegate;

+ (MaterialUseListController *)viewControllerWithAppointment:(Appointment *)app {
    MaterialUseListController *mc = [[MaterialUseListController alloc] initWithNibName:@"MaterialUseListController" bundle:nil];
    mc.Appointment = app;
    mc.title = @"Material Usage List";
    return mc;
}


+ (MaterialUseListController *)viewControllerWithAppointment:(Appointment *)app withSelectionDelegate:(id<MaterialUsageSelectionDelegate>)del {
    MaterialUseListController *mc = [[MaterialUseListController alloc] initWithNibName:@"MaterialUseListController" bundle:nil];
    mc.Appointment = app;
    //mc.usageSelectionDelegate = del;
    mc.title = @"Material Usage List";
    return mc;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewMaterial)];
    self.navigationItem.rightBarButtonItem = addBtn;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshList) name:@"RELOAD_MATERIAL_USAGE_LIST" object:nil];
  
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _materialUseagList = [[self.Appointment.material_usages allObjects] mutableCopy];
    [_mainTable reloadData];
}

- (void)refreshList {
    _materialUseagList = [[NSMutableArray alloc] init];
    _materialUseagList = [[self.Appointment.material_usages allObjects] mutableCopy];
    [_mainTable reloadData];
}

- (void) addNewMaterial{
    MaterialListController *ml = [MaterialListController viewControllerWithAppointment:self.Appointment];
    [self.navigationController pushViewController:ml animated:YES];
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

# pragma table method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_materialUseagList count]==0){
        return 1;
    }else{
        return [_materialUseagList count];
    }

   // return _materialUseagList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_materialUseagList count] == 0 && indexPath.row == 0) {
        return 80;
    }
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if([_materialUseagList count] == 0)
    {
        UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.tag = -1010;
        
        cell.textLabel.text = @"To add a material to the usage list please touch the plus button in the upper right hand corner";
        [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        return cell;
    }else{
        MaterialusetablelistCell *cell = (MaterialusetablelistCell*)[tblView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil || cell.tag == -1010)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"MaterialuselistCell" owner:self options:nil];
            
            for(id materialCurrentObject in topLevelObject)
            {
                if([materialCurrentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (MaterialusetablelistCell*) materialCurrentObject;
                }
            }
        }
        
        [cell setMaterilUsage:[_materialUseagList objectAtIndex:indexPath.row]];
        
        
        return cell;
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_materialUseagList.count > 0) {
        MaterialUsage *mur = [_materialUseagList objectAtIndex:indexPath.row];
//        if (_usageSelectionDelegate && [_usageSelectionDelegate respondsToSelector:@selector(MaterialUsageSelected:)]) {
//            [_usageSelectionDelegate MaterialUsageSelected:mur];
//            [self.navigationController popViewControllerAnimated:YES];
//        }else{
            MaterialUsageRecordController *murController = [MaterialUsageRecordController viewControllerWithAppointment:self.Appointment andMaterialUsage:mur];
            [self.navigationController pushViewController:murController animated:YES];
//        }
    }
    
   
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        //cell.editingAccessoryView.frame=CGRectMake(0, 0, 60, 30);
    if([_materialUseagList count]  > 0){
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            //MaterialUsage * tp = [_materialUseagList objectAtIndex:indexPath.row];
            //26112015
//            [self.Appointment.materialUsageList deleteMaterialUsage:tp withDelegate:self];
            [self postNotificationForDirty];
            NSLog(@"table reloading.........");
                //        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        }
        
    }
}

#pragma mark - ListItemDelegate

- (void)ListItemAddedSuccessfully {
    
}

- (void)ListItemDeletedSuccessfully {
        //    [[ActivityIndicator currentIndicator] displayCompleted];
    //26112015
//    _materialUseagList = [self.Appointment.materialUsageList getMaterialUsageArray];
    [_mainTable reloadData];
}
- (void) ListItemDeletionFailedWithError:(NSString*) error
{
        
}

- (void) ListItemAdditionFailedWithError:(NSString*) error{}


@end
