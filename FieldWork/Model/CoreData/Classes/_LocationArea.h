// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationArea.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface LocationAreaID : NSManagedObjectID {}
@end

@interface _LocationArea : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LocationAreaID *objectID;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* location_area_name;

@end

@interface _LocationArea (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveLocation_area_name;
- (void)setPrimitiveLocation_area_name:(nullable NSString*)value;

@end

@interface LocationAreaAttributes: NSObject 
+ (NSString *)entity_id;
+ (NSString *)location_area_name;
@end

NS_ASSUME_NONNULL_END
