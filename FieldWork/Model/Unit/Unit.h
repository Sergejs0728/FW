#import "_Unit.h"

@interface Unit : _Unit

+ (FEMMapping *)defaultMapping;
+ (FEMMapping *)reverseMapping;
+ (Unit*)unitWithUnitNumber:(NSString*)unitNumber serviceLocation:(ServiceLocation*)serviceLocation;

- (void) saveForServiceLocation:(ServiceLocation*)serviceLocation completion:(ItemSavedBlock)completion;

@end
