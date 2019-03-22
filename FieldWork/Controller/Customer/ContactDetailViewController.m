//
//  ContactDetailViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 2/27/14.
//
//

#import "ContactDetailViewController.h"
#import "PhoneInfo.h"

@interface ContactDetailViewController ()

@end

@implementation ContactDetailViewController

+ (ContactDetailViewController *)viewControllerWithContact:(Contact *)con {
    ContactDetailViewController *cont=[[ContactDetailViewController alloc]initWithNibName:@"ContactDetailViewController" bundle:nil];
    cont.contact=con;
    
    return cont;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     //26112015
//    self.title = [self.contact getDisplayName];
    _lblContactName.text = [NSString stringWithFormat:@"%@ %@",_contact.first_name,_contact.last_name];
    _phoneKindList = [NSMutableDictionary new];
    PhoneInfo *phoneInfo = [[PhoneInfo alloc] init];
    phone_array = [NSMutableArray new];
    if (_contact.phone.length && _contact.phone_kind.length) {
        phoneInfo.phone = _contact.phone;
        phoneInfo.phone_kind = _contact.phone_kind;
        [phone_array addObject:phoneInfo];
    }
    
    
    
    _lblDescription.text = self.contact.contact_description;
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Memory warning");
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
         //26112015
        return phone_array.count;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    if (indexPath.section == 0) {
        // Phones
         //26112015
        PhoneInfo *pi = [phone_array objectAtIndex:indexPath.row];
        cell.textLabel.text = pi.phone_kind;
        NSString *number = pi.phone;
        cell.detailTextLabel.text = number;
        
    }else{
        // Email
        cell.textLabel.text = _contact.email;
        cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        // Phones
         //26112015
        PhoneInfo *pi = [phone_array objectAtIndex:indexPath.row];
        NSString *phoneNumber = pi.phone;
        phoneNumber = [phoneNumber stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
    }else{
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate = self;
        
        // TODO : FIX THIS
        NSArray *toRecipients = [NSArray arrayWithObject:_contact.email];
        
        [mailPicker setSubject:@"Hello"];
        [mailPicker setToRecipients:toRecipients];
        
        [mailPicker setMessageBody: @"" isHTML:NO];
        [self.navigationController presentViewController:mailPicker animated:YES completion:^{
            
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
