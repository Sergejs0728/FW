//
//  FloorPlansViewController.h
//  FieldWork
//
//  Created by Alexander on 09.09.16.
//
//

#import <UIKit/UIKit.h>

typedef void (^CallbackBlock)();


@interface FloorPlansViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) NSNumber* workOrderId;
@property (nonatomic) CallbackBlock block;
@property (strong, nonatomic) NSString* building;
@property (strong,nonatomic) NSNumber* serviceLocationId;
@end
