//
//  EstimateViewController.m
//  FieldWork
//
//  Created by Alexander on 20.03.17.
//
//

#import "EstimateViewController.h"
#import "EstimateStatusTableViewCell.h"
#import "EstimateCustomerTableViewCell.h"
#import "HeaderView.h"
#import "LineItem.h"
#import "AppLineItemCell.h"
#import "Utils.h"
#import "AppPdfFormCell.h"
#import "LineItemFooterCell.h"
#import "PDFFieldsEditorViewController.h"
#import "AppPhotoCell.h"
#import "AddPictureViewController.h"
#import "PhotoAttachment.h"
#import "TrapAddController.h"
#import "SchemeDrawerControllerViewController.h"
#import "StageModel.h"
#import "NSDictionary+Extension.h"
#import "SyncManager.h"
#import <AVFoundation/AVFoundation.h>
#import "NewAppointmentViewController.h"

@interface EstimateViewController ()<UIDocumentInteractionControllerDelegate,NewWorkOrderDelegate>
@property (weak, nonatomic) IBOutlet UIExpandableTableView *tableView;
@property (strong, nonatomic) Estimate *estimate;
// LineItem Balance ForwardCell
@property (weak, nonatomic) IBOutlet UITableViewCell *notInvoiced;
@property (weak, nonatomic) IBOutlet UITableViewCell *lineItemBalanceForwardCell;
@property (weak, nonatomic) IBOutlet UILabel *lblBalanceForward;
@property (weak, nonatomic) IBOutlet EstimateStatusTableViewCell* statusCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *lineItemFirstRow;
@property (strong, nonatomic) IBOutlet UITableViewCell *headerView;
@property (strong,nonatomic) NSArray* pdf_attachments;
@property (strong,nonatomic) ServiceLocation* serviceLocation;
@property (strong,nonatomic) NSArray* stages;
@property (strong,nonatomic) NSMutableArray* lineItems;
@property (weak, nonatomic) IBOutlet UITableViewCell *lineItemFirstRowNoPayment;
@property (weak, nonatomic) IBOutlet EstimateCustomerTableViewCell* customerCell;
@property (strong,nonatomic) UIDocumentInteractionController* documentInteractionController;
//@property (weak, nonatomic) IBOutlet EstimateCustomerTableViewCell* addressCell;

@end

@implementation EstimateViewController

+(EstimateViewController *)initViewControllerEstimate:(Estimate*) estimate{
    
    EstimateViewController *controller = [[EstimateViewController alloc]initWithNibName:@"EstimateViewController" bundle:nil];
    controller.estimate=estimate;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[EstimateStatusTableViewCell self] forCellReuseIdentifier:@"EstimateStatusTableViewCell"];
    [self.tableView registerClass:[EstimateCustomerTableViewCell self] forCellReuseIdentifier:@"EstimateCustomerTableViewCell"];
     [self.tableView registerClass:[LineItemFooterCell self] forCellReuseIdentifier:@"LineItemFooterCell"];
    [self.tableView registerClass:[AppLineItemCell self] forCellReuseIdentifier:@"AppLineItemCell"];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveEstimate)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[self.navigationController.navigationBar tintColor]}];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AppLineItemCell" bundle:nil] forCellReuseIdentifier:@"AppLineItemCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LineItemFooterCell" bundle:nil] forCellReuseIdentifier:@"LineItemFooterCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"LineItemFooterCell_iPad" bundle:nil] forCellReuseIdentifier:@"LineItemFooterCell_iPad"];
    self.title=[NSString stringWithFormat:@"EST #%@",_estimate.estimate_number];
