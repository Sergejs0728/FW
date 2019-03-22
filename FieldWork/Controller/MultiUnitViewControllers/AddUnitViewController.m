//
//  AddUnitViewController.m
//  FieldWork
//
//  Created by Alexander Kotenko on 10.05.17.
//
//

#import "AddUnitViewController.h"
#import "AddUnitFieldCell.h"
#import "AddUnitTextViewCell.h"
#import "AddUnitCell.h"
#import "DataTableViewController.h"
#import "FlatType.h"
#import "NewAppointMentsDetailViewController.h"

@interface AddUnitViewController ()<UITableViewDelegate,UITableViewDataSource,DataSelectionDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTableViewConstraint;
@property(strong,nonatomic) Unit* unit;

@end

@implementation AddUnitViewController{
    NSString* unitNumber;
    NSString* tenantName;
    NSString* phone1;
    NSString* phone2;
    NSString* email1;
    NSString* email2;
    NSString* notes;
    FlatType* unitType;
}

+(AddUnitViewController *)init {
    AddUnitViewController * vc;
    vc =[[AddUnitViewController alloc]initWithNibName:@"AddUnitViewController" bundle:nil];
    vc.title = @"Add Unit";
    return vc;
}

- (NSMutableString*)addFieldName:(NSString*)name to:(NSMutableString*)fieldsNames {
    if (fieldsNames.length) {
        [fieldsNames appendFormat:@", %@", name];
    }  else {
        [fieldsNames appendString:name];
    }
    return fieldsNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem barButtonWithTitle:NSLocalizedString(@"Save", @"") andBlock:^{
        [self.view endEditing:YES];
        if ([[AppDelegate appDelegate] isReachable]) {
            if ([self validation]) {
                [self createUnit];
                [[ActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Saving...", @"")];
                [_unit saveForServiceLocation:_serviceLocation completion:^(id item, BOOL is_success, NSString *error) {
                    if (is_success) {
                        _serviceLocation.flats = [_serviceLocation.flats setByAddingObject:_unit];
                        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                        [[ActivityIndicator currentIndicator] displayCompleted];
                        [_delegate addUnitViewControllerDidFinish:_unit];
                    } else {
                        [[ActivityIndicator currentIndicator] displayCompletedWithError:error];
                    }
                }];
            }
        } else {
            [[ActivityIndicator currentIndicator] displayCompletedWithError:NSLocalizedString(@"No Internet connection", @"")];
        }
    }];
    [self registerNibs:@[@"AddUnitFieldCell",@"AddUnitCell",@"AddUnitTextViewCell"]];
    _tableView.delegate=self;
    _tableView.dataSource=self;
}

-(void)registerNibs:(NSArray*)keys{
    for (NSString* key in keys) {
        UINib *cellNib = [UINib nibWithNibName:key bundle:nil];
        [self.tableView registerNib:cellNib forCellReuseIdentifier:key];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)agjustContentSize:(BOOL)grow notification:(NSNotification *)n {
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    if (grow) {
        _bottomTableViewConstraint.constant = keyboardSize.height;
    } else {
        _bottomTableViewConstraint.constant = 0;
    }
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    [self agjustContentSize:NO notification:n];
}

- (void)keyboardWillShow:(NSNotification *)n
{
    [self agjustContentSize:YES notification:n];
}

- (void)createUnit {
    _unit = [Unit MR_createEntityInContext:[NSManagedObjectContext MR_defaultContext]];
    _unit.unit_number=unitNumber;
    _unit.tenant_name=tenantName;
    _unit.tenant_phone_1=phone1;
    _unit.tenant_phone_2=phone2;
    _unit.tenant_email_1=email1;
    _unit.tenant_email_2=email2;
    _unit.notes=notes;
    _unit.flat_type_id = unitType.entity_id;
    _unit.entity_status = c_ADDED;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


#pragma mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return AddUnitCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    switch (row) {
        case AddUnitNumber:{
            AddUnitFieldCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitFieldCell"forIndexPath:indexPath];
            [cell.fieldNameLabel setText:@"Unit #"];
            [cell.field setKeyboardType:UIKeyboardTypeNumberPad];
            cell.blockDidChange = ^(NSString *value) {
                unitNumber =value;
            };
            return cell;
        }
            break;
        case AddUnitType:{
            AddUnitCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitCell"forIndexPath:indexPath];
            [cell.cellLabel setText:@"Unit Type"];
            if (unitType) {
                [cell.valueLabel setText:unitType.name];
            }
            else{
                [cell.valueLabel setText:@""];
            }
            return cell;
        }
            break;
        case AddUnitTenantName:{
            AddUnitFieldCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitFieldCell"forIndexPath:indexPath];
            [cell.fieldNameLabel setText:@"Tenant name"];
            [cell.field setKeyboardType:UIKeyboardTypeDefault];
            cell.blockDidChange = ^(NSString *value) {
                tenantName=value;
            };
            return cell;
        }
            break;
        case AddUnitPhone1:{
            AddUnitFieldCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitFieldCell"forIndexPath:indexPath];
            [cell.fieldNameLabel setText:@"Phone 1"];
            [cell.field setKeyboardType:UIKeyboardTypePhonePad];
            cell.blockDidChange = ^(NSString *value) {
                phone1=value;
            };
            return cell;
        }
            break;
        case AddUnitPhone2:{
            AddUnitFieldCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitFieldCell"forIndexPath:indexPath];
            [cell.fieldNameLabel setText:@"Phone 2"];
            [cell.field setKeyboardType:UIKeyboardTypePhonePad];
            cell.blockDidChange = ^(NSString *value) {
                phone2=value;
            };
            return cell;
        }
            break;
        case AddUnitEmail1:{
            AddUnitFieldCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitFieldCell"forIndexPath:indexPath];
            [cell.fieldNameLabel setText:@"Email 1"];
            [cell.field setKeyboardType:UIKeyboardTypeEmailAddress];
            cell.blockDidChange = ^(NSString *value) {
                email1=value;
            };
            return cell;
        }
            break;
        case AddUnitEmail2:{
            AddUnitFieldCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitFieldCell"forIndexPath:indexPath];
            [cell.fieldNameLabel setText:@"Email 2"];
            [cell.field setKeyboardType:UIKeyboardTypeEmailAddress];
            cell.blockDidChange = ^(NSString *value) {
                email2=value;
            };
            return cell;
        }
            break;
        case AddUnitNotes:{
            AddUnitTextViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddUnitTextViewCell"forIndexPath:indexPath];
            [cell.cellLabel setText:@"Notes"];
            cell.blockDidChange = ^(NSString *value) {
                notes=value;
            };
            return cell;
        }
            break;
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==AddUnitNotes) {
        return 320;
    }
    else{
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    if (row==AddUnitType) {
        DataTableViewController* viewController=[DataTableViewController tableWithDataType:FlatTypesList andDelegate:self];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark -
-(void)DataSelectedForData:(id)data andType:(DataType)type{
    if (type==FlatTypesList) {
        unitType = (FlatType*)data;
        [self.tableView reloadData];
    }
}

#pragma mark -
-(BOOL)validation{
    NSString *message = nil;
    Unit *existingUnit = [Unit unitWithUnitNumber:unitNumber serviceLocation:_serviceLocation];
    if (existingUnit) {
        message = NSLocalizedString(@"Unit number must be unique per location", @"");
    } else {
        NSMutableString *fieldsNames = [NSMutableString string];
        if (unitNumber == nil || unitNumber.length == 0) {
            fieldsNames = [self addFieldName:NSLocalizedString(@"unit number", @"") to:fieldsNames];
        }
        if (unitType == nil) {
            fieldsNames = [self addFieldName:NSLocalizedString(@"unit type", @"") to:fieldsNames];
        }
        if (tenantName == nil || tenantName.length == 0) {
            fieldsNames = [self addFieldName:NSLocalizedString(@"tenant name", @"") to:fieldsNames];
        }
        if (phone1 == nil || phone1.length == 0) {
            fieldsNames = [self addFieldName:NSLocalizedString(@"phone 1", @"") to:fieldsNames];
        }
        if (email1 == nil || email1.length == 0) {
            fieldsNames = [self addFieldName:NSLocalizedString(@"email 1", @"") to:fieldsNames];
        }
        
        if (fieldsNames.length) {
            message = [NSString stringWithFormat:NSLocalizedString(@"Please fill %@", nil), fieldsNames];
        }
        
    }
    if (message) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Unit", @"")
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"")
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                         }];
        [alert addAction:actionOk];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
        
    }
    return YES;
}


@end
