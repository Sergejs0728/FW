
//
//  NewAppointMentsDetailViewController.m
//  FieldWork
//
//  Created by Samir on 11/2/15.
//
//

#import "NewAppointMentsDetailViewController.h"
#import "HeaderCell.h"
#import "SchemeDrawerControllerViewController.h"
#import "ChemicalUseCell.h"
#import "DevicesCell.h"
#import "LineItemCell.h"
#import "NotesCell.h"
#import "PDFCell.h"
#import "PhotosCell.h"
#import "SectionHeaderCell.h"
#import "AppWeatherTableViewCell.h"
#import "ServiceInstructionCell.h"
#import "SignatureCell.h"
#import "PDFSignatureCell.h"
#import "PDFField.h"
#import "UnitsCell.h"
#import "CustomLabel.h"
#import "AppServiceCell.h"
#import "EnvironmentViewController.h"
#import "AppDetailCell.h"
#import "AppPdfFormCell.h"
#import "AppNotesCell.h"
#import "AppChemicalCell.h"
#import "PDFFieldsEditorViewController.h"
#import "AppPhotoCell.h"
#import "AppDevicesCell.h"
#import "AppUnitsCell.h"
#import "AppLineItemCell.h"
#import "AppSignatureCell.h"
#import "AppTimeCell.h"
#import "AppSchemeCell.h"
#import "TrapAddController.h"
#import "StartWorkOrderViewController.h"
#import "UIAlertController+Blocks.h"
#import "PDFViewerController.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import <Crashlytics/Crashlytics.h>
#import "SyncManager.h"
#import "FloorPlansViewController.h"
#import "AppointmentManager.h"

#define PhotosFeature @"Images"
#define PDFFormsFeature @"PDF Forms"
#define DrawingFeature @"Drawing"
#define DevicesFeature @"Traps scanning"

#define REFRESH_LONG_TIMER 20
#define REFRESH_SHORT_TIMER 2

@interface NewAppointMentsDetailViewController ()<AppDeveiceDelegate, MFMailComposeViewControllerDelegate, iPadSamcomActionSheetDelegate>
@property (strong,nonatomic) NSArray* stages;
@property (strong,nonatomic) NSArray* pdf_forms;
@property (strong,nonatomic) NSArray* pdf_attachments;
@property (strong,nonatomic)NSArray* accountFeatures;
@property (nonatomic) BOOL autoGeneratesInvoice;
@property (strong, nonatomic) GameTimer *gameTimer;
@property (nonatomic)BOOL hideCustomerInfo;
@end

@implementation NewAppointMentsDetailViewController


+(NewAppointMentsDetailViewController *)initViewControllerAppointment:(Appointment *)app{
    NewAppointMentsDetailViewController *controller = [[NewAppointMentsDetailViewController alloc]initWithNibName:@"NewAppointMentsDetailViewController" bundle:nil];
    controller.Appointment = app;
    DLog(@"DEBUG APPT ID : %@", app.entity_id);
    return controller;
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.Appointment calculateTaxAmount];
    [self loadStages];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    User* user = [User getUser];
    _hideCustomerInfo=user.hide_customer_details;
//    _accountFeatures=@[@"stripe",
//                       @"PayPal",
//                       @"Quickbooks",
//                       @"PDF Forms",
//                       @"Images",
//                       @"Mapping",
//                       @"Traps scanning",
//                       @"sms",
//                       @"Address Autocomplete",
//                       @"Drawing"];
    _accountFeatures=user.account_features;
    _pdf_forms=[self.Appointment.pdf_forms allObjects];
    
    [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"BuildingCell"];
    self.title = [NSString stringWithFormat:@"WO #%@", self.Appointment.report_number];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveAppointment)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *btnClose = [UIBarButtonItem barButtonWithTitle:@"Close" andBlock:^{
        
        UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:@"You have not saved this record, would you like to save before proceeding?"  preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
            [self saveAppointment];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSNumber* serviceLocationId=self.Appointment.service_location_id;
            ServiceLocation* serviceLocation=[ServiceLocation MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"entity_id == %@", serviceLocationId]];
            if((serviceLocation.floors)||(serviceLocation.floors.count>0)||(serviceLocation.floors.count)){
                NSArray* stages=[serviceLocation.floors array];
                for (StageModel* stage in stages) {
                    [stage setDeleted:@(NO)];
                }
            }
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    }];
    [btnClose setTextColor:RED_COLOR];
    self.navigationItem.leftBarButtonItem = btnClose;
    
    reader = [[CVZBarReaderViewController alloc] init];
    reader.readerDelegate = self;
    reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    scanner = reader.scanner;
    reader.cameraOverlayView=[self setOverlayButton];
    
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDevices) name:UPDATE_DEVIDES object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSectionFromNotification:) name:kWORKORDER_DETAIL_UPDATE_SECTION object:nil];
    
    [self removeStartControllerFromStack];
    
    _recommendationBlock = ^void
    {
        NSMutableArray *existing_items = [Recommendations recommendationByIds:(NSArray*)weakSelf.Appointment.recommendation_ids];
        DataTableViewController *controller = [DataTableViewController tableWithDataType:RecommendationsList andDelegate:nil withMultipleChoices:YES];
        controller.existing_items = existing_items;
        controller.dataSelectionBlock = ^(id data){
            NSArray *rec_ids = [(NSArray*)data valueForKey:@"entity_id"];
            [weakSelf.Appointment setRecommendation_ids:rec_ids];
            [weakSelf.Appointment saveAppointmentOnLocal];
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:controller animated:YES];
    };
    
    _environmentBlock = ^void
    {
        EnvironmentViewController* controller= [EnvironmentViewController initWithAppointment:weakSelf.Appointment];
        controller.onPopBlock = ^(id data){
             Appointment* newAppointment = (Appointment*)data;
            [weakSelf.Appointment setTemperature:newAppointment.temperature];
            [weakSelf.Appointment setWind_speed:newAppointment.wind_speed];
            [weakSelf.Appointment setWind_direction:newAppointment.wind_direction];
            [weakSelf.tableView reloadData];
        };

        [weakSelf.navigationController pushViewController:controller animated:YES];
    };

    
    _conditionsBlock = ^void
    {
        NSMutableArray *existing_items = [Conditions conditionByIds:(NSArray*)weakSelf.Appointment.appointment_condition_ids];
        
        DataTableViewController *controller = [DataTableViewController tableWithDataType:ConditionsList andDelegate:nil withMultipleChoices:YES];
        controller.existing_items = existing_items;
        controller.dataSelectionBlock = ^(id data){
            NSArray *rec_ids = [(NSArray*)data valueForKey:@"entity_id"];
            [weakSelf.Appointment setAppointment_condition_ids:rec_ids];
            [weakSelf.Appointment saveAppointmentOnLocal];
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:controller animated:YES];
    };
}


