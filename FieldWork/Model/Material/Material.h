#import "_Material.h"

@interface Material : _Material {}
// Custom logic goes here.

+ (FEMMapping* )defaultMapping;

+ (Material*) newEntity;

+ (void) loadAllWithBlock:(ItemLoadedBlock)block;

+ (Material*) getById:(NSNumber*) material_id;

+ (Material*) materialByName:(NSString*) name;

- (void) addNewMaterialOnServerWithBlock:(ItemSavedBlock)block;

@end
