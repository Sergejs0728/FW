//
//  PDFFieldsEditorViewController.h
//  FieldWork
//
//  Created by Alexander Kotenko on 11.08.16.
//
//

#import <UIKit/UIKit.h>
#import "FWPDFForm.h"

typedef void(^PDFFieldsBlock)(void);

@interface PDFFieldsEditorViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSNumber* pdfFormId;
@property (strong,nonatomic) NSNumber* pdfAttachmentId;
@property (strong,nonatomic) NSNumber* appId;
@property (strong,nonatomic) PDFFieldsBlock fieldsBlock;
@end
