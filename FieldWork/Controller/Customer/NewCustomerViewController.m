//
//  NewCustomerViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 3/1/14.
//
//

#import "NewCustomerViewController.h"
#import "LocationType.h"
#import "Customer.h"
#import "TaxRates.h"
#import "ServiceLocation.h"
#import "CustomerManager.h"
#import "User.h"

@interface NewCustomerViewController () <UITextFieldDelegate>

@end

@implementation NewCustomerViewController
@synthesize scrollView=_scrollView;
@synthesize segmentCon=_segmentCon;
@synthesize txt_srname=_txt_srname;
@synthesize txt_fname=_txt_fname;
@synthesize txt_lname=_txt_lname;
@synthesize txt_billing_name=_txt_billing_name;
@synthesize txt_Address1=_txt_Address1;
@synthesize txt_Address2=_txt_Address2;
@synthesize txt_city=_txt_city;
@synthesize txt_state=_txt_state;
@synthesize txt_zip=_txt_zip;
@synthesize txt_billing_terms=_txt_billing_terms;
@synthesize txt_service_email=_txt_service_email;
@synthesize bottomView=_bottomView;
@synthesize swtch=_swtch;
@synthesize txt_propertylst=_txt_propertylst;
@synthesize containerView=_containerView;
@synthesize pickerContainerActionSheet=_pickerContainerActionSheet;
@synthesize pickerView=_pickerView;
@synthesize pickerContainerView=pickerContainerView;
@synthesize billing_termsarray=_billing_termsarray;

@synthesize txt_commercial=_txt_commercial;
@synthesize segmentView1=_segmentView1;
@synthesize segmentView2=_segmentView2;

@synthesize currentCustomer = _currentCustomer;



+(NewCustomerViewController *)viewController
{
    NewCustomerViewController *cust;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        cust = [[NewCustomerViewController alloc]initWithNibName:@"NewCustomerViewController_iPad" bundle:nil];
    }else{
        cust = [[NewCustomerViewController alloc]initWithNibName:@"NewCustomerViewController" bundle:nil];
        
    }
    cust.title=@"New Customer";
    return cust;
}

+ (NewCustomerViewController *)viewControllerWithCustomer:(Customer *)customer {
    NewCustomerViewController *cust;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        cust = [[NewCustomerViewController alloc]initWithNibName:@"NewCustomerViewController_iPad" bundle:nil];
    }else{
        cust = [[NewCustomerViewController alloc]initWithNibName:@"NewCustomerViewController" bundle:nil];
        
    }
    cust.title=@"New Customer";
    cust.currentCustomer = customer;
    
    return cust;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:kHIDE_PICKERVIEW object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        for (UIView* view in self.view.subviews) { // fast fix
            if ([view isKindOfClass:[SamcomActionSheet_iPad class]]) {
                [view removeFromSuperview];
            }
        }
    }];
    [self createBarButton];
    _IS_EDIT = NO;
    if(!_currentServiceLocation.service_route_id){
        _currentServiceLocation.service_route_id=[User getUser].service_route_id;
    }
        // Github Checking IOS8 -- Samir changes
     if (_currentCustomer == nil) {
        _currentCustomer = [Customer newEntity];
        _currentCustomer.service_locations = [[NSSet alloc] init];
         
         _currentServiceLocation = [ServiceLocation newEntityWithCustomer:_currentCustomer];
         
        _serviceAddressView.hidden = YES;
     }else{
         _IS_EDIT = YES;
         if (_currentCustomer.service_locations && _currentCustomer.service_locations.count > 0) {
             _currentServiceLocation = [[_currentCustomer.service_locations allObjects] objectAtIndex:0];
         }
         [self.swtch setOn:NO];
     }
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adjustViewHeight) name:kADJUST_FULL_VIEW_HEIGHT object:nil];
    [self setInitialData];
    _billing_termsarray=[[NSMutableArray alloc]init];
    
    _billing_termsarray = [BillingTerms fetchAll];
    
    _arrLocationTypes = [[NSMutableArray alloc] init];
    _arrLocationTypes = [LocationType getLocationTypes];
    
    _arrTaxRates = [[NSMutableArray alloc] init];
    _arrTaxRates = [TaxRates fetchAll];
    
    User* currentUser=[User getUser];
    _serviceRoutesArr = [ServiceRoutes fetchAllWithCurrent:currentUser.entity_id];
