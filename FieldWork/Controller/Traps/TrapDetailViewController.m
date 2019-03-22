//
//  TrapDetailViewController.m
//  FieldWork
//
//  Created by Alex on 29.06.17.
//
//

#import "TrapDetailViewController.h"
#import "UIPlaceHolderTextView.h"
#import "FieldWorkButton.h"
#import "Appointment.h"
#import "CustomerDevice.h"
#import "InspectionRecord.h"
#import "BarcodeScanerViewController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import "UIAlertController+Blocks.h"
#import "TrapAddController.h"

@interface TrapDetailViewController () <BarcodeScanerViewControllerDelegate, UITextViewDelegate> {
    NSString *noteString;
    NSString *exceptionString;
    NSString *barcode;
    InspectionRecord *inspectionRecord;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTrapNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblBarcode;
@property (weak, nonatomic) IBOutlet UILabel *lblScannedTime;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *tvException;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *tvNotes;
@property (weak, nonatomic) IBOutlet FieldWorkButton *btnRescan;
@property (strong, nonatomic) IBOutlet BarcodeScanerViewController *reader;

@end

@implementation TrapDetailViewController

+ (TrapDetailViewController*) initWithAppointment:(Appointment*)app withCustomerTrap:(CustomerDevice*)trap
{
    TrapDetailViewController *vc = [[TrapDetailViewController alloc] initWithNibName:@"TrapDetailViewController" bundle:nil];
    
    vc.title = NSLocalizedString(@"Traps Scan Detail", @"");
    vc.Appointment = app;
    vc.customerTrap = trap;
    vc.scannedDate = [NSDate systemDate];
    
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [_tvException setPlaceholder:@"Exception detail (200) characters"];
    [_tvNotes setPlaceholder:@"Note (200) characters"];
    _tvNotes.secondDelegate = self;
    _tvException.characterLength = _tvNotes.characterLength = 200;
    
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"barcode == %@", self.customerTrap.barcode];
//    inspectionRecord = [[[self.Appointment.inspection_records filteredSetUsingPredicate:predicate] allObjects] firstObject];
    noteString = self.customerTrap.notes;
    barcode = self.customerTrap.barcode;
//    exceptionString = inspectionRecord.exception;
    _tvNotes.text = noteString;
//    _tvException.text = inspectionRecord.exception;
    _lblTrapNumber.text = self.customerTrap.number;
    [self createBarButton];
    [self initUI];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_tvException resignFirstResponder];
    [_tvNotes resignFirstResponder];
}


- (BOOL)navigationShouldPopOnBackButton {
//    if (inspectionRecord) {
//        [inspectionRecord discard];
//    }
    [self back];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"Memory getting low, please save your data."
                               delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    if ([self.view window] == nil)
    {
        self.view = nil;
    }
}

#pragma mark -
- (void)initUI {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm a";
    NSString *scannedOnString = [formatter stringFromDate:self.scannedDate];
    _lblScannedTime.text = scannedOnString;
    _lblBarcode.text = barcode;
}

-(void)createBarButton{
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
}