-(void)loadStages{
    NSNumber* serviceLocationId=self.Appointment.service_location_id;
    ServiceLocation* serviceLocation=[ServiceLocation MR_findFirstWithPredicate:[NSPredicate predicateWithFormat:@"entity_id == %@", serviceLocationId]];
    if((serviceLocation.floors)||(serviceLocation.floors.count>0)||(serviceLocation.floors.count)){
        NSArray* stages=[serviceLocation.floors array];
        NSPredicate* predicate=[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary<NSString *,id> *  bindings) {
                StageModel* object=evaluatedObject;
                return ![object.deleted boolValue];
        }];
        _stages=[stages filteredArrayUsingPredicate:predicate];
        NSMutableArray* tempBuildingArray=[NSMutableArray new];
        for (StageModel* stage in stages) {
            NSString* building=stage.building;
            NSString* floor=stage.floor;
            BOOL deleted=[stage.deleted boolValue];
            if ((building)&&(floor)&&(!deleted)) {
                [tempBuildingArray addObject:building];
            }
        }
        [self refreshObjects];
        NSIndexSet* indexSet=[NSIndexSet indexSetWithIndex:FWScheme];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(BOOL) navigationShouldPopOnBackButton
{
    [[[UIAlertView alloc] initWithTitle:@"FieldWork" message:@"You have not saved this record, would you like to save before proceeding?"
                               delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
    return NO;
}

- (void)refreshObjects {
    self.Appointment = [Appointment getById:self.Appointment.entity_id];
    _serviceLocaion = [self.Appointment getServiceLocation];
    self.cust = [self.Appointment getCustomer];
}

- (void) updateDevices
{
    [self refreshObjects];
    [self reloadSection:FWDevices];
}



- (void) updateSectionFromNotification:(NSNotification*)not
{
    [self refreshObjects];
    if ([not.name isEqualToString:kWORKORDER_DETAIL_UPDATE_SECTION]) {
        NSDictionary* userInfo = not.userInfo;
        NSNumber *num = [userInfo objectForKey:@"section"];
        [self reloadSection:[num integerValue]];
    }
}

- (void) reloadSection:(NSInteger)section
{
    [self.tableView reloadData];
}

- (UIView *)setOverlayButton{
    UIView *v=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [v setBackgroundColor:[UIColor clearColor]];
    UIButton * btntorch =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 10,60,60)];
    [btntorch addTarget:self action:@selector(torchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIImage __autoreleasing *torch = [UIImage imageNamed:@"torch.png"];
    [btntorch setImage:torch forState:UIControlStateNormal];
    [btntorch setImage:torch forState:UIControlStateHighlighted];
    [v addSubview:btntorch];
    torch = nil;
    btntorch = nil;
    return  v;
}

-(void)torchButtonClicked{
    if (reader.cameraFlashMode == UIImagePickerControllerCameraFlashModeOff) {
        reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
    }else{
        reader.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    }
}

- (void) removeStartControllerFromStack
{
    NSUInteger index = NSNotFound;
    for (UIViewController* viewController in self.navigationController.viewControllers) {
        
        if ([viewController isKindOfClass:[StartWorkOrderViewController class]] ) {
            
            index = [self.navigationController.viewControllers indexOfObject:viewController];
            break;
        }
    }
    if (index != NSNotFound ) {
        NSMutableArray *temp = [self.navigationController.viewControllers mutableCopy];
        [temp removeObjectAtIndex:index];
        self.navigationController.viewControllers = temp;
    }
}

- (void)tryToSaveImmediately {
    [self.Appointment saveAppointmentOnLocal];
    if ([[AppDelegate appDelegate] isReachable]) {
        [[SyncManager Instance] stopTimer];
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        [self.Appointment saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kRELOAD_WORKORDERS_TABLE object:nil];
            [[SyncManager Instance] startTimer];
            [[SyncManager Instance] startSync];
            [self.gameTimer stopTimer];
            self.gameTimer = [[GameTimer alloc]initWithLongInterval:REFRESH_LONG_TIMER andShortInterval:REFRESH_SHORT_TIMER andDelegate:self];
            [self.gameTimer startTimer];
        }];
    }
}

- (void)saveAppointment {
    
    
    UIAlertController *alertController;
    if (self.Appointment.started_at_time == nil) {
        alertController = [UIAlertController
                           alertControllerWithTitle:@"Appointment"
                           message:@"Start time is required"
                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                           [alertController dismissViewControllerAnimated:YES completion:^{
                                               
                                           }];
                                       }];
         [alertController addAction:cancelAction];
    }else{
        NSDate *dt = [NSDate date];
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setDateFormat:@"hh:mm a"];
        NSString *time = [NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:dt]];
        if (!self.Appointment.finished_at_time) {
             self.Appointment.finished_at_time = [Utils getMilitaryTime:time];
        }
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            alertController = [UIAlertController
                               alertControllerWithTitle:@"Appointment"
                               message:@""
                               preferredStyle:UIAlertControllerStyleAlert];
        }else{
            alertController = [UIAlertController
                               alertControllerWithTitle:@"Appointment"
                               message:@""
                               preferredStyle:UIAlertControllerStyleActionSheet];
        }
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel action");
                                           [alertController dismissViewControllerAnimated:YES completion:^{
                                               
                                           }];
                                       }];
        [alertController addAction:cancelAction];
        __weak __typeof(self) weakSelf = self;
        
        [alertController addAction:[UIAlertAction
                                    actionWithTitle:@"Save & Exit"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [weakSelf tryToSaveImmediately];
                                    }]];
        
        [alertController addAction:[UIAlertAction
                                    actionWithTitle:@"Complete & Exit"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [weakSelf.Appointment setStatus:wo_STATUS_COMPLETE];
                                        CLLocationCoordinate2D coord = [[Location Instance] getCurrentCoordinates];
                                        [weakSelf.Appointment setWorker_lat:@(coord.latitude)];
                                        [weakSelf.Appointment setWorker_lng:@(coord.longitude)];
                                        [weakSelf tryToSaveImmediately];
                                    }]];
        
        if ([UserSetting getPrintOnOff] == YES) {
            [alertController addAction:[UIAlertAction
                                        actionWithTitle:@"Complete & Print"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction *action)
                                        {
                                            [weakSelf.Appointment setStatus:wo_STATUS_COMPLETE];
                                            [weakSelf.Appointment saveAppointmentOnLocal];
                                            if ([[AppDelegate appDelegate] isReachable]) {
                                                [[ActivityIndicator currentIndicator] displayActivity:@"Saving..."];
                                                [weakSelf.Appointment saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                                                    if (is_saved) {
                                                        [self downloadServiceReportAndDo:FWPrint];
                                                    } else {
                                                        [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Saving failed"];
                                                        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Could not save work order, please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                                    }
                                                }];
                                            } else {
                                                [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Need internet connection to print the Service report" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                            }
                                        }]];
        }
        [alertController addAction:[UIAlertAction
                                    actionWithTitle:@"Complete & Email"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [weakSelf.Appointment setStatus:wo_STATUS_COMPLETE];
                                        [weakSelf.Appointment saveAppointmentOnLocal];
                                        if ([[AppDelegate appDelegate] isReachable]) {
                                            [[ActivityIndicator currentIndicator] displayActivity:@"Saving..."];
                                            [weakSelf.Appointment saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                                                if (is_saved) {
                                                    [self downloadServiceReportAndDo:FWEmail];
                                                } else {
                                                    [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Saving failed"];
                                                    [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Could not save work order, please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                                }
                                            }];
                                        } else {
                                            [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Need internet connection to email the Service report" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                        }
                                        
                                    }]];
        
        [alertController addAction:[UIAlertAction
                                    actionWithTitle:@"Preview"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        [weakSelf.Appointment saveAppointmentOnLocal];
                                        if ([[AppDelegate appDelegate] isReachable]) {
                                            [[ActivityIndicator currentIndicator] displayActivity:@"Saving..."];
                                            [weakSelf.Appointment saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
                                                if (is_saved) {
                                                    [self downloadServiceReportAndDo:FWPreview];
                                                } else {
                                                    [[ActivityIndicator currentIndicator] displayCompletedWithError:@"Saving failed"];
                                                    [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Could not save work order, please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                                }
                                            }];
                                        } else {
                                            [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Need internet connection to preview the Service report" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                                        }
                                        
                                    }]];

    }
    
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void) downloadServiceReportAndDo:(NSAction)action
{
    [[ActivityIndicator currentIndicator] displayActivity:@"Downloading..."];
    [self.Appointment downloadServiceReportWithBlock:^(id result, BOOL is_success) {
        [[ActivityIndicator currentIndicator] displayCompleted];
        if (is_success) {
            if (action == FWPrint) {
                [self printFile];
            } else if (action == FWPreview) {
                PDFViewerController *controller = [PDFViewerController viewControllerWithPDFPath:[Appointment ServiceReportPath] forAppointment:self.Appointment];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
                [self.navigationController presentViewController:nav animated:YES completion:nil];
            } else if (action == FWEmail) {
                [self displayMailComposerSheetWithString:[Appointment ServiceReportPath] filePath:YES];
            }
        } else {
            [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Could not download the Service Report, Please try again." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
        }
    }];
}

- (HeaderView*) createHeaderViewForSection:(NSInteger)section withTitle:(NSString*)title andButtonBlock:(void(^)())block
{
    HeaderView *view;
    if (section == FWLineItem) {
        if (self.Appointment.invoice != nil) {
            Payment *payment = [self.Appointment.invoice getMobilePayment];
            if (payment != nil) {
                view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title isPaid:YES];
            }else{
                view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title isPaid:NO];
            }
        }else{
                view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title isPaid:NO];
        }
    }else{
        view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title];
    }
    
    view.headerOpenBlock = ^(NSInteger section) {
        [self refreshObjects];
        [_tableView headerViewOpen:section];
    };
    
    view.headerCloseBlock = ^(NSInteger section) {
        [self refreshObjects];
        [_tableView headerViewClose:section];
    };
    
    if (block) {
        [view addRightButtonWithTitle:@"+ Add" andBlock:block];
    }
    return view;
}

#pragma mark show_PDFFieldsEditorViewController

-(void) pdfDialogForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDFForm *form = [_pdf_forms objectAtIndex:indexPath.row];
    NSArray* fields=[[form fields] array];
    if (fields) {
        if (fields.count>0) {
            PDFFieldsEditorViewController *pdfController = [PDFFieldsEditorViewController new];
            [pdfController setPdfForm:form];
            PDFAttachment *att = [form getRelatedAttachment];
            
            [pdfController setPdfAttachment:att];
            if (!_pdf_attachments) {
                _pdf_attachments= [self.Appointment.attachments allObjects];
            }
            for (PDFAttachment* attachment in _pdf_attachments) {
                if(attachment.pdf_form_id.integerValue==form.entity_id.integerValue){
                    [attachment.managedObjectContext refreshObject:attachment mergeChanges:NO];
                    [pdfController setPdfAttachment:attachment];
                    break;
                }
            }
            pdfController.fieldsBlock=^(){
                NSIndexSet* set=[NSIndexSet indexSetWithIndex:FWPDFForms];
                [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:pdfController animated:YES];
        }
        else{
            PDFAttachment *att = [form getRelatedAttachment];
            NSString *doc_path = @"";
            if (att) {
                doc_path = [att pdfFilePath];
            } else {
                doc_path = [form pdfFilePath];
            }
            if (doc_path.length > 0) {
                [self openDocument:doc_path];
            }
        }
    }
    else{
        PDFAttachment *att = [form getRelatedAttachment];
        NSString *doc_path = @"";
        if (att) {
            doc_path = [att pdfFilePath];
        } else {
            doc_path = [form pdfFilePath];
        }
        if (doc_path.length > 0) {
            [self openDocument:doc_path];
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return FWTotalSections;
}

- (void) RequestDidSuccess:(FWRequest*)request{
    if (request.IsSuccess){
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            PDFAttachment *attachment = [PDFAttachment MR_createEntityInContext:localContext];
            NSDictionary *mainDict = request.serverData;
            NSDictionary *attachmentDict = [mainDict objectForKey:@"attachment"];
            BOOL saved = YES;
            @try {
                [FEMDeserializer fillObject:attachment fromRepresentation:attachmentDict mapping:[PDFAttachment defaultMapping]];
                NSArray* fieldValues=[attachmentDict objectForKey:@"field_values"];
                for (NSDictionary* fieldDict in fieldValues) {
                    PDFField *field = [PDFField MR_createEntityInContext:localContext];
                    [FEMDeserializer fillObject:field fromRepresentation:fieldDict mapping:[PDFField defaultMapping]];
                    field.pdf_attachment=attachment;
                }
            } @catch (NSException *exception) {
                saved = NO;
                [FWRequest sendReportWithEvent:@"Crash" attributes:@{@"Class":NSStringFromClass([self class]),
                                                                     @"Method":NSStringFromSelector(@selector(RequestDidSuccess:)),
                                                                     @"Exception":exception.description,
                                                                     @"UserId":attachment.entity_id,
                                                                     @"RequestTag":request.Tag,
                                                                     @"RequestMethod":@"GET",
                                                                     @"ServerDataClass":NSStringFromClass([request.serverData class])}];
            }
        }];
    }
}

