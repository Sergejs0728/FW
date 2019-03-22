//
//  PDFFieldsEditorViewController.m
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import "PDFFieldsEditorViewController.h"
#import "PDFFieldTextAreaCell.h"
#import "PDFFieldDateCell.h"
#import "PDFFieldCheckboxCell.h"
#import "PDFFieldStaticCell.h"
#import "PDFFieldNumberCell.h"
#import "PDFFieldTextCell.h"
#import "PDFField.h"
#import "PDFSelectCell.h"
#import "PDFFieldOptionsCell.h"
#import "PDFSignatureCell.h"
#import "AppSignatureCell.h"
#import "CaptureSignatureController.h"
#import "PDFFieldHeaderCell.h"
#import <UICollectionView_ARDynamicHeightLayoutCell/UICollectionView+ARDynamicCacheHeightLayoutCell.h>

#define kOrdinaryCellHeight 50
#define kCellWithTextFieldHeight 90

#define kSelectCellHeight 50
#define kTextCellHeight 135
#define kSignatureCellHeight 180

#define FieldTypeValues @[@"textarea", @"date", @"number", @"text", @"checkbox", @"static", @"radio", @"select", @"signature", @"header"]
#define FieldTypeValue(type) FieldTypeValues[type]

typedef NS_ENUM(NSInteger, FieldType) {
    FieldTypeTextarea = 0,
    FieldTypeDate,
    FieldTypeNumber,
    FieldTypeText,
    FieldTypeCheckbox,
    FieldTypeStatic,
    FieldTypeRadio,
    FieldTypeSelect,
    FieldTypeSignature,
    FieldTypeHeader
};

@interface PDFFieldsEditorViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong,nonatomic) NSMutableArray* filteredFields;
@property (nonatomic) BOOL save;
@property (nonatomic) BOOL hasChanges;
@property (strong,nonatomic) UIGestureRecognizer *hideKeyBoardGestureRecognizer;
@property (strong,nonatomic) FWPDFForm* pdfForm;
@property (strong,nonatomic) PDFAttachment* pdfAttachment;
@end

@implementation PDFFieldsEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _save=NO;
    _hasChanges=NO;
    _hideKeyBoardGestureRecognizer=[[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:_hideKeyBoardGestureRecognizer];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(saveFields)];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    NSDictionary* nibsWithIdentifiers=@{@"PDFFieldDateCell":@"DateCell",
                                        @"PDFFieldTextAreaCell":@"TextAreaCell",
                                        @"PDFFieldTextCell":@"TextCell",
                                        @"PDFFieldStaticCell":@"StaticCell",
                                        @"PDFFieldCheckboxCell":@"CheckboxCell",
                                        @"PDFFieldNumberCell":@"NumberCell",
                                        @"PDFSignatureCell":@"SignatureIdentifier",
                                        @"PDFFieldOptionsCell":@"OptionsCell",
                                        @"PDFSelectCell":@"SelectCell",
                                        @"PDFFieldHeaderCell":@"HeaderCell"};
    for (NSString* nib in nibsWithIdentifiers) {
        NSString* identifier=[nibsWithIdentifiers objectForKey:nib];
        [self setNibWithName:nib forCollectionView:self.collectionView forIdentifier:identifier];
    }
    
    
    _pdfForm= [FWPDFForm getById:_pdfFormId appointmentId:_appId];
    //    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    //    Appointment *appt = [Appointment getById:appDelegate.working_appointment_id];
    Appointment *appt = [Appointment getById:_appId];
    _pdfAttachment = [_pdfForm getRelatedAttachmentForAppointId:appt.entity_id];
    if (_pdfForm) {
        _filteredFields=[NSMutableArray array];
        for (PDFField *field in [_pdfForm.fields array].mutableCopy) {
            if (!field.hiddenValue && [FieldTypeValues containsObject:field.field_type]) {
                [_filteredFields addObject:field.mutableCopy];
            }
        }
        [self.navigationItem setTitle:_pdfForm.name];
    }
    NSArray* attachmentFields;
    if (_pdfAttachment) {
        attachmentFields=[_pdfAttachment.field_values array];
        if (attachmentFields) {
            for (PDFField *attachmentField in attachmentFields) {
                for (PDFField* field in _filteredFields) {
                    if ([field.pdf_name isEqualToString:attachmentField.pdf_name]) {
                        if (attachmentField.field_value && attachmentField.field_value.length>0) {
                            field.field_value = attachmentField.field_value;
                        } else {
                            field.field_value = field.default_value;
                        }
                    }
                }
            }
        }
        
    }
    
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    
}

