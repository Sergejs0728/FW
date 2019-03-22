//
//  PDFFieldDateCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"
typedef void(^PDFFieldDateCellBlock)(NSString* value);


@interface PDFFieldDateCell : UICollectionViewCell <UITextFieldDelegate>
@property (strong,nonatomic)  NSDate* choosenDate;
@property(strong,nonatomic)PDFField* field;
@property(strong,nonatomic)PDFFieldDateCellBlock block;
//@property (strong,nonatomic) DateBlock dateBlock;
//-(void)setupWithLabel:(NSString*)label;
//-(NSString*)getValue;
@end
