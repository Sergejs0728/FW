//
//  ContactListViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import "ContactListViewController.h"

@interface ContactListViewController ()

@end

@implementation ContactListViewController
@synthesize contact_list=_contact_list;
@synthesize contact_table=_contact_table;
@synthesize searchWasActive=searchWasActive;
@synthesize sectionedListContent=sectionedListContent;
@synthesize savedScopeButtonIndex=savedScopeButtonIndex;
@synthesize filteredListContent=filteredListContent;
@synthesize savedSearchTerm=savedSearchTerm;
@synthesize listContent=listContent;

+ (ContactListViewController *)viewControllerWithContactArray:(NSMutableArray *)contact_list {
    ContactListViewController *controller = [[ContactListViewController alloc] initWithNibName:@"ContactListViewController" bundle:nil];
    controller.title=@"Contacts";
    controller.contact_list=[[NSMutableArray alloc]init];
    controller.contact_list = contact_list;
    return controller;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   //
    [self.filteredListContent addObjectsFromArray:_contact_list];
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[self.listContent count]];
    if (self.savedSearchTerm)
	{
        [self.searchDisplayController setActive:self.searchWasActive];
        [self.searchDisplayController.searchBar setSelectedScopeButtonIndex:self.savedScopeButtonIndex];
        [self.searchDisplayController.searchBar setText:savedSearchTerm];
        
        self.savedSearchTerm = nil;
    }
    [self.contact_table reloadData];
    
    // Do any additional setup after loading the view from its nib.
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

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory issue!!!");
}

#pragma mark-UITableView Delegate & Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_contact_list.count ==0)
    {
        return 1;
    }
    else
    { if (tableView==self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredListContent count];
    }
    else{
        return _contact_list.count;
    }
        return _contact_list.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   static NSString *CellIdentifier = @"Cell1";
    if (_contact_list.count==0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.tag = -1010;
        
        cell.textLabel.text = @"There are no contacts to be shown!";
        [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
        cell.textLabel.textColor=[UIColor lightGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel sizeToFit];
        return cell;
        
        
    }
    else
    {
        static NSString *CellIdentifier2 = @"Cell2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        /*
         *   If the cell is nil it means no cell was available for reuse and that we should
         *   create a new one.
         */
        if (cell == nil) {
            
            /*
             *   Actually create a new cell (with an identifier so that it can be dequeued).
             */
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            Contact *c =nil;
            
            
            if (tableView==self.searchDisplayController.searchResultsTableView)
            {
                c=[filteredListContent objectAtIndex:indexPath.row];
                cell.textLabel.text=[NSString stringWithFormat:@"%@ %@ %@ ",c.title,c.first_name,c.last_name];
            }
            else
            {
                c=[_contact_list objectAtIndex:indexPath.row];
                 cell.textLabel.text=[NSString stringWithFormat:@"%@ %@ %@ ",c.title,c.first_name,c.last_name];
            }

            
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_contact_list.count==0)
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    else{
        Contact *cinfo=nil;
        ContactDetailViewController *det;
        if (tableView==self.searchDisplayController.searchResultsTableView)
        {
            cinfo=[filteredListContent objectAtIndex:indexPath.row];
            det=[ContactDetailViewController viewControllerWithContact:cinfo];
            [self.navigationController pushViewController:det animated:YES];
        }
        else
        {
            cinfo=[_contact_list objectAtIndex:indexPath.row];
            det=[ContactDetailViewController viewControllerWithContact:cinfo];
            [self.navigationController pushViewController:det animated:YES];
        }
        
       
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    
    for (Contact *info in _contact_list) {
        if (info.first_name != nil)
        {
            NSRange range = [[info.first_name lowercaseString] rangeOfString:[searchText lowercaseString]];
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



@end