-(void)back:(UIBarButtonItem*)barButtonItem{
    if (!_save&&_hasChanges) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Save shanges?"
                                                                       message:@"Save changes in PDFForm?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"YES"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             [self saveFields];
                                                         }];
        [alert addAction:okAction];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"NO"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 [_pdfAttachment.managedObjectContext rollback];
                                                                 [self.navigationController popViewControllerAnimated:YES];
                                                             }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_filteredFields) {
        return _filteredFields.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row= indexPath.row;
    PDFField* field = [_filteredFields objectAtIndex:row];
    NSInteger type = [FieldTypeValues indexOfObject:field.field_type];
    
    switch (type) {
        case FieldTypeTextarea: {
            return [collectionView ar_sizeForCellWithIdentifier:@"TextAreaCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldTextAreaCell *currentCell=cell;
                [currentCell setField:field];
            }];
            
        }
            break;
        case FieldTypeStatic: {
            return [collectionView ar_sizeForCellWithIdentifier:@"StaticCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldStaticCell *currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeDate: {
            return [collectionView ar_sizeForCellWithIdentifier:@"DateCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldDateCell * currentCell=cell;
                [currentCell setField:field];
                currentCell.block=^(NSString* value){
                    [field setField_value: value];
                };
            }];
        }
            break;
        case FieldTypeNumber: {
            return [collectionView ar_sizeForCellWithIdentifier:@"NumberCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldNumberCell * currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeText: {
            return [collectionView ar_sizeForCellWithIdentifier:@"TextCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldTextCell * currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeCheckbox: {
            return [collectionView ar_sizeForCellWithIdentifier:@"CheckboxCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldCheckboxCell * currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeRadio: {
            return [collectionView ar_sizeForCellWithIdentifier:@"OptionsCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldOptionsCell * currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeHeader:{
            return [collectionView ar_sizeForCellWithIdentifier:@"HeaderCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFFieldHeaderCell * currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeSelect: {
            return [collectionView ar_sizeForCellWithIdentifier:@"SelectCell" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFSelectCell * currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
        case FieldTypeSignature: {
            return [collectionView ar_sizeForCellWithIdentifier:@"SignatureIdentifier" indexPath:indexPath fixedWidth:collectionView.frame.size.width configuration:^(__kindof UICollectionViewCell *cell) {
                PDFSignatureCell *currentCell=cell;
                [currentCell setField:field];
            }];
        }
            break;
            
    }
    return CGSizeZero;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=indexPath.row;
    __block PDFField* field=[_filteredFields objectAtIndex:row];
    
    
    NSInteger type = [FieldTypeValues indexOfObject:field.field_type];
    switch (type) {
        case FieldTypeTextarea: {
            PDFFieldTextAreaCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TextAreaCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value: value];
            };
            return cell;
        }
            break;
        case FieldTypeStatic: {
            PDFFieldStaticCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"StaticCell" forIndexPath:indexPath];
            [cell setField:field];
            return cell;
        }
            break;
        case FieldTypeDate: {
            PDFFieldDateCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"DateCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value: value];
            };
            return cell;
        }
            break;
        case FieldTypeNumber: {
            PDFFieldNumberCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"NumberCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value: value];
            };
            return cell;
        }
            break;
        case FieldTypeText: {
            PDFFieldTextCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"TextCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value: value];
            };
            return cell;
        }
            break;
        case FieldTypeCheckbox: {
            PDFFieldCheckboxCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CheckboxCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value: value];
            };
            return cell;
        }
            break;
        case FieldTypeRadio: {
            PDFFieldOptionsCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"OptionsCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value: value];
            };
            return cell;
        }
            break;
        case FieldTypeHeader:{
            PDFFieldHeaderCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
            [cell setField:field];
            return cell;
        }
            break;
        case FieldTypeSelect: {
            PDFSelectCell * cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectCell" forIndexPath:indexPath];
            [cell setField:field];
            cell.block=^(NSString* value){
                _hasChanges=YES;
                [field setField_value:value];
            };
            return cell;
        }
            break;
        case FieldTypeSignature: {
            PDFSignatureCell *cell = (PDFSignatureCell *)[self createSignatureCellsWithCollectionView:collectionView andIndexPath:indexPath];
            [cell setField:field];
            __weak PDFFieldsEditorViewController* weakSelf= self;
            [cell setBlock:^{
                CaptureSignatureController *signature = [CaptureSignatureController viewControllerWithPDFAttachment:_pdfAttachment andBlock:^(id result) {
                    [field setField_value:result];
                    [weakSelf.collectionView reloadData];
                }];
                signature.closeBlock=^(){
                    _hasChanges=YES;
                };
                [weakSelf.navigationController pushViewController:signature animated:YES];
            }];
            return cell;
        }
            break;
            
        default: {
            UICollectionViewCell* cell =[UICollectionViewCell new];
            return cell;
        }
            break;
    }
    
}