- (void) RequestDidFailForRequest:(FWRequest*)request withError:(NSString*)error{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    __weak __typeof(self) weakSelf = self;
    if (section == FWLineItem) {
        if (([self.Appointment.hide_invoice_information boolValue])||(![self.Appointment.auto_generates_invoice boolValue])) {
            return [self createHeaderViewForSection:section withTitle:@"INVOICE" andButtonBlock:nil];

        } else {
            return [self createHeaderViewForSection:section withTitle:@"INVOICE" andButtonBlock:^{
                AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerNewWorkOrderAppointment:_Appointment andLineItem:nil Delegate:self];
                [self.navigationController pushViewController:addLineItem animated:YES];
            }];
        }
    }else if (section == FWServiceInstruction){
        return [self createHeaderViewForSection:section withTitle:@"SERVICE INSTRUCTIONS" andButtonBlock:nil];
    }else if (section == FWLocationNote){
        return [self createHeaderViewForSection:section withTitle:@"LOCATION NOTE" andButtonBlock:nil];
    }else if ((section == FWPDFForms)&&([_accountFeatures containsObject:PDFFormsFeature])){
        return [self createHeaderViewForSection:section withTitle:@"PDF FORMS" andButtonBlock:nil];
    }else if (section == FWNotes){
        return [self createHeaderViewForSection:section withTitle:@"NOTES" andButtonBlock:nil];
    }else if (section == FWMaterialUse){
        return [self createHeaderViewForSection:section withTitle:@"MATERIAL USE" andButtonBlock:^{
            MaterialListController *ml = [MaterialListController viewControllerWithAppointment:self.Appointment];
            ml.materialUsagedAddedBlock = ^{
                [self.tableView reloadData];
            };
            [weakSelf.navigationController pushViewController:ml animated:YES];
        }];
    }else if ((section == FWPhotos)&&([_accountFeatures containsObject:PhotosFeature])){
        UIView *headerview = [self createHeaderViewForSection:section withTitle:@"PHOTOS" andButtonBlock:^{
            if ([[self.Appointment.photo_attachments filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects].count < 12) {
                [weakSelf appPhotoOpenImagePicker];
            } else {
                UIAlertController *alertController = [UIAlertController
                                                      alertControllerWithTitle:@"FieldWork"
                                                      message:@"Please, upload no more then 12 photos."
                                                      preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction
                                               actionWithTitle:@"OK"
                                               style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction *action)
                                               {
                                                   [alertController dismissViewControllerAnimated:YES completion:^{
                                                       
                                                   }];
                                               }];
                [alertController addAction:cancelAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }];
         return headerview;
    }else if ((section == FWDevices)&&([_accountFeatures containsObject:DevicesFeature])){
        return [self createHeaderViewForSection:section withTitle:@"DEVICES" andButtonBlock:nil];
    }else if ((section == FWScheme)&&([_accountFeatures containsObject:DrawingFeature])){
        return [self createHeaderViewForSection:section withTitle:@"DIAGRAM" andButtonBlock:^{
            [self addFloor];
        }];
    }else if (section == FWSignature){
        return [self createHeaderViewForSection:section withTitle:@"SIGNATURES" andButtonBlock:nil];
    } else if (section == FWRecommendation) {
    
        // :: Add this code if we want to hide the section when there are no Recommendations or Conditions
//        if (((NSArray*)self.Appointment.recommendation_ids).count == 0)
//        {
//            return nil;
//        }
        
        return [self createHeaderViewForSection:section withTitle:@"RECOMMENDATION" andButtonBlock:^{
            _recommendationBlock();
            
        }];
    } else  if (section == FWEnvironment) {
                return [self createHeaderViewForSection:section withTitle:@"ENVIRONMENT" andButtonBlock:^{
                    if(_environmentBlock){
                        _environmentBlock();
                    }
        }];
    } else
        if (section == FWConditions) {
        
        // :: Add this code if we want to hide the section when there are no Recommendations or Conditions
//        if (((NSArray*)self.Appointment.appointment_condition_ids).count == 0)
//        {FloorPlansViewController
//            return nil;
//        }
        return [self createHeaderViewForSection:section withTitle:@"CONDITIONS" andButtonBlock:^{
            _conditionsBlock();
        }];
    }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == FWLineItem && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        NSUInteger cnt = [self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count;
        if ([self.Appointment.hide_invoice_information boolValue]) {
            if ([self.Appointment.auto_generates_invoice boolValue]) {
                return cnt > 0 ? cnt + 3 : 0;
            }
             return cnt > 0 ? cnt + 2 : 0;
        }else{
            if (![self.Appointment.auto_generates_invoice boolValue]) {
                NSUInteger returnValue=(cnt > 0 ? cnt + 3 : 0);
                return returnValue;
            }
             return cnt > 0 ? cnt + 3 : 0;
        }
    } else if (section == FWPDFForms && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        NSUInteger cnt = _pdf_forms.count;
        return cnt > 0 ? cnt : 1;
    } else if (section == FWMaterialUse && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        NSUInteger cnt = [self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count;
        return cnt <= 0 ? 1 : cnt;
    } else if ([@[@(FWServiceInstruction),@(FWNotes),@(FWPhotos),@(FWLocationNote),@(FWDevices),@(FWSignature),@(FWEnvironment)] containsObject:[NSNumber numberWithInteger:section]] && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        return 1;
    } else if (section == FWAppointmentDetails) {
        return 1;
    } else if (section == FWLocationNote) {
        return 0;
    }else if (section == FWScheme && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        NSInteger cnt=self.stages.count;
        return cnt > 0 ? cnt : 1;
    }else if (section == FWEnvironment ) {
        return 0;
    } else if (section == FWRecommendation && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        // :: Add this code if we want to hide the section when there are no Recommendations or Conditions
//        if (((NSArray*)self.Appointment.recommendation_ids).count == 0)
//        {
//            return 0;
//        }
        
        NSUInteger cnt = [(NSArray*)self.Appointment.recommendation_ids count];
        return cnt <= 0 ? 1 : cnt;
    } else if (section == FWConditions && (self.tableView.sectionOpen != NSNotFound && self.tableView.sectionOpen == section)) {
        NSUInteger cnt = [(NSArray*)self.Appointment.appointment_condition_ids count];
        return cnt <= 0 ? 1 : cnt;
    }
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForRowAtIndexPath:indexPath];
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static CGFloat NO_DATA_CELL_HEIGHT = 44;
    if (indexPath.section == FWAppointmentDetails) {
<<<<<<< HEAD
        return 170;
=======
//        if (_serviceLocaion.phone.length == 0 && _serviceLocaion.email.length == 0) {
//            return 221;
//        } else if (_serviceLocaion.phone.length == 0 || _serviceLocaion.email.length == 0) {
//            return 242;
//        } else {
        if (_hideCustomerInfo) {
            return 300;

        }
            return 279;
//        }//detail
>>>>>>> drawing_fixes_new
    } else if (indexPath.section == FWTimeSelection) {
        return 0;
    } else if (indexPath.section == FWLineItem){
            if ([self.Appointment.hide_invoice_information boolValue]) {
                if (indexPath.row == [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count] + 1){
                    return 143;
                }
            }else{
                if ([self.Appointment.auto_generates_invoice boolValue]){
                    if (indexPath.row == [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count] + 2){
                        return 143;
                    }
                    if (indexPath.row == 0) {
                        if ([_serviceLocaion.hide_balance boolValue] == YES) {
                            return 0;
                        }
                    }
            
                }
            }
        return 44;//line items
    }else if (indexPath.section == FWEnvironment){//here
<<<<<<< HEAD
        if ((self.Appointment.temperature == nil || self.Appointment.temperature.length <= 0)&&
            (self.Appointment.wind_speed == nil || self.Appointment.wind_speed.length <= 0)&&
            (self.Appointment.wind_direction == nil || self.Appointment.wind_direction.length <= 0)) {
            return NO_DATA_CELL_HEIGHT;
        }
        return 144;
=======
            if (((self.Appointment.temperature == nil )|| (self.Appointment.temperature.length <= 0)|| ([self.Appointment.temperature isEqualToString:@""]))&&
                ((self.Appointment.wind_speed == nil )|| (self.Appointment.wind_speed.length <= 0)|| ([self.Appointment.wind_speed isEqualToString:@""]))&&
                ((self.Appointment.wind_direction == nil) || (self.Appointment.wind_direction.length <= 0)|| ([self.Appointment.wind_direction isEqualToString:@""]))&&
                ((self.Appointment.square_feet == nil )|| (self.Appointment.square_feet.length <= 0)|| ([self.Appointment.square_feet isEqualToString:@""]))) {
                    return NO_DATA_CELL_HEIGHT;
            }
            return 190;
>>>>>>> drawing_fixes_new
        
    }else
        if (indexPath.section == FWLocationNote){
            if (self.serviceLocaion) {
                if (self.serviceLocaion.notes == nil || self.serviceLocaion.notes.length<= 0) {
                    return NO_DATA_CELL_HEIGHT;
                }
                CGRect rect = TEXT_SIZE(self.serviceLocaion.notes, 15);
                if (rect.size.height < 71) {
                    return 71;
                }
                return rect.size.height+20;
            }
            //return 97;//service
        }else
<<<<<<< HEAD
            if (indexPath.section == FWServiceInstruction){
                if (self.Appointment.instructions == nil || self.Appointment.instructions.length <= 0) {
                    return NO_DATA_CELL_HEIGHT;
                }
                CGRect rect = TEXT_SIZE(self.Appointment.instructions, 15);
                if (rect.size.height < 71) {
                    return 71;
                }
                return rect.size.height;
                //return 97;//service
            }else if (indexPath.section == FWPDFForms){
                return 46;// pdf
            }else if (indexPath.section == FWNotes){
                CGRect note_rect = TEXT_SIZE(self.Appointment.notes, 15);
                CGRect private_note_rect = TEXT_SIZE(self.Appointment.private_notes, 15);
                
                float total_height = 0;
                if (note_rect.size.height > 70 && private_note_rect.size.height > 70) {
                    total_height = note_rect.size.height + private_note_rect.size.height + 20;
                }else if (note_rect.size.height < 70 && private_note_rect.size.height < 70){
                    total_height = 93;
                }else if (note_rect.size.height > 70) {
                    total_height = note_rect.size.height + 50;
                }else if (private_note_rect.size.height > 70) {
                    total_height = private_note_rect.size.height + 50;
                }
                
                return total_height + 100;
                
            } else if (indexPath.section == FWMaterialUse){
                if ([[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects].count == 0) {
                    return NO_DATA_CELL_HEIGHT;
                }
                return 61;
            }else if (indexPath.section == FWPhotos){
                // Photos
                NSArray *photos = [PhotoAttachment getPhotosWithAppointmentId:self.Appointment.entity_id];
                photos = [photos filteredArrayUsingPredicate:NON_DELETED_PREDECATE()];
                NSUInteger photo_count = photos.count;
                //        NSUInteger photo_count = [[self.Appointment.photo_attachments filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count];
                if (photo_count <= 0) {
                    return NO_DATA_CELL_HEIGHT;
                }
                NSInteger rows = photo_count <= 3 ? 1 : (photo_count / 3);
                if (photo_count <= 3) {
                    rows = 1;
                } else {
                    rows = photo_count % 3 == 0 ? (photo_count / 3) : (photo_count / 3) + 1;
                }
                
                NSInteger height = rows * 108;
                return height;
            }else if (indexPath.section == FWDevices){
                return 100;
            }else  if (indexPath.section == FWScheme){
                return 44;
            }else if (indexPath.section == FWSignature){
                return 360;
            }
=======
    if (indexPath.section == FWServiceInstruction){
        if (self.Appointment.instructions == nil || self.Appointment.instructions.length <= 0) {
            return NO_DATA_CELL_HEIGHT;
        }
        CGRect rect = TEXT_SIZE(self.Appointment.instructions, 15);
        if (rect.size.height < 71) {
            return 71;
        }
        return rect.size.height+20;
        //return 97;//service
    }else if (indexPath.section == FWPDFForms){
        return 46;// pdf
    }else if (indexPath.section == FWNotes){
        CGRect note_rect = TEXT_SIZE(self.Appointment.notes, 15);
        CGRect private_note_rect = TEXT_SIZE(self.Appointment.private_notes, 15);
        
        float total_height = 0;
        if (note_rect.size.height > 70 && private_note_rect.size.height > 70) {
            total_height = note_rect.size.height + private_note_rect.size.height + 20;
        }else if (note_rect.size.height < 70 && private_note_rect.size.height < 70){
            total_height = 93;
        }else if (note_rect.size.height > 70) {
            total_height = note_rect.size.height + 50;
        }else if (private_note_rect.size.height > 70) {
            total_height = private_note_rect.size.height + 50;
        }
        
        return total_height + 100;
        
    } else if (indexPath.section == FWMaterialUse){
        if ([[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects].count == 0) {
            return NO_DATA_CELL_HEIGHT;
        }
        return 61;
    }else if (indexPath.section == FWPhotos){
        // Photos
        NSArray *photos = [PhotoAttachment getPhotosWithAppointmentId:self.Appointment.entity_id];
        photos = [photos filteredArrayUsingPredicate:NON_DELETED_PREDECATE()];
        NSUInteger photo_count = photos.count;
//        NSUInteger photo_count = [[self.Appointment.photo_attachments filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count];
        if (photo_count <= 0) {
            return NO_DATA_CELL_HEIGHT;
        }
        NSInteger rows = photo_count <= 3 ? 1 : (photo_count / 3);
        if (photo_count <= 3) {
            rows = 1;
        } else {
            rows = photo_count % 3 == 0 ? (photo_count / 3) : (photo_count / 3) + 1;
        }
        
        NSInteger height = rows * 108;
        return height;
    }else if (indexPath.section == FWDevices){
        return 100;
    }else  if (indexPath.section == FWScheme){
        return 44;
    }else if (indexPath.section == FWSignature){
        return 360;
    }
>>>>>>> drawing_fixes_new
    return 44;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == FWAppointmentDetails) {
        return UITableViewAutomaticDimension;
    } else  {
        return [self heightForRowAtIndexPath:indexPath];
    }
}

- (CGSize)sizeForLabel:(UILabel *)label {
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    return size;
}

- (void)showMapsSelectorActionSheet {
    ServiceLocation *ser_loc = [self.Appointment getServiceLocation];
    CLLocationCoordinate2D cord = CLLocationCoordinate2DMake([ser_loc.lat doubleValue], [ser_loc.lng doubleValue]);
    UIAlertController *alertController = [UIAlertController  alertControllerWithTitle:@"FieldWork"  message:@"Choose map app"  preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Apple Maps" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        Class itemClass = [MKMapItem class];
        if (itemClass && [itemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:cord addressDictionary:nil] ];
            toLocation.name = [[self.Appointment getCustomer] getDisplayName];
            [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                           launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving, [NSNumber numberWithBool:YES], nil]
                                                                     forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey, MKLaunchOptionsShowsTrafficKey, nil]]];
            
        }

    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Google Maps" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString* urlStr = [NSString stringWithFormat: @"comgooglemapsurl://maps.google.com/maps?daddr=%f,%f", cord.latitude, cord.longitude];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://maps.google.com/maps?daddr=%f,%f", cord.latitude, cord.longitude]]];
        }
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Waze Maps" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSString* urlStr = [NSString stringWithFormat: @"waze://?ll=%f,%f&navigate=yes", cord.latitude, cord.longitude];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlStr]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/us/app/id323229106"]];
        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ((section==FWPDFForms)&&(![_accountFeatures containsObject:PDFFormsFeature])) {
        return 0;
    }
    if ((section==FWPhotos)&&(![_accountFeatures containsObject:PhotosFeature])) {
        return 0;
    }
    if ((section==FWDevices)&&(![_accountFeatures containsObject:DevicesFeature])) {
        return 0;
    }
    if ((section==FWScheme)&&(![_accountFeatures containsObject:DrawingFeature])) {
        return 0;
    }
    if([@[@(FWLineItem),@(FWServiceInstruction),@(FWLocationNote),@(FWEnvironment),@(FWPDFForms),@(FWNotes),@(FWScheme),@(FWMaterialUse),@(FWPhotos),@(FWDevices),@(FWSignature), @(FWRecommendation), @(FWConditions)] containsObject:[NSNumber numberWithInteger:section]]){
        return 38;
    }
    else {
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == FWAppointmentDetails) {
        return 0;//detail
    } else {
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    [footer setBackgroundColor:[UIColor clearColor]];
    return footer;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == FWAppointmentDetails) {
        AppDetailCell *cell = (AppDetailCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.drivingDirectionAction = ^(NSInteger tag){
            [self showMapsSelectorActionSheet];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == FWLocationNote) {
        if (self.serviceLocaion.notes == nil || self.serviceLocaion.notes.length <= 0)
        {
            return [self getNoItemCell:@"None provided"];
        }
        AppServiceCell *cell = (AppServiceCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == FWTimeSelection) {
        AppTimeCell *cell = (AppTimeCell*) [self createcellWithtableView:tableView andIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == FWLineItem){
        UITableViewCell *cell = (UITableViewCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == FWServiceInstruction){
        if (self.Appointment.instructions == nil || self.Appointment.instructions.length <= 0)
        {
            return [self getNoItemCell:@"No Instructions added."];
        }
        AppServiceCell *cell = (AppServiceCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == FWPDFForms){
        if((!_pdf_forms)||(_pdf_forms.count == 0)||(!_pdf_forms.count))
        {
            return [self getNoItemCell:@"No pdf forms attached"];
        }
        AppPdfFormCell *cell = (AppPdfFormCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == FWNotes){
        AppNotesCell *cell = (AppNotesCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else
        if (indexPath.section == FWEnvironment){
            if (((self.Appointment.temperature == nil )|| (self.Appointment.temperature.length <= 0)|| ([self.Appointment.temperature isEqualToString:@""]))&&
                ((self.Appointment.wind_speed == nil )|| (self.Appointment.wind_speed.length <= 0)|| ([self.Appointment.wind_speed isEqualToString:@""]))&&
                ((self.Appointment.wind_direction == nil) || (self.Appointment.wind_direction.length <= 0)|| ([self.Appointment.wind_direction isEqualToString:@""]))&&
                 ((self.Appointment.square_feet == nil )|| (self.Appointment.square_feet.length <= 0)|| ([self.Appointment.square_feet isEqualToString:@""]))) {
                    return [self getNoItemCell:@"No Weather Conditions added."];
            }
            AppWeatherTableViewCell *cell = (AppWeatherTableViewCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    } else if (indexPath.section == FWMaterialUse){
        if ([[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects].count == 0)
        {
            return [self getNoItemCell:@"No Material Usage added."];
        }
        AppChemicalCell *cell = (AppChemicalCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if (indexPath.section == FWPhotos){
        NSArray *photos = [PhotoAttachment getPhotosWithAppointmentId:self.Appointment.entity_id];
        photos = [photos filteredArrayUsingPredicate:NON_DELETED_PREDECATE()];
        if (photos.count == 0)
        {
            return [self getNoItemCell:@"No photos added."];
        }
        AppPhotoCell *cell = (AppPhotoCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
         NSLog(@"Photos Count- %lu",(unsigned long)self.Appointment.photo_attachments.count);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak __typeof(self) weakSelf = self;
        [cell setPhotos:photos.mutableCopy withDeleteBlock:^(PhotoAttachment *photo) {
            [weakSelf deletePhoto:photo];
        } andUpdateBlock:^(PhotoAttachment *photo) {
            AddPictureViewController * controller = [AddPictureViewController initViewController:photo Appointment:self.Appointment];
            [weakSelf.navigationController pushViewController:controller animated:YES];
        }];
        [cell fillCollectionView];
        return cell;
    }else if (indexPath.section == FWDevices){
        AppDevicesCell *cell = (AppDevicesCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDelegate:self];
        return cell;
        
    }else if (indexPath.section == FWSignature){
        AppSignatureCell *cell = (AppSignatureCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == FWScheme){
        if (self.stages) {
            if (self.stages.count>0) {
                UITableViewCell *cell = (UITableViewCell *)[self createcellWithtableView:tableView andIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else{
                return [self getNoItemCell:@"No scheme added."];
            }
        }else{
            return [self getNoItemCell:@"No scheme added."];
        }

    } else if (indexPath.section == FWRecommendation) {
            if (((NSArray*)self.Appointment.recommendation_ids).count == 0)
            {
                return [self getNoItemCell:@"No recommendation added."];
            }
        UITableViewCell *cell = [self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == FWConditions) {
        if (((NSArray*)self.Appointment.appointment_condition_ids).count == 0)
        {
            return [self getNoItemCell:@"No conditions added."];
        }
        UITableViewCell *cell = [self createcellWithtableView:tableView andIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}


-(id)createcellWithtableView:(UITableView *)tableView andIndexPath:(NSIndexPath *)indexpath{
    
    if (indexpath.section == FWAppointmentDetails) {
        static NSString *identifier = @"DetailIdentifier";
        AppDetailCell *cell = (AppDetailCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppDetailCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppDetailCell*) appcell;
                }
            }
        }
        cell.hideCustomerInfo=_hideCustomerInfo;

        [cell setDataWithAppointment:self.Appointment];
        [cell.btnMore setAction:kUIButtonBlockTouchUpInside withBlock:^{
            if (!_hideCustomerInfo) {
                ServiceLocationDetailViewController *det=[ServiceLocationDetailViewController viewControllerWithServiceLocation:_serviceLocaion];
                [self.navigationController pushViewController:det animated:YES];
            }
            else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                               message:@"You do not have access to customers"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:nil];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            
        }];
        [cell.btnEmail setAction:kUIButtonBlockTouchUpInside withBlock:^{
            if ([cell.btnEmail.titleLabel.text length]) {
                [self displayMailComposerSheetWithString:cell.btnEmail.titleLabel.text filePath:NO];
            }
        }];
        [cell.btnStartAtTime setAction:kUIButtonBlockTouchUpInside withBlock:^{
            if(self.Appointment.started_at_time == nil){
                NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
                [timeFormatter setDateFormat:@"hh:mm a"];
                NSString *time = [NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:[NSDate date]]];
                self.Appointment.started_at_time = [Utils getMilitaryTime:time];//time;
                cell.lblStartsAtTime.text =  time;
            }else{
                 [self openTimePickerWithTag:START_TIME andTitle:@"Start Time"];
            }
        }];
        [cell.btnEndsAtTime setAction:kUIButtonBlockTouchUpInside withBlock:^{
            if (self.Appointment.finished_at_time == nil) {
                NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
                [timeFormatter setDateFormat:@"hh:mm a"];
                NSString *time = [NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:[NSDate date]]];
                self.Appointment.finished_at_time = [Utils getMilitaryTime:time];//time;
                cell.lblEndsAtTime.text =  time;
            }else{
                 [self openTimePickerWithTag:END_TIME andTitle:@"End Time"];
            }
        }];
        return cell;
    } else if (indexpath.section == FWTimeSelection) {
        static NSString *identifier = @"AppTimeCelldentifier";
        AppTimeCell *cell = (AppTimeCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppTimeCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppTimeCell*) appcell;
                }
            }
        }
        [cell setAppointmentData:self.Appointment andButtonClickBlock:^(BOOL isStartTimeClicked) {
            if (isStartTimeClicked) {
                // Start Time
                [self openTimePickerWithTag:START_TIME andTitle:@"Start Time"];
            } else {
                // End Time
                [self openTimePickerWithTag:END_TIME andTitle:@"End Time"];
            }
        }];
        return cell;
    } else if (indexpath.section == FWEnvironment) {
//        static NSString *identifier = @"AppWeatherCelldentifier";
        AppWeatherTableViewCell *cell = (AppWeatherTableViewCell*)  [tableView dequeueReusableCellWithIdentifier:@"AppWeatherCellIdentifier"];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppWeatherTableViewCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppWeatherTableViewCell*) appcell;
                }
            }
        }
        [cell initializeWithTemperature:self.Appointment.temperature windDirection:self.Appointment.wind_direction  windSpeed:self.Appointment.wind_speed andSqFeet:self.Appointment.square_feet];
        return cell;

    } else if (indexpath.section == FWLineItem) {
        if (![self.Appointment.auto_generates_invoice boolValue]) {
            if(indexpath.row == 0){
                [_lblBalanceForward setText:[Utils getCurrencyStringFromAmount:[self.Appointment.balance_forward floatValue]]];
                return _lineItemBalanceForwardCell;
            }
            if (indexpath.row == 1) {
                return _notInvoiced;
            }
            if(indexpath.row == 2){
                return _lineItemFirstRowNoPayment;
            }
            else{
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
                LineItem *line_item = [[[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:(indexpath.row - 3)];
                [cell setLineItem:line_item forWorkOrder:self.Appointment];
                return cell;
            }
        }
        else{

        if ([self.Appointment.hide_invoice_information boolValue]) {
            if(indexpath.row == 0){
                if (![self.Appointment.auto_generates_invoice boolValue]) {
                    return _lineItemFirstRowNoPayment;
                }
                else{
                    return _lineItemFirstRow;
                }
            } else if(indexpath.row == 1){
                return _notInvoiced;
            }
            else if (indexpath.row == [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count] + 2){
                __weak typeof(self) weakSelf = self;
                
                LineItemFooterCell *cell = nil;//(AppLineItemCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
                if (cell == nil)
                {
                    NSArray *topLevelObject;
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
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
               
                cell.contentMode = UIViewContentModeRedraw;
                [cell setDataWithAppointment:self.Appointment withPayNowBlock:^{
                    PaymentViewController *controller=[PaymentViewController initViewControllerWithAppointment:weakSelf.Appointment];
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                } isWorkPool:NO];
                
                cell.discountValueChangedBlock = ^Appointment*(float discount)
                {
                    NSLog(@"%02f", discount);
                    if (self.Appointment.invoice == nil) {
                        
                        Invoice *invoice = [Invoice invoiceWithAppointment:weakSelf.Appointment];
                        [weakSelf.Appointment setInvoice:invoice];
                    }
//                    [weakSelf calculateLineItems];
                    [weakSelf.Appointment.invoice setDiscount:[NSNumber numberWithFloat:discount]];
                    [weakSelf.Appointment.invoice setDiscount_amount:self.Appointment.discount_amount];
                    [weakSelf.Appointment calculateTaxAmount];
                    
                    return weakSelf.Appointment;
                };
                if ([self.Appointment.hide_invoice_information boolValue]) {
                    [cell hidePayNowButton];
                    [cell hideLineItem];
                }
                
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
                LineItem *line_item = [[[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:(indexpath.row - 1)];
                [cell setLineItem:line_item forWorkOrder:self.Appointment];
                if ([self.Appointment.hide_invoice_information boolValue]) {
                    [cell hideLineItemContents];
                }
                return cell;
            }
        }
        
        else{
                if(indexpath.row == 0){
                     [_lblBalanceForward setText:[Utils getCurrencyStringFromAmount:[self.Appointment.balance_forward floatValue]]];
                     return _lineItemBalanceForwardCell;
                 }
                 if(indexpath.row == 1){
                     return _lineItemFirstRow;
                 } else if (indexpath.row == [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count] + 2){
                     __weak typeof(self) weakSelf = self;
                     
                     LineItemFooterCell *cell = nil;//(AppLineItemCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
                     if (cell == nil)
                     {
                         NSArray *topLevelObject;
                         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
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
                     
                     cell.contentMode = UIViewContentModeRedraw;
                     [cell setDataWithAppointment:self.Appointment withPayNowBlock:^{
                         PaymentViewController *controller=[PaymentViewController initViewControllerWithAppointment:weakSelf.Appointment];
                         [weakSelf.navigationController pushViewController:controller animated:YES];
                     } isWorkPool:NO];
                     
                     cell.discountValueChangedBlock = ^Appointment*(float discount)
                     {
                         NSLog(@"%02f", discount);
                         if (self.Appointment.invoice == nil) {
                             
                             Invoice *invoice = [Invoice invoiceWithAppointment:weakSelf.Appointment];
                             [weakSelf.Appointment setInvoice:invoice];
                         }
                         [weakSelf.Appointment.invoice setDiscount:[NSNumber numberWithFloat:discount]];
                         [weakSelf.Appointment setDiscount:[NSNumber numberWithFloat:discount]];
                         [weakSelf.Appointment.invoice setDiscount_amount:self.Appointment.discount_amount];
                         [weakSelf.Appointment calculateTaxAmount];
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
                     LineItem *line_item = [[[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:(indexpath.row - 2)];
                     [cell setLineItem:line_item forWorkOrder:self.Appointment];
                     return cell;
                 }
                 
             }
        }
    }


    if (indexpath.section == FWLocationNote) // LocationNote
    {
        static NSString *identifier = @"ServiceIdentifier";
        AppServiceCell *cell = (AppServiceCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppServiceCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppServiceCell*) appcell;
                }
            }
        }
        NSString *text = self.serviceLocaion.notes;
        [cell setServiceInstructionsText:text];
        return cell;
    }
    else if (indexpath.section == FWServiceInstruction) // LocationNote
    {
        static NSString *identifier = @"ServiceIdentifier";
        AppServiceCell *cell = (AppServiceCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppServiceCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppServiceCell*) appcell;
                }
            }
        }
        NSString *text = self.Appointment.instructions;
        [cell setServiceInstructionsText:text];
        return cell;
    }
    else
        if (indexpath.section == FWPDFForms) // PDFForm
    {
        static NSString *identifier = @"PdfIdentifier";
        AppPdfFormCell *cell = (AppPdfFormCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppPdfFormCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppPdfFormCell*) appcell;
                }
            }
        }
        [cell setPdfForm:[_pdf_forms objectAtIndex:indexpath.row]];
        return cell;
        
    }else if (indexpath.section == FWNotes){
        static NSString *identifier = @"NotesIdentifier";
        AppNotesCell *cell = (AppNotesCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppNotesCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppNotesCell*) appcell;
                }
            }
        }
        [cell setNotes:self.Appointment];
        __weak typeof(self) weakSelf = self;
        [cell setPublicNoteTouchBlock:^{
            NSLog(@"Public Note Clocked");
            EnterNoteController *note_controller = [EnterNoteController viewControllerWithExistingText:weakSelf.Appointment.notes placeholder:@"Report Findings - Notes" title:@"Notes" returnBlock:^(BOOL save_clicked, NSString *text_entered) {
                if (save_clicked){
                    [weakSelf.Appointment setNotes:text_entered];
                    [weakSelf.tableView reloadData];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
            }];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:note_controller];
            [weakSelf.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
        }];
        [cell setPrivateNoteTouchBlock:^{
            NSLog(@"Private Note Clocked");
            EnterNoteController *note_controller = [EnterNoteController viewControllerWithExistingText:weakSelf.Appointment.private_notes placeholder:@"Private Note" title:@"Private Note" returnBlock:^(BOOL save_clicked, NSString *text_entered) {
                if (save_clicked){
                    [weakSelf.Appointment setPrivate_notes:text_entered];
                    [weakSelf.tableView reloadData];
                    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
                }
            }];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:note_controller];
            [weakSelf.navigationController presentViewController:nav animated:YES completion:^{
                
            }];
        }];
        
        return cell;
    }else if (indexpath.section == FWMaterialUse){
        static NSString *identifier = @"ChemicalIdentifier";
        AppChemicalCell *cell = (AppChemicalCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppChemicalCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppChemicalCell*) appcell;
                }
            }
        }
        NSArray *materials = [[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects];
        if (indexpath.row < materials.count) {
            [cell setMaterialUsage:[[[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:indexpath.row]];
        }
        
        return cell;

    }
    else if (indexpath.section == FWPhotos){
        static NSString *identifier = @"PhotoIdentifier";
        AppPhotoCell *cell = (AppPhotoCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppPhotoCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppPhotoCell*) appcell;
                }
            }
        }
        return cell;
    }else if (indexpath.section == FWDevices){
        static NSString *identifier = @"DeviceIdentifier";
        AppDevicesCell *cell = (AppDevicesCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppDevicesCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppDevicesCell*) appcell;
                }
            }
        }
        [cell setDevicesForAppointmet:self.Appointment serviceLocation:self.serviceLocaion];
        return cell;
    }else if (indexpath.section == FWScheme) // Scheme
    {
        static NSString *identifier = @"BuildingCell";
        UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (self.stages) {
            StageModel* stage= [self.stages objectAtIndex:indexpath.row];
            NSString* cellTitle =stage.floor;
            [cell.textLabel setText:cellTitle];
        }
        return cell;
    }
    else if (indexpath.section == FWSignature){
        static NSString *identifier = @"SignatureIdentifier";
        AppSignatureCell *cell = (AppSignatureCell*) [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil)
        {
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppSignatureCell" owner:self options:nil];
            for(id appcell in topLevelObject)
            {
                if([appcell isKindOfClass:[UITableViewCell class]])
                {
                    cell = (AppSignatureCell*) appcell;
                }
            }
        }
        [cell setSignature:self.Appointment];
        __weak typeof(self) weakSelf = self;
        [cell setCustomerSignatureTouchBlock:^{
            CaptureSignatureController *signature = [CaptureSignatureController viewControllerWithAppointment:weakSelf.Appointment withCaptureMode:CustomerMode andBlock:^{
                [weakSelf.tableView reloadData];
            }];
            [weakSelf.navigationController pushViewController:signature animated:YES];
        }];
        
        [cell setTechnicianSignatureTouchBlock:^{
            CaptureSignatureController *signature = [CaptureSignatureController viewControllerWithAppointment:weakSelf.Appointment withCaptureMode:TechnicianMode andBlock:^{
                [weakSelf.tableView reloadData];
            }];
            [weakSelf.navigationController pushViewController:signature animated:YES];
        }];
        
        return cell;
    } else if (indexpath.section == FWRecommendation) {
        static NSString *identifier = @"FWRecommendationIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSNumber *rec_id = [(NSArray*)self.Appointment.recommendation_ids objectAtIndex:indexpath.row];
        Recommendations *rec = [Recommendations recommendationById:rec_id];
        if (rec) {
            [cell.textLabel setText:rec.name];
        }
        return cell;
    } else if (indexpath.section == FWConditions) {
        static NSString *identifier = @"FWConditionsIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSNumber *rec_id = [(NSArray*)self.Appointment.appointment_condition_ids objectAtIndex:indexpath.row];
        Conditions *con = [Conditions conditionById:rec_id];
        if (con) {
            [cell.textLabel setText:con.name];
        }
        return cell;
    }
    return nil;
}

