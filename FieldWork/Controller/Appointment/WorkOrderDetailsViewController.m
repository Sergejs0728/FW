//
//  WorkOrderDetailsViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 3/4/14.
//
//

#import "WorkOrderDetailsViewController.h"

@interface WorkOrderDetailsViewController ()

@end

@implementation WorkOrderDetailsViewController
@synthesize work_detail_table=_work_detail_table;
@synthesize workorder_scrollview=_workorder_scrollview;
@synthesize bottom_view=_bottom_view;
@synthesize txtView=_txtView;
@synthesize line_items=_line_items;
+(WorkOrderDetailsViewController *)viewControllerWithAppointment:(Appointment *)app
{
    WorkOrderDetailsViewController *work;
    //WorkOrderDetailsViewController_iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        work=[[WorkOrderDetailsViewController alloc]initWithNibName:@"WorkOrderDetailsViewController_iPad" bundle:nil];
        //do ur  ipad logic
    }else
    {
         work=[[WorkOrderDetailsViewController alloc]initWithNibName:@"WorkOrderDetailsViewController" bundle:nil];
        //do ur  iphone logic
    }
   
    work.title=@"Work Order Details";
    work.Appointment = app;
    return work;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewLineItem)];
    
    self.navigationItem.rightBarButtonItems = @[addBtn];
    
    
    [self loadTable];
    _txtView.text=self.Appointment.instructions;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self adjustHeightOfTableview];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}
-(void)adjustHeightOfTableview
{
    
    float table_height = 10 + 40;
    
    table_height = table_height + ((44 * self.line_items.count));
    _work_detail_table.frame = CGRectMake(self.work_detail_table.frame.origin.x, self.work_detail_table.frame.origin.y, self.work_detail_table.frame.size.width, table_height);
    _work_detail_table.scrollEnabled = NO;
    
    
    _bottom_view.frame = CGRectMake(_bottom_view.frame.origin.x, table_height + 20, _bottom_view.frame.size.width, _bottom_view.frame.size.height);
   
    _workorder_scrollview.contentSize=CGSizeMake(self.workorder_scrollview.frame.size.width,_bottom_view.frame.origin.y + _bottom_view.frame.size.height + 20);

}

- (void)addNewLineItem
{
    AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerNewWorkOrderAppointment:_Appointment andLineItem:nil Delegate:self];
    [self.navigationController pushViewController:addLineItem animated:YES];
}

- (void)loadTable {
    _line_items = [[NSMutableArray alloc] init];
    for (LineItem *info in self.Appointment.line_items) {
        if (![info.entity_status isEqualToNumber:c_DELETED]) {
            [_line_items addObject:info];
        }
    }
    [_work_detail_table reloadData];
}

#pragma mark-UITableView Delegate & Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _line_items.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return @"Line Items";
//    }
//    return @"";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return _tblSectionHeaderView;
    }
    return [[UIView alloc] init];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"CellLineItems";
    LineItemTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObject = nil;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"LineItemTableCell_iPad" owner:self options:nil];
        }else{
            topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"LineItemTableCell" owner:self options:nil];
        }
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (LineItemTableCell*) currentObject;
            }
        }
    }
    LineItem * info = [_line_items objectAtIndex:indexPath.row];
    cell.lblName.text = info.name;
    cell.lblPrice.text = [Utils getCurrencyStringFromAmount:[info.price floatValue]];
    cell.lblQty.text = [NSString stringWithFormat:@"%d",[info.quantity intValue]];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_work_detail_table)
    {
        return 44;
    }
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LineItem *info = [_line_items objectAtIndex:indexPath.row];
    AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerNewWorkOrderAppointment:_Appointment andLineItem:info Delegate:self];
    [self.navigationController pushViewController:addLineItem animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        LineItem *info = [_line_items objectAtIndex:indexPath.row];
        if (info.entity_idValue < 0) {
            [self.Appointment.line_itemsSet removeObject:info];
            [info MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
            [info saveLineItem];
        }else{
            [info setEntity_status:c_DELETED];
            [info saveLineItem];
        }
        [_line_items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self adjustHeightOfTableview];
        [self postNotificationForDirty];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - NewWorkOrderDelegate

- (void)LineItemAdded:(LineItem *)item {
    int editedIndex = -1;
    for (int i = 0; i < self.Appointment.line_items.count; i++) {
        LineItem *info = [[self.Appointment.line_items array] objectAtIndex:i];
        if ([info.entity_id isEqualToNumber:item.entity_id]) {
            editedIndex = i;
            break;
        }
    }
    
    if (editedIndex >= 0) {
        if ([item.entity_id intValue] > 0 && ![item.entity_status isEqualToNumber:c_ADDED]) {
            [item setEntity_status:c_EDITED];
            
        }else{
        }
    }else{
        if (item) [self.Appointment.line_itemsSet addObject:item];
    }
    [item saveLineItem];
    [self loadTable];
    
}



- (void)CustomerChosen:(Customer *)customer {

}
- (void)ServiceLocationChosen:(ServiceLocation *)ser_loc{

}








@end