-(UICollectionViewCell*)createSignatureCellsWithCollectionView:(UICollectionView*) collectionView andIndexPath:(NSIndexPath*) indexPath{
    static NSString *identifier = @"SignatureIdentifier";
    PDFSignatureCell *cell = (PDFSignatureCell*) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"AppSignatureCell" owner:self options:nil];
        for(id appcell in topLevelObject)
        {
            if([appcell isKindOfClass:[UICollectionViewCell class]])
            {
                cell = (PDFSignatureCell*) appcell;
            }
        }
    }
    return cell;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGFloat keyboardHeight=keyboardFrameBeginRect.size.height;
    [_bottomConstraint setConstant:keyboardHeight];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [_bottomConstraint setConstant:0];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)saveFields {
    [self.view endEditing:YES];
    NSMutableString *fieldsNames = [NSMutableString string];
    for (PDFField *field in _filteredFields) {
        if (field.requiredValue && ((field.field_value == nil) || (field.field_value.length == 0))) {
            if (fieldsNames.length) {
                [fieldsNames appendFormat:@", %@", field.label];
            } else {
                [fieldsNames appendString:field.label];
            }
        }
    }
    if (fieldsNames.length) {
        [self showAlertWithMessage:fieldsNames];
        return;
    }
    _save=YES;
    for (PDFField* field in self.filteredFields) {
        if ((field.field_value==nil) || (field.field_value.length==0)) {
            if (field.default_value || (field.default_value.length>0)) {
                field.field_value=field.default_value;
            }
            else{
                field.field_value=@"";
            }
        }
    }
//    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    Appointment *appt = [Appointment getById:appDelegate.working_appointment_id];
    Appointment *appt = [Appointment getById:_appId];
    if (appt) {
        if (self.pdfAttachment == nil) {
            _pdfAttachment = [PDFAttachment newPDFAttachmentWithAppointmentId:appt.entity_id andPDFForm:_pdfForm];
            [_pdfAttachment setAttached_pdf_form_file_name:_pdfForm.name];
            [_pdfAttachment setAttachment_file_name:_pdfForm.document_file_name];
            [_pdfAttachment setAttached_pdf_form_content_type:_pdfForm.document_content_type];
            [_pdfAttachment setAttachment_content_type:_pdfForm.document_content_type];
            [_pdfAttachment setEntity_status: c_ADDED];
        } else {
            [_pdfAttachment setEntity_status: c_EDITED];
        }
        [_pdfAttachment setField_values:[NSOrderedSet orderedSetWithArray:self.filteredFields]];
        _pdfAttachment.appointment_occurrence_id = appt.entity_id;
        [self.pdfAttachment setPdf_form_id:self.pdfForm.entity_id];
        if (_pdfAttachment.entity_status == c_ADDED) {
            [appt addAttachmentsObject:_pdfAttachment];
        }
        [self.pdfAttachment setPdf_form: self.pdfForm];
        [appt setEntity_status:c_EDITED];
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        [self.navigationController popViewControllerAnimated:YES];
        if (_fieldsBlock) {
            _fieldsBlock();
        }
    }
    
}

-(void)showAlertWithMessage:(NSString*)message{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Warning!"
                                          message:[NSString stringWithFormat:@"Please fill %@ fields",message]
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK")
                               style:UIAlertActionStyleDefault
                               handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void) setNibWithName:(NSString*) nibName forCollectionView:(UICollectionView*) collectionView forIdentifier:(NSString*) identifier{
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}


@end
