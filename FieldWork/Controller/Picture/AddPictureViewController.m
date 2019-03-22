//
//  AddPictureViewController.m
//  FieldWork
//
//  Created by Mac4 on 28/01/15.
//
//

#import "AddPictureViewController.h"
#import "NewAppointMentsDetailViewController.h"
#import "Estimate.h"
#import <AVFoundation/AVFoundation.h>

@interface AddPictureViewController ()

@end


@implementation AddPictureViewController
@synthesize imgView=_imgView;
@synthesize txtNoteView=_txtNoteView;
@synthesize pAttechment=_pAttechment;
@synthesize isEdit;
@synthesize preSelectedImage;

+ (AddPictureViewController *)initViewController:(PhotoAttachment *)pAttechment Appointment:(Appointment *)app{
    
    AddPictureViewController * controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewControlleriPad" bundle:nil];
    }else{
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewController" bundle:nil];
    }
    controller.isEdit = YES;
    controller.title =@"Add Picture";
    controller.Appointment = app;
    controller.pAttechment = pAttechment;
    return controller;
}

+ (AddPictureViewController *)initViewController:(PhotoAttachment *)pAttechment Estimate:(Estimate *)est{
    
    AddPictureViewController * controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewControlleriPad" bundle:nil];
    }else{
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewController" bundle:nil];
    }
    controller.isEdit = YES;
    controller.title =@"Add Picture";
    controller.Appointment = nil;
    controller.pAttechment = pAttechment;
    return controller;
}

+ (AddPictureViewController *)initViewController:(Appointment *)app{
    AddPictureViewController * controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewControlleriPad" bundle:nil];
    }else{
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewController" bundle:nil];
    }
    controller.isEdit = NO;
    controller.title =@"Add Picture";
    controller.Appointment = app;
    controller.pAttechment = [PhotoAttachment newPhotoWithAppointmentId:app.entity_id];
    return controller;
}

+ (AddPictureViewController *)initViewController:(Appointment *)app andImage:(UIImage*)image{
    AddPictureViewController * controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewControlleriPad" bundle:nil];
    }else{
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewController" bundle:nil];
    }
    controller.isEdit = NO;
    controller.title =@"Add Picture";
    controller.Appointment = app;
    controller.pAttechment = [PhotoAttachment newPhotoWithAppointmentId:app.entity_id];
    controller.preSelectedImage = image;
    return controller;
}

