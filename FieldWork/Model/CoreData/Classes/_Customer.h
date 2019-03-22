// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Customer.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class ServiceLocation;

@class NSObject;

@class NSObject;

@class NSObject;

@class NSObject;

@interface CustomerID : NSManagedObjectID {}
@end

@interface _Customer : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CustomerID *objectID;

@property (nonatomic, strong, nullable) NSNumber* account_number;

@property (atomic) int32_t account_numberValue;
- (int32_t)account_numberValue;
- (void)setAccount_numberValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* balance;

@property (atomic) float balanceValue;
- (float)balanceValue;
- (void)setBalanceValue:(float)value_;

@property (nonatomic, strong, nullable) NSString* billing_attention;

@property (nonatomic, strong, nullable) NSString* billing_city;

@property (nonatomic, strong, nullable) NSString* billing_contact;

@property (nonatomic, strong, nullable) NSString* billing_county;

@property (nonatomic, strong, nullable) NSString* billing_name;

@property (nonatomic, strong, nullable) NSString* billing_phone;

@property (nonatomic, strong, nullable) NSString* billing_phone_ext;

@property (nonatomic, strong, nullable) NSString* billing_phone_kind;

@property (nonatomic, strong, nullable) id billing_phones;

@property (nonatomic, strong, nullable) id billing_phones_exts;

@property (nonatomic, strong, nullable) id billing_phones_kinds;

@property (nonatomic, strong, nullable) NSString* billing_state;

@property (nonatomic, strong, nullable) NSString* billing_street;

@property (nonatomic, strong, nullable) NSString* billing_street2;

@property (nonatomic, strong, nullable) NSString* billing_suite;

@property (nonatomic, strong, nullable) NSNumber* billing_term_id;

@property (atomic) int32_t billing_term_idValue;
- (int32_t)billing_term_idValue;
- (void)setBilling_term_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* billing_zip;

@property (nonatomic, strong, nullable) NSString* customer_name;

@property (nonatomic, strong, nullable) NSString* customer_type;

@property (nonatomic, strong, nullable) NSNumber* email_marketing;

@property (atomic) BOOL email_marketingValue;
- (BOOL)email_marketingValue;
- (void)setEmail_marketingValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_id;

@property (atomic) int32_t entity_idValue;
- (int32_t)entity_idValue;
- (void)setEntity_idValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSNumber* entity_status;

@property (atomic) int32_t entity_statusValue;
- (int32_t)entity_statusValue;
- (void)setEntity_statusValue:(int32_t)value_;

@property (nonatomic, strong, nullable) NSString* first_name;

@property (nonatomic, strong, nullable) NSNumber* inspections_enabled;

@property (atomic) BOOL inspections_enabledValue;
- (BOOL)inspections_enabledValue;
- (void)setInspections_enabledValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* invoice_email;

@property (nonatomic, strong, nullable) NSString* last_name;

@property (nonatomic, strong, nullable) NSNumber* lat;

@property (atomic) double latValue;
- (double)latValue;
- (void)setLatValue:(double)value_;

@property (nonatomic, strong, nullable) NSNumber* lng;

@property (atomic) double lngValue;
- (double)lngValue;
- (void)setLngValue:(double)value_;

@property (nonatomic, strong, nullable) NSString* name;

@property (nonatomic, strong, nullable) NSString* name_prefix;

@property (nonatomic, strong, nullable) id payment_methods;

@property (nonatomic, strong, nullable) NSNumber* send_report_email;

@property (atomic) BOOL send_report_emailValue;
- (BOOL)send_report_emailValue;
- (void)setSend_report_emailValue:(BOOL)value_;

@property (nonatomic, strong, nullable) NSString* site;

@property (nonatomic, strong, nullable) NSSet<ServiceLocation*> *service_locations;
- (nullable NSMutableSet<ServiceLocation*>*)service_locationsSet;

@end

@interface _Customer (Service_locationsCoreDataGeneratedAccessors)
- (void)addService_locations:(NSSet<ServiceLocation*>*)value_;
- (void)removeService_locations:(NSSet<ServiceLocation*>*)value_;
- (void)addService_locationsObject:(ServiceLocation*)value_;
- (void)removeService_locationsObject:(ServiceLocation*)value_;

@end

@interface _Customer (CoreDataGeneratedPrimitiveAccessors)

- (nullable NSNumber*)primitiveAccount_number;
- (void)setPrimitiveAccount_number:(nullable NSNumber*)value;

- (int32_t)primitiveAccount_numberValue;
- (void)setPrimitiveAccount_numberValue:(int32_t)value_;

- (nullable NSNumber*)primitiveBalance;
- (void)setPrimitiveBalance:(nullable NSNumber*)value;

- (float)primitiveBalanceValue;
- (void)setPrimitiveBalanceValue:(float)value_;

- (nullable NSString*)primitiveBilling_attention;
- (void)setPrimitiveBilling_attention:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_city;
- (void)setPrimitiveBilling_city:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_contact;
- (void)setPrimitiveBilling_contact:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_county;
- (void)setPrimitiveBilling_county:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_name;
- (void)setPrimitiveBilling_name:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_phone;
- (void)setPrimitiveBilling_phone:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_phone_ext;
- (void)setPrimitiveBilling_phone_ext:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_phone_kind;
- (void)setPrimitiveBilling_phone_kind:(nullable NSString*)value;

- (nullable id)primitiveBilling_phones;
- (void)setPrimitiveBilling_phones:(nullable id)value;

