    //
    //  NewWorkOrderViewController.m
    //  FieldWork
    //
    //  Created by Samir Khatri on 8/2/14.
    //
    //

#import "NewWorkOrderViewController.h"
#import "CustomerListViewController.h"
#import "Appointment.h"
#import "Appointment+Helper.h"
#import "Customer.h"
#import "AddLineItemViewController.h"
#import "User.h"

@interface NewWorkOrderViewController ()
{
    NSDate *selected_date;
}


@end

static int TABLE_LINE_ITEM_HEIGHT = 44;

@implementation NewWorkOrderViewController


+ (NewWorkOrderViewController *)viewControllerWithWorkOrder:(Appointment *)app {
    NewWorkOrderViewController *controller;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller = [[NewWorkOrderViewController alloc] initWithNibName:@"NewWorkOrderViewController_iPad" bundle:nil];
    }else{
        controller = [[NewWorkOrderViewController alloc] initWithNibName:@"NewWorkOrderViewController" bundle:nil];
        
    }
    controller.Appointment = app;
    controller.title = @"New Work Order";
    return controller;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    if (([self.Appointment.entity_id intValue] > 0)) {
        self.title = [NSString stringWithFormat:@"WO #%@", self.Appointment.report_number];
    }
    if ([self.Appointment.line_items array] == nil) {
        self.Appointment.line_items = [[NSOrderedSet alloc] init];
    }
    _lineItems = [[self.Appointment.line_items array] mutableCopy];
    NSString *address = [[self.Appointment getServiceLocation] getFullAddress];
    _lblServiceLocation.text = address;
    _txtDate.text = [Utils dateFormatMMddyyyy:self.Appointment.starts_at];
    _txtStartTime.text = [Utils dateFormathhmma:self.Appointment.starts_at];
    _txtEndTime.text= [Utils dateFormathhmma:self.Appointment.ends_at];
//    _txtStartTime.text = [Utils getCorrectDateFormathhmmaa:self.Appointment.starts_at];
//    _txtEndTime.text = [Utils getCorrectDateFormathhmmaa:self.Appointment.ends_at];
    _txtServiceInstruction.text= self.Appointment.instructions;
    _txtPoNumber.text= self.Appointment.purchase_order_no;
    [self.Appointment calculateTaxAmountForOwnTaxtRate:NO];
    self.Appointment.service_route_ids= @[[User getUser].service_route_id];
    _txtPoNumber.text = self.Appointment.purchase_order_no;
    [self createBarButton];
    [self expandViews];
    datePicker =[[UIDatePicker alloc]init];
    _txtServiceInstruction.layer.cornerRadius = 7.0;
    _txtServiceInstruction.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _txtServiceInstruction.layer.borderWidth = 1.0;
    if (self.Appointment.starts_at_date.length <= 0) {
        NSDate *dt = [NSDate systemDate];
        _txtDate.text = [Utils dateFormatMMddyyyy:dt];
        _txtStartTime.text = [Utils dateFormathhmma:dt];
        _txtEndTime.text = [Utils dateFormathhmma:dt];
        
    }
    lblCharacter.text = @"2000";
    _txtServiceInstruction.delegate =self;
}



-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(btnSaveClicked:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}

