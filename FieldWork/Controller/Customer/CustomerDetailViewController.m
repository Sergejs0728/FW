    //
    //  CustomerDetailViewController.m
    //  FieldWork
    //
    //  Created by Samir Kha on 19/02/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "CustomerDetailViewController.h"
#import "DrivingDirectionMap.h"
@implementation CustomerDetailViewController
@synthesize cust = cust,CustomerTable;


+ (CustomerDetailViewController*) initWithAppointment:(Customer*) app;
{
    CustomerDetailViewController *customer ;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        customer = [[CustomerDetailViewController alloc] initWithNibName:@"CustomerDetailViewController_IPad" bundle:nil];
    }else{
        customer = [[CustomerDetailViewController alloc] initWithNibName:@"CustomerDetailViewController" bundle:nil];
    }
    customer.title = @"Customer Detail";
    customer.cust=app;
    return customer;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    addressViewRoundCornerbtn.layer.cornerRadius = 9;
    BillingAddressViewRoundCornerbtn.layer.cornerRadius = 9;
    
    [self loadCustomerValues];
    if (!_isHidden) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editCustomerClicked)];
        
        self.navigationItem.rightBarButtonItem=rightButton;
    }
    
    if (![[AppDelegate appDelegate]isReachable]) {
        for (UIBarButtonItem *bitem in self.navigationItem.rightBarButtonItems) {
            if (bitem != nil) {
                bitem.enabled = NO;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCustomer) name:kCUSTOMER_HAS_CHANGED object:nil];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) reloadCustomer
{
    self.cust = [Customer getById:self.cust.entity_id];
    [self loadCustomerValues];
}

- (void) loadCustomerValues
{
    lblContactName.text = [self.cust getDisplayName];
    
    NSString *address= @"";
    lblCustomerName.text = [self.cust getDisplayName];
    
    lblContectHed_name.text = [self.cust getDisplayName];
    
    lblAddress.text = address;
    lblAddress.numberOfLines = 0;
    [lblAddress sizeToFit];
    
    billing_lblContactName.text = [self.cust getDisplayName];
    
    NSString *billing_address= [self.cust getBillingFullAddress];
    
    lblCustomerName.text = [self.cust getDisplayName];
    
    billing_lblAddress.text = billing_address;
    billing_lblAddress.numberOfLines = 0;
    [billing_lblAddress sizeToFit];
    
    _phoneList = [NSMutableArray new];
    _phoneKindsList = [NSMutableArray new];
    
    if (self.cust.billing_phone.length > 0) {
        [_phoneList addObject:self.cust.billing_phone];
        [_phoneKindsList addObject:self.cust.billing_phone_kind];
//        [_phoneKindList setObject:self.cust.billing_phone forKey:self.cust.billing_phone_kind];
    }
    NSArray* phones=self.cust.billing_phones;
    for (int i=0;i<phones.count;i++) {
        NSString* phoneNumber=[self.cust.billing_phones objectAtIndex:i];
        NSString* phoneKind=[self.cust.billing_phones_kinds objectAtIndex:i];
        [_phoneList addObject:phoneNumber];
        [_phoneKindsList addObject:phoneKind];
    }
    [CustomerTable reloadData];
}


- (void)editCustomerClicked{
    NewCustomerViewController *controller = [NewCustomerViewController viewControllerWithCustomer:self.cust];
    [self.navigationController pushViewController:controller animated:YES];
}

-(IBAction)displayDrivingDirectionMap:(id)sender
{
    [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
    UIButton * btn= (UIButton *)sender;
        // TODO : FIX THIS
    NSString *addr = @"";//[self.cust getFullAddress];
    if (btn.tag==1011) {
        
        addr=[self.cust getBillingFullAddress];
    }
    
    [SVGeocoder geocode:addr
             completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                 if (placemarks.count > 0) {
                     SVPlacemark *place = [placemarks objectAtIndex:0];
                     Class itemClass = [MKMapItem class];
                     if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
                         MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
                         MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:place.coordinate addressDictionary:nil] ];
                         
                         toLocation.name = [self.cust getDisplayName];
                         [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                                        launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                                  forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
                         
                     } else {
                         NSString* urlStr = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=Current%%20Location&daddr=%f,%f", place.coordinate.latitude, place.coordinate.longitude];
                         [[UIApplication sharedApplication] openURL: [NSURL URLWithString:urlStr]];
                     }
                     
                 }
                 [[ActivityIndicator currentIndicator] displayCompleted];
             }];
}

