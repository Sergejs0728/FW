// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Unit.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class ServiceLocation;

@interface UnitID : NSManagedObjectID {}
@end

@interface _Unit : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UnitID *objectID;

@property (nonatomic, strong, nullable) NSDate* created_at;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* flat_type_id;

@property (atomic) int32_t flat_type_idValue;
- (int32_t)flat_type_idValue;
- (void)setFlat_type_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSString* tenant_email_1;

@property (nonatomic, strong, nullable) NSString* tenant_email_2;

@property (nonatomic, strong, nullable) NSString* tenant_name;

@property (nonatomic, strong, nullable) NSString* tenant_phone_1;

@property (nonatomic, strong, nullable) NSString* tenant_phone_2;

@property (nonatomic, strong, nullable) NSString* unit_number;

@property (nonatomic, strong, nullable) NSDate* updated_at;

@property (nonatomic, strong, nullable) ServiceLocation *service_location;

@end

@interface _Unit (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(nullable NSDate*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSNumber*)primitiveFlat_type_id;
- (void)setPrimitiveFlat_type_id:(nullable NSNumber*)value;

- (int32_t)primitiveFlat_type_idValue;
- (void)setPrimitiveFlat_type_idValue:(int32_t)value_;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_email_1;
- (void)setPrimitiveTenant_email_1:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_email_2;
- (void)setPrimitiveTenant_email_2:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_name;
- (void)setPrimitiveTenant_name:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_phone_1;
- (void)setPrimitiveTenant_phone_1:(nullable NSString*)value;

- (nullable NSString*)primitiveTenant_phone_2;
- (void)setPrimitiveTenant_phone_2:(nullable NSString*)value;

- (nullable NSString*)primitiveUnit_number;
- (void)setPrimitiveUnit_number:(nullable NSString*)value;

- (nullable NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(nullable NSDate*)value;

- (ServiceLocation*)primitiveService_location;
- (void)setPrimitiveService_location:(ServiceLocation*)value;

@end

@interface UnitAttributes: NSObject 
+ (NSString *)created_at;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)flat_type_id;
+ (NSString *)notes;
+ (NSString *)tenant_email_1;
+ (NSString *)tenant_email_2;
+ (NSString *)tenant_name;
+ (NSString *)tenant_phone_1;
+ (NSString *)tenant_phone_2;
+ (NSString *)unit_number;
+ (NSString *)updated_at;
@end

@interface UnitRelationships: NSObject
+ (NSString *)service_location;
@end

NS_ASSUME_NONNULL_END
