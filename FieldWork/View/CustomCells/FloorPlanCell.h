//
//  FloorPlanCell.h
//  FieldWork
//
//  Created by Alexander on 12.09.16.
//
//

#import <UIKit/UIKit.h>
#import "StageModel.h"

typedef void (^CallbackBlock)();

@interface FloorPlanCell : UICollectionViewCell
@property (strong,nonatomic) StageModel* stageModel;
@property(nonatomic)CallbackBlock callback;
@end