//    _serviceRoutesArr = [ServiceRoutes fetchAll];
    
    _phoneTypeArr = [[NSMutableArray alloc] init];
    _phoneTypeArrSer = [[NSMutableArray alloc] init];
    

    _pickerBillingTerms = [[UIPickerView alloc] init];
    _pickerLocationType = [[UIPickerView alloc] init];
    _pickerTaxRates = [[UIPickerView alloc] init];
    _pickerServiceRoutes = [[UIPickerView alloc] init];
    _pickerSrNames = [[UIPickerView alloc] init];
    _srNames = [[NSMutableArray alloc] initWithObjects:@"Mr.", @"Mrs.", @"Ms.", @"Dr.", nil];
    if (!_IS_EDIT) {
        //Changes By Rahul Soni
        if (_arrTaxRates.count) {
            TaxRates *tr = [_arrTaxRates objectAtIndex:0];
            _txt_tax_rate.text = tr.name;
            _currentServiceLocation.tax_rate_id = tr.entity_id;
        }
        //
        if (_serviceRoutesArr.count) {
            ServiceRoutes *sr = [_serviceRoutesArr objectAtIndex:0];
            _txt_service_routes.text = sr.service_route_name;
            _currentServiceLocation.service_route_id = sr.entity_id;
        }
        //
        _txt_ser_name.text = @"Main Location";
    }

    if (_IS_EDIT == YES) {
        [_segmentCon setSelectedSegmentIndex:([_currentCustomer.customer_type  isEqual: @"Residential"] ? 0 : 1)];
        switch (_segmentCon.selectedSegmentIndex)
        {
            case 0:
                //segment 0
                [self.segmentView1 setHidden:NO];
                [self.segmentView2 setHidden:YES];
                break;
            case 1:
                [self.segmentView1 setHidden:YES];
                [self.segmentView2 setHidden:NO];
                break;
                
            default:
                break;
        }
        _txt_fname.text = _currentCustomer.first_name;
        _txt_lname.text = _currentCustomer.last_name;
        _txt_srname.text = _currentCustomer.name_prefix;
        _txt_commercial.text = _currentCustomer.name;
        _txt_Address1.text = _currentCustomer.billing_street;
        _txt_Address2.text = _currentCustomer.billing_street2;
        _txt_state.text = _currentCustomer.billing_state;
        _txt_city.text = _currentCustomer.billing_city;
        _txt_zip.text = _currentCustomer.billing_zip;
        
        _txt_ser_address1.text = _currentServiceLocation.street;
        _txt_ser_address2.text = _currentServiceLocation.street2;
        _txt_ser_city.text = _currentServiceLocation.city;
        _txt_ser_state.text = _currentServiceLocation.state;	
        _txt_ser_zip.text = _currentServiceLocation.zip;
        
        _txt_ser_name.text = _currentServiceLocation.name;
        
        _txt_service_email.text = _currentCustomer.invoice_email;
        
        
        BillingTerms *bt = [BillingTerms getbillingTermsById:[_currentCustomer.billing_term_id intValue]];
        _txt_billing_terms.text = bt.name;
        
        LocationType *lt = [LocationType getLocationTypeById:[_currentServiceLocation.location_type_id intValue]];
        _txt_location_type.text = lt.location_type_name;
        
        TaxRates *tr = [TaxRates getTaxRatesById:_currentServiceLocation.tax_rate_id];
        _txt_tax_rate.text = tr.name;
        
        ServiceRoutes *sr = [ServiceRoutes serviceRoutesById:[_currentServiceLocation.service_route_id intValue]];
        _txt_service_routes.text = sr.service_route_name;

        
        _phoneTypeArr = [PhoneInfo createBillingPhoneArray:_currentCustomer];
        _phoneTypeArrSer = [PhoneInfo createServicePhoneArray:_currentServiceLocation];

    }
    else{
        BillingTerms *bt;
        NSMutableArray* billings=[BillingTerms fetchAll];
        [billings   filterUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
            BillingTerms* evaluated=evaluatedObject;
            return  ([evaluated.name caseInsensitiveCompare:@"On Completion"]==NSOrderedSame);
        }]];
        if(billings){
            if(billings.count>0){
                bt=[billings objectAtIndex:0];
            }
            else{
                bt=[[BillingTerms fetchAll] objectAtIndex:0];
            }
            
        }
        else{
            bt=[[BillingTerms fetchAll] objectAtIndex:0];
        }
        _currentCustomer.billing_term_id=bt.entity_id;
        _txt_billing_terms.text = bt.name;
        
    }
    
    [_phoneTypeTableView setData:_phoneTypeArr];
    
   
    [_phoneTypeTableViewSer setData:_phoneTypeArrSer];
    [self adjustViewHeight];

}

