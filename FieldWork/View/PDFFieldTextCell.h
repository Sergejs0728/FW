//
//  PDFFieldTextCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 31.08.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"

typedef void(^PDFFieldTextCellBlock)(NSString* value);

@interface PDFFieldTextCell : UICollectionViewCell <UITextFieldDelegate>
@property(strong,nonatomic)PDFField* field;
@property (strong,nonatomic) PDFFieldTextCellBlock block;
@end