- (void) calculateLineItems
{
    float Total =0.0;
    float discount = [self.Appointment.discount floatValue];
    [self.Appointment setDiscount:[NSNumber numberWithFloat:discount]];
    TaxRates *tr = [TaxRates getTaxRatesById:_serviceLocaion.tax_rate_id];
    for (LineItem * info in self.Appointment.line_items) {
        float p = [info.total floatValue];
        Total = Total + p;
    }
    float tax = Total * [tr.rate floatValue];
    [self.Appointment setTax_amount:[NSNumber numberWithFloat:tax]];
    [self.Appointment.invoice setTax_amount:[NSNumber numberWithFloat:tax]];
    
}


-(void)addFloor{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add diagram?"
                                                                   message:@"Set name"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *  textField) {
        [textField setPlaceholder:@"name"];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         NSString* floor=[alert.textFields objectAtIndex:0].text;
                                                         if (floor.length==0){
                                                             NSString* message;
                                                             if (floor.length==0) {
                                                                 message=@"Set name";
                                                             }
                                                             UIAlertController *innerAlert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                                                 message:message
                                                                                                                          preferredStyle:UIAlertControllerStyleAlert];
                                                             UIAlertAction *innerCancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                                                         style:UIAlertActionStyleDefault
                                                                                                                       handler:nil];
                                                             [innerAlert addAction:innerCancelAction];
                                                             [self presentViewController:innerAlert animated:YES completion:nil];
                                                         }
                                                         else{
                                                             SchemeDrawerControllerViewController *drawerController = [[SchemeDrawerControllerViewController alloc] initWithNibName:@"SchemeDrawerControllerViewController" bundle:nil];
                                                             drawerController.stageTitle=floor;
                                                             drawerController.serviceLocationId=self.Appointment.service_location_id;
                                                             drawerController.newScheme=YES;
                                                             drawerController.block=^(){
                                                                 NSIndexSet* set=[NSIndexSet indexSetWithIndex:FWScheme];
                                                                 [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                                                             };
                                                             [self.navigationController pushViewController:drawerController animated:YES];
                                                         }
                                                     }];
    [alert addAction:okAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}

