//
//  PDFSelectCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 01.09.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"
#import "PDFSelectItemCell.h"

typedef void(^PDFFieldSelectCellBlock)(NSString* selectedValue);

@interface PDFSelectCell : UICollectionViewCell <UITableViewDelegate, UITableViewDataSource>
@property(strong,nonatomic)PDFField* field;
@property (strong,nonatomic) PDFFieldSelectCellBlock block;
@end
