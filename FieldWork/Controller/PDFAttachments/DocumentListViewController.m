//
//  DocumentListViewController.m
//  FieldWork
//
//  Created by Samir Khatri on 3/20/14.
//
//

#import "DocumentListViewController.h"

@interface DocumentListViewController ()

@end

@implementation DocumentListViewController

+ (DocumentListViewController *)viewComntrollerWithAppointment:(Appointment *)app {
    DocumentListViewController *controller = [[DocumentListViewController alloc] initWithNibName:@"DocumentListViewController" bundle:nil];
    controller.Appointment = app;
    controller.title = @"PDF Attachments";
    return controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_table reloadData];
}

- (void) reloadTable
{
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.Appointment.pdf_forms.count;
    }else{

        return self.Appointment.attachments.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Original documents";
    }else{
        return @"Completed Forms";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
#endif

    if (indexPath.section == 0) {
        FWPDFForm *attachment = [[self.Appointment.pdf_forms allObjects] objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
        cell.textLabel.text = attachment.name;
    }else
    {
        PDFAttachment *attachment = [[self.Appointment.attachments allObjects] objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
        cell.textLabel.text = attachment.attached_pdf_form_file_name;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        FWPDFForm *att = [[self.Appointment.pdf_forms allObjects] objectAtIndex:indexPath.row];
        if (att) {
            [att openPdfForEditingWithFromRect:CGRectZero andInView:self.view appointment:self.Appointment];
            [self postNotificationForDirty];
        }
    }else{
        PDFAttachment *att = [[self.Appointment.attachments allObjects] objectAtIndex:indexPath.row];
        if (att) {
            [att openPdfForEditingWithFromRect:CGRectZero andInView:self.view];
            [self postNotificationForDirty];
        }
    }
}

@end
