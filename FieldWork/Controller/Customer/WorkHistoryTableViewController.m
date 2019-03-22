//
//  WorkHistoryTableViewController.m
//  FieldWork
//
//  Created by Mac4 on 13/10/14.
//
//

#import "WorkHistoryTableViewController.h"

@interface WorkHistoryTableViewController ()

@end

@implementation WorkHistoryTableViewController
@synthesize service_location = _service_location;

+(WorkHistoryTableViewController *)viewControllerWithServiceLocation:(ServiceLocation*) serloc
{
    WorkHistoryTableViewController *cust;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        cust = [[WorkHistoryTableViewController alloc]initWithNibName:@"WorkOrderTabelViewController_iPad" bundle:nil];
    }else{
        cust = [[WorkHistoryTableViewController alloc]initWithNibName:@"WorkHistoryTableViewController" bundle:nil];
    }
    cust.title=serloc.name;
    cust.service_location = serloc;
    return cust;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
        if (self.service_location != nil) {
        //26112015
        //_workHistory = [self.service_location getWorkHistory];
        if (_workHistory.count <= 0) {
            //[[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
            ////26112015
            __weak WorkHistoryTableViewController *weakSelf = self;
            
            [self.service_location loadWorkHistory:^(id result, NSString *error) {
                if (!error) {
                    [weakSelf loadTable];
                }
            }];
        }
    }
}

-(void)loadTable{
    _workHistory = [Appointment getWorkOrderHistoryByServiceLocationId:_service_location];
    if (_workHistory.count > 0) {
        [_tblWorkHistory reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _workHistory.count <= 0 ? 1 : _workHistory.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([_workHistory count] <= 0)
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
        cell.textLabel.textAlignment = UITextAlignmentLeft;
#else
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
#endif
        
        cell.textLabel.text = @"Could not find work history.";
        [[cell textLabel] setFont:[UIFont systemFontOfSize:14.0]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else{
        static NSString *CellTableIdentifier = @"CellTableIdentifier";
        WorkHistoryCell *cell = (WorkHistoryCell*)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
        if (cell == nil)
        {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
            {
                NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"WorkHistoryCell_iPad" owner:self options:nil];
                for(id appcell in topLevelObject)
                {
                    if([appcell isKindOfClass:[UITableViewCell class]])
                    {
                        cell = (WorkHistoryCell*) appcell;
                    }
                }
            }
            else
            {
                NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"WorkHistoryCell" owner:self options:nil];
                for(id appcell in topLevelObject)
                {
                    if([appcell isKindOfClass:[UITableViewCell class]])
                    {
                        cell = (WorkHistoryCell*) appcell;
                    }
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        Appointment *app = [_workHistory objectAtIndex:indexPath.row];
        [cell setData:app];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_workHistory.count <= 0) {
        return 44;
    }
    return 80;
}


#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < _workHistory.count) {
        Appointment *app = [_workHistory objectAtIndex:indexPath.row];
        if (app) {
            WOHistoryDetailController *controller = [WOHistoryDetailController viewControllerWithWorkOrder:app];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}


#pragma mark - WorkHistoryDelegate

- (void)WorkHistoryLoaded {
    [[ActivityIndicator currentIndicator] displayCompleted];
    //26112015
   // _workHistory = [self.service_location getWorkHistory];
    if (_workHistory) {
        [_tblWorkHistory reloadData];
    }
}

- (void)WorkHistoryLoadFailWithError:(NSString *)error {
    [[ActivityIndicator currentIndicator] displayCompleted];
}

@end
