//
//  FieldWorkButton.m
//  FieldWork
//
//  Created by Samir Khatri on 11/12/13.
//
//

#import "FieldWorkButton.h"

@implementation FieldWorkButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    if ([AppDelegate OSVersion] < 7) {
        //ios 6
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        self.layer.borderWidth = 1.0;
        
        self.layer.cornerRadius = 10;
       
    }else{
        self.layer.borderWidth = 1.0f;
        
        CGColorRef clrref = [UIColor colorWithRed:205.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1.0].CGColor;
        
        self.layer.borderColor = clrref;
        //
        UIColor * __autoreleasing clr = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0];
        self.backgroundColor = clr;
        
        self.layer.cornerRadius = 2.0f;
        //CFRelease(clrref);
    }
   
}

@end
