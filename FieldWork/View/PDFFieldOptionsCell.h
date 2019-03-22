//
//  PDFFieldOptionsCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 31.08.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"

typedef void(^PDFFieldOptionsCellBlock)(NSString* value);

@interface PDFFieldOptionsCell : UICollectionViewCell <UIPickerViewDataSource, UIPickerViewDelegate>
@property(strong,nonatomic)PDFField* field;
@property (strong,nonatomic) PDFFieldOptionsCellBlock block;

@end