- (void)back {
    NSUInteger index = NSNotFound;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        if ([viewController isKindOfClass:[TrapAddController class]]) {
            index = [self.navigationController.viewControllers indexOfObject:viewController];
            break;
        }
    }
    
    if (index != NSNotFound && index - 1 < self.navigationController.viewControllers.count) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index - 1] animated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)save {
    // ensure that trap saved to get in in local context
    [self.customerTrap.managedObjectContext MR_saveOnlySelfAndWait];
//    if (inspectionRecord == nil) {
//        inspectionRecord = [InspectionRecord newInspectionWithBarcode:barcode inContext:[NSManagedObjectContext MR_defaultContext]];
//    }
//    [inspectionRecord.managedObjectContext MR_saveOnlySelfAndWait];
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext * _Nonnull localContext) {
//        InspectionRecord *record = nil;
//        if (inspectionRecord == nil) {
//            record = [InspectionRecord newInspectionWithBarcode:barcode inContext:localContext];
//        } else {
//            record = [inspectionRecord MR_inContext:localContext];
//        }
        CustomerDevice *trap = [self.customerTrap MR_inContext:localContext];
//        Appointment *app = [self.Appointment MR_inContext:localContext];
        trap.barcode = barcode;
        if ([trap.entity_status isEqual:c_UNCHANGED]) {
            trap.entity_status = c_EDITED;
        }
//        record.trap_number = trap.number;
//        record.trap_type_id = trap.trap_type_id;
//        record.appointment = app;
//        record.building = trap.building;
//        record.floor = trap.floor;
//        record.trap_number = trap.number;
//        record.trap_id = trap.entity_id;
//        record.scanned_on = self.scannedDate;
//        record.notes = noteString;
//        record.exception = exceptionString;
//        if ([record.entity_status isEqual:c_UNCHANGED]) {
//            record.entity_status = c_EDITED;
//        }
//        if (![app.inspection_records containsObject:record]) {
//            [app.inspection_recordsSet addObject:record];
//        }
    }];
//    // refresh record
//    inspectionRecord = [InspectionRecord inspectionById:inspectionRecord.entity_id];
//    TrapInspectionViewController *vc = [TrapInspectionViewController initWithAppointment:self.Appointment withInspection:inspectionRecord];
    TrapInspectionViewController *vc = [TrapInspectionViewController initWithAppointment:self.Appointment withTrap:self.customerTrap];
    vc.exception = exceptionString;
    vc.notes = noteString;
    vc.scannedDate = _scannedDate;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)saveTrap {
    self.customerTrap.barcode = barcode;
    if ([self.customerTrap.entity_status isEqual:c_UNCHANGED]) {
        self.customerTrap.entity_status = c_EDITED;
    }
    [self.customerTrap.managedObjectContext MR_saveOnlySelfAndWait];
}

#pragma mark - IBActions
- (IBAction)onRescan:(UIButton *)sender {
    _reader = [[BarcodeScanerViewController alloc] init];
    _reader.delegate = self;
    [self presentViewController:_reader animated:YES completion:nil];
}

#pragma mark - BarcodeScanerViewControllerDelegate
- (void)barcodeScanerViewControllerDidScan:(NSString *)code {
    [_reader dismissViewControllerAnimated:YES completion:^{
        if ([code isEqualToString:barcode]) {
            return;
        }
        CustomerDevice *trap = [CustomerDevice deviceByBarcode:code andService_location:self.customerTrap.service_location_id];
        if (trap) {
            [UIAlertController showAlertInViewController:self
                                               withTitle:ALERT_TITLE
                                                 message:NSLocalizedString(@"Already exists", @"")
                                       cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil
                                                tapBlock:nil];
        } else {
            [UIAlertController showAlertInViewController:self
                                               withTitle:ALERT_TITLE
                                                 message:NSLocalizedString(@"Would you like to save?", @"")
                                       cancelButtonTitle:NSLocalizedString(@"Yes", @"")
                                  destructiveButtonTitle:NSLocalizedString(@"No", @"")
                                       otherButtonTitles:nil
                                                tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                    if (buttonIndex == controller.cancelButtonIndex) {
                                                        barcode = code;
                                                        _scannedDate = [NSDate systemDate];
                                                        [self saveTrap];
                                                        [self initUI];
                                                    }
                                                }];
        }
    }];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (textView == _tvNotes) {
        if([text isEqualToString:@"\n"]) {
            //  [textView resignFirstResponder];
            //  return NO;
            noteString = [NSString stringWithFormat:@"%@   ",textView.text];
        }else if(![text isEqualToString:@""]){
            noteString = [NSString stringWithFormat:@"%@%@",textView.text,text];
        }else{
            if (textView.text.length) {
                noteString = [textView.text substringToIndex:textView.text.length - 1];
            }
        }
    }
    
    return YES;
}

#pragma mark -
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
