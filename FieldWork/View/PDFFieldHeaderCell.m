//
//  PDFFieldHeaderCell.m
//  FieldWork
//
//  Created by alex on 01.06.17.
//
//

#import "PDFFieldHeaderCell.h"

@implementation PDFFieldHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setField:(PDFField *)field {
    [_label setText:field.label.uppercaseString];
}

@end
