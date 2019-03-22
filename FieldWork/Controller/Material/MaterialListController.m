//
//  MaterialListController.m
//  FieldWork
//
//  Created by Samir Kha on 11/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "MaterialListController.h"
#import "UnitInspection.h"
//#import "MaterialList.h"


@implementation MaterialListController

@synthesize materialList = _materialList;
@synthesize filteredListContent;
@synthesize table;
@synthesize materialUsageSelectionDelegate = _materialUsageSelectionDelegate;
@synthesize delegate=_delegate;

+ (MaterialListController *)viewControllerWithAppointment:(Appointment *)app {
    MaterialListController *mc = [[MaterialListController alloc] initWithNibName:@"MaterialListController" bundle:nil];
    mc.Appointment = app;
    return mc;
}

+(MaterialListController *)viewControllerWithAppointment:(Appointment *)app AddLineItemDelegate:(id<AddLineItemDelegate>)del{
    MaterialListController *mc = [[MaterialListController alloc] initWithNibName:@"MaterialListController" bundle:nil];
    mc.Appointment = app;
    mc.delegate = del;
    mc.navigationItem.backBarButtonItem.title = @"";
    return mc;
}

+(MaterialListController *)viewControllerWithEstimate:(Estimate *)est AddLineItemDelegate:(id<AddLineItemDelegate>)del{
    MaterialListController *mc = [[MaterialListController alloc] initWithNibName:@"MaterialListController" bundle:nil];
    mc.estimate = est;
    mc.delegate = del;
    mc.navigationItem.backBarButtonItem.title = @"";
    return mc;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewMaterial)];
    
    self.navigationItem.rightBarButtonItem = addBtn;
    self.navigationItem.title = @"Material List";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadMaterialList) name:kMATERIAL_ADDED object:nil];
    self.filteredListContent = [[NSMutableArray alloc] init];
    self.materialList = [[NSMutableArray alloc] init];
    [self loadMaterialList];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSSortDescriptor * sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [self.materialList sortUsingDescriptors:[NSMutableArray arrayWithObject:sortDesc]];
    [table reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self isMovingToParentViewController]) {
        self.materialList = nil;
        self.filteredListContent = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.view = nil;
        table = nil;
    }
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

- (void) addNewMaterial{
    MaterialAddController *ma = [MaterialAddController viewControllerWithAppointment:self.Appointment];
    [self.navigationController pushViewController:ma animated:YES];
}

- (void) loadMaterialList
{
    __weak MaterialListController *weakself = self;
    [Material loadAllWithBlock:^(id result, NSString *error) {
        weakself.materialList = [[(NSArray*)result sortUsingKey:@"name"] mutableCopy];
//        weakself.materialList = result;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *appointmentArray;
        appointmentArray = [defaults stringForKey:@"appointmentList"];

        
        
        NSString *materialArray;
        materialArray = [defaults stringForKey:@"materialList"];
        

        UnitInspection *_inspectionRecord = [UnitInspection getFavoriteunitInspection:appointmentArray deleted:NO][2];
        if (_inspectionRecord) {
            if (_inspectionRecord.material_usages) {
                NSMutableArray *_selectedMaterialUsage = [NSMutableArray arrayWithArray:[_inspectionRecord.material_usages allObjects]];
                for (MaterialUsage *mu in _selectedMaterialUsage) {
//                    [mu.managedObjectContext MR_saveOnlySelfAndWait];
//                    if(mu.material_id == materialArray)
                }
            }
        }
        [table reloadData];
    }];
    
}


#pragma table method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.materialList count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    Material *mat;
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        mat = [self.filteredListContent objectAtIndex:indexPath.row];
    }else{
        mat = [self.materialList objectAtIndex:indexPath.row];
    }
    
    
    cell.textLabel.text = mat.name;
    //mat = nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_delegate) {
        Material *mat = [self.materialList objectAtIndex:indexPath.row];
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            mat = [self.filteredListContent objectAtIndex:indexPath.row];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(getMaterialInfo:)]) {
            [_delegate getMaterialInfo:mat];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        
        Material *mat = [self.materialList objectAtIndex:indexPath.row];
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            mat = [self.filteredListContent objectAtIndex:indexPath.row];
        }
        MaterialUsage *mu = [MaterialUsage createWithMaterialId:mat.entity_id];
        MaterialUsageRecordController *mur = [MaterialUsageRecordController viewControllerWithAppointment:self.Appointment andMaterialUsage:mu];
        mur.materialUsageSelectionDelegate = _materialUsageSelectionDelegate;
        [self.navigationController pushViewController:mur animated:YES];
        mur = nil;
        mu = nil;
    }
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
    
//    for (Material *mat in self.materialList) {
//        NSComparisonResult result = [mat.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
//        if (result == NSOrderedSame)
//        {
//            [self.filteredListContent addObject:mat];
//        }
//    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[c] %@", searchText ];
    self.filteredListContent  = [NSMutableArray arrayWithArray:[self.materialList filteredArrayUsingPredicate:predicate]];
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.table reloadData];
}
// Just written to avoid warning... no use here...
- (void)getMaterialInfo:(Material*)mat {}


@end