//    _estimate=[Estimate getById:_estimate.entity_id];
    _serviceLocation=[ServiceLocation getById:_estimate.service_location_id];
    _stages=[[_serviceLocation floors] array];
    _lineItems = [[[self.estimate.line_items filteredOrderedSetUsingPredicate:NON_DELETED_PREDECATE()] array] mutableCopy];

    _tableView.delegate=self;
    _tableView.dataSource=self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (HeaderView*) createHeaderViewForSection:(NSInteger)section withTitle:(NSString*)title andButtonBlock:(void(^)())block
{
    HeaderView *view;
    if (section == FWLineItemsSection) {
//        if (self.Appointment.invoice != nil) {
//            Payment *payment = [self.Appointment.invoice getMobilePayment];
//            if (payment != nil) {
//                view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title isPaid:YES];
//            }else{
//                view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title isPaid:NO];
//            }
//        }else{
            view = [[HeaderView alloc] initWithTableView:self.tableView andSection:section andTitle:title isPaid:NO];
//        }
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;

    if (indexPath.section==FWStatusSection) {

        [_statusCell setStatus:_estimate.status];
        _statusCell.statusChanged=^(){
            
                UITableViewRowActionStyle* style=UITableViewRowActionStyleNormal;
                style=UITableViewRowActionStyleNormal;
     
                    NSArray* statuses=@[@"Pending", @"Accepted", @"Declined"];
                    statuses = [statuses filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id object, NSDictionary *bindings) {
                        return ![object isEqualToString:_estimate.status];
                    }]];
                        if (statuses) {
                            UIAlertController * alertController = [UIAlertController
                                                                   alertControllerWithTitle:@"Change Status"
                                                                   message:nil
                                                                   preferredStyle:UIAlertControllerStyleAlert];
                            
                            UIAlertAction *cancelAction = [UIAlertAction
                                                           actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                                           style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction *action)
                                                           {
                                                               NSLog(@"Cancel action");
                                                               [alertController dismissViewControllerAnimated:YES completion:nil];
                                                           }];
                            [alertController addAction:cancelAction];
                            for (NSString* status in statuses) {
                                    UIAlertAction *statusAction = [UIAlertAction
                                                                   actionWithTitle:status
                                                                   style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction *action)
                                                                   {
                                                                       [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
                                                                       [_estimate setStatus:status];
                                                                       [_estimate saveEstimateOnServerWithBlock:^(BOOL is_saved, NSNumber *estimate_id) {
                                                                           [_estimate saveEstimateOnLocal];
                                                                           if (![[ActivityIndicator currentIndicator] ishidden]) {
                                                                               [[ActivityIndicator currentIndicator] displayCompleted];
                                                                           }
                                                                       }];
                                                                       [tableView endEditing:YES];
                                                                       [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                                                   }];
                                    [alertController addAction:statusAction];
                                }
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
            };
         return _statusCell;
    }
    if (indexPath.section==FWCustomerSection) {
        EstimateCustomerTableViewCell* cell=nil;
        if (cell == nil){
            NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"EstimateCustomerTableViewCell" owner:self options:nil];
            for(id appcell in topLevelObject){
                if([appcell isKindOfClass:[UITableViewCell class]]){
                    cell = (EstimateCustomerTableViewCell*) appcell;
                }
            }
        }
        [cell setEstimate:_estimate];
        if (indexPath.row==0) {
            [cell showCustomer];
        }
        if (indexPath.row==1) {
            [cell showServiceLocation];
        }
        return cell;
    }
    if (indexPath.section==FWLineItemsSection) {
            if(indexPath.row == 0){
                return _lineItemBalanceForwardCell;
            }
            else{
                if(indexPath.row == _lineItems.count+1){
                    LineItemFooterCell * cell = nil;
                    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
                        cell=[tableView dequeueReusableCellWithIdentifier:@"LineItemFooterCell_iPad"];
                    }
                    else{
                        cell=[tableView dequeueReusableCellWithIdentifier:@"LineItemFooterCell"];
                    }
                cell.contentMode = UIViewContentModeRedraw;
                [cell hidePayNowButton];
                [cell updateDataEstimate:_estimate];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//                cell.discountValueChangedBlock = ^Appointment*(float discount)
//                {
//                    NSLog(@"%02f", discount);
//                    if (self.Appointment.invoice == nil) {
//                        
//                        Invoice *invoice = [Invoice invoiceWithAppointment:weakSelf.Appointment];
//                        [weakSelf.Appointment setInvoice:invoice];
//                    }
//                    //                    [weakSelf calculateLineItems];
//                    [weakSelf.Appointment.invoice setDiscount:[NSNumber numberWithFloat:discount]];
//                    [weakSelf.Appointment.invoice setDiscount_amount:self.Appointment.discount_amount];
//                    [weakSelf.Appointment calculateTaxAmount];
//                    
//                    return weakSelf.Appointment;
//                };
//                if ([self.Appointment.hide_invoice_information boolValue]) {
//                    [cell hidePayNowButton];
//                    [cell hideLineItem];
//                }
                return cell;
            }
        else{
                AppLineItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AppLineItemCell"];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

                if (!cell) {
                    cell = [[AppLineItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AppLineItemCell"];
                }
                LineItem *line_item = [_lineItems objectAtIndex:(indexPath.row-1)];
                [cell setLineItem:line_item];
                return cell;
            }
        }
        
    }
    if (indexPath.section==FWPDFFormsSection) {
        if (self.estimate.pdf_forms.count>0) {
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
            FWPDFForm* form=[[_estimate.pdf_forms allObjects] objectAtIndex:indexPath.row];
            [cell setPdfForm:form];
            return cell;

        }
        else{
            return [self getNoItemCell:@"No PDF forms added."];
        }
    }
    if (indexPath.section == FWPhotosSection){
        NSArray *photos = [_estimate.photo_attachments allObjects];
        if (photos.count == 0)
        {
            return [self getNoItemCell:@"No photos added."];
        }
        photos = [photos filteredArrayUsingPredicate:NON_DELETED_PREDECATE()];
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
        NSLog(@"Photos Count- %lu",(unsigned long)self.estimate.photo_attachments.count);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        __weak __typeof(self) weakSelf = self;
        [cell setPhotos:photos.mutableCopy withDeleteBlock:^(PhotoAttachment *photo) {
                        [self deletePhoto:photo];
        } andUpdateBlock:^(PhotoAttachment *photo) {
                        AddPictureViewController * controller = [AddPictureViewController initViewController:photo Estimate:self.estimate];
                        [self.navigationController pushViewController:controller animated:YES];
        }];
        [cell fillCollectionView];
        return cell;
    }
    if (indexPath.section == FWSchemeSection) // Scheme
    {
        if (_stages && _stages.count > 0) {
            static NSString *identifier = @"BuildingCell";
            UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            StageModel* stage= [_stages objectAtIndex:indexPath.row];
            NSString* cellTitle =stage.floor;
            [cell.textLabel setText:cellTitle];
            return cell;
        }
        else{
            return [self getNoItemCell:@"No diagrams added."];
        }
    }
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
                                        NSMutableSet* tempSet=[self.estimate.photo_attachments mutableCopy];
                                       [tempSet removeObject:photo];
                                        self.estimate.photo_attachments=[tempSet copy];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    if (section==FWCustomerSection) {
        return 125;
    }
    else{
        if (section==FWPhotosSection) {
            NSArray *photos = [_estimate.photo_attachments allObjects];
            photos = [photos filteredArrayUsingPredicate:NON_DELETED_PREDECATE()];
            NSUInteger photo_count = photos.count;
            //        NSUInteger photo_count = [[self.Appointment.photo_attachments filteredSetUsingPredicate:NON_DELETED_PREDECATE()] count];
            if (photo_count <= 0) {
                return 44;
            }
            NSInteger rows = photo_count <= 3 ? 1 : (photo_count / 3);
            if (photo_count <= 3) {
                rows = 1;
            } else {
                rows = photo_count % 3 == 0 ? (photo_count / 3) : (photo_count / 3) + 1;
            }
        
            NSInteger height = rows * 108;
            return height;
        }
        else{
            if (section>=FWLineItemsSection){
                if ((section==FWLineItemsSection)&&(row==_lineItems.count+1)) {
                    return 143;
                }
                return 44;
            }
        }
    }
    return 44;
}


