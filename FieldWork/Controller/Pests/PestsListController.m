    //
    //  PestsListController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 15/01/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "PestsListController.h"
#import "Pest.h"


@implementation PestsListController

@synthesize pestList = _pestList;
@synthesize filteredListContent;
@synthesize inspectionRecord = _inspectionRecord;
@synthesize isFromInspection = _IsFromInspection;
@synthesize pestSelectionDelegate = _pestSelectionDelegate;
@synthesize inspectionPestRecords;

+ (PestsListController *)viewControllerWithAppointment:(Appointment *)app {
    PestsListController *mc = [[PestsListController alloc] initWithNibName:@"PestsListController" bundle:nil];
    mc.Appointment = app;
    mc.isFromInspection = NO;
    return mc;
}

+ (PestsListController *)viewControllerWithAppointment:(Appointment *)app andInspection:(InspectionRecord *)ins {
    PestsListController *mc = [[PestsListController alloc] initWithNibName:@"PestsListController" bundle:nil];
    mc.Appointment = app;
    mc.inspectionRecord = ins;
    mc.isFromInspection = YES;
    return mc;
}

- (void)didReceiveMemoryWarning
{
        // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
        // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void) viewWillAppear:(BOOL)animated
{   [super viewWillAppear:animated];
    
    [self reloadPestList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTargetPests)];
    self.navigationItem.rightBarButtonItem = addBtn;
    self.navigationItem.title = @"Pest Types";
    
    self.filteredListContent = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadPestList) name:@"Notification_PestAdded" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.filteredListContent = nil;
    self.pestList = nil;
    if ([self isMovingToParentViewController]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        self.view = nil;
    }
}

-(void)reloadPestList{
    self.pestList = [[NSMutableArray alloc]init];
    
    [Pest fetchAllWithBlock:^(id result, NSString *error) {
        _pestList = (NSMutableArray*) result;
        NSSortDescriptor * sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        [_pestList sortUsingDescriptors:[NSMutableArray arrayWithObject:sortDesc]];
        [table reloadData];
    }];

}

-(void)addTargetPests
{
    PestsAddController *pa = [PestsAddController viewControllerWithAppointment:self.Appointment];
    [self.navigationController pushViewController:pa animated:YES];
    pa = nil;
}


//26112015
//- (void) loadPestList
//{
//    [[PestList Instance] loadWithDelegate:self];
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma table method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        //NSLog(@"pest list %@",self.pestList);
    if (tableView == self.searchDisplayController.searchResultsTableView)
        {
        return [self.filteredListContent count];
        }
    else
        {
        return [self.pestList count];
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
    Pest *pt = [self.pestList objectAtIndex:indexPath.row];
    if (tableView == self.searchDisplayController.searchResultsTableView)
        {
        pt = [self.filteredListContent objectAtIndex:indexPath.row];
        }
    
    cell.textLabel.text = pt.name;
    cell.textLabel.tag = [pt.entity_id integerValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Pest *pt = [self.pestList objectAtIndex:indexPath.row];
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        pt = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    
    
    //    26112015
    if (pt) {
        if (self.isFromInspection) {
            /*
            for (InspectionPest *ipr in self.inspectionPestRecords) {
                if (([ipr.pest_type_id isEqualToNumber:pt.entity_id])){//&&(![pt.entity_id isEqualToNumber:@(-1)])) {
                    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You already have this pest selected." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                    return;
                }
            }
             */
            if (_pestSelectionDelegate && [_pestSelectionDelegate respondsToSelector:@selector(pestRecordSelectedFor:withTargetPest:)]) {
                [_pestSelectionDelegate pestRecordSelectedFor:Inspection withTargetPest:pt];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTable" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //[self.Appointment.targetPestList addPestType:tp andDelegate:self];
            if (_pestSelectionDelegate && [_pestSelectionDelegate respondsToSelector:@selector(pestRecordSelectedFor:withTargetPest:)]) {
                [_pestSelectionDelegate pestRecordSelectedFor:MaterialUse withTargetPest:pt];
            }
            [self.navigationController popViewControllerAnimated:YES];
            //[[ActivityIndicator currentIndicator] displayActivity:@"Please Wait..."];
        }
        
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
    
//    for (Pest *pt in self.pestList) {
//        NSComparisonResult result = [pt.name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
//        if (result == NSOrderedSame)
//            {
//            [self.filteredListContent addObject:pt];
//            }
//    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchText ];
    self.filteredListContent  = [NSMutableArray arrayWithArray:[self.pestList filteredArrayUsingPredicate:predicate]];
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

#pragma ListItemDelegate


- (void)ListItemAddedSuccessfully {
    [[ActivityIndicator currentIndicator] displayCompleted];
    
//    26112015
//    [[NSNotificationCenter defaultCenter] postNotificationName:TARGET_PEST_LOAD_NOTIFICATION object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)ListItemAdditionFailedWithError:(NSString *)error {
    [[ActivityIndicator currentIndicator] displayCompleted];
}

- (void) ListItemDeletedSuccessfully{}
- (void) ListItemDeletionFailedWithError:(NSString*) error{}


@end
