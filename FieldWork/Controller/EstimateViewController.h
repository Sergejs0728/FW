//
//  EstimateViewController.h
//  FieldWork
//
//  Created by Alexander on 20.03.17.
//
//

#import <UIKit/UIKit.h>
#import "UIExpandableTableView.h"
#import "Estimate.h"

typedef NS_ENUM(NSInteger, EstimateSectionType) {
    FWStatusSection = 0,
    FWCustomerSection = 1,
    FWLineItemsSection = 2,
    FWPDFFormsSection = 3,
    FWPhotosSection = 4,
    FWSchemeSection = 5,
    FWNumberOfSection=6
};
@interface EstimateViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate>
+(EstimateViewController *)initViewControllerEstimate:(Estimate*) estimate;
@end