+ (AddPictureViewController *)initViewControllerEstimate:(Estimate *)est andImage:(UIImage*)image{
    AddPictureViewController * controller;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewControlleriPad" bundle:nil];
    }else{
        controller =[[AddPictureViewController alloc]initWithNibName:@"AddPictureViewController" bundle:nil];
    }
    controller.isEdit = NO;
    controller.title =@"Add Picture";
    controller.Appointment = nil;
    controller.pAttechment = [PhotoAttachment newPhotoWithEstimate:est];
    controller.preSelectedImage = image;
    return controller;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (BOOL)navigationShouldPopOnBackButton {
    if (self.isEdit == NO) {
        [self.pAttechment discard];
    }

    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _characterlbl.text =@"300";
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Save"
                                   style:UIControlStateNormal
                                   target:self
                                   action:@selector(addPictureClicked:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    if (!isEdit) {
        if (self.preSelectedImage) {
            _imgView.image = self.preSelectedImage;
            _txtNoteView.text = _pAttechment.comments;
//            _imageV = self.preSelectedImage;
            
//            [self.pAttechment saveImageOnLocal:self.preSelectedImage WithCompletion:^(id result, BOOL is_success) {
////                _imgView.image = [_pAttechment getImg];
////                _txtNoteView.text = _pAttechment.comments;
////                _imageV = [_pAttechment getImg];
//            }];
        }else {
            [self addPicture];
        }
    }else{
        _imgView.image = [_pAttechment getImg];
        _txtNoteView.text = _pAttechment.comments;
        self.preSelectedImage = [_pAttechment getImg];
    }
    self.imgView.layer.borderColor = [UIColor colorWithRed:152.0/255.0 green:152.0/255.0 blue:162.0/255.0 alpha:1.0].CGColor;
    self.imgView.layer.borderWidth = 2.0;
    
    int len = (int)_txtNoteView.text.length;
    _characterlbl.text=[NSString stringWithFormat:@"%i",300-len];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)addPictureClicked:(id)sender{
    if (_pAttechment) {
        [_pAttechment setComments:_txtNoteView.text];
        UIImage * Image = [self.preSelectedImage resizedImageWithMaximumSize:CGSizeMake(640, 640)];
        [_pAttechment saveImageOnLocal:Image WithCompletion:^(id result, BOOL is_success) {
            if (isEdit) {
                if (![_pAttechment.entity_status isEqualToNumber:c_ADDED]) {
                    [_pAttechment setEntity_status:c_EDITED];
                }
            }else{
                [_pAttechment setEntity_status:c_ADDED];
                [self.Appointment.photo_attachmentsSet addObject:_pAttechment];
            }
            [_pAttechment setSync_status:c_DIRTY];
            [_pAttechment savePhoto];
            [self postNotificationForDirty];
            if (self.photoAddedBlock) {
                self.photoAddedBlock();
            }
            //        [[NSNotificationCenter defaultCenter] postNotificationName:kWORKORDER_DETAIL_UPDATE_SECTION object:self userInfo:@{@"section":@(FWPhotos)}];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)addPhotoClicked:(id)sender{
    [self addPicture];
}

#pragma mark -UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    
    int limit = 300;
    if (_txtNoteView.text.length > limit) {
        _txtNoteView.text = [_txtNoteView.text substringToIndex:limit];
    }
    int len = (int)_txtNoteView.text.length;
    _characterlbl.text=[NSString stringWithFormat:@"%i",300-len];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL flag = NO;
    
    if([text length] == 0)
    {
        if([textView.text length] != 0)
        {
            flag = YES;
            return YES;
        }
        else {
            return NO;
        }
    }
    else if([[textView text] length] > 299)
    {
        return NO;
    }
    return YES;
}


#pragma mark -PictureFileUploadDelegate
-(void)fileUploadedSuccessFully{
    [[ActivityIndicator currentIndicator]displayCompleted];
    
}

- (void)FileUploadFail {
    [[ActivityIndicator currentIndicator]displayCompletedWithError:@"Fail"];
}

-(void)addPicture{
    NSArray *photos = [PhotoAttachment getPhotosWithAppointmentId:self.Appointment.entity_id];
    photos = [photos filteredArrayUsingPredicate:NON_DELETED_PREDECATE()];
    if (photos.count<12 && ![_pAttechment.sync_status isEqual:c_SYNC]) {
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Select Pictures" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Capture",@"Camera Roll", nil];
        [alrt show];
    }
}

#pragma mark - UIImagePickerControllerDelegate


//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
//    picker.allowsEditing=YES;
//    picker.delegate=self;
//    UIImage * _chosenImage =  editingInfo[UIImagePickerControllerOriginalImage];;
//        // Add Picture
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    _imgView.image=  _chosenImage;
//    _imageV = _chosenImage;
//}

- (void) imagePickerController: (UIImagePickerController*)picker didFinishPickingMediaWithInfo: (NSDictionary*) info{
    picker.allowsEditing=YES;
    picker.delegate=self;
    UIImage * _chosenImage =  info[UIImagePickerControllerOriginalImage];;
        // Add Picture
    [picker dismissViewControllerAnimated:YES completion:NULL];
    _imgView.image=  _chosenImage;
    self.preSelectedImage = _chosenImage;
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    picker.allowsEditing=YES;
//    picker.delegate=self;
//    UIImage * _chosenImage = info[UIImagePickerControllerEditedImage];
//    // Add Picture
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    _imgView.image=  _chosenImage;
//    _imageV = _chosenImage;
//    
//}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)OpenGalleryToUserPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}


-(void)OpenCameraToCapture
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if ((![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])&&(authStatus!=AVAuthorizationStatusAuthorized)) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:ALERT_TITLE
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    else
    {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:^{
        }];
        
    }
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1)
    {
        [self OpenCameraToCapture];
        
    }
    else if (buttonIndex==2)    
    {
        [self OpenGalleryToUserPhotoLibrary];
    }else{
        [self.pAttechment discard];
        [self.navigationController popViewControllerAnimated:YES];
    }
}



@end
