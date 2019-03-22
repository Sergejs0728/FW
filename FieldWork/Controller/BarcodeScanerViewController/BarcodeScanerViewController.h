//
//  BarcodeScanerViewController.h
//  FieldWork
//
//  Created by Alexander on 07.09.17.
//
//

#import <UIKit/UIKit.h>

@protocol BarcodeScanerViewControllerDelegate <NSObject>

- (void)barcodeScanerViewControllerDidScan:(NSString *)barcode;

@end

@interface BarcodeScanerViewController : UIViewController

@property (nonatomic, weak) id<BarcodeScanerViewControllerDelegate>delegate;
@property (nonatomic, copy) void(^completion)(NSString *barcode);

@end
