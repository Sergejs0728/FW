//
//  PDFFieldNumberCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"
typedef void(^PDFFieldNumberCellBlock)(NSString* value);


@interface PDFFieldNumberCell : UICollectionViewCell <UITextFieldDelegate>
@property(strong,nonatomic)PDFField* field;
@property(strong,nonatomic)PDFFieldNumberCellBlock block;
//-(void)setupWithLabel:(NSString*) label;
//-(NSString*)getValue;
@end
