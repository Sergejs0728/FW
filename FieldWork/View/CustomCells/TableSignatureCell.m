//
//  PDFSignatureCell.m
//  FieldWork
//
//  Created by Alexander Kotenko on 19.08.16.
//
//

#import "TableSignatureCell.h"
#import "KLCPopup.h"

@implementation TableSignatureCell{
    NSString* btnText;
}

-(void)awakeFromNib {
    //    DrawSignature *signature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 161)];
    //    [signatureView addSubview:signature];
    // Initialization code
}

- (void)setSignature:(NSString *)signature title:(NSString*)title {
    _signature = signature;
    [_label setText:title];
    [_drawSignature removeFromSuperview];
    btnText=_btn.titleLabel.text;
    if (_signature && _signature.length > 0){
        _drawSignature = [[DrawSignature alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 161)];
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