-(BOOL) navigationShouldPopOnBackButton
{
    [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"Are you sure want to exit?"
                               delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
    return NO;
}

#pragma mark -UIAlertViewDelegate	


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1) {
        [[NSManagedObjectContext MR_defaultContext] rollback];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - Custom Methods

- (void)expandViews
{
    float line_item_table_height = 143+38+(_lineItems.count * 44);
    
    constraintLineItemContainerViewHeight.constant = line_item_table_height;
    NSLog( @"constant, %f",constraintLineItemContainerViewHeight.constant);
//    lineItemContainerView.frame = CGRectMake(lineItemContainerView.frame.origin.x, lineItemContainerView.frame.origin.y, lineItemContainerView.frame.size.width, line_item_table_height);
//    _tblLineItems.frame = CGRectMake(_tblLineItems.frame.origin.x, 0, _tblLineItems.frame.size.width, line_item_table_height);
    
//    constraintBottomViewHeight.constant
//    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x,lineItemContainerView.frame.origin.y +  lineItemContainerView.frame.size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
    
    
//    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _bottomView.frame.origin.y  + _bottomView.frame.size.height - 50);
}

#pragma mark - Events

- (void)btnNewLineItemClicked:(id)sender {
    
    
    [self.view endEditing:YES];
    
    if ([self.Appointment.service_location_id intValue] <= 0) {
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:ALERT_TITLE message:@"Please select Service Location first." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    LineItem *lineItem = [LineItem newLineItem];
    lineItem.payable_type = @"Service";
    lineItem.quantityValue = 1;
    ServiceLocation *serloc = [self.Appointment getServiceLocation];
    
    TaxRates *tr = [TaxRates getTaxRatesById:serloc.tax_rate_id];
    lineItem.taxable = [NSNumber numberWithInteger:tr.service_taxable];
    
    AddLineItemViewController *addLineItem =[AddLineItemViewController initViewControllerNewWorkOrderAppointment:_Appointment andLineItem:lineItem Delegate:self];
    [self.navigationController pushViewController:addLineItem animated:YES];
}

- (void)btnSaveClicked:(id)sender {
    [self.Appointment setLine_items:[NSOrderedSet orderedSetWithArray:_lineItems]];
    if (self.Appointment.line_items == nil || self.Appointment.line_items.count <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please add line item." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    if (self.Appointment.service_route_ids == nil || [(NSArray*)self.Appointment.service_route_ids count] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Please select atlest one technician." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    if ([[AppDelegate appDelegate] isReachable]) {
        [[ActivityIndicator currentIndicator]displayActivity:@"Please wait..."];
        
        [self.Appointment setStatus:wo_STATUS_SHEDULED];
        [self.Appointment setStarts_at_date:_txtDate.text];
        [self.Appointment setEnds_at_date:_txtDate.text];
        [self.Appointment setStarted_at_time:_txtStartTime.text];
        [self.Appointment setFinished_at_time:_txtEndTime.text];
        [self.Appointment setStarts_at_time:_txtStartTime.text];
        [self.Appointment setInstructions:_txtServiceInstruction.text];
        [self.Appointment setPurchase_order_no:_txtPoNumber.text];
        [self.Appointment setEnds_at_time:_txtEndTime.text];
        
        
        // We are removing the started_at_time and finished_at_time at the time of creation of JSON.
        
        __weak typeof(self) _weakSelf = self;
        if ([self.Appointment.entity_id intValue] > 0) {
            [self.Appointment setSpecific:[NSNumber numberWithBool:YES]];
            //[self.Appointment saveAppointmentOnLocal];
            [self.Appointment saveWorkPoolAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                [[ActivityIndicator currentIndicator] displayCompleted];
                if (is_saved) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
                    [_weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Could not save this work order, please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                }
            }];
            
        } else {
            [self.Appointment addNewWorkOrderWithBklock:^(id item, BOOL is_success, NSString *error) {
                [[ActivityIndicator currentIndicator] displayCompleted];
                if (is_success) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
                    [_weakSelf.navigationController popViewControllerAnimated:YES];
                } else {
                    [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                }
            }];
        }
    } else {
        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"No internet connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }
    
}

-(void)dateClicked:(id)sender{
    datePicker.datePickerMode = UIDatePickerModeDate;
    [self openDatePickerViewWithTag:DATE_PICKER_DATE_TAG andTitle:@"Appointment Date" forDatePickerView:datePicker];
}

-(void)startTimeClicked:(id)sender{
    datePicker.datePickerMode = UIDatePickerModeTime;
    NSDate *dt = [NSDate systemDate];
    datePicker.date = dt;
    
    [self openDatePickerViewWithTag:DATE_PICKER_START_TIME_TAG andTitle:@"Start Time" forDatePickerView:datePicker];
    
    
}
-(void)endTimeClicked:(id)sender{
    datePicker.datePickerMode = UIDatePickerModeTime;
    NSDate *dt = [NSDate systemDate];
    datePicker.date = dt;
    
    [self openDatePickerViewWithTag:DATE_PICKER_END_TIME_TAG andTitle:@"End Time" forDatePickerView:datePicker];
    
    
}


- (void) calculateLineItems
{
    float Total =0.0;
    float discount = [self.Appointment.discount floatValue];
    [self.Appointment setDiscount:[NSNumber numberWithFloat:discount]];
    ServiceLocation *serloc = [self.Appointment getServiceLocation];
    TaxRates *tr = [TaxRates getTaxRatesById:serloc.tax_rate_id];

    [self.Appointment setTax_amount:[NSNumber numberWithFloat:0.0]];
    [self.Appointment setDiscount_amount:[NSNumber numberWithFloat:0.0]];

    for (LineItem * info in _lineItems) {
        float p = [info.total floatValue];
        float disc = 0, tax = 0;
        if (discount > 0) {
            disc = (p * discount) / 100;
        }
        self.Appointment.discount_amount = [NSNumber numberWithFloat:[self.Appointment.discount_amount floatValue] + disc];
        p = p - disc;
        if ([info.taxable floatValue] == YES) {
            
            tax = (p * [tr.rate floatValue]); // 100;
        }
        self.Appointment.tax_amount = [NSNumber numberWithFloat:[self.Appointment.tax_amount floatValue] + tax];
        p = p + tax;
        
        Total = Total + p;
    }
}

#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tblChooseTable) {
        return 3;
    }else if (tableView == _tblLineItems){
        NSUInteger cnt = _lineItems.count;
        return cnt + 2;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tblChooseTable) {
        return 1;
    }else if (tableView == _tblLineItems){
        return 1;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == _tblLineItems){
        NSLog(@"heightForHeaderInSection:%d",38);
        return 38;
    }
    else {
        NSLog(@"heightForHeaderInSection:%d",1);

        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tblLineItems) {
        if (indexPath.row == [_lineItems count] + 1){
            NSLog(@"heightForRowAtIndexPath:%d",143);

            return 143;
        }
        NSLog(@"heightForRowAtIndexPath:%d",44);

        return 44;
    }
    NSLog(@"heightForRowAtIndexPath:%d",44);

    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView*) createHeaderViewForSection:(NSInteger)section withTitle:(NSString*)title andButtonBlock:(void(^)())block
{
    float height = [_tblLineItems.delegate tableView:_tblLineItems heightForHeaderInSection:section];
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(_tblLineItems.frame), height);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UILabel *lbl = [[CustomLabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, height)];
    [lbl setText:title];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setFont:[UIFont systemFontOfSize:13.0]];
    [view addSubview:lbl];
    [view setBackgroundColor:[UIColor colorWithRed:142.0f/255.0f green:142.0f/255.0f blue:142.0f/255.0f alpha:1.0f]];
    
    float btn_width = 100;
    CGRect btn_frame = CGRectMake(view.frame.size.width - btn_width, 0, btn_width, height);
    UIButton *btn = [[UIButton alloc] initWithFrame:btn_frame];
    [btn setTitle:@"+ Add" forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
    [btn setBackgroundColor:[UIColor colorWithRed:94.0/255.0 green:94.0/255.0 blue:94.0/255.0 alpha:1.0]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (block) {
        [btn setAction:kUIButtonBlockTouchUpInside withBlock:block];
    }
    [view addSubview:btn];
    [view bringSubviewToFront:btn];
    
    return view;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tblLineItems) {
        return [self createHeaderViewForSection:section withTitle:@"LINE ITEMS" andButtonBlock:^{
            [self btnNewLineItemClicked:nil];
        }];
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tblChooseTable) {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
            {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            }
        if (indexPath.row == 0) {
            if ([self.Appointment.customer_id intValue] > 0) {
                Customer *cust = [self.Appointment getCustomer];
                
                cell.textLabel.text = [cust getDisplayName];
            }else{
                cell.textLabel.text = @"Choose Customer";
            }
        }else if (indexPath.row == 1){
            if ([self.Appointment.service_location_id intValue] > 0) {
                ServiceLocation *ser = [self.Appointment getServiceLocation];
                cell.textLabel.text = ser.name;
            }else{
                cell.textLabel.text = @"Choose Service Location...";
            }
        }else if (indexPath.row == 2){
            
            if (self.Appointment.service_route_ids != nil) {
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                NSMutableArray * serviceRouteArr = [self.Appointment.service_route_ids mutableCopy];
                for (NSNumber *sr_id in serviceRouteArr) {
                    ServiceRoutes *sr = [ServiceRoutes serviceRoutesById:[sr_id intValue]];
                    if (sr.service_route_name) [arr addObject:sr.service_route_name];
                }
                NSString *name= [arr joinWithDelimeter:@","];
                cell.textLabel.text = [name isEqualToString:@""] ? @"Choose technician...": name;
            }else{
                cell.textLabel.text = @"Choose technician...";
            }
        }
        return cell;
    }else if (tableView == _tblLineItems) {
        if(indexPath.row == 0){
            return _lineItemFirstRow;
        } else if (indexPath.row == [_lineItems count] + 1){
            __block NewWorkOrderViewController* weakSelf = self;
            
            LineItemFooterCell *cell = nil;//(AppLineItemCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                NSArray *topLevelObject;
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
                {
                    topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"LineItemFooterCell_iPad" owner:self options:nil];
                }else{
                    topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"LineItemFooterCell" owner:self options:nil];
                }
                for(id appcell in topLevelObject)
                {
                    if([appcell isKindOfClass:[UITableViewCell class]])
                    {
                        cell = (LineItemFooterCell*) appcell;
                    }
                }
            }
            [cell hidePayNowButton];
            
            [cell setDataWithAppointment:self.Appointment withPayNowBlock:^{
            } isWorkPool:YES];
            cell.discountValueChangedBlock = ^Appointment*(float discount)
            {
                NSLog(@"%02f", discount);
                
                [weakSelf.Appointment setDiscount:[NSNumber numberWithFloat:discount]];
                [weakSelf.Appointment.invoice setDiscount:[NSNumber numberWithFloat:discount]];
                
                return weakSelf.Appointment;
            };
            
            
            return cell;
        } else {
            AppLineItemCell *cell = nil;//(AppLineItemCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil)
            {
                NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppLineItemCell" owner:self options:nil];
                for(id appcell in topLevelObject)
                {
                    if([appcell isKindOfClass:[UITableViewCell class]])
                    {
                        cell = (AppLineItemCell*) appcell;
                    }
                }
            }
            LineItem *line_item = [_lineItems objectAtIndex:(indexPath.row - 1)];
            [cell setLineItem:line_item forWorkOrder:self.Appointment];
            return cell;
        }
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (tableView == _tblChooseTable) {
        if (indexPath.row == 0) {
            CustomerListViewController *cust_list = [CustomerListViewController initWithNewWorkOrderDelegate:self];
            [self.navigationController pushViewController:cust_list animated:YES];
        }
        if (indexPath.row == 1) {
            if ([self.Appointment.customer_id intValue] <= 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"Please select customer first." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                return;
            }
            Customer *cust = [self.Appointment getCustomer];
            CustomerServiceLocationListControllerViewController *controller = [CustomerServiceLocationListControllerViewController initViewControllerWiithCustomer:cust withWorkOrderDelegate:self];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 2) {
            if ([self.Appointment.customer_id intValue] <= 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"Please select customer first." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alert show];
                return;
            }
            DataTableViewController *dt = [DataTableViewController tableWithDataType:ServiceRoutesList andDelegate:self withMultipleChoices:YES];
             NSMutableArray * arr = [[NSMutableArray alloc]init];
            for (NSNumber *sr_id in self.Appointment.service_route_ids) {
                ServiceRoutes *sr = [ServiceRoutes serviceRoutesById:[sr_id intValue]];
                if (sr) [arr addObject:sr];
            }

            dt.existing_items = arr;
            [self.navigationController pushViewController:dt animated:YES];
        }
    }
    
    if (tableView == _tblLineItems) {
        if (indexPath.row < 1 || indexPath.row > [_lineItems count]) {
            return;
        }
        LineItem * info = [_lineItems objectAtIndex:indexPath.row - 1];
        AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerNewWorkOrderAppointment:_Appointment andLineItem:info Delegate:self];
        [self.navigationController pushViewController:addLineItem animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tblLineItems) {
        if (indexPath.row < 1 || indexPath.row > [_lineItems count] + 1) {
            return;
        }
        if (editingStyle == UITableViewCellEditingStyleDelete) {
             LineItem *info = [_lineItems objectAtIndex:indexPath.row - 1];
            [_lineItems removeObjectAtIndex:indexPath.row - 1];
            [info setEntity_status:c_DELETED];
            [info saveLineItem];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self expandViews];
            //[self calculateLineItems];
            [self.Appointment calculateTaxAmountForOwnTaxtRate:NO];
             [tableView reloadData];

        }
    }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tblLineItems) {
        if (indexPath.row < 1 || indexPath.row >= [_lineItems count] + 1) {
            return NO;
        }
        return YES;
    }
    return NO;
}


