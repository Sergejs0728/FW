//
//  PDFFieldStaticCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import "PDFFieldStaticCell.h"

@interface PDFFieldStaticCell()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation PDFFieldStaticCell

-(void)setupWithLabel:(NSString*) label{
    [_label setText:label];
    [_label sizeToFit];
}
-(void)setField:(PDFField *)field{
    _field=field;
    [_label setText:field.label];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
