// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationType.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class LocationArea;

@interface LocationTypeID : NSManagedObjectID {}
@end

@interface _LocationType : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) LocationTypeID *objectID;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* location_type_color;

@property (nonatomic, strong, nullable) NSString* location_type_name;

@property (nonatomic, strong, nullable) NSSet<LocationArea*> *location_areas;
- (nullable NSMutableSet<LocationArea*>*)location_areasSet;

@end

@interface _LocationType (Location_areasCoreDataGeneratedAccessors)
- (void)addLocation_areas:(NSSet<LocationArea*>*)value_;
- (void)removeLocation_areas:(NSSet<LocationArea*>*)value_;
- (void)addLocation_areasObject:(LocationArea*)value_;
- (void)removeLocation_areasObject:(LocationArea*)value_;

@end

@interface _LocationType (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveLocation_type_color;
- (void)setPrimitiveLocation_type_color:(nullable NSString*)value;

- (nullable NSString*)primitiveLocation_type_name;
- (void)setPrimitiveLocation_type_name:(nullable NSString*)value;

- (NSMutableSet<LocationArea*>*)primitiveLocation_areas;
- (void)setPrimitiveLocation_areas:(NSMutableSet<LocationArea*>*)value;

@end

@interface LocationTypeAttributes: NSObject 
+ (NSString *)entity_id;
+ (NSString *)location_type_color;
+ (NSString *)location_type_name;
@end

@interface LocationTypeRelationships: NSObject
+ (NSString *)location_areas;
@end

NS_ASSUME_NONNULL_END
