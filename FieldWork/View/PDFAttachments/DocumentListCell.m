//
//  DocumentListCell.m
//  FieldWork
//
//  Created by Samir Khatri on 3/20/14.
//
//

#import "DocumentListCell.h"

@implementation DocumentListCell

@synthesize lblDocumentName = _lblDocumentName;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
