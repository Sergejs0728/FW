// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ServiceRoutes.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ServiceRoutesID : NSManagedObjectID {}
@end

@interface _ServiceRoutes : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) ServiceRoutesID *objectID;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* service_route_name;

@end

@interface _ServiceRoutes (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveService_route_name;
- (void)setPrimitiveService_route_name:(nullable NSString*)value;

@end

@interface ServiceRoutesAttributes: NSObject 
+ (NSString *)entity_id;
+ (NSString *)service_route_name;
@end

NS_ASSUME_NONNULL_END
