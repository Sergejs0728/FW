    //
//  ServiceLocationDetailViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import "ServiceLocationDetailViewController.h"
#import "ServiceLocationNoteViewController.h"
#import "ServiceLocationsNotesTableViewCell.h"

@interface ServiceLocationDetailViewController () {
    BOOL _isShortNotes;
}
@property (nonatomic, strong) ServiceLocationsNotesTableViewCell *cellNotes;
@end

@implementation ServiceLocationDetailViewController
@synthesize service_location = _service_location;
@synthesize scrollView=_scrollView;



+(ServiceLocationDetailViewController *)viewControllerWithServiceLocation:(ServiceLocation *)ser_loc
{
    ServiceLocationDetailViewController *service;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        service =[[ServiceLocationDetailViewController alloc]initWithNibName:@"ServiceLocationDetailViewController_iPad" bundle:nil];
        
    }
    else{
        service =[[ServiceLocationDetailViewController alloc]initWithNibName:@"ServiceLocationDetailViewController" bundle:nil];
        
    }
    service.service_location = ser_loc;
    service.title= ser_loc.name;
    return service;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  
    _isShortNotes = NO;
    _phoneList = [NSMutableArray new];
    _phoneKindsList=[NSMutableArray new];
    
    if (_service_location.phone.length > 0) {
        [_phoneList addObject:_service_location.phone];
    
        if([_service_location.phone_kind isEqualToString: @""]){
            [_phoneKindsList addObject:@"Phone"];
        }else{
            [_phoneKindsList addObject:_service_location.phone_kind];
        }
        
        
//        [_phoneKindList setObject:_service_location.phone forKey:_service_location.phone_kind];
    }
    if ([_service_location.contacts allObjects] != nil && [_service_location.contacts allObjects].count > 0) {
        for (Contact *pi in _service_location.contacts) {
            if (pi.phone && pi.phone_kind) {
                [_phoneList addObject:pi.phone];
                [_phoneKindsList addObject:pi.phone_kind];
//                [_phoneKindList setObject:pi.phone forKey:pi.phone_kind];
            }
        }
    }
    NSArray* phones=_service_location.phones;
    NSArray* phoneKinds=_service_location.phones_kinds;
    for (int i=0;i<phones.count;i++) {
        NSString* phoneNumber=[phones objectAtIndex:i];
        NSString* phoneKind=[phoneKinds objectAtIndex:i];
        [_phoneList addObject:phoneNumber];
        [_phoneKindsList addObject:phoneKind];
    }
    
    

//                 
//    if (phones.count > 0) {
//        [_phoneKindList ];
//        [_phoneKindList setObject:_service_location.phone forKey:_service_location.phone_kind];
//    }
//    
    lblContectHed_name.text = _service_location.name;
    
