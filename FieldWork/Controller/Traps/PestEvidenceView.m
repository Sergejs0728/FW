    //
    //  PestEvidenceView.m
    //  FieldWork
    //
    //  Created by Samir Kha on 12/02/2013.
    //  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
    //

#import "PestEvidenceView.h"

@implementation PestEvidenceView
@synthesize PestEvidencetable=_PestEvidencelist;
//26112015
//@synthesize barcode=_barcode;
//@synthesize customerTrap = _customerTrap;
//
//+ (PestEvidenceView*) initWithAppointment:(Appointment *)appt andCustomerTrap:(CustomerTrap *)ctrap
//{
//    PestEvidenceView * trap=[[PestEvidenceView alloc]initWithNibName:@"PestEvidenceView" bundle:nil];
//    trap.title = @"Pest Evidence";
//    trap.customerTrap = ctrap;
//    trap.barcode=ctrap.barcode;
//    return trap;
//}
- (void)viewDidLoad
{
    //26112015
//    Pestlabel.text=self.barcode;
    PestEvidencelist=[[NSMutableArray alloc]initWithObjects:@"Evidence", nil];
    [super viewDidLoad];
}
-(IBAction)PestEvidencebtn:(id)sender
{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Findings";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
    cell.textLabel.text=[PestEvidencelist objectAtIndex:indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning
{
     [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */
- (void)viewDidUnload
{
    [super viewDidUnload];
        // Release any retained subviews of the main view.
        // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
