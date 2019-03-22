//
//  PictureViewController.h
//  FieldWork
//
//  Created by Mac4 on 28/01/15.
//
//

#import <UIKit/UIKit.h>
#import "PictureCollectionViewCell.h"
#import "AddPictureViewController.h"
#import "Constants.h"
#import "Appointment.h"
#import "PhotoAttachment.h"
#import "CommonAppointmentViewController.h"

@interface PictureViewController : CommonAppointmentViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,PictureDelegate>
{
    IBOutlet UICollectionView *_collectionView;
    NSMutableArray * _pictureArray;
    PictureCollectionViewCell *_cellItem;
    
}
@property (nonatomic,retain) UICollectionView *collectionView;
@property (nonatomic,retain) PictureCollectionViewCell *cellItem;
@property (nonatomic,retain) NSMutableArray * pictureArray;

+ (PictureViewController *)initViewControllerAppointment:(Appointment*) app;

- (void) addNewPicture;

@end
