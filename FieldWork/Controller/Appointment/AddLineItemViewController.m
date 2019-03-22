//
//  AddLineItemViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 8/11/14.
//
//

#import "AddLineItemViewController.h"
#import "NewWorkOrderViewController.h"
#import "MaterialListController.h"
#import "Material.h"
@interface AddLineItemViewController ()

@end

@implementation AddLineItemViewController
@synthesize delegate=_delegate;
@synthesize tblView=_tblView;
@synthesize appointment=_appointment;
@synthesize currentLineItem = _currentLineItem;


+(AddLineItemViewController *)initViewControllerNewWorkOrderAppointment:(Appointment *)app andLineItem:(LineItem *)lineItem Delegate:(id<NewWorkOrderDelegate>)del{
    AddLineItemViewController * addLineItemViewController = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        addLineItemViewController =[[AddLineItemViewController alloc]initWithNibName:@"AddLineItemViewController_iPad" bundle:nil];
    }else{
        addLineItemViewController =[[AddLineItemViewController alloc]initWithNibName:@"AddLineItemViewController" bundle:nil];
    }
    
    addLineItemViewController.title = @"Line Item";
    addLineItemViewController.appointment = app;
    addLineItemViewController.delegate = del;
    addLineItemViewController.currentLineItem = lineItem;
    return addLineItemViewController;
}

+(AddLineItemViewController *)initViewControllerEstimate:(Estimate *)est andLineItem:(LineItem *)lineItem Delegate:(id<NewWorkOrderDelegate>)del{
    AddLineItemViewController * addLineItemViewController = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        addLineItemViewController = [[AddLineItemViewController alloc]initWithNibName:@"AddLineItemViewController_iPad" bundle:nil];
    }else{
        addLineItemViewController = [[AddLineItemViewController alloc]initWithNibName:@"AddLineItemViewController" bundle:nil];
    }
    
    addLineItemViewController.title =@"Line Item";
    addLineItemViewController.estimate = est;
    addLineItemViewController.delegate = del;
    addLineItemViewController.currentLineItem = lineItem;
    return addLineItemViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.currentLineItem == nil) {
        _is_adding_new = YES;
        self.currentLineItem = [LineItem newLineItem];
        self.currentLineItem.quantity = [NSNumber numberWithInt:1];
    } else {
        _is_adding_new = NO;
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [gestureRecognizer setCancelsTouchesInView:NO];
    gestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gestureRecognizer];
    
    [self createBarButton];
    formatter = [NSNumberFormatter new];
    NSLocale *american = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:american];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setLenient:YES];
    [formatter setGeneratesDecimalNumbers:YES];
}

- (BOOL)navigationShouldPopOnBackButton {
//    if (_is_adding_new == YES) {
        [self.currentLineItem discard];
//    }
    return YES;
}