#pragma mark - NewWorkOrderDelegate

- (void)LineItemAdded:(LineItem *)item {
    if (item) {
        int editedIndex = -1;
        for (int i = 0; i < _lineItems.count; i++) {
            LineItem *info = [_lineItems objectAtIndex:i];
            if ([info.entity_id intValue] == [item.entity_id intValue]) {
                editedIndex = i;
                break;
            }
        }
        if (editedIndex >= 0) {
            [item setEntity_status:c_EDITED];
            [item.managedObjectContext MR_saveOnlySelfAndWait];
            [_lineItems replaceObjectAtIndex:editedIndex withObject:[item MR_inContext:self.Appointment.managedObjectContext]];
        }else{
            [item setEntity_status:c_ADDED];
            [item.managedObjectContext MR_saveOnlySelfAndWait];
            [_lineItems addObject:[item MR_inContext:self.Appointment.managedObjectContext]];
        }
        
        [self.Appointment setLine_items:[NSOrderedSet orderedSetWithArray:_lineItems]];
        
//        _tblLineItems.frame = CGRectMake(_tblLineItems.frame.origin.x, _tblLineItems.frame.origin.y, _tblLineItems.frame.size.width,TABLE_LINE_ITEM_HEIGHT * _lineItems.count + 5);
        [self expandViews];
        [self calculateLineItems];
//        [self performSelector:@selector(calculateLineItems) withObject:nil afterDelay:1.0];
        [self.Appointment calculateTaxAmountForOwnTaxtRate:NO];
        [_tblLineItems reloadData];
    }
}



