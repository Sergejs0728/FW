//
//  PictureCollectionViewCell.m
//  FieldWork
//
//  Created by Mac4 on 28/01/15.
//
//

#import "PictureCollectionViewCell.h"

@implementation PictureCollectionViewCell
@synthesize imgView=_imgView;
@synthesize delegate =_delegate;
@synthesize pAttechment=_pAttechment;

- (void)awakeFromNib {
    // Initialization code
}
-(void)deletePictureClicked:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(pictureDeleteCell:)]) {
        [_delegate pictureDeleteCell:self];
    }
}


@end
