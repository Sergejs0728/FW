//
//  AppPhotoCell.h
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import <UIKit/UIKit.h>
#import "PhotoAttachment.h"
#import "UIButton+Block.h"

typedef void(^DeletePhotoBlock)(PhotoAttachment* photo);

typedef void(^PhotoClicked)(PhotoAttachment* photo);

@interface AppPhotoCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
{
    IBOutlet UICollectionView *_collectionView;
    
    DeletePhotoBlock _deletePhotoBlock;
    
    PhotoClicked _photoClickedBlock;
}

@property (nonatomic, strong) NSArray *photos;

- (void) fillCollectionView;

- (CGFloat) getContentHeightForWidth:(CGFloat)width;

- (void) setPhotos:(NSArray *)arr_photos withDeleteBlock:(DeletePhotoBlock)deleteBlock andUpdateBlock:(PhotoClicked)updateBlock;

@end