- (void)CustomerChosen:(Customer *)customer {
    if (customer) {
        
        self.Appointment.customer_id = customer.entity_id;
        self.Appointment.service_location_id = 0;
        NSArray * arr = [[customer.service_locations allObjects]mutableCopy];
        if (arr.count == 1 && arr.count != 0) {
            ServiceLocation * serLoc = [arr objectAtIndex:0];
            [self ServiceLocationChosen:serLoc];
        }
        [_tblChooseTable reloadData];
    }
}

- (void)ServiceLocationChosen:(ServiceLocation *)ser_loc {
    if (ser_loc) {
        [self.Appointment setService_location_id:ser_loc.entity_id];
        
        //[self calculateLineItems];
        [self.Appointment calculateTaxAmountForOwnTaxtRate:NO];
        NSString *address = [[self.Appointment getServiceLocation] getFullAddress];
        _lblServiceLocation.text = address;
        [_tblChooseTable reloadData];
        [_tblLineItems reloadData];
    }
}

#pragma mark -SamcomActionSheet

- (void) openDatePickerViewWithTag:(int) tag andTitle:(NSString*) title forDatePickerView:(UIDatePicker*) picker
{
    [self.view endEditing:YES];
    SamcomActionSheet_iPad * action = [SamcomActionSheet_iPad initIPadUIDatePickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" DatepickerView:picker inView:self.view withCustomDate:nil];
    
    action.tag = tag;
    action.isViewOpen= YES;
    [action showDatePicker];
}


#pragma mark -SamcomActionSheetDelegate
- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
        // [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    
    if (actionSheet.tag == DATE_PICKER_DATE_TAG) {
        self.Appointment.starts_at = actionSheet.datePicker.date;
        self.Appointment.ends_at = actionSheet.datePicker.date;
        selected_date = actionSheet.datePicker.date;
        _txtDate.text = [Utils dateFormatMMddyyyy:actionSheet.datePicker.date];
    }else if (actionSheet.tag == DATE_PICKER_START_TIME_TAG){
        startTime = actionSheet.datePicker.date;
        _txtStartTime.text = [Utils dateFormathhmma:actionSheet.datePicker.date];
        self.Appointment.starts_at = startTime;
    }else if (actionSheet.tag == DATE_PICKER_END_TIME_TAG){
        endTime = actionSheet.datePicker.date;
        _txtEndTime.text = [Utils dateFormathhmma:actionSheet.datePicker.date];
        self.Appointment.ends_at = endTime;
    }
        //
    [self.view endEditing:YES];
}
- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
        //  [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [self.view endEditing:YES];
}


