//
//  AddPictureViewController.h
//  FieldWork
//
//  Created by Mac4 on 28/01/15.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ActivityIndicator.h"
#import "PhotoAttachment.h"
#import "Appointment.h"
#import "UIImage+ResizeMagick.h"
#import "PictureViewController.h"
#import "CommonAppointmentViewController.h"


//26112015
//Delegate PictureFileUploadDelegate
@interface AddPictureViewController : CommonAppointmentViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>{
    IBOutlet UIImageView * _imgView;
    IBOutlet UITextView * _txtNoteView;
//    UIImage * _imageV;
    IBOutlet UILabel * _characterlbl;
    BOOL isEdit;
    PhotoAttachment * _pAttechment;
    
}
+ (AddPictureViewController *)initViewController:(PhotoAttachment *)pAttechment Appointment:(Appointment *) app;

+ (AddPictureViewController *)initViewController:(Appointment *)app;

+ (AddPictureViewController *)initViewController:(PhotoAttachment *)pAttechment Estimate:(Estimate *)est;

+ (AddPictureViewController *)initViewController:(Appointment *)app andImage:(UIImage*)image;

+ (AddPictureViewController *)initViewControllerEstimate:(Estimate *)est andImage:(UIImage*)image;

@property (nonatomic ,retain) UIImageView * imgView;
@property (nonatomic ,assign) BOOL isEdit;
@property (nonatomic ,retain) UITextView * txtNoteView;
@property (nonatomic ,retain) UIImage * imageV;
@property (nonatomic ,retain) PhotoAttachment * pAttechment;
@property (nonatomic, retain, readwrite) UIImage *preSelectedImage;

@property (nonatomic,copy) GeneralNotificationBlock photoAddedBlock;

- (IBAction)addPictureClicked:(id)sender;

- (IBAction)addPhotoClicked:(id)sender;

- (void) addPicture;


@end
