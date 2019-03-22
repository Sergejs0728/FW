//
//  FloorPlanCell.m
//  FieldWork
//
//  Created by Alexander on 12.09.16.
//
//

#import "FloorPlanCell.h"

@interface FloorPlanCell ()
@property (weak, nonatomic) IBOutlet UIImageView *floorPlanPreview;
@property (weak, nonatomic) IBOutlet UILabel *floorTitle;
@property (strong, nonatomic) UILongPressGestureRecognizer* longPress;
@end

@implementation FloorPlanCell

-(void)setStageModel:(StageModel *)stageModel{
    if (stageModel) {
        _stageModel=stageModel;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        if (stageModel.filePath) {
            NSString *path = [NSString stringWithFormat:@"%@/%@.png",documentsDirectory, stageModel.filePath];
            [_floorPlanPreview setImage:[UIImage imageWithContentsOfFile:path]];
        }
        else{
            [_floorPlanPreview setImage:nil];
        }
        [_floorTitle setText:_stageModel.floor];
        _longPress= [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressEvent:)];
        [self addGestureRecognizer:_longPress];
    }
}

- (void)longPressEvent:(UILongPressGestureRecognizer *)gesture {
    if (_callback) {
        _callback();
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
