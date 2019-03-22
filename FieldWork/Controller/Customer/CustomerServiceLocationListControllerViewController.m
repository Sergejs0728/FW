//
//  CustomerServiceLocationListControllerViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import "CustomerServiceLocationListControllerViewController.h"

@interface CustomerServiceLocationListControllerViewController ()

@end
@implementation CustomerServiceLocationListControllerViewController
@synthesize servicelocation_tble=_servicelocation_tble;
@synthesize filteredListContent=filteredListContent;
@synthesize sectionedListContent=sectionedListContent;
@synthesize savedSearchTerm=savedSearchTerm;
@synthesize savedScopeButtonIndex=savedScopeButtonIndex;
@synthesize searchWasActive=searchWasActive;
@synthesize LoadAll=LoadAll;
@synthesize listContent;
@synthesize workOrderDelegate = _workOrderDelegate;

+(CustomerServiceLocationListControllerViewController *)initViewControllerWiithCustomer:(Customer *)customer
{
    CustomerServiceLocationListControllerViewController *cust=[[CustomerServiceLocationListControllerViewController alloc]initWithNibName:@"CustomerServiceLocationListControllerViewController" bundle:nil];

    cust.title=@"Service Locations";
    cust.cusotmer = customer;
    return cust;
}

+ (CustomerServiceLocationListControllerViewController *)initViewControllerWiithCustomer:(Customer *)customer withWorkOrderDelegate:(id<NewWorkOrderDelegate>)del {
    CustomerServiceLocationListControllerViewController *controller= [CustomerServiceLocationListControllerViewController initViewControllerWiithCustomer:customer];
    controller.workOrderDelegate = del;
    return controller;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _service_locations = [[NSMutableArray alloc ] init];
    _service_locations = [[self.cusotmer.service_locations allObjects]mutableCopy];
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    [self.filteredListContent addObjectsFromArray:_service_locations];
	
	// restore search settings if they were saved in didReceiveMemoryWarning.
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
	
	[self.servicelocation_tble reloadData];
	

    
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

#pragma  mark-UITableView Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [_service_locations count];
    }
    return _service_locations.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell1";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    /*
     *   If the cell is nil it means no cell was available for reuse and that we should
     *   create a new one.
     */
    if (cell == nil) {
        
        /*
         *   Actually create a new cell (with an identifier so that it can be dequeued).
         */
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    ServiceLocation *info=nil;
    if (tableView==self.searchDisplayController.searchResultsTableView)
    {
        info=[filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        info=[_service_locations objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = info.name;

    return cell;
    

	
	

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceLocation *serv=nil;
    if (tableView==self.searchDisplayController.searchResultsTableView)
    {
        serv=[filteredListContent objectAtIndex:indexPath.row];
    }
    else
    {
        serv=[_service_locations objectAtIndex:indexPath.row];
    }
    if (_workOrderDelegate && [_workOrderDelegate respondsToSelector:@selector(ServiceLocationChosen:)]) {
        [_workOrderDelegate ServiceLocationChosen:serv];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    ServiceLocationDetailViewController *det=[ServiceLocationDetailViewController viewControllerWithServiceLocation:serv];
    [self.navigationController pushViewController:det animated:YES];
}


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	   
    
    for (ServiceLocation *info in _service_locations) {
        if (info.name != nil)
        {
            NSRange range = [[info.name lowercaseString] rangeOfString:[searchText lowercaseString]];
            if (range.location != NSNotFound) {
                [self.filteredListContent addObject:info];
            }
        }
    }
}



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    if (searchString.length > 0) {
        [self filterContentForSearchText:searchString scope:
         [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    }
    
    
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


- (void)CustomerListLoaded{
    
}

- (void)CustomerListLoadFailed:(NSString *)error {
    
}



@end
