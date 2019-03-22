//
//  PDFFieldCheckboxCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"
typedef void(^PDFFieldCheckboxCellBlock)(NSString* value);
@interface PDFFieldCheckboxCell : UICollectionViewCell
@property(strong,nonatomic)PDFField* field;
//@property (nonatomic) BOOL checkBoxSelected;
@property (strong,nonatomic)PDFFieldCheckboxCellBlock block;
//-(void)setupWithLabel:(NSString*)label;
//-(NSString*)getValue;

@end
