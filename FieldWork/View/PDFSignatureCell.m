//
//  PDFSignatureCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 19.08.16.
//
//

#import "PDFSignatureCell.h"
#import "KLCPopup.h"

@implementation PDFSignatureCell{
    NSString* btnText;
}

-(void)awakeFromNib {
    //    DrawSignature *signature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 161)];
    //    [signatureView addSubview:signature];
    // Initialization code
    [_signatureView layoutIfNeeded];
    [self layoutIfNeeded];
}

- (void)setField:(PDFField *)field {
    _field=field;
    _signature =field.field_value;
    [_label setText:field.label];
    [_drawSignature removeFromSuperview];
    btnText=_btn.titleLabel.text;
    if (_signature && _signature.length > 0){
        _drawSignature = [[DrawSignature alloc]initWithFrame:_signatureView.bounds];
        NSMutableArray *arr = [SignaturePoint parseWithArray:_signature];
        if (arr && arr.count > 0) {
            _array=arr;
            _drawSignature.sigPoints = [_array mutableCopy];
        }
        
        [_signatureView addSubview:_drawSignature];
        
        _signatureDVView.showDottedBorderAndButton = NO;
        [_btn setTitle:@"" forState:UIControlStateNormal];
        
    }else {
        [_btn setTitle:btnText forState:UIControlStateNormal];

        _signatureDVView.showDottedBorderAndButton = YES;
    }
    [_signatureView bringSubviewToFront:_btn];
    
}


- (void)btnPreviewClicked:(id)sender {
    if (_block) {
        _block();
    }
}



@end