-(void)textFieldDidChange:(UITextField *)txt{
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *text             = @"";//_txtDiscount.text;
    NSString *decimalSeperator = @".";
    NSCharacterSet *charSet    = nil;
    NSString *numberChars      = @"0123456789";
    
    
        // the number formatter will only be instantiated once ...
    
    static NSNumberFormatter *numberFormatter;
    if (!numberFormatter)
        {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle           = kCFNumberFormatterDecimalStyle;
        numberFormatter.maximumFractionDigits = 10;
        numberFormatter.minimumFractionDigits = 0;
        numberFormatter.decimalSeparator      = decimalSeperator;
        numberFormatter.usesGroupingSeparator = NO;
        }
    
    
        // create a character set of valid chars (numbers and optionally a decimal sign) ...
    
    NSRange decimalRange = [text rangeOfString:decimalSeperator];
    BOOL isDecimalNumber = (decimalRange.location != NSNotFound);
    if (isDecimalNumber)
        {
        charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
        }
    else
        {
        numberChars = [numberChars stringByAppendingString:decimalSeperator];
        charSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
        }
    
    
        // remove amy characters from the string that are not a number or decimal sign ...
    
    NSCharacterSet *invertedCharSet = [charSet invertedSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
    text = [text stringByReplacingCharactersInRange:range withString:trimmedString];
    
    
        // whenever a decimalSeperator is entered, we'll just update the textField.
        // whenever other chars are entered, we'll calculate the new number and update the textField accordingly.
    
    if (text.length > 3) {
        return NO;
    }
    
    if ([string isEqualToString:decimalSeperator] == YES)
        {
        textField.text = text;
        }
    else
        {
        NSNumber *number = [numberFormatter numberFromString:text];
        if (number == nil)
            {
            number = [NSNumber numberWithInt:0];
            }
        
        
        textField.text = isDecimalNumber ? text : [numberFormatter stringFromNumber:number];
        }
    //[self calculateLineItems];
    [self.Appointment calculateTaxAmountForOwnTaxtRate:NO];
    [_tblLineItems reloadData];
    return NO; // we return NO because we have manually edited the textField contents.
}

- (void) AppointmentSavedSuccessfully{
    [[ActivityIndicator currentIndicator]displayCompleted];
        //26112015
        //    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_APPOINTMENT_NOTIFICATION object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) AppointmentSaveFailedWithError:(NSString*) error{
    [[ActivityIndicator currentIndicator]displayCompleted];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - DataSelectionDelegate

- (void)DataSelectedForData:(id)data andType:(DataType)type {
    NSMutableArray *arr = (NSMutableArray*) data;
    self.Appointment.service_route_ids = [arr valueForKey:@"entity_id"];
    [_tblChooseTable reloadData];
}

#pragma mark -UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    int limit = 2000;
    if (_txtServiceInstruction.text.length > limit) {
        _txtServiceInstruction.text = [_txtServiceInstruction.text substringToIndex:limit];
    }
    int len = (int)_txtServiceInstruction.text.length;
    lblCharacter.text=[NSString stringWithFormat:@"%i",2000-len];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL flag = NO;
    
    if([text length] == 0)
        {
        if([textView.text length] != 0)
            {
            flag = YES;
            return YES;
            }
        else {
            return NO;
        }
        }
    else if([[textView text] length] > 1999)
        {
        return NO;
        }
    return YES;
}
@end
