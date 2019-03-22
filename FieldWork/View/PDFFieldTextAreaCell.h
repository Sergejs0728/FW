//
//  PDFFieldTextAreaCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"

typedef void(^PDFFieldTextAreaCellBlock)(NSString* value);


@interface PDFFieldTextAreaCell : UICollectionViewCell <UITextViewDelegate>
@property(strong,nonatomic)PDFField* field;
@property (strong,nonatomic) PDFFieldTextAreaCellBlock block;
//-(void)setupWithLabel:(NSString*)label defaultText:(NSString*) defaultText andMaxLength:(NSNumber*) maxLength;
//-(NSString*)getValue;
@end
