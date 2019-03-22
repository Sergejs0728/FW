    //
    //  NewCustomerTableViewController.m
    //  FieldWork
    //
    //  Created by Samir on 10/27/15.
    //
    //

#import "NewCustomerTableViewController.h"
#import "MFSideMenu.h"

@interface NewCustomerTableViewController ()

@end

@implementation NewCustomerTableViewController
{
    NSArray *indexTitles;
}

+(NewCustomerTableViewController *)initControllerWithMenu:(BOOL)isMenu{
    
    NewCustomerTableViewController *controller = [[NewCustomerTableViewController alloc]initWithNibName:@"NewCustomerTableViewController" bundle:nil];
    
    controller.isMenuOption = isMenu;
    return controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self createAddButton];
    if (self.isMenuOption) {
        [self createMenuButton];
    }
    
    self.title = @"Add Customer";
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:231.0/256 green:76.0/256 blue:58.0/256 alpha:1]}];
    
    indexTitles = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M",
                    @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    
}

-(void)createMenuButton{
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

-(void)createAddButton{
    UIImage* image1 = [UIImage imageNamed:@"ic_new_appointments.png"];
    CGRect frameimg1 = CGRectMake(15,5, 25,25);
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:frameimg1];
    [rightButton setBackgroundImage:image1 forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(addCustomer:)
          forControlEvents:UIControlEventTouchUpInside];
    [rightButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = addButton;
}

-(void)menuClicked:(id)sender{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
    }];
}

-(void)addCustomer:(id)sender{
    
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
        {
        return nil;
        }
    return indexTitles;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
        // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
        // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    CustomersContentCell *cell = (CustomersContentCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"CustomersContentCell" owner:self options:nil];
        for(id appcell in topLevelObject)
            {
            if([appcell isKindOfClass:[UITableViewCell class]])
                {
                cell = (CustomersContentCell*) appcell;
                }
            }
        
        
        }
    
    
    
    
    cell.nameLabel.text = @"Abc";
    cell.costLabel.text = @"$999";
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
