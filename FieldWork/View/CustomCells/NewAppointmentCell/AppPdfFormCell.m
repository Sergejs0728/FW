//
//  AppPdfFormCell.m
//  FieldWork
//
//  Created by Samir on 11/24/15.
//
//

#import "AppPdfFormCell.h"
#import "PDFAttachment.h"

@implementation AppPdfFormCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
    // Configure the view for the selected state
}

- (void) setPdfForm:(FWPDFForm*) form
{
    [self setNeedsLayout];
    [_lblPdfName setText:form.name];
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    PDFAttachment *att = [form getRelatedAttachmentForAppointId:appDelegate.working_appointment_id];
//    NSOrderedSet* values=att.field_values;
//    NSArray* fieldValues=[values array];
//    if ([[UIDevice currentDevice] userInterfaceIdiom] != UIUserInterfaceIdiomPad) {
//        _imgCheckMark.hidden = (fieldValues.count==0);
//        [self drawRound];
//    }
//    else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self drawRound];
//            BOOL hidden=((fieldValues.count==0)&&(att==NULL));
            BOOL hidden = att == nil;
            _imgCheckMark.hidden = hidden;
        });
//    }
}

-(void)drawRound{
    _vRoundCircle.borderColor = [UIColor grayColor];
    _vRoundCircle.borderWidth = 1.0;
    _vRoundCircle.borderType = BorderTypeDashed;
    _vRoundCircle.cornerRadius = _vRoundCircle.frame.size.width / 2;
    _vRoundCircle.dashPattern = 1;
    _vRoundCircle.spacePattern = 2;
    _imgCheckMark.layer.cornerRadius = _imgCheckMark.frame.size.width / 2;
    _imgCheckMark.clipsToBounds = YES;
}

@end
