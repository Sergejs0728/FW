// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to User.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class NSObject;

@interface UserID : NSManagedObjectID {}
@end

@interface _User : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) UserID *objectID;

@property (nonatomic, strong, nullable) id account_features;

@property (nonatomic, strong, nullable) NSNumber* account_id;

@property (atomic) int32_t account_idValue;
- (int32_t)account_idValue;
- (void)setAccount_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* country;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* first_name;

@property (nonatomic, strong, nullable) NSNumber* hide_customer_details;

@property (atomic) BOOL hide_customer_detailsValue;
- (BOOL)hide_customer_detailsValue;
- (void)setHide_customer_detailsValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* inspections_enabled;

@property (atomic) BOOL inspections_enabledValue;
- (BOOL)inspections_enabledValue;
- (void)setInspections_enabledValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* is_admin;

@property (atomic) BOOL is_adminValue;
- (BOOL)is_adminValue;
- (void)setIs_adminValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* last_name;

@property (nonatomic, strong, nullable) NSString* license_number;

@property (nonatomic, strong, nullable) NSNumber* mobile_customers_access;

@property (atomic) BOOL mobile_customers_accessValue;
- (BOOL)mobile_customers_accessValue;
- (void)setMobile_customers_accessValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* service_route_id;

@property (atomic) int32_t service_route_idValue;
- (int32_t)service_route_idValue;
- (void)setService_route_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* show_balance_forward;

@property (atomic) BOOL show_balance_forwardValue;
- (BOOL)show_balance_forwardValue;
- (void)setShow_balance_forwardValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* show_environment_fields;

@property (atomic) BOOL show_environment_fieldsValue;
- (BOOL)show_environment_fieldsValue;
- (void)setShow_environment_fieldsValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* show_photos;

@property (atomic) BOOL show_photosValue;
- (BOOL)show_photosValue;
- (void)setShow_photosValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* stripe_pk;

@end

@interface _User (CoreDataGeneratedPrimitiveAccessors)

- (nullable id)primitiveAccount_features;
- (void)setPrimitiveAccount_features:(nullable id)value;

- (nullable NSNumber*)primitiveAccount_id;
- (void)setPrimitiveAccount_id:(nullable NSNumber*)value;

- (int32_t)primitiveAccount_idValue;
- (void)setPrimitiveAccount_idValue:(int32_t)value_;

- (nullable NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSString*)primitiveFirst_name;
- (void)setPrimitiveFirst_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveHide_customer_details;
- (void)setPrimitiveHide_customer_details:(nullable NSNumber*)value;

- (BOOL)primitiveHide_customer_detailsValue;
- (void)setPrimitiveHide_customer_detailsValue:(BOOL)value_;

- (nullable NSNumber*)primitiveInspections_enabled;
- (void)setPrimitiveInspections_enabled:(nullable NSNumber*)value;

- (BOOL)primitiveInspections_enabledValue;
- (void)setPrimitiveInspections_enabledValue:(BOOL)value_;

- (nullable NSNumber*)primitiveIs_admin;
- (void)setPrimitiveIs_admin:(nullable NSNumber*)value;

- (BOOL)primitiveIs_adminValue;
- (void)setPrimitiveIs_adminValue:(BOOL)value_;

- (nullable NSString*)primitiveLast_name;
- (void)setPrimitiveLast_name:(nullable NSString*)value;

- (nullable NSString*)primitiveLicense_number;
- (void)setPrimitiveLicense_number:(nullable NSString*)value;

- (nullable NSNumber*)primitiveMobile_customers_access;
- (void)setPrimitiveMobile_customers_access:(nullable NSNumber*)value;

- (BOOL)primitiveMobile_customers_accessValue;
- (void)setPrimitiveMobile_customers_accessValue:(BOOL)value_;

- (nullable NSNumber*)primitiveService_route_id;
- (void)setPrimitiveService_route_id:(nullable NSNumber*)value;

- (int32_t)primitiveService_route_idValue;
- (void)setPrimitiveService_route_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveShow_balance_forward;
- (void)setPrimitiveShow_balance_forward:(nullable NSNumber*)value;

- (BOOL)primitiveShow_balance_forwardValue;
- (void)setPrimitiveShow_balance_forwardValue:(BOOL)value_;

- (nullable NSNumber*)primitiveShow_environment_fields;
- (void)setPrimitiveShow_environment_fields:(nullable NSNumber*)value;

- (BOOL)primitiveShow_environment_fieldsValue;
- (void)setPrimitiveShow_environment_fieldsValue:(BOOL)value_;

- (nullable NSNumber*)primitiveShow_photos;
- (void)setPrimitiveShow_photos:(nullable NSNumber*)value;

- (BOOL)primitiveShow_photosValue;
- (void)setPrimitiveShow_photosValue:(BOOL)value_;

- (nullable NSString*)primitiveStripe_pk;
- (void)setPrimitiveStripe_pk:(nullable NSString*)value;

@end

@interface UserAttributes: NSObject 
+ (NSString *)account_features;
+ (NSString *)account_id;
+ (NSString *)country;
+ (NSString *)entity_id;
+ (NSString *)first_name;
+ (NSString *)hide_customer_details;
+ (NSString *)inspections_enabled;
+ (NSString *)is_admin;
+ (NSString *)last_name;
+ (NSString *)license_number;
+ (NSString *)mobile_customers_access;
+ (NSString *)service_route_id;
+ (NSString *)show_balance_forward;
+ (NSString *)show_environment_fields;
+ (NSString *)show_photos;
+ (NSString *)stripe_pk;
@end

NS_ASSUME_NONNULL_END
