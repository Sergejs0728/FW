#import "_Pest.h"


@interface Pest : _Pest {}

typedef void (^PestResponseBlock)(NSNumber *pestId, NSString *error);

+ (FEMMapping* )defaultMapping;

+ (NSMutableArray*) fetchAll;

+ (void) fetchAllWithBlock:(ItemLoadedBlock)block;

+ (Pest*) pestById:(NSNumber*)pest_id;

+ (Pest*) pestByName:(NSString*)name;

-(void)postPest:(PestResponseBlock) block;

@end
