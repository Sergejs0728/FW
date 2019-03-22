//
//  PDFFieldHeaderCell.h
//  FieldWork
//
//  Created by alex on 01.06.17.
//
//

#import <UIKit/UIKit.h>
#import "PDFField.h"

@interface PDFFieldHeaderCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label;
- (void)setField:(PDFField *)field;

@end