- (void)didReceiveMemoryWarning
{
        // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
        // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        int rows = cust.invoice_email.length > 0 ? 2 : 1;
        rows = rows + (int)_phoneList.count;
        return rows;
    }else{
        return 2;
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Details";
    }
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(indexPath.row != 0){
            if (cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            }
        }else{
            NSString *address = [self.cust getBillingFullAddress];
            NSString *custName = [self.cust getDisplayName];
            NSString *full_string = [NSString stringWithFormat:@"%@\n%@", custName, address];
            _addressCell.lblAddress.text = full_string;
            _addressCell.lblAddress.numberOfLines = 0;
            [_addressCell.lblAddress sizeToFit];
            return _addressCell;
        }
        if (indexPath.row == _phoneList.count + 1) {
                // EMail Cell
            cell.textLabel.text = self.cust.invoice_email;
            cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        }else{
            NSArray *allKeys = _phoneKindsList;
            cell.textLabel.text = [allKeys objectAtIndex:indexPath.row - 1];
            NSString *number = [_phoneList objectAtIndex:indexPath.row-1];
            cell.detailTextLabel.text = number;
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0);
        return cell;
        
    }else{
        
        static NSString *CellIdentifier = @"Cell";
        
        AppotmentDetailCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell1 == nil)
            {
            
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppointmentDetailTableCell" owner:self options:nil];
            
            for (AppotmentDetailCell *AppointmentCurrentObject in topLevelObject)
                {
                if([AppointmentCurrentObject isKindOfClass:[UITableViewCell class]])
                    {
                    cell1 = (AppotmentDetailCell*)AppointmentCurrentObject;
                    }
                }
            }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
        {
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell1.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }
#endif
        if(indexPath.row == 0)
        {
            // TODO : FIX THIS
            //cell.lbl1.text = self.cust.service_contact;
            if (cell1.lbl1.text.length <= 0)
            {
            }
            cell1.lbl1.text = @"Contacts";
            cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            //cell.lbl2.text = self.cust.service_contact;
        }
        
        else if(indexPath.row == 1)
        {
            cell1.lbl1.text = @"Service Locations";
            cell1.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            // TODO : FIX THIS
            //cell.lbl2.text = self.cust.service_record_email;
        }
        //cell1.backgroundColor = [UIColor redColor];
        return cell1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)
    {
        if (indexPath.row == 1) {
            //Keval
            if (self.cust.billing_phone.length <= 0) {
                if (self.cust.invoice_email.length <=0)
                {
                    return 0;
                }else{
                    return 45;
                }
            }
        }
    }
    if(indexPath.section == 0)
        {
        if (indexPath.row == 0) {
            return 85;
        }
        }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == _phoneList.count + 1) {
            // Email
            MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
            mailPicker.mailComposeDelegate = self;
            
            NSArray *toRecipients = [NSArray arrayWithObject:self.cust.invoice_email];
            
            [mailPicker setSubject:@"Hello"];
            [mailPicker setToRecipients:toRecipients];
            
            [mailPicker setMessageBody: @"" isHTML:NO];
            [self.navigationController presentViewController:mailPicker animated:YES completion:^{
                
            }];
            
        }else if(indexPath.row != 0){
            if(_phoneList.count > 0)
            {
                NSArray *allkeys = _phoneList;
                NSString *phoneNumber = [_phoneList objectAtIndex:indexPath.row-1];
                phoneNumber = [phoneNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
                
            }
        }
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            NSArray * conatctArr = [Contact getContactByCustomerId:cust.entity_id];
            ContactListViewController *clist=[ContactListViewController viewControllerWithContactArray:[conatctArr mutableCopy]];
            [self.navigationController pushViewController:clist animated:YES];
            
        }
        else if(indexPath.row == 1)
        {
            CustomerServiceLocationListControllerViewController *custSrvceCon=[CustomerServiceLocationListControllerViewController initViewControllerWiithCustomer:self.cust];
            [self.navigationController pushViewController:custSrvceCon animated:YES];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