-(void)createBarButton{
   
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveClicked:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellServicePrice";
    AddLineItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AddLineItemCell" owner:self options:nil];
        
        for(id currentObject in topLevelObject)
        {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (AddLineItemCell*) currentObject;
            }
        }
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        cell.txtField.frame = CGRectMake(cell.txtField.frame.origin.x, cell.txtField.frame.origin.y, 600, cell.txtField.frame.size.height);
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.txtField.userInteractionEnabled = YES;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.txtField.userInteractionEnabled = NO;
        if (_currentLineItem.payable_type == nil || _currentLineItem.payable_type.length == 0 || ![_currentLineItem.lineitem_type isEqualToString:@"other"]) {
            cell.txtField.text = [_currentLineItem.lineitem_type capitalizedString];
        } else {
            cell.txtField.text = _currentLineItem.payable_type;
        }
        
    }else if (indexPath.row == 1){
        cell.txtField.placeholder = @"Name";
        cell.txtField.userInteractionEnabled = ([_currentLineItem.lineitem_type isEqualToString:@"other"] || _currentLineItem.payable_type.length == 0 || _currentLineItem.payable_type == nil);
        cell.txtField.text = _currentLineItem.name;
    }else if (indexPath.row == 2){
        cell.txtField.placeholder = @"Qty";
        cell.txtField.keyboardType = UIKeyboardTypeNumberPad;
        
        if (_currentLineItem.quantity > 0) {
            cell.txtField.text = [NSString stringWithFormat:@"%@", _currentLineItem.quantity];
            cell.txtField.userInteractionEnabled = YES;
            cell.txtField.tag = 1;
            //cell.txtField.delegate = nil;
        }
    }else if (indexPath.row == 3){
        cell.txtField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.txtField.placeholder = @"Price";
        cell.txtField.delegate = self;
        cell.txtField.enabled = YES;
        cell.txtField.tag = 2;
        if (_currentLineItem.price > 0) {
//            NSString* price = [NSString stringWithFormat:@"%@", _currentLineItem.price];
//            NSRange range = [price rangeOfString:@"."];
            cell.txtField.text = [formatter stringFromNumber:_currentLineItem.price];
//            if (range.location != NSNotFound)
//            {
//                cell.txtField.text = [NSString stringWithFormat:@"$%@",_currentLineItem.price];
//            } else {
//                cell.txtField.text = [NSString stringWithFormat:@"$%@.00",_currentLineItem.price];
//            }
        }
    }else if (indexPath.row ==4){
        cell.txtField.userInteractionEnabled = NO;
        cell.textLabel.text = @"Taxable";
        cell.editing = NO;
        if ([_currentLineItem.taxable isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell* uncheckCell = [tableView
                                    cellForRowAtIndexPath:indexPath];

    AddLineItemCell *cell = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (indexPath.row == 0) {
        DataTableViewController *dt = [DataTableViewController tableWithDataType:AddLineItem andDelegate:self];
        _currentLineItem.quantityValue = cell.txtField.text.integerValue;
        [self.navigationController pushViewController:dt animated:YES];
    } else if (indexPath.row == 1) {
        if (![_currentLineItem.lineitem_type isEqualToString:@"other"] && _currentLineItem.payable_type && _currentLineItem.payable_type.length > 0) {
            if ([_currentLineItem.payable_type isEqualToString:@"Service"]) {
                DataTableViewController *dt = [DataTableViewController tableWithDataType:LineItemServices andDelegate:self];
                _currentLineItem.quantityValue = cell.txtField.text.integerValue;
                [self.navigationController pushViewController:dt animated:YES];
            } else if ([_currentLineItem.payable_type isEqualToString:@"Material"]) {
                MaterialListController * mater =[MaterialListController viewControllerWithAppointment:_appointment AddLineItemDelegate:self];
                _currentLineItem.quantityValue = cell.txtField.text.integerValue;
                [self.navigationController pushViewController:mater animated:YES];
            }
        }
    } else if (indexPath.row == 4) {
        if (uncheckCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        } else {
            uncheckCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
}

-(void)saveClicked:(id)sender{
    
    UITableViewCell *cell5 = [_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    AddLineItemCell *cell1 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    AddLineItemCell *cell2 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    AddLineItemCell *cell3 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    AddLineItemCell *cell4 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    
    if (cell1.txtField.text.length <= 0 || cell2.txtField.text.length <= 0 || cell3.txtField.text.floatValue <= 0 || cell3.txtField.text.length <= 0 || cell4.txtField.text.length <= 0) {
        
        UIAlertView * alertView =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please enter valid information to add Line Item" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    _currentLineItem.name = cell2.txtField.text;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    [_currentLineItem setQuantity:[f numberFromString:cell3.txtField.text]];
    
    if (_currentLineItem.payable_type.length == 0 || _currentLineItem.payable_type == nil) {
        _currentLineItem.lineitem_type=@"other";
    } else {
        _currentLineItem.lineitem_type=[_currentLineItem.payable_type lowercaseString];
    }
    [_currentLineItem setPrice:FloatNumber([Utils getValueFromCurrencyStyleString:cell4.txtField.text])];
    [_currentLineItem setTaxableValue:NO];
    [_currentLineItem setTotal:FloatNumber([_currentLineItem.price floatValue] * [_currentLineItem.quantity floatValue])];
    if (cell5.accessoryType == UITableViewCellAccessoryCheckmark) {
        [_currentLineItem setTaxableValue:YES];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(LineItemAdded:)]) {
        [_delegate LineItemAdded:_currentLineItem];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    if (type == AddLineItem) {
        AddLineItemCell *cell1 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        NSString *selectedData = (NSString *)data;
        cell1.txtField.text = selectedData;
        if ([data isEqualToString:@"Other"]) {
            _currentLineItem.payable_type = @"";
            _currentLineItem.lineitem_type=@"other";
        } else {
           _currentLineItem.payable_type = selectedData;
            _currentLineItem.lineitem_type=[_currentLineItem.payable_type lowercaseString];
        }
        cell1.txtField.userInteractionEnabled = NO;
        AddLineItemCell *cell2 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell2.txtField setText:@""];
        _currentLineItem.name = @"";
        
    }else if (type == LineItemServices) {
        AddLineItemCell *cell1 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        Services *services = (Services*)data;
        cell1.txtField.text = services.service_description;
        _currentLineItem.payable_id = services.entity_id;
        _currentLineItem.name = services.service_description;
        
        AddLineItemCell *cell3 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        cell3.txtField.text = [NSString stringWithFormat:@"$%.02f", [services.price floatValue]];
        _currentLineItem.price = services.price;
    }
    [_tblView reloadData];
}

-(void)getMaterialInfo:(Material *)mat{
    material = mat;
    AddLineItemCell *cell1 = (AddLineItemCell*)[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell1.txtField.text = mat.name;
    _currentLineItem.payable_id = mat.entity_id;
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"%@",textField.text);
    if (textField.tag == 1) {
        NSString *replaced = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (replaced.length > 7) {
            return NO;
        }
    }
    if (textField.tag == 2) {
        NSString *originalString = [textField.text stringByReplacingOccurrencesOfString:formatter.currencySymbol withString:@""];
        NSString* noSpaces =
        [[originalString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
         componentsJoinedByString:@""];
        if (range.location==0 && range.length==1) {
            return NO;
        }
        range.location = range.location - (textField.text.length - noSpaces.length);
        NSString *replaced = [noSpaces stringByReplacingCharactersInRange:range withString:string];
        if (replaced.length > 10) {
            return NO;
        }
        NSDecimalNumber *amount = (NSDecimalNumber*) [formatter numberFromString:replaced];
        if (amount == nil) {
            // Something screwed up the parsing. Probably an alpha character.
            return NO;
        }
        // If the field is empty (the inital case) the number should be shifted to
        // start in the right most decimal place.
        short powerOf10 = 0;
        if ([textField.text isEqualToString:@""]) {
            powerOf10 = -formatter.maximumFractionDigits;
        }
        // If the edit point is to the right of the decimal point we need to do
        // some shifting.
        else if (range.location + formatter.maximumFractionDigits >= noSpaces.length) {
            // If there's a range of text selected, it'll delete part of the number
            // so shift it back to the right.
            if (range.length) {
                powerOf10 = -range.length;
            }
            // Otherwise they're adding this many characters so shift left.
            else {
                powerOf10 = [string length];
            }
        }
        amount = [amount decimalNumberByMultiplyingByPowerOf10:powerOf10];
        // Replace the value and then cancel this change..
        textField.text = [formatter stringFromNumber:amount];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