-(void)createBarButton{
   
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = saveButton;
}
- (void)adjustViewHeight {
    
    float height = ([_phoneTypeTableView rowCount]*44) + 15;
    //NSLog(@"Height : %f", height);
    
    constraintPhoneTypeTableViewHeight.constant = height;
    
    //int y_pos = _swtch.frame.origin.y + _swtch.frame.size.height + 30;
    
    if (_serviceAddressView.hidden) {
        //_mostBottomView.frame = CGRectMake(_mostBottomView.frame.origin.x, y_pos, _mostBottomView.frame.size.width, _mostBottomView.frame.size.height);
        constraintServiceAddressViewHeight.constant = 0;
    }else{
        //y_pos = y_pos + _serviceAddressView.frame.size.height + 10;
        float tbt_height_for_ser = (([_phoneTypeTableViewSer rowCount] + 1)*44);
        //_mostBottomView.frame = CGRectMake(_mostBottomView.frame.origin.x, y_pos, _mostBottomView.frame.size.width, _mostBottomView.frame.size.height);
        NSLog(@"tbl height : %f", tbt_height_for_ser);
        constraintPhoneTypeTableViewSerHeight.constant = tbt_height_for_ser;
//        _phoneTypeTableViewSer.frame = CGRectMake(_phoneTypeTableViewSer.frame.origin.x, _phoneTypeTableViewSer.frame.origin.y, _phoneTypeTableViewSer.frame.size.width, tbt_height_for_ser);
        NSLog(@"tbl height ----: %f", _phoneTypeTableViewSer.frame.size.height);
        NSLog(@"tbl height constraint ----: %f", constraintPhoneTypeTableViewSerHeight.constant);
        constraintServiceAddressViewHeight.constant += 150;
//        _serviceAddressView.frame = CGRectMake(_serviceAddressView.frame.origin.x, _serviceAddressView.frame.origin.y, _serviceAddressView.frame.size.width, 150 + _phoneTypeTableViewSer.frame.size.height);
    }
    
//    _bottomView.frame = CGRectMake(_bottomView.frame.origin.x, _phoneTypeTableView	.frame.origin.y + _phoneTypeTableView.frame.size.height + 10, _bottomView.frame.size.width, _serviceAddressView.frame.origin.y + _serviceAddressView.frame.size.height + 10);
   // btnSave.frame = CGRectMake(btnSave.frame.origin.x, _bottomView.frame.origin.y + _bottomView.frame.size.height + 20, btnSave.frame.size.width, btnSave.frame.size.height);
    
//    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _bottomView.frame.origin.y + _bottomView.frame.size.height + 70);
    
}

-(void)setInitialData
{
     self.segmentView2.hidden=YES;
//    _scrollView.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+_bottomView.frame.size.height);
}
-(void)switchValueChanged:(UISwitch*)sender
{
   
    if (self.swtch.on) {
        NSLog(@"switch is On");
        _serviceAddressView.hidden = YES;
    }
    else
    {
        NSLog(@"switch is Offf");
        _serviceAddressView.hidden = NO;
        // Add one more section for address
    }
    [self adjustViewHeight];
}
-(void)segmentValueChanged:(UISegmentedControl*)sender
{
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            //segment 0
            [self.segmentView1 setHidden:NO];
            [self.segmentView2 setHidden:YES];
            break;
        case 1:
            [self.segmentView1 setHidden:YES];
            [self.segmentView2 setHidden:NO];
            break;
        
        default:
            break;
    }

}
-(void)billingTermsClicked:(id)sender
{
    [self openPickerViewWithTag:PICKER_BILLING_TERMS_TAG andTitle:@"Billing Terms" forPickerView:_pickerBillingTerms];
}

- (void)btnServiceRoutesClicked:(id)sender {
    [self openPickerViewWithTag:PICKER_SERVICE_ROUTES_TAG andTitle:@"Service Routes" forPickerView:_pickerServiceRoutes];
}

- (void)btnLocationTypeClicked:(id)sender {
    [self openPickerViewWithTag:PICKER_LOCATION_TYPE_TAG andTitle:@"Location Type" forPickerView:_pickerLocationType];
}

- (void)btnTaxRateClicked:(id)sender {
    [self openPickerViewWithTag:PICKER_TAX_RATE_TAG andTitle:@"Tax Rates" forPickerView:_pickerTaxRates];
}

- (void)btnSrNameClicked:(id)sender {
    [self openPickerViewWithTag:PICKER_SR_NAME andTitle:@"" forPickerView:_pickerSrNames];
}

