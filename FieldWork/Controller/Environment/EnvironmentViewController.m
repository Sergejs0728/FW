//
//  EnvironmentViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 29/07/2013.
//
//

#import "EnvironmentViewController.h"

@interface EnvironmentViewController ()
@property (nonatomic) BOOL saved;
@end

@implementation EnvironmentViewController



+ (EnvironmentViewController *)initWithAppointment:(Appointment *)app
{
    EnvironmentViewController * environment;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        environment =[[EnvironmentViewController alloc]initWithNibName:@"EnvironmentView_iPad" bundle:nil];
        
    }else{
        environment =[[EnvironmentViewController alloc]initWithNibName:@"EnvironmentView" bundle:nil];
        
    }
    environment.Appointment= app;
    environment.title =@"Environment";
    return environment;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _saved=NO;
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(SaveEnvironment:)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    mainTable.delegate=self;
    mainTable.dataSource=self;
    [mainTable reloadData];
	
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

-(void)SaveEnvironment:(id)sender{
    CustomTableCell *directioncell = (CustomTableCell*)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString * direction = directioncell.txt.text;
    CustomTableCell *speedcell = (CustomTableCell*)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    NSString * speed = speedcell.txt.text;
    CustomTableCell *tempCell = (CustomTableCell*)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    NSString * temp = tempCell.txt.text;
    CustomTableCell *sqFeetCell = (CustomTableCell*)[mainTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    NSString * sqFeet = sqFeetCell.txt.text;
    self.Appointment.wind_direction = direction;
    self.Appointment.wind_speed = speed;
    self.Appointment.temperature = temp;
    self.Appointment.square_feet = sqFeet;
    [self.Appointment saveAppointmentOnLocal];
    _saved=YES;
    if (_onPopBlock) {
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            _onPopBlock(self.Appointment);
        }];
        [self.navigationController popViewControllerAnimated:YES];
        [CATransaction commit];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if(!_saved){
        [self.Appointment.managedObjectContext rollback];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"CellAmountCheck";
        CustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"CustomLableTextCell" owner:self options:nil];
            
            for(id currentObject in topLevelObject)
            {
                if([currentObject isKindOfClass:[UITableViewCell class]])
                {
                    cell = (CustomTableCell*) currentObject;
                }
            }
        }
        if(indexPath.row == 0)
        {
            cell.lbl.text = @"Wind Direction";
            cell.txt.text = self.Appointment.wind_direction;
            cell.txt.enabled = NO;
            cell.txt.tag =0;
        }
        else if(indexPath.row == 1)
        {
            cell.lbl.text = @"Wind Speed";
            cell.txt.text = self.Appointment.wind_speed;
            cell.txt.tag = 1;
        }
        else if(indexPath.row == 2)
        {
            cell.lbl.text = @"Temperature";
            cell.txt.text = self.Appointment.temperature;
            cell.txt.tag = 2;
        }
        else if(indexPath.row == 3)
        {
            cell.lbl.text = @"Sq Feet";
            cell.txt.text = self.Appointment.square_feet;
            cell.txt.tag = 3;
        }
        cell.txt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
        CustomTableCell * cell0 = (CustomTableCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        CustomTableCell * cell2 = (CustomTableCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        CustomTableCell * cell3 = (CustomTableCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        
        self.Appointment.square_feet = cell0.txt.text;
        self.Appointment.wind_speed = cell2.txt.text;
        self.Appointment.temperature = cell3.txt.text;
        
        DataTableViewController *dt = [DataTableViewController tableWithDataType:WindDirection andDelegate:self];
        [self.navigationController pushViewController:dt animated:YES];
    }
}

#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    self.Appointment.wind_direction = data;
    [mainTable reloadData];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

@end
