//
//  NewWorkOrderDetailViewController.m
//  FieldWork
//
//  Created by SAMCOM on 15/12/15.
//
//

#import "StartWorkOrderViewController.h"
#import "WorkOrderDeatilCell.h"
#import "NewAppointMentsDetailViewController.h"
#import "NSDate+Extentsion.h"

@interface StartWorkOrderViewController ()
@property (nonatomic, strong) WorkOrderDeatilCell *cellPattern;
@end

@implementation StartWorkOrderViewController
@synthesize Tblobj;
+(StartWorkOrderViewController *)initViewControllerWithAppointment:(Appointment *)app
{
    StartWorkOrderViewController *controller=[[StartWorkOrderViewController alloc]initWithNibName:@"StartWorkOrderViewController" bundle:nil];
    controller.title=[NSString stringWithFormat:@"WO #%@", app.report_number];
    controller.Appointment = app;
    return controller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)btnStartClicked:(id)sender {
    
//    self.appointment.started_at_time = [Utils getMilitaryTime:cell.lblData.text];
    
//    NSDate *dt = [[NSDate date] changeTimeZoneToLocal];
//    NSString *time = [dt stringWithFormat:@"HH:mm"];
//    [self.Appointment setStarted_at_time:time];
    
    NewAppointMentsDetailViewController *controller = [NewAppointMentsDetailViewController initViewControllerAppointment:self.Appointment];
    [self.navigationController pushViewController:controller animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    [[UITableViewHeaderFooterView appearance] setTintColor:[UIColor grayColor]];

    if(section == 0)
    {
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 44)];
        customTitleView.backgroundColor=[UIColor grayColor];
        UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(10,0,self.view.frame.size.width, 30)];
        titleLabel.font = [UIFont boldSystemFontOfSize:13];
        titleLabel.text = @"SERVICE INSTRUCTIONS";
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        
        [customTitleView addSubview:titleLabel];
        return customTitleView;

       // return @"SERVICE INSTRUCTIONS";
    }
    else
    {
        UIView *customTitleView = [ [UIView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, 44)];
        customTitleView.backgroundColor=[UIColor grayColor];
        UILabel *titleLabel = [ [UILabel alloc] initWithFrame:CGRectMake(10,0,self.view.frame.size.width, 30)];
        
        titleLabel.text = @"LOCATION NOTE";
        titleLabel.font = [UIFont boldSystemFontOfSize:13];
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        [customTitleView addSubview:titleLabel];

        return customTitleView;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderDeatilCell *cell = (WorkOrderDeatilCell *)[tableView dequeueReusableCellWithIdentifier:@"WorkOrderDeatilCell"];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WorkOrderDeatilCell" owner:self options:nil] objectAtIndex:0];
    }
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}


- (void)configureCell:(WorkOrderDeatilCell *)cell forIndexPath:(NSIndexPath*)indexPath {
    if (indexPath.section==0)
    {
        if (self.Appointment.instructions && self.Appointment.instructions.length > 0) {
            [cell.labelText setText:self.Appointment.instructions];
        } else {
            [cell.labelText setText:@"None Provided"];
        }
    }
    else
    {
        ServiceLocation *ser_loc = [self.Appointment getServiceLocation];
        if (ser_loc.notes && ser_loc.notes.length > 0) {
            [cell.labelText setText:ser_loc.notes];
        } else {
            [cell.labelText setText:@"None Provided"];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellPattern==nil) {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"WorkOrderDeatilCell" owner:self options:nil];
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                _cellPattern = (WorkOrderDeatilCell*) currentObject;
            }
        }
    }
    [self configureCell:_cellPattern forIndexPath:indexPath];
    return [_cellPattern calculateHeight];
}

//Keval
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
