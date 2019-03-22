//
//  UILabel+Extension.m
//  FieldWork
//
//  Created by Samir Khatri on 4/15/14.
//
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

- (void)alignTop {
    // Deprecated
    //CGSize fontSize = [self.text sizeWithFont:self.font];
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font }];
    
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    
    // Deprecated
    //CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    CGRect theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{NSFontAttributeName: self.font}
                                              context:nil];
    
    
    int newLinesToPad = (finalHeight  - theStringSize.size.height) / fontSize.height;
    
    for(int i=0; i<= newLinesToPad; i++)
    {
        self.text = [self.text stringByAppendingString:@"\n"];
    }
}

- (void)alignBottom {
    // Deprecated
    //CGSize fontSize = [self.text sizeWithFont:self.font];
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName: self.font }];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    // Deprecated
    //CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    CGRect theStringSize = [self.text boundingRectWithSize:CGSizeMake(finalWidth, finalHeight)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName: self.font}
                                                   context:nil];
    int newLinesToPad = (finalHeight  - theStringSize.size.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}

@end