- (void)refreshObjects {
//    _estimate=[Estimate getById:_estimate.entity_id];
    [self.tableView reloadData];
//    self.Appointment = [Appointment getById:self.Appointment.entity_id];
//    _serviceLocaion = [self.Appointment getServiceLocation];
//    self.cust = [self.Appointment getCustomer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section>=FWLineItemsSection){
        return 44;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==FWLineItemsSection) {
        return [self createHeaderViewForSection:section withTitle:@"LINE ITEMS" andButtonBlock:^{
            AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerEstimate:_estimate andLineItem:nil Delegate:self];
            [self.navigationController pushViewController:addLineItem animated:YES];
        }];
    }
    if (section==FWPDFFormsSection) {
        return [self createHeaderViewForSection:section withTitle:@"PDF FORMS" andButtonBlock:nil];
    }
    if (section==FWSchemeSection) {
        return [self createHeaderViewForSection:section withTitle:@"DIAGRAMS" andButtonBlock:^{
            [self addFloor];
        }];
    }
    return [self createHeaderViewForSection:section withTitle:@"PHOTOS" andButtonBlock:^{
        if ([[self.estimate.photo_attachments filteredSetUsingPredicate:NON_DELETED_PREDECATE()] allObjects].count < 12) {
            [self appPhotoOpenImagePicker];
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
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return FWNumberOfSection;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==FWStatusSection) {
        return 1;
    }
    if (section==FWCustomerSection) {
        return 2;
    }
    if ((section==FWLineItemsSection)&& (self.tableView.sectionOpen == section)) {
        NSUInteger cnt=_lineItems.count;
        return cnt+2;
    }
    if ((section==FWSchemeSection)&& (self.tableView.sectionOpen == section)) {
        if (_stages.count>0) {
            return _stages.count;
        }
        return 1;
    }
    if ((section==FWPDFFormsSection)&& (self.tableView.sectionOpen == section)) {
        if (self.estimate.pdf_forms.count>0) {
            return self.estimate.pdf_forms.count;
        }
        return 1;
    }
    if ((section==FWPhotosSection)&& (self.tableView.sectionOpen == section)) {
//        if (self.estimate.photo_attachments.count>0) {
//            return self.estimate.photo_attachments.count;
//        }
        return 1;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    if (section==FWPDFFormsSection) {
        if((_estimate.pdf_forms)&&(_estimate.pdf_forms.count != 0))
        {
            [self pdfDialogForRowAtIndexPath:indexPath];
        }
    }
    if (section==FWSchemeSection) {
        if ((self.stages)&&(self.stages.count>0)) {
            StageModel* stage= [self.stages objectAtIndex:row];
            SchemeDrawerControllerViewController *drawerController = [[SchemeDrawerControllerViewController alloc] initWithNibName:@"SchemeDrawerControllerViewController" bundle:nil];
            [drawerController setStageModel:stage];
            drawerController.serviceLocationId=_serviceLocation.entity_id;
            drawerController.block=^(){
                NSIndexSet* indexSet=[NSIndexSet indexSetWithIndex:FWSchemeSection];
                [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            };
            [self.navigationController pushViewController:drawerController animated:YES];
        }
        else{
            [self addFloor];
        }
    }
    if (section==FWCustomerSection) {
        if (indexPath.row==0) {
            Customer* customer=[Customer getById:_estimate.customer_id];
            CustomerDetailViewController* controller=[CustomerDetailViewController initWithAppointment:customer];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row==1) {
            ServiceLocation *ser_loc = [self.estimate getServiceLocation];
            ServiceLocationDetailViewController *detail = [ServiceLocationDetailViewController viewControllerWithServiceLocation:ser_loc];
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
    if (section == FWLineItemsSection){
        if (indexPath.row < 1 || indexPath.row > [_lineItems count] ) {
            return;
        }
        LineItem *info = [_lineItems objectAtIndex:(indexPath.row - 1)];
        AddLineItemViewController * addLineItem =[AddLineItemViewController initViewControllerEstimate:self.estimate andLineItem:info Delegate:self];
        [self.navigationController pushViewController:addLineItem animated:YES];
    }
}

#pragma mark -UIImagePickerControllerDelegate

- (void) imagePickerController: (UIImagePickerController*)picker didFinishPickingMediaWithInfo: (NSDictionary*) info{
    UIImage *image1 = [info objectForKey:UIImagePickerControllerOriginalImage];
    AddPictureViewController * controller =[AddPictureViewController initViewControllerEstimate:self.estimate andImage:image1];
    controller.photoAddedBlock = ^{
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}


-(void) pdfDialogForRowAtIndexPath:(NSIndexPath *)indexPath {
    FWPDFForm *form = [[_estimate.pdf_forms allObjects] objectAtIndex:indexPath.row];
    NSArray* fields=[[form fields] array];
    BOOL openWithAcrobat=[form.use_acrobat boolValue];
    if (openWithAcrobat) {
        PDFAttachment *att = [form getEstimateAttachment];
        NSString *doc_path = @"";
        if (att) {
            doc_path = [att pdfFilePath];
        } else {
            doc_path = [form pdfFilePathWithEstimate:_estimate];
        }
        if (doc_path.length > 0) {
            if([[NSFileManager defaultManager] fileExistsAtPath:doc_path]){
                [self openDocument:doc_path];
            }
        }
    }
    else{
        if (fields) {
            if (fields.count>0) {
                PDFFieldsEditorViewController *pdfController = [PDFFieldsEditorViewController new];
                [pdfController setPdfFormId:form.entity_id];
                // TODO: check if attachment is ok
                PDFAttachment *att = [form getRelatedAttachmentForAppointId:self.estimate.entity_id];
                [pdfController setPdfAttachmentId:att.entity_id];
                if (!_pdf_attachments) {
                    _pdf_attachments= [_estimate.attachments allObjects];
                }
                for (PDFAttachment* attachment in _pdf_attachments) {
                    if(attachment.pdf_form_id.integerValue==form.entity_id.integerValue){
                        [attachment.managedObjectContext refreshObject:attachment mergeChanges:NO];
                        [pdfController setPdfAttachmentId:attachment.entity_id];
                        break;
                    }
                }
                pdfController.fieldsBlock=^(){
                    NSIndexSet* set=[NSIndexSet indexSetWithIndex:FWPDFFormsSection];
                    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                };
                [self.navigationController pushViewController:pdfController animated:YES];
            }
            else{
                PDFAttachment *att = [form getEstimateAttachment];
                NSString *doc_path = @"";
                if (att) {
                    doc_path = [att pdfFilePath];
                } else {
                    doc_path = [form pdfFilePathWithEstimate:_estimate];
                }
                if (doc_path.length > 0) {
                    [self openDocument:doc_path];
                }
            }
        }
    }
}

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
                                    NSString *mediaType = AVMediaTypeVideo;
                                    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
                                    if ((![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])&&(authStatus!=AVAuthorizationStatusAuthorized))
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
                                                             drawerController.serviceLocationId=self.serviceLocation.entity_id;
                                                             drawerController.block=^(){
                                                                 _serviceLocation=[ServiceLocation getById:_estimate.service_location_id];
                                                                 _stages=[[_serviceLocation floors] array];
                                                                 NSIndexSet* set=[NSIndexSet indexSetWithIndex:FWSchemeSection];
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



-(void)saveEstimate{
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    if ([[AppDelegate appDelegate] isReachable]) {
        [[SyncManager Instance] stopTimer];
        [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
        [self.estimate saveEstimateOnServerWithBlock:^(BOOL is_saved, NSNumber *est_id) {
            [self.estimate saveEstimateOnLocal];
             if (![[ActivityIndicator currentIndicator] ishidden]) {
                [[ActivityIndicator currentIndicator] displayCompleted];
            }
            [[SyncManager Instance] startTimer];
            [[SyncManager Instance] startSync];
            [[ActivityIndicator currentIndicator] hide];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) LineItemAdded:(LineItem*) item{
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
            [_lineItems replaceObjectAtIndex:editedIndex withObject:item];
        }else{
            [item setEntity_status:c_ADDED];
            [_lineItems addObject:item];
        }
        
        [self.estimate setLine_items:[[NSOrderedSet orderedSetWithArray:_lineItems] copy]];
        
        
        [self.estimate calculateTaxAmount];
        [self.tableView reloadData];
    }
}



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    // :: adding code to avoid deleting "No Materials Used" label
    if (indexPath.section == FWLineItemsSection) {
        if (self.estimate.line_itemsSet.count > 0) {
            return UITableViewCellEditingStyleDelete;
        } else {
            return UITableViewCellEditingStyleNone;
        }
    }
    return UITableViewCellEditingStyleNone;
}


//- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSInteger section=indexPath.section;
//    if (self.estimate.line_items.count <= 0) {
//        return @[];
//    }
//    id item = [[self.estimate.line_items allObjects] objectAtIndex:indexPath.row];
//    if([item isKindOfClass:[Appointment class]]){
//        Appointment *app=item;
//        NSString* rowActionTitle=@"Change Status";
//        UITableViewRowActionStyle* style=UITableViewRowActionStyleNormal;
//        style=UITableViewRowActionStyleNormal;
//        UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:style title:rowActionTitle handler:^(UITableViewRowAction *  action, NSIndexPath *  indexPath) {
//            if(![app.status isEqualToString:@"Complete"]){
//                NSArray* statuses=[Statuses MR_findAllSortedBy:@"status_name" ascending:YES];
//                if (statuses) {
//                    UIAlertController * alertController = [UIAlertController
//                                                           alertControllerWithTitle:@"Change Status"
//                                                           message:nil
//                                                           preferredStyle:UIAlertControllerStyleAlert];
//                    
//                    UIAlertAction *cancelAction = [UIAlertAction
//                                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
//                                                   style:UIAlertActionStyleCancel
//                                                   handler:^(UIAlertAction *action)
//                                                   {
//                                                       NSLog(@"Cancel action");
//                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
//                                                   }];
//                    [alertController addAction:cancelAction];
//                    for (Statuses* status in statuses) {
//                        NSString* statusName=status.status_name;
//                        if(![statusName isEqualToString:@"Complete"]){
//                            UIAlertAction *statusAction = [UIAlertAction
//                                                           actionWithTitle:statusName
//                                                           style:UIAlertActionStyleDefault
//                                                           handler:^(UIAlertAction *action)
//                                                           {
//                                                               [[ActivityIndicator currentIndicator] displayActivity:@"Please wait..."];
//                                                               _isLoading = YES;
//                                                               [app setStatus:statusName];
//                                                               [app saveAppointmentOnServerWithBlock:^(BOOL is_saved, NSNumber *appointment_id) {
//                                                                   [app saveAppointmentOnLocal];
//                                                                   if (![[ActivityIndicator currentIndicator] ishidden]) {
//                                                                       [[ActivityIndicator currentIndicator] displayCompleted];
//                                                                   }
//                                                               }];
//                                                               [tableView endEditing:YES];
//                                                               [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//                                                               [alertController dismissViewControllerAnimated:YES completion:nil];
//                                                           }];
//                            [alertController addAction:statusAction];
//                        }
//                    }
//                    [self presentViewController:alertController animated:YES completion:nil];
//                }
//            }
//            else{
//                UIAlertController *    alertController = [UIAlertController
//                                                          alertControllerWithTitle:@"Warning!"
//                                                          message:@"Status of Canceled order can't be changed"
//                                                          preferredStyle:UIAlertControllerStyleAlert];
//                
//                UIAlertAction *cancelAction = [UIAlertAction
//                                               actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
//                                               style:UIAlertActionStyleCancel
//                                               handler:^(UIAlertAction *action)
//                                               {
//                                                   NSLog(@"Cancel action");
//                                                   [alertController dismissViewControllerAnimated:YES completion:nil];
//                                               }];
//                [alertController addAction:cancelAction];
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//        }];
//        [action setBackgroundColor:[UIColor colorWithRed:(101.0/255.0) green:(107.0/255.0) blue:(124.0/255.0) alpha:1]];
//        return @[action];
//    }
//    return @[];
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == FWLineItemsSection) {
            // Line Item
            if (_lineItems.count <= 1) {
                [[[UIAlertView alloc] initWithTitle:ALERT_TITLE message:@"You can not delete last line item." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
                return;
            } else {
                [self.tableView reloadData];
            }
            NSLog(@"row = %ld", (long)indexPath.row);
            // TableView First Row is Line Item Title
            LineItem *info = [_lineItems objectAtIndex:indexPath.row - 1];
            if (info.entity_idValue < 0) {
                [self.estimate.line_itemsSet removeObject:info];
                [info MR_deleteEntityInContext:[NSManagedObjectContext MR_defaultContext]];
                [info saveLineItem];
            }else{
                [info setEntity_status:c_DELETED];
                [info saveLineItem];
            }
//            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            _lineItems = [[[self.estimate.line_items filteredOrderedSetUsingPredicate:NON_DELETED_PREDECATE()] array] mutableCopy];

            [self.estimate calculateTaxAmount];
            [self.estimate saveEstimateOnLocal];
            [tableView reloadData];
        }
    }
}

//- (void) CustomerChosen:(Customer*) customer;
//
//- (void) ServiceLocationChosen:(ServiceLocation*) ser_loc;
@end