//     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//    {
//        float buttons_y = _detail_table.frame.origin.y + _detail_table.frame.size.height;
//        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, buttons_y+100+100);
//        NSString *billing_address= [self.service_location getFullAddress];
//        lblContectHed_name.text=self.service_location.name;
//        
//        billing_lblAddress.text = billing_address;
//        billing_lblAddress.numberOfLines = 0;
//       //[billing_lblAddress sizeToFit];
//    }
//    else{
//        float buttons_y = _detail_table.frame.origin.y + _detail_table.frame.size.height;
//        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, buttons_y+100+100);
//        NSString *billing_address= [self.service_location getFullAddress];
//        lblContectHed_name.text=self.service_location.name;
//        
//        billing_lblAddress.text = billing_address;
//        billing_lblAddress.numberOfLines = 0;
//        //[billing_lblAddress sizeToFit];
//    }
}
#pragma mark-UITableView DataSource & Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        int rows = 1;
        if (_service_location.email.length) {
            rows = rows + 1;
        }
        if (_service_location.notes.length) {
            rows = rows + 1;
        }
        rows = rows + (int)_phoneList.count;
        return rows;
    }else{
        return 2;// when you want to enable work history
        //return 1;
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Details";
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.section == 0)
    {
        if (indexPath.row == 0) {
            return 85;
        }  else if (_service_location.notes.length && indexPath.row == _phoneList.count + 1) {

            
            if (_cellNotes==nil) {
                NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"ServiceLocationsNotesTableViewCell" owner:self options:nil];
                
                for(id currentObject in topLevelObject)
                {
                    if([currentObject isKindOfClass:[UITableViewCell class]])
                    {
                        _cellNotes = (ServiceLocationsNotesTableViewCell*) currentObject;
                    }
                }
                //                _cellNotes = [tableView dequeueReusableCellWithIdentifier:@"ServiceLocationsNotesTableViewCell"];

            }
            
            
            [self configureNotesCell:_cellNotes];
            CGFloat height = [_cellNotes calculateHeight];
            return height;
        }
    }
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if ((_service_location.notes.length && indexPath.row ==  _phoneList.count + 2) || (!_service_location.notes.length && indexPath.row == _phoneList.count + 1)) {
            // Email
            if (_service_location.email.length) {
                MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
                mailPicker.mailComposeDelegate = self;
                
                // TODO : FIX THIS
                NSArray *toRecipients = [NSArray arrayWithObject:_service_location.email];
                
                [mailPicker setSubject:@"Hello"];
                [mailPicker setToRecipients:toRecipients];
                
                [mailPicker setMessageBody: @"" isHTML:NO];
                [self.navigationController presentViewController:mailPicker animated:YES completion:^{
                    
                }];
            }
            
        } else if (!(_service_location.notes.length && indexPath.row == _phoneList.count + 1) && indexPath.row>0){
            if(_phoneList.count > 0)
            {
                NSString *phoneNumber = [_phoneList objectAtIndex:indexPath.row-1];
                phoneNumber = [phoneNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
                // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[self.cust.phones objectForKey:[[self.cust.phones allKeys] objectAtIndex:0]]]]];
            }
        }
    }
    if (indexPath.section == 1)
    {
        if (indexPath.row==0)
        {
            NSArray * temp = [_service_location.contacts allObjects];
            ContactListViewController *con=[ContactListViewController viewControllerWithContactArray:[temp mutableCopy]];
            [self.navigationController pushViewController:con animated:YES];
        } else if (indexPath.row == 1) {
            WorkHistoryTableViewController *controller = [WorkHistoryTableViewController viewControllerWithServiceLocation:_service_location];
            [self.navigationController pushViewController:controller animated:YES];
        }
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(indexPath.row != 0){
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
                
            }
        }else{
           
            NSString *address = [_service_location getFullAddress];
            NSString *custName = _service_location.name;
            NSString *full_string = [NSString stringWithFormat:@"%@\n%@", custName, address];
            _addressCell.lblAddress.text = full_string;
            _addressCell.lblAddress.numberOfLines = 0;
            [_addressCell.lblAddress sizeToFit];
            return _addressCell;
        }
        
        if ((_service_location.notes.length && indexPath.row ==  _phoneList.count + 2) || (!_service_location.notes.length && indexPath.row == _phoneList.count + 1)) {
            // EMail Cell
            cell.textLabel.text = _service_location.email;
            cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        } else if (_service_location.notes.length && indexPath.row == _phoneList.count + 1) {
            static NSString *notesCellIdentifier = @"ServiceLocationsNotesTableViewCell";
            ServiceLocationsNotesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:notesCellIdentifier];
            if (cell == nil)
            {
                [tableView registerNib:[UINib nibWithNibName:@"ServiceLocationsNotesTableViewCell" bundle:nil] forCellReuseIdentifier:notesCellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:notesCellIdentifier];
                                                        
            }
            [self configureNotesCell:cell];
            cell.viewAction = ^ {
                _isShortNotes = !_isShortNotes;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            };
            return cell;
        } else {
            NSArray *allKeys = _phoneKindsList;
            cell.textLabel.text = [allKeys objectAtIndex:indexPath.row - 1];
            NSString *number = [_phoneList objectAtIndex:indexPath.row-1];
            if (_service_location.phone_ext.length > 0) {
                number = [NSString stringWithFormat:@"%@ %@",number,_service_location.phone_ext];
            }
              
            cell.detailTextLabel.text = number;
        }
        cell.separatorInset = UIEdgeInsetsMake(0, 30, 0, 0);
        return cell;
        
    }else{
        static NSString *CellIdentifier = @"Cell1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if(indexPath.row == 0)
            {
                // TODO : FIX THIS
                //cell.lbl1.text = self.cust.service_contact;
                if (cell.textLabel.text.length <= 0)
                {
                    cell.textLabel.text = @"Contacts";
                }
                
                //cell.lbl2.text = self.cust.service_contact;
            }else if (indexPath.row == 1){
                cell.textLabel.text = @"Work History";
            }
            
            
        }
        return cell;
    }
}

- (void)configureNotesCell:(ServiceLocationsNotesTableViewCell *)cell {
    cell.isShort = _isShortNotes;
    cell.notes = _service_location.notes;
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
