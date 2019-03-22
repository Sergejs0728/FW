//
//  PDFSignatureCell.h
//  FieldWork
//
//  Created by Alexander Kotenko on 19.08.16.
//
//

#import <UIKit/UIKit.h>
#import "DottedView.h"
#import "DrawSignature.h"
#import "PDFField.h"

#define DEGREES_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface PDFSignatureCell : UICollectionViewCell

@property (weak,nonatomic) IBOutlet UIView *signatureView;
@property (weak,nonatomic) IBOutlet DottedView *signatureDVView;
@property (strong,nonatomic) NSString* signature;
@property (strong,nonatomic) NSArray* array;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic)GeneralNotificationBlock block;
@property (strong,nonatomic) PDFField* field;
@property (strong, nonatomic) DrawSignature *drawSignature;
@property (weak, nonatomic) IBOutlet UIButton *btn;

//- (void)setSignatureTouchBlock:(GeneralNotificationBlock)block;

- (IBAction)btnPreviewClicked:(id)sender;


@end