- (UITableViewCell*) getNoItemCell:(NSString*)msg
{
    NSString *CellIdentifier = msg;
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = msg;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row=indexPath.row;
    if (indexPath.section == FWLineItem){
        if (indexPath.row < 2 || indexPath.row > [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count] + 1) {
            return;
        }
        LineItem *info = [[[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:(indexPath.row - 2)];
        AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerNewWorkOrderAppointment:self.Appointment andLineItem:info Delegate:self];
        [self.navigationController pushViewController:addLineItem animated:YES];
    } else if (indexPath.section == FWMaterialUse) {
        if ([self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()].count <= 0) {
            MaterialListController *ml = [MaterialListController viewControllerWithAppointment:self.Appointment];
            ml.materialUsagedAddedBlock = ^{
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:ml animated:YES];
        } else {
            MaterialUsage *mur = [[[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects] objectAtIndex:indexPath.row];
            MaterialUsageRecordController *murController = [MaterialUsageRecordController viewControllerWithAppointment:self.Appointment andMaterialUsage:mur];
            [self.navigationController pushViewController:murController animated:YES];
        }
    } else if (indexPath.section == FWPhotos) {
        return;
    } else if (indexPath.section == FWPDFForms) {
        if((_pdf_forms)&&(_pdf_forms.count != 0))
        {
            [self pdfDialogForRowAtIndexPath:indexPath];
        }
    } else if (indexPath.section == FWRecommendation) {
        _recommendationBlock();
    } else if (indexPath.section == FWConditions) {
        _conditionsBlock();
    } else if (indexPath.section == FWEnvironment) {
        if ((self.Appointment.temperature != nil || self.Appointment.temperature.length > 0)&&
            (self.Appointment.wind_speed != nil || self.Appointment.wind_speed.length > 0)&&
            (self.Appointment.wind_direction != nil || self.Appointment.wind_direction.length > 0)&&
            (self.Appointment.square_feet != nil || self.Appointment.square_feet.length > 0)) {
                if (_environmentBlock) {
                    _environmentBlock();
                }
        }
    }
    else if(indexPath.section == FWScheme){
        if ((self.stages)&&(self.stages.count>0)) {
            StageModel* stage= [self.stages objectAtIndex:row];
            SchemeDrawerControllerViewController *drawerController = [[SchemeDrawerControllerViewController alloc] initWithNibName:@"SchemeDrawerControllerViewController" bundle:nil];
            [drawerController setStageModel:stage];
            drawerController.serviceLocationId=self.Appointment.service_location_id;
            drawerController.newScheme=NO;
            drawerController.block=^(){
                NSIndexSet* indexSet=[NSIndexSet indexSetWithIndex:FWScheme];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:drawerController animated:YES];
        }
        else{
            [self addFloor];
        }
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == FWLineItem) {
            // Line Item
            NSArray *line_items = [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects];
            if (line_items.count <= 1) {
                [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"You can not delete last line item." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                return;
            } else {
                [self.tableView reloadData];
            }
            NSLog(@"row = %ld", (long)indexPath.row);
                // TableView First Row is Line Item Title
            LineItem *info = [line_items objectAtIndex:indexPath.row - 2];
            if (info.entity_idValue < 0) {
                [self.Appointment.line_itemsSet removeObject:info];
                [info MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                [info saveLineItem];
            }else{
                [info setEntity_status:c_DELETED];
                [info saveLineItem];
            }
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.Appointment calculateTaxAmount];
            [self.Appointment saveAppointmentOnLocal];
            [tableView reloadData];
        } else if (indexPath.section == FWMaterialUse) {
            // Material Usages
            MaterialUsage *material_usage = [[[self.Appointment.material_usages filteredSetUsingPredicate:NON_DELETED_PREDECATE()]  allObjects] objectAtIndex:indexPath.row];
            if (material_usage.entity_idValue < 0) {
                [self.Appointment.material_usagesSet removeObject:material_usage];
                [material_usage MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                [material_usage saveMaterialUsage];
            }else {
                [material_usage setEntity_status:c_DELETED];
                [material_usage saveMaterialUsage];
            }
            NSLog(@"Row %ld",(long)indexPath.row);
           // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView reloadData];
        } else if (indexPath.section == FWScheme) {
            // Stages
            if (_stages.count>0) {
                StageModel *stage = [_stages objectAtIndex:indexPath.row];

                UIAlertController *alertDelete = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Do you want to delete diagram %@?",stage.floor]
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okDeleteAction = [UIAlertAction actionWithTitle:@"OK"
                                                                         style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction *action) {
                                                                           NSFileManager *fileManager = [NSFileManager defaultManager];
                                                                           NSError *error;
                                                                           NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                                                                           NSString *documentsDirectory = [paths objectAtIndex:0];
                                                                           NSString* filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, stage.filePath];
                                                                           [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@",filePath] error:&error];
                                                                           [self deleteStage:stage completion:^(BOOL contextDidSave, NSError *  error) {
                                                                               [self loadStages];
                                                                           }];
                                                                       }];
                [alertDelete addAction:okDeleteAction];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"CANCEL"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:nil];
                [alertDelete addAction:cancelAction];
                [self presentViewController:alertDelete animated:YES completion:nil];
            }
        }
    }
}
-(void)deleteStage:(StageModel*) stageModel completion:(MRSaveCompletionHandler) completion{
    [stageModel setDeleted:@(YES)];
    [stageModel.managedObjectContext MR_saveWithBlock:^(NSManagedObjectContext * localContext) {
        
    } completion:completion];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([@[@(FWLineItem),@(FWMaterialUse),@(FWScheme)] containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
        if ([@[@(FWLineItem)] containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == [[self.Appointment.line_items filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count] + 2) {
                return NO;
            }
        }
        return YES;
        [self.tableView reloadData];
    }
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    // :: adding code to avoid deleting "No Materials Used" label
    if (indexPath.section == FWLineItem) {
        if (self.Appointment.line_itemsSet.count > 0) {
            return UITableViewCellEditingStyleDelete;
        } else {
            return UITableViewCellEditingStyleNone;
        }
    } else if (indexPath.section == FWMaterialUse) {
        if (self.Appointment.material_usagesSet.count > 0) {
            return UITableViewCellEditingStyleDelete;
        } else {
            return UITableViewCellEditingStyleNone;
        }
    }else if (indexPath.section == FWScheme) {
        if (self.stages.count > 0) {
            return UITableViewCellEditingStyleDelete;
        } else {
            return UITableViewCellEditingStyleNone;
        }
    }
    return UITableViewCellEditingStyleNone;
}

- (void) deletePhoto:(PhotoAttachment*) photo
{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Photos"
                                          message:@"Are you sure want to delete?"
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"No", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                   }];
    [alertController addAction:cancelAction];
    __weak __typeof(self) weakSelf = self;
    
    [alertController addAction:[UIAlertAction
                                actionWithTitle:@"Yes"
                                style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction *action)
                                {
                                    if ([photo.entity_status isEqualToNumber:c_ADDED]) {
                                        [weakSelf.Appointment.photo_attachmentsSet removeObject:photo];
                                        [photo MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                                    }else{
                                        [photo setEntity_status:c_DELETED];
                                        [photo setSync_status:c_UNCHANGED];
                                    }
                                    [photo clearImages];
                                    [photo savePhoto];
                                    [weakSelf.tableView reloadData];
                                }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - Image Picker

-(void)appPhotoOpenImagePicker{
    UIAlertController *alertController;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        alertController = [UIAlertController
                           alertControllerWithTitle:@"Photos"
                           message:@"Add Photo"
                           preferredStyle:UIAlertControllerStyleAlert];
    }else{
        alertController = [UIAlertController
                           alertControllerWithTitle:@"Photos"
                           message:@"Add Photo"
                           preferredStyle:UIAlertControllerStyleActionSheet];
    }

    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel action");
                                       [alertController dismissViewControllerAnimated:YES completion:^{
                                           
                                       }];
                                   }];
    [alertController addAction:cancelAction];
    
    [alertController addAction:[UIAlertAction
                                    actionWithTitle:@"From Camera"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction *action)
                                    {
                                        NSLog(@"From Camera action");
                                        UIImagePickerController *imagePC = [UIImagePickerController new];
                                        
                                        imagePC.delegate = self;
                                        
                                        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                        {
                                            return;
                                        }
                                        
                                        imagePC.sourceType = UIImagePickerControllerSourceTypeCamera;
                                        
                                        [self presentViewController:imagePC animated:YES completion:nil];
                                    }]];
    
    [alertController addAction:[UIAlertAction
                                actionWithTitle:@"Existing photo"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                {
                                    NSLog(@"Existing photo action");
                                    UIImagePickerController *imagePC = [UIImagePickerController new];
                                    
                                    imagePC.delegate = self;
                                    
                                    
                                    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
                                    {
                                        return;
                                    }
                                    
                                    imagePC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                    
                                    [self presentViewController:imagePC animated:YES completion:nil];
                                }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark -AppDeveiceDelegate
-(void)scanForDevice{
    [self presentViewController:reader animated:YES completion:^{
        
    }];
}

-(void)viewAllDevices{
    TrapListController *trap_list = [TrapListController initWithAppointment:self.Appointment];
    [self.navigationController pushViewController:trap_list animated:YES];
}

-(void)playBeep
{
    NSString *path = [NSString
                      stringWithFormat:@"%@%@",
                      [[NSBundle mainBundle] resourcePath],
                      @"/barcodeBeep.wav"];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

#pragma mark -UIImagePickerControllerDelegate

- (void) imagePickerController: (UIImagePickerController*)picker didFinishPickingMediaWithInfo: (NSDictionary*) info{
    if ([picker isKindOfClass:[ZBarReaderViewController class]]) {
        id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
        
        NSString * barcode_data = @"";
        
        for(ZBarSymbol *symbol in results)
        {
            
            barcode_data = symbol.data;
            
            
            [self playBeep];
        }
        //resultImage.image = [info objectForKey: UIImagePickerControllerOriginalImage];
        [reader dismissViewControllerAnimated:reader completion:^{
        }];
        CustomerDevice *device = [CustomerDevice deviceByBarcode:barcode_data andService_location:[self.Appointment.service_location_id intValue]];
        if (device == nil) {
            device = [CustomerDevice newDeviceForCustomer:self.Appointment.customer_id forServiceLocaiton:self.Appointment.service_location_id];
            [device setBarcode:barcode_data];
            TrapAddController * trapadd = [TrapAddController initWithAppointment:self.Appointment withCustomerTrap:device];
            [self.navigationController pushViewController:trapadd animated:YES];
        } else {
            NSSet *temp = [self.Appointment.inspection_records filteredSetUsingPredicate:[NSPredicate predicateWithFormat:@"barcode == %@", barcode_data]];
            if ([temp allObjects].count > 0) {
                [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"That device has already been inspected." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                return;
            }
            TrapDetailView *detailView = [TrapDetailView initWithAppointment:self.Appointment withCustomerTrap:device WithBoolean:nil];
            [self.navigationController pushViewController:detailView animated:YES];
        }

    } else {
        UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
        AddPictureViewController * controller =[AddPictureViewController initViewController:self.Appointment andImage:image1];
        controller.photoAddedBlock = ^{
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:controller animated:YES];
        
        [picker dismissViewControllerAnimated:NO completion:nil];
    }
}


#pragma mark - NewWorkOrderDelegate

- (void)LineItemAdded:(LineItem *)item {
    if (item) {
        int editedIndex = -1;
        for (int i = 0; i < self.Appointment.line_items.count; i++) {
            LineItem *info = [[self.Appointment.line_items allObjects] objectAtIndex:i];
            if ([info.entity_id isEqualToNumber:item.entity_id]) {
                editedIndex = i;
                break;
            }
        }
        
        if (editedIndex >= 0) {
            if ([item.entity_id intValue] > 0 && ![item.entity_status isEqualToNumber:c_ADDED]) {
                [item setEntity_status:c_EDITED];
            }else{
            }
        }else{
            [self.Appointment.line_itemsSet addObject:item];
        }
        [item saveLineItem];
        [self.tableView reloadData];
        [self.Appointment calculateTaxAmount];
    }
}



#pragma mark - Document Open Code

- (void) openDocument:(NSString*) url
{
    
    
    NSURL * URL = [NSURL fileURLWithPath:url];
    
    if (URL) {
        // Initialize Document Interaction Controller
        _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        // Configure Document Interaction Controller
        [_documentInteractionController setDelegate:self];
        // Present Open In Menu
        [_documentInteractionController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];
    }

}

#pragma mark - Printing Code

- (void)printFile {
    
    NSString *filePath = [Appointment ServiceReportPath];
    
    if (![UserSetting getAirPrintOnOff]) {
        int64_t delay = 2.0; // In seconds
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^(void){
            [PrinterHelper Instance].printStatusUpdateBlock = ^(NSString *status) {
                if (status.length <= 0) {
                    [[ActivityIndicator currentIndicator] displayCompleted];
                }else{
                    [[ActivityIndicator currentIndicator] displayActivity:status];
                }
            };
            
            [[PrinterHelper Instance] printFile:filePath];
        });
    }else{
        
        UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
        
        NSURL *fileURL = [NSURL fileURLWithPath:filePath]; // Document file URL
        
        pic.delegate = self;
        
        if ([UIPrintInteractionController canPrintURL:fileURL] == YES)
        {
            UIPrintInfo *printInfo = [NSClassFromString(@"UIPrintInfo") printInfo];
            
            printInfo.duplex = UIPrintInfoDuplexLongEdge;
            printInfo.outputType = UIPrintInfoOutputGeneral;
            printInfo.jobName = @"PDF";
            
            pic.printInfo = printInfo;
            pic.printingItem = fileURL;
            pic.showsPageRange = YES;
            CGRect rect = self.view.bounds;
            
            if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
                [pic presentAnimated:YES completionHandler:nil];
            }else{
                rect  = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5,[UIScreen mainScreen].bounds.size.height * 0.6, 0, 0);
                [pic presentFromRect:rect
                              inView:self.view
                            animated:YES
                   completionHandler:nil];
            }
            
            
            if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [pic presentFromRect:self.view.frame
                              inView:self.view
                            animated:YES
                   completionHandler:nil];
                
            }
            
            if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                //[[KGModal sharedInstance]showWithContentViewController:pic];
            }
            
            
            [pic presentFromRect:self.view.frame inView:self.view animated:YES completionHandler:
             ^(UIPrintInteractionController *pic, BOOL completed, NSError *error)
             {
#ifdef DEBUG
                 if ((completed == NO) && (error != nil)) NSLog(@"%s %@", __FUNCTION__, error);
#endif
             }
             ];
        }
    }
}

