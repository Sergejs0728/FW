//
//  PDFFieldTextAreaCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import "PDFFieldTextAreaCell.h"

@interface PDFFieldTextAreaCell ()
@property (weak, nonatomic) IBOutlet UILabel *lablel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) BOOL hasPlaceholder;
@property (strong,nonatomic) NSAttributedString* defaultText;
@property (strong,nonatomic) UITapGestureRecognizer* textVewTap;
@end

@implementation PDFFieldTextAreaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setField:(PDFField *)field{
    _field=field;
    [_lablel setText:[NSString stringWithFormat:@"%@:",field.label]];
    [_textView setDelegate:self];
    if (field.field_value) {
        [_textView setText:field.field_value];
    }
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.length + range.location > textView.text.length)
    {
        return NO;
    }
    
    if (_field.max_lengthValue>0) {
        NSUInteger newLength = [textView.text length] + [text length] - range.length;
        return newLength <= _field.max_lengthValue;
    }
    else{
        return YES;
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    NSString* value=textView.text;
    if (_block) {
        _block(value);
    }
}

-(NSString*)getValue{
    return self.textView.text;
}
@end
