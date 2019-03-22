//
//  PictureCollectionViewCell.h
//  FieldWork
//
//  Created by Mac4 on 28/01/15.
//
//
//- (void)deleteInspectionRecord:(InspectionRecord *)record withDelegate:(id<ListItemDelegate>)del {
#import <UIKit/UIKit.h>

#import "PhotoAttachment.h"
@class PictureCollectionViewCell;
@protocol PictureDelegate <NSObject>

- (void) pictureDeleteCell:(PictureCollectionViewCell *)cell;

@end

@interface PictureCollectionViewCell : UICollectionViewCell{
    
    IBOutlet UIImageView * _imgView;
    id<PictureDelegate> _delegate;
    PhotoAttachment * _pAttechment;
}
@property (nonatomic ,retain) UIImageView *imgView;
@property (nonatomic ,retain) PhotoAttachment *pAttechment;
@property (nonatomic ,retain) id<PictureDelegate> delegate;

- (IBAction)deletePictureClicked:(id)sender;
@end