-(void)longTimerExpired:(GameTimer *)gameTimer{

}


-(void)shortTimerExpired:(GameTimer *)gameTimer time:(float)time longInterval:(float)longInterval{
    BOOL isDirtyAppointmentsFound = [[AppointmentManager Instance] scanForDirtyAppointments];
    if (isDirtyAppointmentsFound) {
        
    }else{
        [self.gameTimer stopTimer];
        self.gameTimer = nil;
        [[AppointmentManager Instance] refreshAppointmentsWithBlock:^(id result, NSString *error) {
            if (![[ActivityIndicator currentIndicator] ishidden]) {
                [[ActivityIndicator currentIndicator] displayCompleted];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }
}

- (void)printInteractionControllerWillDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)printInteractionControllerDidDismissPrinterOptions:(UIPrintInteractionController *)printInteractionController{
    //[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Mail Composer

-(void)displayMailComposerSheetWithString:(NSString*)composerString filePath: (BOOL) filePath
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        // Fill out the email body text.
        [picker setSubject:@""];
        NSString *emailBody = @"";
        [picker setMessageBody:emailBody isHTML:YES];
        
        // attach report
        BOOL showNow = YES;
        if (filePath) {
            NSData *myData = [NSData dataWithContentsOfFile:composerString];
            if (myData) {
                [picker addAttachmentData:myData mimeType:@"application/pdf"
                                 fileName:@"ServiceReport.pdf"];
            }
            /*
            NSArray *forms = [self.Appointment.pdf_forms allObjects];
            __block NSInteger counter = 0;
            for (PDFForm *form in forms) {
                    NSData *myData = [NSData dataWithContentsOfFile:[form pdfFilePath]];
                    if (myData) {
                        [picker addAttachmentData:myData mimeType:form.document_content_type
                                         fileName:form.document_file_name];
                    } else {
                        showNow = NO;
                        counter++;
                        [[ActivityIndicator currentIndicator] displayActivity:@"Downloading..."];
                        [form downloadWithCompletionBlock:^(FWRequest *request) {
                            counter--;
                            NSData *myData = [NSData dataWithContentsOfFile:[form pdfFilePath]];
                            if (myData) {
                                [picker addAttachmentData:myData mimeType:form.document_content_type
                                                 fileName:form.document_file_name];
                            }
                            if (counter==0) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [[ActivityIndicator currentIndicator] displayCompleted];
                                    [self.navigationController presentViewController:picker animated:YES completion:nil];
                                });
                            }
                        }];
                    }
                
            }
            */
            
            // attach pdf forms or attachments
            NSArray *forms = _pdf_forms;
            __block NSInteger counter = 0;
            for (PDFForm *form in forms) {
                PDFAttachment *att = [form getRelatedAttachment];
                NSString *doc_path = @"";
                BOOL isAttachmentFound = att!=nil;
                if (isAttachmentFound) {
                    doc_path = [att pdfFilePath];
                } else {
                    doc_path = [form pdfFilePath];
                }
                if (doc_path.length > 0) {
                    NSData *myData = [NSData dataWithContentsOfFile:doc_path];
                    if (myData) {
                        [picker addAttachmentData:myData
                                         mimeType:form.document_content_type
                                         fileName:[NSString stringWithFormat:@"(%@)%@", form.name, form.document_file_name]];
                    } else {
                        showNow = NO;
                        counter++;
                        [[ActivityIndicator currentIndicator] displayActivity:@"Downloading..."];
                        if (isAttachmentFound) {
                            [att downloadWithCompletionBlock:^(FWRequest *request) {
                                counter--;
                                NSData *myData = [NSData dataWithContentsOfFile:doc_path];
                                if (myData) {
                                    [picker addAttachmentData:myData
                                                     mimeType:att.attachment_content_type
                                                     fileName:[NSString stringWithFormat:@"(%@)%@", form.name, form.document_file_name]];
                                }
                                if (counter==0) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[ActivityIndicator currentIndicator] displayCompleted];
                                        [self.navigationController presentViewController:picker animated:YES completion:nil];
                                    });
                                }
                            }];

                        } else {
                            [form downloadWithCompletionBlock:^(FWRequest *request) {
                                counter--;
                                NSData *myData = [NSData dataWithContentsOfFile:doc_path];
                                if (myData) {
                                    [picker addAttachmentData:myData
                                                     mimeType:form.document_content_type
                                                     fileName:[NSString stringWithFormat:@"(%@)%@", form.name, form.document_file_name]];
                                }
                                if (counter==0) {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [[ActivityIndicator currentIndicator] displayCompleted];
                                        [self.navigationController presentViewController:picker animated:YES completion:nil];
                                    });
                                }
                            }];

                        }
                        
                    }
                }
            }
        } else {
            NSArray *toRecipients = [NSArray arrayWithObject:composerString];
            
            [picker setSubject:@"Hello"];
            [picker setToRecipients:toRecipients];
            
            [picker setMessageBody: @"" isHTML:NO];
        }
        // Attach an image to the email.
        
        
        // Present the mail composition interface.
        if (showNow) {
            [self.navigationController presentViewController:picker animated:YES completion:nil];
        }
    }else {
        [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"Device does not support send mail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

// The mail compose view controller delegate method
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - Time Picker Code

- (void) openTimePickerWithTag:(int)tag andTitle:(NSString*)title
{
    [self.view endEditing:YES];
    
    _timerPicker = [[UIDatePicker alloc] init];
    [_timerPicker setDatePickerMode:UIDatePickerModeTime];
    
    NSDate *dt = [NSDate date];
    _timerPicker.date = dt;
    
    SamcomActionSheet_iPad * action = [SamcomActionSheet_iPad initIPadUIDatePickerWithTitle:title delegate:self doneButtonTitle:@"Done" cancelButtonTitle:@"Cancel" DatepickerView:_timerPicker inView:self.view withCustomDate:nil];
    
    action.tag = tag;
    action.isViewOpen= YES;
    [action showDatePicker];
}
#pragma mark -SamcomActionSheetDelegate
- (void)actionSheetDoneClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm a"];
    if (actionSheet.tag == START_TIME) {
        NSString *time = [NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:_timerPicker.date]];
        self.Appointment.started_at_time = [Utils getMilitaryTime:time];
    }else if (actionSheet.tag== END_TIME){
        NSString *time = [NSString stringWithFormat:@"%@",[timeFormatter stringFromDate:_timerPicker.date]];
        self.Appointment.finished_at_time = [Utils getMilitaryTime:time];
    }
    [self.tableView reloadData];
    [self.view endEditing:YES];
}
- (void)actionSheetCancelClickedWithActionSheet:(SamcomActionSheet *)actionSheet {
    
    [self.view endEditing:YES];
}

@end
