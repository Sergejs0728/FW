// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CustomerDevice.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface CustomerDeviceID : NSManagedObjectID {}
@end

@interface _CustomerDevice : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CustomerDeviceID *objectID;

@property (nonatomic, strong, nullable) NSString* barcode;

@property (nonatomic, strong, nullable) NSString* building;

@property (nonatomic, strong, nullable) NSNumber* customer_id;

@property (atomic) int32_t customer_idValue;
- (int32_t)customer_idValue;
- (void)setCustomer_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* device_area_id;

@property (atomic) int32_t device_area_idValue;
- (int32_t)device_area_idValue;
- (void)setDevice_area_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* floor;

@property (nonatomic, strong, nullable) NSString* location_details;

@property (nonatomic, strong, nullable) NSString* notes;

@property (nonatomic, strong, nullable) NSString* number;

@property (nonatomic, strong, nullable) NSString* service_frequency;

@property (nonatomic, strong, nullable) NSNumber* service_location_id;

@property (atomic) int32_t service_location_idValue;
- (int32_t)service_location_idValue;
- (void)setService_location_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* trap_type_id;

@property (atomic) int32_t trap_type_idValue;
- (int32_t)trap_type_idValue;
- (void)setTrap_type_idValue:(int32_t)value_;

@end

@interface _CustomerDevice (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSString*)primitiveBarcode;
- (void)setPrimitiveBarcode:(nullable NSString*)value;

- (nullable NSString*)primitiveBuilding;
- (void)setPrimitiveBuilding:(nullable NSString*)value;

- (nullable NSNumber*)primitiveCustomer_id;
- (void)setPrimitiveCustomer_id:(nullable NSNumber*)value;

- (int32_t)primitiveCustomer_idValue;
- (void)setPrimitiveCustomer_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveDevice_area_id;
- (void)setPrimitiveDevice_area_id:(nullable NSNumber*)value;

- (int32_t)primitiveDevice_area_idValue;
- (void)setPrimitiveDevice_area_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitiveFloor;
- (void)setPrimitiveFloor:(nullable NSString*)value;

- (nullable NSString*)primitiveLocation_details;
- (void)setPrimitiveLocation_details:(nullable NSString*)value;

- (nullable NSString*)primitiveNotes;
- (void)setPrimitiveNotes:(nullable NSString*)value;

- (nullable NSString*)primitiveNumber;
- (void)setPrimitiveNumber:(nullable NSString*)value;

- (nullable NSString*)primitiveService_frequency;
- (void)setPrimitiveService_frequency:(nullable NSString*)value;

- (nullable NSNumber*)primitiveService_location_id;
- (void)setPrimitiveService_location_id:(nullable NSNumber*)value;

- (int32_t)primitiveService_location_idValue;
- (void)setPrimitiveService_location_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveTrap_type_id;
- (void)setPrimitiveTrap_type_id:(nullable NSNumber*)value;

- (int32_t)primitiveTrap_type_idValue;
- (void)setPrimitiveTrap_type_idValue:(int32_t)value_;

@end

@interface CustomerDeviceAttributes: NSObject 
+ (NSString *)barcode;
+ (NSString *)building;
+ (NSString *)customer_id;
+ (NSString *)device_area_id;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)floor;
+ (NSString *)location_details;
+ (NSString *)notes;
+ (NSString *)number;
+ (NSString *)service_frequency;
+ (NSString *)service_location_id;
+ (NSString *)trap_type_id;
@end

NS_ASSUME_NONNULL_END
