//
//  AppPhotoCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppPhotoCell.h"
#import "AppPhotoCollectionCell.h"
#import "UIImage+ResizeMagick.h"
static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";
@implementation AppPhotoCell

- (void)awakeFromNib {
    [_collectionView registerNib:[UINib nibWithNibName:@"AppPhotoCollectionCell" bundle:nil] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setMinimumInteritemSpacing:3.0f];
    [flowLayout setMinimumLineSpacing:3.0f];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [_collectionView setPagingEnabled:YES];
    [_collectionView setCollectionViewLayout:flowLayout];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setPhotos:(NSArray *)arr_photos withDeleteBlock:(DeletePhotoBlock)deleteBlock andUpdateBlock:(PhotoClicked)updateBlock {
    _deletePhotoBlock = deleteBlock;
    _photoClickedBlock = updateBlock;
    self.photos = arr_photos;
}


- (void)fillCollectionView
{
    [_collectionView reloadData];
}

- (CGFloat) getContentHeightForWidth:(CGFloat)width
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        if (self.photos.count > 0)
        {
            CGFloat CollectionCellWidth = (width - 20) / 6;
            
            int itemsCount = (int)[self collectionView:_collectionView numberOfItemsInSection:0];
            
            int rowsNumber = itemsCount / 6;
            if (itemsCount % 6 > 0)
            {
                rowsNumber++;
            }
            CGFloat parentCellHeight = CollectionCellWidth * rowsNumber + 10 * (rowsNumber - 1);
            return parentCellHeight;
        }
        else
        {
            return 40;
        }
    }else{
        if (self.photos.count > 0)
        {
            CGFloat CollectionCellWidth = (width - 20) / 3;
            
            int itemsCount = (int)[self collectionView:_collectionView numberOfItemsInSection:0];
            
            int rowsNumber = itemsCount / 3;
            if (itemsCount % 3 > 0)
            {
                rowsNumber++;
            }
            CGFloat parentCellHeight = CollectionCellWidth * rowsNumber + 10 * (rowsNumber - 1);
            return parentCellHeight;
        }
        else
        {
            return 40;
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AppPhotoCollectionCell *cell = (AppPhotoCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    if (self.photos.count > 0) {

        __block PhotoAttachment *pa = [self.photos objectAtIndex:indexPath.row];        
        UIImage *image = [pa getThumb];
//        NSLog(@"imahe size: w = %f, h = %f", image.size.width, image.size.height);
        cell.image.image = image;
        cell.btnPhotoDelete.enabled = ![pa.sync_status isEqual:c_SYNC];
        [cell.btnPhotoDelete setAction:kUIButtonBlockTouchUpInside withBlock:^{
            if (_deletePhotoBlock) {
                _deletePhotoBlock(pa);
            }
        }];
    }else{
        cell.backgroundColor = [UIColor lightGrayColor];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    PhotoAttachment *photo = [self.photos objectAtIndex:indexPath.row];
    if (_photoClickedBlock) {
        _photoClickedBlock(photo);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGSize size;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        float cellWidth = screenWidth / 6.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
        size = CGSizeMake(cellWidth - 6, cellWidth - 5);

    }else{
        float cellWidth = screenWidth / 3.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
        size = CGSizeMake(cellWidth - 3, cellWidth - 3);

    }
    
    return size;
}


@end
