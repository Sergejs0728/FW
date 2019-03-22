// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BaitConditions.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BaitConditionsID : NSManagedObjectID {}
@end

@interface _BaitConditions : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BaitConditionsID *objectID;

@property (nonatomic, strong, nullable) NSString* bait_condition_name;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@end

@interface _BaitConditions (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveBait_condition_name;
- (void)setPrimitiveBait_condition_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

@end

@interface BaitConditionsAttributes: NSObject 
+ (NSString *)bait_condition_name;
+ (NSString *)entity_id;
@end

NS_ASSUME_NONNULL_END