- (nullable id)primitiveBilling_phones_exts;
- (void)setPrimitiveBilling_phones_exts:(nullable id)value;

- (nullable id)primitiveBilling_phones_kinds;
- (void)setPrimitiveBilling_phones_kinds:(nullable id)value;

- (nullable NSString*)primitiveBilling_state;
- (void)setPrimitiveBilling_state:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_street;
- (void)setPrimitiveBilling_street:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_street2;
- (void)setPrimitiveBilling_street2:(nullable NSString*)value;

- (nullable NSString*)primitiveBilling_suite;
- (void)setPrimitiveBilling_suite:(nullable NSString*)value;

- (nullable NSNumber*)primitiveBilling_term_id;
- (void)setPrimitiveBilling_term_id:(nullable NSNumber*)value;

- (int32_t)primitiveBilling_term_idValue;
- (void)setPrimitiveBilling_term_idValue:(int32_t)value_;

- (nullable NSString*)primitiveBilling_zip;
- (void)setPrimitiveBilling_zip:(nullable NSString*)value;

- (nullable NSString*)primitiveCustomer_name;
- (void)setPrimitiveCustomer_name:(nullable NSString*)value;

- (nullable NSString*)primitiveCustomer_type;
- (void)setPrimitiveCustomer_type:(nullable NSString*)value;

- (nullable NSNumber*)primitiveEmail_marketing;
- (void)setPrimitiveEmail_marketing:(nullable NSNumber*)value;

- (BOOL)primitiveEmail_marketingValue;
- (void)setPrimitiveEmail_marketingValue:(BOOL)value_;

- (nullable NSNumber*)primitiveEntity_id;
- (void)setPrimitiveEntity_id:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_idValue;
- (void)setPrimitiveEntity_idValue:(int32_t)value_;

- (nullable NSNumber*)primitiveEntity_status;
- (void)setPrimitiveEntity_status:(nullable NSNumber*)value;

- (int32_t)primitiveEntity_statusValue;
- (void)setPrimitiveEntity_statusValue:(int32_t)value_;

- (nullable NSString*)primitiveFirst_name;
- (void)setPrimitiveFirst_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveInspections_enabled;
- (void)setPrimitiveInspections_enabled:(nullable NSNumber*)value;

- (BOOL)primitiveInspections_enabledValue;
- (void)setPrimitiveInspections_enabledValue:(BOOL)value_;

- (nullable NSString*)primitiveInvoice_email;
- (void)setPrimitiveInvoice_email:(nullable NSString*)value;

- (nullable NSString*)primitiveLast_name;
- (void)setPrimitiveLast_name:(nullable NSString*)value;

- (nullable NSNumber*)primitiveLat;
- (void)setPrimitiveLat:(nullable NSNumber*)value;

- (double)primitiveLatValue;
- (void)setPrimitiveLatValue:(double)value_;

- (nullable NSNumber*)primitiveLng;
- (void)setPrimitiveLng:(nullable NSNumber*)value;

- (double)primitiveLngValue;
- (void)setPrimitiveLngValue:(double)value_;

- (nullable NSString*)primitiveName;
- (void)setPrimitiveName:(nullable NSString*)value;

- (nullable NSString*)primitiveName_prefix;
- (void)setPrimitiveName_prefix:(nullable NSString*)value;

- (nullable id)primitivePayment_methods;
- (void)setPrimitivePayment_methods:(nullable id)value;

- (nullable NSNumber*)primitiveSend_report_email;
- (void)setPrimitiveSend_report_email:(nullable NSNumber*)value;

- (BOOL)primitiveSend_report_emailValue;
- (void)setPrimitiveSend_report_emailValue:(BOOL)value_;

- (nullable NSString*)primitiveSite;
- (void)setPrimitiveSite:(nullable NSString*)value;

- (NSMutableSet<ServiceLocation*>*)primitiveService_locations;
- (void)setPrimitiveService_locations:(NSMutableSet<ServiceLocation*>*)value;

@end

@interface CustomerAttributes: NSObject 
+ (NSString *)account_number;
+ (NSString *)balance;
+ (NSString *)billing_attention;
+ (NSString *)billing_city;
+ (NSString *)billing_contact;
+ (NSString *)billing_county;
+ (NSString *)billing_name;
+ (NSString *)billing_phone;
+ (NSString *)billing_phone_ext;
+ (NSString *)billing_phone_kind;
+ (NSString *)billing_phones;
+ (NSString *)billing_phones_exts;
+ (NSString *)billing_phones_kinds;
+ (NSString *)billing_state;
+ (NSString *)billing_street;
+ (NSString *)billing_street2;
+ (NSString *)billing_suite;
+ (NSString *)billing_term_id;
+ (NSString *)billing_zip;
+ (NSString *)customer_name;
+ (NSString *)customer_type;
+ (NSString *)email_marketing;
+ (NSString *)entity_id;
+ (NSString *)entity_status;
+ (NSString *)first_name;
+ (NSString *)inspections_enabled;
+ (NSString *)invoice_email;
+ (NSString *)last_name;
+ (NSString *)lat;
+ (NSString *)lng;
+ (NSString *)name;
+ (NSString *)name_prefix;
+ (NSString *)payment_methods;
+ (NSString *)send_report_email;
+ (NSString *)site;
@end

@interface CustomerRelationships: NSObject
+ (NSString *)service_locations;
@end

NS_ASSUME_NONNULL_END
