#import "_StageModel.h"

@interface StageModel : _StageModel

+ (FEMMapping *) defaultMapping ;
+ (StageModel*) stageByFloor:(NSString*)floor serviceLocation:(ServiceLocation*)sl;
+ (NSArray *) stagesForSync;
+ (NSArray*) stagesToDelete;
+ (NSArray*)getDirtyForServiceLocation:(ServiceLocation*)serviceLocation;
- (void) uploadPlan;
+ (NSMutableArray*) getStages;
- (void) download;
- (void) downloadWithCompletionBlock:(DownloadFileCompletionBlock)block;
-(void)deleteOnServerBlock:(void (^)())block;
// Custom logic goes here.
@end