- (void) openPickerViewWithTag:(int) tag andTitle:(NSString*) title forPickerView:(UIPickerView*) picker
{
   
    [self.view endEditing:YES];
    picker.showsSelectionIndicator=YES;
    picker.dataSource = self;
    picker.delegate = self;
    picker.tag = tag;
    SamcomActionSheet_iPad * action = [SamcomActionSheet_iPad initIPadUIPickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" pickerView:picker inView:self.view];
        
    action.tag = tag;
    action.isViewOpen= YES;
    [action show];

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
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark - SAVE

- (void)save:(id)sender {
    
    [self.view endEditing:YES];
    
    if (_segmentCon.selectedSegmentIndex == 0) {
        if (_txt_fname.text.length <= 0 && _txt_lname.text.length <= 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please enter valid name." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }else{
        if (_txt_commercial.text.length <= 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please enter valid name." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
    
    if ([_currentCustomer.billing_term_id intValue] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please select billing terms." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([_currentServiceLocation.service_route_id intValue] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please select service route." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if (_txt_ser_name.text.length <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please enter service location name." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if ([_currentServiceLocation.tax_rate_id intValue] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please select tax rate." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    // validate email
    if (![_txt_service_email.text isEqualToString:@""]) {
        if (![Utils validateEmailWithString:_txt_service_email.text]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:@"Please enter valid email address." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
  
    
    _currentCustomer.customer_type = _segmentCon.selectedSegmentIndex == 0 ? @"Residential" : @"Commercial";
    
    _currentCustomer.first_name = _txt_fname.text;
    _currentCustomer.last_name = _txt_lname.text;
    _currentCustomer.name_prefix = _txt_srname.text;
    _currentCustomer.name = _txt_commercial.text;
    _currentCustomer.billing_street = _txt_Address1.text;
    _currentCustomer.billing_street2 = _txt_Address2.text;
    _currentCustomer.billing_state = _txt_state.text;
    _currentCustomer.billing_city = _txt_city.text;
    _currentCustomer.billing_zip = _txt_zip.text;
    
    
    
    //NARENDRA
    
    if (_phoneTypeArr != nil && _phoneTypeArr.count > 0) {
        PhoneInfo *primary = [_phoneTypeArr objectAtIndex:0];
        _currentCustomer.billing_phone = primary.phone;
        _currentCustomer.billing_phone_ext = primary.phone_ext;
        _currentCustomer.billing_phone_kind= primary.phone_kind;
        
        _currentCustomer.billing_phones = [[NSMutableArray alloc] init];
        _currentCustomer.billing_phones_exts = [[NSMutableArray alloc] init];
        _currentCustomer.billing_phones_kinds = [[NSMutableArray alloc] init];
        if (_phoneTypeArr.count > 1) {
            for (int i =1; i < _phoneTypeArr.count; i++) {
                PhoneInfo *ph = [_phoneTypeArr objectAtIndex:i];
                if (ph.phone) [_currentCustomer.billing_phones addObject:ph.phone];
                if (ph.phone_ext) [_currentCustomer.billing_phones_exts addObject:ph.phone_ext];
                if (ph.phone_kind) [_currentCustomer.billing_phones_kinds addObject:ph.phone_kind];
            }
        }
    }
    
    _currentServiceLocation.name = _txt_ser_name.text;
    NSMutableArray *ser_phone_arr = [[NSMutableArray alloc] init];
    if (_swtch.isOn) {
        _currentServiceLocation.street = _txt_Address1.text;
        _currentServiceLocation.street2 = _txt_Address2.text;
        _currentServiceLocation.city = _txt_city.text;
        _currentServiceLocation.state = _txt_state.text;
        _currentServiceLocation.zip = _txt_zip.text;
        ser_phone_arr = _phoneTypeArr;
    }else{
        ser_phone_arr = _phoneTypeArrSer;
        _currentServiceLocation.street = _txt_ser_address1.text;
        _currentServiceLocation.street2 = _txt_ser_address2.text;
        _currentServiceLocation.city = _txt_ser_city.text;
        _currentServiceLocation.state = _txt_ser_state.text;
        _currentServiceLocation.zip = _txt_ser_zip.text;
    }
    _currentServiceLocation.email = _currentCustomer.invoice_email = _txt_service_email.text;
    
    if (ser_phone_arr != nil && ser_phone_arr.count > 0) {
        PhoneInfo *primary = [ser_phone_arr objectAtIndex:0];
        _currentServiceLocation.phone = primary.phone;
        _currentServiceLocation.phone_ext = primary.phone_ext;
        _currentServiceLocation.phone_kind = primary.phone_kind;
        
        _currentServiceLocation.phones = [[NSMutableArray alloc] init];
        _currentServiceLocation.phones_exts = [[NSMutableArray alloc] init];
        _currentServiceLocation.phones_kinds = [[NSMutableArray alloc] init];
        if (_phoneTypeArr.count > 1) {
            for (int i =1; i < ser_phone_arr.count; i++) {
                PhoneInfo *ph = [ser_phone_arr objectAtIndex:i];
                if (ph.phone) [_currentServiceLocation.phones addObject:ph.phone];
                if (ph.phone_ext) [_currentServiceLocation.phones_exts addObject:ph.phone_ext];
                if (ph.phone_kind) [_currentServiceLocation.phones_kinds addObject:ph.phone_kind];
            }
        }
    }
//
    [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
    
    
    [[CustomerManager Instance] addNewCustomer:_currentCustomer withBlock:^(id item, BOOL is_success, NSString *error) {
        [[ActivityIndicator currentIndicator] displayCompleted];
        if (is_success == YES) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kCUSTOMER_HAS_CHANGED object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
    
}


#pragma mark- UIActionSheet & PickerView Delegate


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == PICKER_BILLING_TERMS_TAG)
    {
        return _billing_termsarray.count;
    }
    if (pickerView.tag == PICKER_LOCATION_TYPE_TAG) {
        return _arrLocationTypes.count;
    }
    if (pickerView.tag == PICKER_TAX_RATE_TAG) {
        return _arrTaxRates.count;
    }
    if (pickerView.tag==PICKER_SERVICE_ROUTES_TAG)
    {
        return _serviceRoutesArr.count;
    }
    if (pickerView.tag == PICKER_SR_NAME) {
        return _srNames.count;
    }
    return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == PICKER_BILLING_TERMS_TAG)
    {
        BillingTerms *bt= [_billing_termsarray objectAtIndex:row];
        return bt.name;
    }
    if (pickerView.tag == PICKER_LOCATION_TYPE_TAG) {
        LocationType *lt = [_arrLocationTypes objectAtIndex:row];
        return lt.location_type_name;
    }
    if (pickerView.tag == PICKER_TAX_RATE_TAG) {
        TaxRates *tr = [_arrTaxRates objectAtIndex:row];
        return tr.name;
    }
    if (pickerView.tag==PICKER_SERVICE_ROUTES_TAG)
    {
        ServiceRoutes *sr = [_serviceRoutesArr objectAtIndex:row];
        return sr.service_route_name;
    }
    if (pickerView.tag == PICKER_SR_NAME) {
        return [_srNames objectAtIndex:row];
    }
    return @"";
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}



#pragma mark - SamcomActionSheetDelegate

- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
    //[actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    int idx = (int)[actionSheet.pickerView selectedRowInComponent:0];
    
   // NARENDRA
    if (actionSheet.tag == PICKER_BILLING_TERMS_TAG) {
        // Billing Terms
        BillingTerms *bt = [_billing_termsarray objectAtIndex:idx];
        _txt_billing_terms.text = bt.name;
        _currentCustomer.billing_term_id = bt.entity_id ;
    }
    if (actionSheet.tag == PICKER_LOCATION_TYPE_TAG) {
        LocationType *lt = [_arrLocationTypes objectAtIndex:idx];
        _txt_location_type.text = lt.location_type_name;
       
        _currentServiceLocation.location_type_id = lt.entity_id;
    }
    if (actionSheet.tag == PICKER_TAX_RATE_TAG) {
        TaxRates *tr = [_arrTaxRates objectAtIndex:idx];
        _txt_tax_rate.text = tr.name;
        _currentServiceLocation.tax_rate_id = tr.entity_id;;
    }
    if (actionSheet.tag == PICKER_SERVICE_ROUTES_TAG) {
        ServiceRoutes *sr = [_serviceRoutesArr objectAtIndex:idx];
        _txt_service_routes.text = sr.service_route_name;
        _currentServiceLocation.service_route_id = sr.entity_id;
    }
    if (actionSheet.tag == PICKER_SR_NAME) {
        _txt_srname.text = [_srNames objectAtIndex:idx];
    }
    [self.view endEditing:YES];
}

- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
   // [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:kHIDE_PICKERVIEW object:nil];
}


#pragma mark - CustomerDelegate

- (void)CustomerAddedSuccessfully:(Customer *)cust {
    [[ActivityIndicator currentIndicator] displayCompleted];
    [self.navigationController popViewControllerAnimated:YES];
    NSString *msg = @"Customer added successfully.";
    if (_IS_EDIT == YES) {
        msg = @"Customer updated successfully.";
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

- (void)CustomerAddFailWithError:(NSString *)error {
    [[ActivityIndicator currentIndicator] displayCompleted];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fieldwork" message:error delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}



@end
