//
//  UIPlaceHolderTextView.m
//  FieldWork
//
//  Created by Samir Khatri on 03/12/13.
//
//

#import "UIPlaceHolderTextView.h"

@interface UIPlaceHolderTextView ()

@property (nonatomic, retain) UILabel *placeHolderLabel;


- (BOOL)isAcceptableTextLength:(NSUInteger)length;

@end

@implementation UIPlaceHolderTextView

@synthesize secondDelegate = _secondDelegate;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        [self setPlaceholder:@""];
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    if([[self text] length] == 0)
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    else
    {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    @autoreleasepool {
        if( [[self placeholder] length] > 0 )
        {
            if (_placeHolderLabel == nil )
            {
                _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
                _placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
                _placeHolderLabel.numberOfLines = 0;
                _placeHolderLabel.font = self.font;
                _placeHolderLabel.backgroundColor = [UIColor clearColor];
                _placeHolderLabel.textColor = self.placeholderColor;
                _placeHolderLabel.alpha = 0;
                _placeHolderLabel.tag = 999;
                [self addSubview:_placeHolderLabel];
            }
            
            _placeHolderLabel.text = self.placeholder;
            [_placeHolderLabel sizeToFit];
            [self sendSubviewToBack:_placeHolderLabel];
        }
        
        if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        
        [super drawRect:rect];
    }
}

- (BOOL)isAcceptableTextLength:(NSUInteger)length {
    return length <= self.characterLength;
}


#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.secondDelegate && [self.secondDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        [self.secondDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    if (self.characterLength > 0) {
        return [self isAcceptableTextLength:textView.text.length + text.length - range.length];
    }else{
        return YES;
    }
    return YES;
}


@end
