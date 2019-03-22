//
//  CustomerListViewController.m
//  FieldWork
//
//  Created by Samir Kha on 06/01/2013.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CustomerListViewController.h"
#import "MFSideMenu.h"

@implementation CustomerListViewController
@synthesize listContent, filteredListContent, sectionedListContent, savedSearchTerm, savedScopeButtonIndex, searchWasActive, tableView, LoadAll;

@synthesize workOrderDelegate = _workOrderDelegate;

+ (CustomerListViewController *)init {
    CustomerListViewController *customer;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customer = [[CustomerListViewController alloc] initWithNibName:@"CustomerListViewController_IPad" bundle:nil];
    }else{
        customer = [[CustomerListViewController alloc] initWithNibName:@"CustomerListViewController" bundle:nil];
        
    }
    customer.LoadAll = YES;
    customer.title = @"Customers";
    customer.workOrderDelegate = nil;
    return customer;
}

+ (CustomerListViewController *)initWithNewWorkOrderDelegate:(id<NewWorkOrderDelegate>)del {
    CustomerListViewController *controller = [CustomerListViewController init];
    controller.workOrderDelegate = del;
    return controller;
}


#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gloabalDataLoaded) name:@"CUSTOMER_LIST_LOADED" object:nil];
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
}

//-(void)setNavItemsColor{
//    
//    //     [self.navigationController.navigationBar
//    //     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
//    
//    //     self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    // [self.navigationController.navigationBar
//    // setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1]}];
//    
//    // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    } else {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
        self.navigationController.navigationBar.translucent = NO;
    }
    
    
    if (self.workOrderDelegate == nil) {
        UIImage* image2 = [UIImage imageNamed:@"menuOrange.png"];
        CGRect frameimg2 = CGRectMake(15,5, 25,25);
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:frameimg2];
        [leftButton setBackgroundImage:image2 forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(menuClicked:)
             forControlEvents:UIControlEventTouchUpInside];
        [leftButton setShowsTouchWhenHighlighted:YES];
        
        UIBarButtonItem *menuButton =[[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = menuButton;
    }
    
    UIImage* image1 = [UIImage imageNamed:@"ic_new_appointments.png"];
    CGRect frameimg1 = CGRectMake(15,5, 25,25);
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:frameimg1];
    [rightButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addNewCustomerClicked)
          forControlEvents:UIControlEventTouchUpInside];
    [rightButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    
    self.navigationItem.rightBarButtonItem=addButton;
    if (![[AppDelegate appDelegate]isReachable]) {
        for (UIBarButtonItem *bitem in self.navigationItem.rightBarButtonItems) {
            if (bitem != nil) {
                bitem.enabled = NO;
            }
        }
    }
    
    
    
    if (self.savedSearchTerm)
    {
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    
    self.tableView.scrollEnabled = YES;
    
    if ([[CustomerManager Instance]loadedCount] <= 0) {
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
    }
    
    [[CustomerManager Instance] loadCustomersWithBlock:^(id result, NSString *error) {
        [[ActivityIndicator currentIndicator] displayCompleted];
        
        [self loadTable];
    }];
    
    
    
}
-(void)addNewCustomerClicked
{
    NewCustomerViewController *addcus=[NewCustomerViewController viewController];
    [self.navigationController pushViewController:addcus animated:YES];
}

-(void)menuClicked:(id)sender{
    
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.searchWasActive = [self.searchDisplayController isActive];
    self.savedSearchTerm = [self.searchDisplayController.searchBar text];
    self.savedScopeButtonIndex = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    
    self.filteredListContent = nil;
    sectionedListContent = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark UITableView data source and delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tblView
{
    if (tblView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
        return [self.sectionedListContent count];
    }
}

- (NSInteger)tableView:(UITableView *)tblView numberOfRowsInSection:(NSInteger)section
{
    /*
     If the requesting table view is the search display controller's table view, return the count of the filtered list, otherwise return the count of the main list.
     */
    if (tblView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredListContent count];
    }
    else
    {
        return [(NSArray *)[self.sectionedListContent objectAtIndex:section]count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tblView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"cellID";
    
    UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:kCellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    
    for(UIView *view in [tableView subviews])
    {
        if([[[view class] description] isEqualToString:@"UITableViewIndex"])
        {
            [view performSelector:@selector(setIndexColor:) withObject:RED_COLOR];
        }
    }
    
    /*
     If the requesting table view is the search display controller's table view, configure the cell using the filtered content, otherwise use the main list.
     */
    Customer *cust = nil;
    if (tblView == self.searchDisplayController.searchResultsTableView)
    {
        cust = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        cust = [self.sectionedListContent objectAtIndexPath:indexPath];
    }
    cell.textLabel.text = [cust getDisplayName];
    return cell;
}

- (void)tableView:(UITableView *)tblView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Customer *cust = nil;
    if (tblView == self.searchDisplayController.searchResultsTableView)
    {
        cust = [self.filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        cust = [self.sectionedListContent objectAtIndexPath:indexPath];
    }
    
    
    if (_workOrderDelegate != nil && [_workOrderDelegate respondsToSelector:@selector(CustomerChosen:)]) {
        [_workOrderDelegate CustomerChosen:cust];
        [self.navigationController popViewControllerAnimated:YES];
        return;
        
    }else{
        CustomerDetailViewController * customer = [CustomerDetailViewController initWithAppointment:cust];
        [self.navigationController pushViewController:customer animated:YES];
    }
    
}
#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    for (Customer *cust in self.listContent) {
        if ([cust getDisplayName] != nil)
        {
            NSRange range = [[[cust getDisplayName] lowercaseString] rangeOfString:[searchText lowercaseString]];
            if (range.location != NSNotFound) {
                [self.filteredListContent addObject:cust];
            }
        }
    }
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

#pragma mark -
- (NSString *)tableView:(UITableView *)tblView titleForHeaderInSection:(NSInteger)section
{
    if (tblView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return [(NSArray *)[self.sectionedListContent objectAtIndex:section]count] ? [[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section] : nil;
        if ([[self.sectionedListContent objectAtIndex: section] count] <= 0) {
            return (NSArray *)[[[UILocalizedIndexedCollation currentCollation] sectionTitles] objectAtIndex:section];
        } else {
            return (NSArray *)[self.sectionedListContent objectAtIndex:section];
        }
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tblView
{
    if (tblView == self.searchDisplayController.searchResultsTableView) {
        return nil;
    } else {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:
                [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    }
}
- (NSInteger)tableView:(UITableView *)tblView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tblView == self.searchDisplayController.searchResultsTableView) {
        return 0;
    } else {
        if (title == UITableViewIndexSearch) {
            [tblView scrollRectToVisible:self.searchDisplayController.searchBar.frame animated:NO];
            return -1;
        } else {
            return [[UILocalizedIndexedCollation currentCollation] sectionForSectionIndexTitleAtIndex:index-1];
        }
    }
}

- (void) loadTable{
    listContent = [[NSArray alloc] init];
    listContent = [Customer getCustomers];
    sectionedListContent = [[NSArray alloc] init];
    sections = [NSMutableArray array];
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    for (Customer *cust in listContent) {
        if ([cust getDisplayName] != nil) {
            NSInteger section = [collation sectionForObject:cust collationStringSelector:@selector(sortingName)];
            [sections addObject:cust toSubarrayAtIndex:section];
        }
    }
    
    NSInteger section = 0;
    for (section = 0; section < [sections count]; section++) {
        NSArray *sortedSubarray;
        sortedSubarray = [[sections objectAtIndex:section] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(Customer*) a sortingName];
            NSString *second = [(Customer*)b sortingName];
            return [first compare:second];
        }];
        [sections replaceObjectAtIndex:section withObject:sortedSubarray];
        
    }
    sectionedListContent = sections;
    [self.tableView reloadData];
    
}

- (void)gloabalDataLoaded{
    [self loadTable];
}

@end
