//
//  PDFSelectItemCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 01.09.16.
//
//

#import <UIKit/UIKit.h>

typedef void(^PDFFieldSelectItemCellBlock)(NSString* option, BOOL checked);

@interface PDFSelectItemCell : UITableViewCell
@property (nonatomic,strong) NSString* option;
@property (strong,nonatomic) NSString* defaultOption;
@property (strong,nonatomic) NSString* value;
//@property (strong,nonatomic) NSMutableArray* selectedOptions;
//@property (strong,nonatomic) PDFFieldSelectItemCellBlock block;
@property (strong,nonatomic) PDFFieldSelectItemCellBlock checkBlock;

-(void)setChecked:(BOOL) checked;
-(void)initialize;
@end
